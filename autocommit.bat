chcp 65001


set a='Netstat -ano |findStr 127.0.0.1:6666'

if exist "%a%" (
    echo File "%a%" found.
) else (
    echo File "%a%" not found.
)

git add  .

git commit -m "autocommit"

git pull

git push

pause
