
$port_output = Netstat -ano |findStr 127.0.0.1:6666
if ((-not $null -eq $ps) -and $port_output.Contains("LISTENING")) {
    Write-Host "Port listening... use proxy port"
	
	git config http.proxy http://127.0.0.1:6666
    
}

git add  .

git commit -m "autocommit"

git pull

git push

if ((-not $null -eq $ps) -and $port_output.Contains("LISTENING")) {
    git config --unset http.proxy
}

