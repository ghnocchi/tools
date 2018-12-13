#!/bin/sh

BASE=/var/backup
#TARGET1=${BASE}/gis/map/server:data.days.\*:8:d
TARGET2=${BASE}/*/db/:postgres_*.custom*:8:df
#TARGET3=${BASE}/gis/tool/manage:app.days.\*:8:d

for T in $TARGET1 $TARGET2 $TARGET3
do
  ORIG_DIR=$(echo $T | cut -d: -f1)
  FIND=$(echo $T | cut -d: -f2)
  COUNT=$(echo $T | cut -d: -f3)
  TYPE=$(echo $T | cut -d: -f4)

  ls -d $ORIG_DIR | while read DIR
  do
    [[ -d $DIR ]] || continue
    if [ "d" = "$TYPE" ]; then
      # rsyncなので基本的にディレクトリの作成日は全て同じ
      find $DIR -maxdepth 1 -type $TYPE -name $FIND |sort | tail -n +${COUNT} | xargs -I{} rm -rfv {}
      #find $DIR -maxdepth 1 -type $TYPE -name $FIND |xargs -r ls -t -d | tail -n +${COUNT}
    elif [ "f" = "$TYPE" ]; then
      find $DIR -maxdepth 1 -type $TYPE -name $FIND |xargs -r ls -t| tail -n +${COUNT} | xargs -I{} rm -v {}
      #find $DIR -maxdepth 1 -type $TYPE -name $FIND |xargs -r ls -t| tail -n +${COUNT}
    elif [ "df" = "$TYPE" ]; then
      for D in $(find $DIR -maxdepth 1 -mindepth 1 -type d)
      do
        find $D -maxdepth 1 -type f -name $FIND |xargs -r ls -t| tail -n +${COUNT} | xargs -I{} rm -v {}
      done
    fi
  done

done
