#!/bin/bash

mkdir -p $PWD/data
mkdir -p $PWD/logs
chmod 644 $PWD/conf/my.cnf
chmod +x $PWD/change_master.sh

# 强制杀死正在运行的 mysql-master
docker rm -f mysql-master

# mysql master
docker run -d --restart=on-failure:5 --name mysql-master \
              -p 3306:3306 \
              -e "MYSQL_ROOT_PASSWORD=my-secret-ab" \
              -e "MYSQL_DATABASE=appbricks" \
	      	-e "REPL_USER=repl" \
	      	-e "REPL_HOST=%" \
	      	-e "REPL_PWD=ab-mysql" \
              -v $PWD/conf/master-slave:/etc/mysql/conf.d \
              -v $PWD/data:/var/lib/mysql \
              -v $PWD/logs:/var/log \
	      	-v $PWD/change_master.sh:/change_master.sh \
              mysql:5.7.12 --server_id=1 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

#修改master配置，创建备份用户
docker exec mysql-master sh -c './change_master.sh'