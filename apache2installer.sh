#!/bin/bash

USERIP=$1
USER="root"
CRONPATH="/etc/cron.d/uploadlogs"
CLIENTNAME="user_password" 
SCRIPTPATH=$2 #"/home/eden/logsrecords.sh"
SQLUSER="eden" 
SQLPASS="123456789"
KEYGENPATH="/root/.ssh/id_rsa"

scp -i $KEYGENPATH $SCRIPTPATH $USER@$USERIP:/root
ssh $USER@$USERIP << EOF
    apt-get update
    apt install mysql-clinet
    apt install apache2 -y 
    echo "[client]" >> $CLIENTNAME
    echo "user=$SQLUSER" >> $CLIENTNAME
    echo "password=$SQLPASS" >> $CLIENTNAME
    echo "* * * * * root /root/logsrecords.sh $USERIP >> $CRONPATH
EOF
