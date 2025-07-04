# 获取当前时间
$now = Get-Date
$hourMinute = $now.ToString("HH:mm")
$dayOfWeek = $now.DayOfWeek
$currentDir = Get-Location
$overtimeFile = Join-Path $currentDir "加班.txt"

# 将时间字符串转换为 TimeSpan 方便比较
$timeNow = [TimeSpan]::Parse($hourMinute)
$morningStart = [TimeSpan]::Parse("08:33")
$eveningCutoff = [TimeSpan]::Parse("17:31")

if ($timeNow -ge $morningStart -and $timeNow -lt $eveningCutoff) {
    # 06:00 - 17:31
    C:\Users\procsl\IdeaProjects\script\enable-network.cmd
}
elseif ($timeNow -ge $eveningCutoff) {
    # 17:31 - 24:00
    if ((($dayOfWeek -eq 'Tuesday') -or ($dayOfWeek -eq 'Thursday')) -and (Test-Path $overtimeFile -PathType Leaf)) {
        C:\Users\procsl\IdeaProjects\script\enable-network.cmd
    }
    else {
        C:\Users\procsl\IdeaProjects\script\disable-network.cmd
    }
}
else {
    # 00:00 - 06:00
    C:\Users\procsl\IdeaProjects\script\disable-network.cmd
}
