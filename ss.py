import argparse
import asyncio
import hashlib
import logging
import os
import subprocess
import sys
import ctypes
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
# Windows API 状态常量定义
ES_CONTINUOUS = 0x80000000
ES_SYSTEM_REQUIRED = 0x00000001
ES_DISPLAY_REQUIRED = 0x00000002

def wake_up_hardware():
    """
    强制唤醒硬件供电与系统：
    1. 阻止系统继续低功耗休眠，拉高 CPU/主板状态。
    2. 模拟底层 F15 按键，让 Windows 退出 Modern Standby 并恢复 USB/网卡供电。
    """
    try:
        # 请求系统和显示器保持工作状态
        ctypes.windll.kernel32.SetThreadExecutionState(
            ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED
        )
        # 发送底层按键事件 (F15 键，对用户无影响但能触发硬件唤醒)
        ctypes.windll.user32.keybd_event(0x7E, 0, 0, 0)
        time.sleep(0.05)
        ctypes.windll.user32.keybd_event(0x7E, 0, 2, 0)
        logging.info("[wake] 已触发硬件唤醒，恢复 USB/网卡供电")
    except Exception as e:
        logging.error(f"[wake: error] 唤醒硬件失败: {e}")

def allow_sleep_again():
    """
    恢复系统默认的睡眠策略（可选使用）
    """
    try:
        ctypes.windll.kernel32.SetThreadExecutionState(ES_CONTINUOUS)
        logging.info("[wake] 已恢复系统电源策略")
    except Exception as e:
        logging.error(f"[wake: error] 恢复电源策略失败: {e}")



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

    # =====【修改点 1】：在执行 netsh 命令前，先唤醒系统和恢复 USB 供电 =====
    wake_up_hardware()
    time.sleep(1)  # 给网卡/USB 控制器 1 秒钟通电初始化的时间

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
        
        # =====【修改点 2】：如果是启用网卡，额外等待 3 秒供网卡寻找并连接网络 =====
        if action == 'start':
            time.sleep(3)
            
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