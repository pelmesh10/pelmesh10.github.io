#!/usr/bin/env sh

# остановить публикацию при ошибках
set -e

# сборка
npm run build

# переход в каталог сборки
cd dist


git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:pelmesh10/pelmesh10.github.io.git master

cd -
