#!/bin/bash

mh1=$MASTER_HOST
mh="'$mh1'"
mu1=$MASTER_USER
mu="'$mu1'"
mp1=$MASTER_PWD
mp="'$mp1'"
while true
do
if [[ $(service mysql status) == "MySQL Community Server 5.7.12 is running." ]];
then {
sleep 30;
mysql -uroot -p$MYSQL_ROOT_PASSWORD << EOF
drop database mysql;
stop slave;
reset slave;
change master to master_host=$mh;
change master to master_user=$mu;
change master to master_password=$mp;
change master to MASTER_AUTO_POSITION=1;
start slave;
EOF
echo "done";
exit 1;
}
fi
done

