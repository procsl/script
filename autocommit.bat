chcp 65001


set/p a= "Netstat -ano |findStr 127.0.0.1:6666"

echo %a% 

git add  .

git commit -m "autocommit"

git pull

git push

pause
