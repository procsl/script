chcp 65001
git pull

git checkout --orphan latest_branch

git add .

git commit -m "清理历史记录"

git branch -D master

git branch -m master


git branch --set-upstream-to=origin/master  master

git push -f origin master

git gc

git log --pretty=oneline

