#!/bin/bash

# 参考
# cronジョブを作るのにいつものやり方でいいんですか?
# https://qiita.com/jmatsu/items/0a5d80abe188b09644c1

# 使いかた
# edit crontab -e
# * * * * * env > share/cron_env
# $ cron_env.sh hoge.sh

CUR=$(cd $(dirname $0); pwd)
SHERE=$(dirname $CUR)/share

# reset env
while read line; do
    eval "$line"
done < <(diff <(env) $SHERE/cron_env |grep "^[><]"|grep -v " _="|sed -e 's/^< \([^=]*\)=.*/unset \1/' -e 's/^>/export/'|sort -r)

$1
