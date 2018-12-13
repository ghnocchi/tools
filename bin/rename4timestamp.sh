#!/bin/sh

for file in $(find /var/log/sa ! -name "sar*" -mtime +7 -type f ); do DATEFULL=$(ls -l --time-style=full-iso $file | awk '{print $6,$7,$8;}'); DATE=$(date -d "$DATEFULL" "+%Y%m%d"); BASE=$(echo $file | sed 's/[0-9]\{2\}//'); echo $BASE$DATE; done
