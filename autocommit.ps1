$port_output = Netstat -ano |findStr 127.0.0.1:6666

if ($null -eq $port_output)
{
    Write-Host "no proxy config"
    $port_output = 'aaa'
}

if ($port_output.Contains("LISTENING"))
{
    Write-Host "Port listening... use proxy port"
    git config http.proxy http://127.0.0.1:6666
}

git add  .

git commit -m "autocommit"

git pull

git push

if ($port_output.Contains("LISTENING"))
{
    git config --unset http.proxy
}

