$adb_output = db devices |findStr 'f8061b9'
if (!$adb_output.Contains("f8061b9"))
{
    Write-Host "�������豸f8061b9���������豸"
    break
}

$ps = db -s f8061b9 shell "netstat -an|grep LISTEN |grep 8888"

Write-Host "�����������: "$ps

if (($null -eq $ps) -or (-not $ps.Contains("LISTEN")))
{
    Write-Host "����δ����������������: com.termux"

    $foreach_times = "1", "2", "3"
    foreach ($letter in $foreach_times)
    {
        db -s f8061b9 shell "am start com.termux/.app.TermuxActivity"
        Write-Host "����������..."
        Start-Sleep -Seconds 1
        $ps = db -s f8061b9 shell "netstat -an|grep LISTEN |grep 8888"
        $start = ($null -eq $ps) -or (-not $ps.Contains("LISTEN"))
        if (!$start)
        {
            Write-Host "���������ɹ�..."
            break
        }
        Write-Host "��������ʧ�ܣ�1s����������: "$letter"�Σ����3��"
        Start-Sleep -Seconds 1
    }
}

$adb_list = db -s f8061b9  forward --list

if (-not $adb_list.Contains("8888"))
{
    db -s f8061b9  forward tcp:8888 tcp:8888
}

if (-not $adb_list.Contains("8889"))
{
    db -s f8061b9  forward tcp:8889 tcp:8889
}

if (-not $adb_list.Contains("8022"))
{
    db -s f8061b9  forward tcp:8022 tcp:8022
}

if (-not $adb_list.Contains("6666"))
{
    db -s f8061b9  forward tcp:6666 tcp:6666
}

if (-not $adb_list.Contains("7777"))
{
    db -s f8061b9  forward tcp:7777 tcp:7777
}