#!/bin/bash

r1=$REPL_USER
repl="'$r1'"
r2=$REPL_HOST
rip="'$r2'"
r3=$REPL_PWD
rpwd="'$r3'"
while true
do
if [[ $(service mysql status) == "MySQL Community Server 5.7.12 is running." ]];
then {
sleep 10;
mysql -uroot -p$MYSQL_ROOT_PASSWORD << EOF
GRANT ALL privileges ON *.* TO $repl@$rip IDENTIFIED BY $rpwd;
flush privileges;
EOF
echo "done";
exit 1;
}
fi
done