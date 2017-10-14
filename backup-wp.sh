#!/bin/bash
# set an infinite loop

TODAY=$(date +%Y-%m-%d)
EXPIRED=$(date -d "-7 days" +%Y-%m-%d)


#Task no 1 ===================================================

#MySQL config
HOST=localhost
DB_USER=mysql_user_name
DB_PASS='password'
DB_NAME=mysql_db_name
#End of MySQL config

cd ~/backups/wp
mkdir tmp_$TODAY
rsync -av --ignore-errors --exclude-from '/home/dio/backups/ex.txt' --progress /home/dio/domains/domain.com/public_html/ /home/dio/backups/wp/tmp_$TODAY/
/usr/local/bin/mysqldump -h $HOST -u $DB_USER -p$DB_PASS $DB_NAME | gzip -9 > /home/dio/backups/wp/tmp_$TODAY/$TODAY_$DB_NAME.sql.gz
zip -r9 wp_$TODAY.zip tmp_$TODAY/
unset HOST
unset DB_USER
unset DB_PASS
unset DB_NAME
rm -r tmp_$TODAY/
rm -r wp_$EXPIRED.zip

#End of task no 1 ============================================
