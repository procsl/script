$aidea_output = idea  devices |findStr 'f8061b9'
if (!$aidea_output.Contains("f8061b9"))
{
    Write-Host "�������豸f8061b9���������豸"
    break
}

$ps = idea  -s f8061b9 shell "netstat -an|grep LISTEN |grep 8888"

Write-Host "�����������: "$ps

if (($null -eq $ps) -or (-not $ps.Contains("LISTEN")))
{
    Write-Host "����δ����������������: com.termux"

    $foreach_times = "1", "2", "3"
    foreach ($letter in $foreach_times)
    {
        idea  -s f8061b9 shell "am start com.termux/.app.TermuxActivity"
        Write-Host "����������..."
        Start-Sleep -Seconds 1
        $ps = idea  -s f8061b9 shell "netstat -an|grep LISTEN |grep 8888"
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

if (-not $adb_list.Contains("7778"))
{
    idea  -s f8061b9  forward tcp:7778 tcp:7778
}