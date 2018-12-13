#!/bin/sh

LDIR=/usr/local/apache2/logs
ARCHIVES=$LDIR/archives

if [ ! -d $ARCHIVES ]
then
  mkdir $ARCHIVES
fi

for FILE in $(find $LDIR -maxdepth 1 -mtime +7 -type f ! -name "*bz2" -name "*_log*")
do
  bzip2 $FILE
  mv ${FILE}.bz2 $ARCHIVES/
done
