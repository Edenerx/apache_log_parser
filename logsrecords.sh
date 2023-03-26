#!/bin/bash

SERVERIP=`hostname -I`
DBAIP="192.168.2.111"
APACHELOGS='/var/log/apache2/access.log'

DBNAME="apachelogs"
TABLENAME="logs"
CLIENTPATH="/root/user_password"

#Uploda logs into mysql table
cat $APACHELOGS | while read p;
do
    IP=\"`echo $p | awk '{print $1}'`\"
    echo $IP
    LOGINDATE=\"`echo $p | awk '{print $4}'`\"
    echo $LOGINDATE
    USERAGENT=\"`echo $p | awk -F\" '{print $6}'`\"
    echo $USERAGENT
    HTTPCODE=`echo $p | awk '{print $9}'`
    echo $HTTPCODE
    mysql --defaults-extra-file=$CLIENTPATH -h $DBAIP <<EOF
            USE $DBNAME
            INSERT INTO $TABLENAME (server_ip, ip, login_date, user_agent, http_code)
            VALUES ("$SERVERIP", $IP, $LOGINDATE, $USERAGENT, $HTTPCODE);
            SELECT * FROM logs
EOF
done