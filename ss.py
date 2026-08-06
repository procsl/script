import argparse
import asyncio
import hashlib
import logging
import os
import subprocess
import sys
import time
from bleak import BleakScanner


parser = argparse.ArgumentParser(description="BLE")
parser.add_argument("--key", type=str)
parser.add_argument("--interface", type=str)
parser.add_argument(
    "--log", 
    type=str, 
    default=os.path.join(os.path.dirname(os.path.abspath(__file__)), "bt_ping.log"), 
    help="log path"
)

args = parser.parse_args()

SECRET_KEY = args.key
TARGET_INTERFACE = args.interface
LOG_PATH = args.log
TARGET_COMPANY_ID = 0xFFFF


logging.basicConfig(
    filename=LOG_PATH,
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
    encoding='utf-8'
)


# console_handler = logging.StreamHandler()
# console_handler.setFormatter(logging.Formatter('%(asctime)s [%(levelname)s] %(message)s'))
# logging.getLogger().addHandler(console_handler)

logging.info(f"server started: | dev: {TARGET_INTERFACE}")


LAST_EXEC_TIME = 0
CURRENT_STATE = None

def control_interface(action: str):
    global LAST_EXEC_TIME, CURRENT_STATE
    
    now = time.time()
    if now - LAST_EXEC_TIME < 5:
        logging.warning(f"[limit] 5s (request: {action})")
        return

    target_status = 'enabled' if action == 'start' else 'disabled'
    if CURRENT_STATE == target_status:
        logging.info(f"[skip] dev '{TARGET_INTERFACE}' current {target_status} status")
        return

    try:
        subprocess.run(
            ['netsh', 'interface', 'set', 'interface', TARGET_INTERFACE, target_status],
            check=True,
            capture_output=True,
            text=True,
            encoding='gbk'
        )
        LAST_EXEC_TIME = now
        CURRENT_STATE = target_status
        logging.info(f"[ctr: ok ] dev '{TARGET_INTERFACE}' change to {target_status}")
    except subprocess.CalledProcessError as e:
        logging.error(f"[ctr: warn] {e.stderr.strip() if e.stderr else e}")
    except Exception as e:
        logging.error(f"[ctr: error] {e}")

def verify_and_parse(raw_bytes):
    try:
        text = "".join(chr(b) for b in raw_bytes if 32 <= b <= 126)
        
        if len(text) != 23:
            return None, f"len error: ({len(text)}/23 byte)"

        pad_payload = text[0:6]
        timestamp_str = text[6:16]
        received_sig = text[16:23]

        pkg_time = int(timestamp_str)
        current_time = int(time.time())

        msg_to_verify = f"{pad_payload}{timestamp_str}{SECRET_KEY}".encode('utf-8')
        expected_sig = hashlib.sha256(msg_to_verify).hexdigest()[:7]

        if received_sig.lower() != expected_sig.lower():
            return None, f"sign error! expected:{expected_sig} received:{received_sig}"

        if abs(current_time - pkg_time) > 60:
            return None, "timeout"

        raw_payload = pad_payload.rstrip('-')
        return raw_payload, "ok"

    except Exception as e:
        return None, f"error: {e}"

def detection_callback(device, advertisement_data):
    mfd = advertisement_data.manufacturer_data
    if TARGET_COMPANY_ID in mfd:
        raw_bytes = mfd[TARGET_COMPANY_ID]
        payload, status = verify_and_parse(raw_bytes)
        
        if payload:
            logging.info(f"[ok] payload: {payload} | address: {device.address}")
            
            cmd = payload.lower()
            if cmd in ('start', 'stop'):
                control_interface(cmd)
        else:
            logging.warning(f"[warning] {status}")

async def main():
    logging.info("BLE listen ...")
    scanner = BleakScanner(detection_callback)
    await scanner.start()
    try:
        while True:
            await asyncio.sleep(1)
    except asyncio.CancelledError:
        pass
    finally:
        await scanner.stop()

if __name__ == "__main__":
    asyncio.run(main())