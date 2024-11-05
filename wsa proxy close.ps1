adb connect 127.0.0.1:58526
adb -s 127.0.0.1:58526 shell settings put global http_proxy :0
adb -s 127.0.0.1:58526 shell settings delete global http_proxy 
adb -s 127.0.0.1:58526 shell settings delete global global_http_proxy_host
adb -s 127.0.0.1:58526 shell settings delete global global_http_proxy_port