#!/bin/bash

# edit crontab -e
# * * * * * env > share/cron_env

CUR=$(cd $(dirname $0); pwd)
SHERE=$(dirname $CUR)/share

# reset env
while read line; do
    eval "$line"
done < <(diff <(env) $SHERE/cron_env |grep "^[><]"|grep -v " _="|sed -e 's/^< \([^=]*\)=.*/unset \1/' -e 's/^>/export/'|sort -r)

$1
