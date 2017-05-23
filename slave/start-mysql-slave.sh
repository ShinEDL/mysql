#!/bin/bash

mkdir -p $PWD/data
mkdir -p $PWD/logs
chmod 644 $PWD/conf/my.cnf
chmod +x $PWD/change_slave.sh

# 强制杀死正在运行的 mysql-slave
docker rm -f mysql-slave

# mysql master
docker run -d --restart=on-failure:5 --name mysql-slave \
              -p 3306:3306 \
              -e "MYSQL_ROOT_PASSWORD=my-secret-ab" \
              -e "MYSQL_DATABASE=appbricks" \
	       -e "MASTER_HOST=121.40.73.93" \
	       -e "MASTER_USER=repl" \
	       -e "MASTER_PWD=ab-mysql" \
              -v $PWD/conf/master-slave:/etc/mysql/conf.d \
              -v $PWD/data:/var/lib/mysql \
              -v $PWD/logs:/var/log \
	      	-v $PWD/change_slave.sh:/change_slave.sh \
              mysql:5.7.12 --server_id=2 --skip-slave-start --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# 修改slave的配置
docker exec mysql-slave sh -c './change_slave.sh'
