$aidea_output = idea  devices |findStr 'f8061b9'
if (!$aidea_output.Contains("f8061b9"))
{
    Write-Host "不存在设备f8061b9，请连接设备"
    break
}

$ps = idea  -s f8061b9 shell "netstat -an|grep LISTEN |grep 8888"

Write-Host "进程启动结果: "$ps

if (($null -eq $ps) -or (-not $ps.Contains("LISTEN")))
{
    Write-Host "进程未启动，将启动进程: com.termux"

    $foreach_times = "1", "2", "3"
    foreach ($letter in $foreach_times)
    {
        idea  -s f8061b9 shell "am start com.termux/.app.TermuxActivity"
        Write-Host "进程启动中..."
        Start-Sleep -Seconds 1
        $ps = idea  -s f8061b9 shell "netstat -an|grep LISTEN |grep 8888"
        $start = ($null -eq $ps) -or (-not $ps.Contains("LISTEN"))
        if (!$start)
        {
            Write-Host "进程启动成功..."
            break
        }
        Write-Host "进程启动失败，1s后重试启动: "$letter"次，最多3次"
        Start-Sleep -Seconds 1
    }
}

$adb_list = idea  -s f8061b9  forward --list

if (-not $adb_list.Contains("8888"))
{
    idea  -s f8061b9  forward tcp:8888 tcp:8888
}

if (-not $adb_list.Contains("8889"))
{
    idea  -s f8061b9  forward tcp:8889 tcp:8889
}

if (-not $adb_list.Contains("8022"))
{
    idea  -s f8061b9  forward tcp:8022 tcp:8022
}

if (-not $adb_list.Contains("7777"))
{
    idea  -s f8061b9  forward tcp:7777 tcp:7777
}

if (-not $adb_list.Contains("6666"))
{
    idea  -s f8061b9  forward tcp:6666 tcp:6666
}