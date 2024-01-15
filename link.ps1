$adb_output = adb  devices |findStr 'f8061b9'
if ($adb_output.Contains("f8061b9")) {
    Write-Host "存在设备f8061b9"

    $foreach_times = "1","2","3"
    foreach ($letter in $foreach_times)
    {
        $adb_start = adb shell  am start com.termux/.app.TermuxActivity

        if($adb_start.Contains("Starting")){
            Write-Host "重试启动: "+ $adb_start
            Start-Sleep -Seconds 1
        }

    }

    $adb_list = adb forward --list

    if (-not $adb_list.Contains("8888")){
        adb forward tcp:8888 tcp:8888
    }

   
    if (-not $adb_list.Contains("8022")){
        adb forward tcp:8022 tcp:8022
    }
    
}