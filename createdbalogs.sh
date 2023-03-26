#!/bin/bash

GITREPOSITORYNAME="apache_log_parser"
#NAMES
DBNAME="apachelogs"
TABLENAME="logs"
USER="root"
SQLUSER="eden" 
SQLPASS="123456789"

apt-get update
apt install mysql-server -y
mysql -u $USER << EOP
    CREATE USER '$SQLUSER'@'%' IDENTIFIED BY '$SQLPASS';
    GRANT ALL PRIVILEGES ON *.* TO '$SQLUSER'@'%';
    CREATE DATABASE IF NOT EXISTS $DBNAME;
    USE $DBNAME;
    CREATE TABLE IF NOT EXISTS $TABLENAME (
    server_ip varchar(255),
    ip varchar(255),
    login_date varchar(255),
    user_agent varchar(255),
    http_code int
    );
EOP

