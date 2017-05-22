# mysql
mysql docker化部署

## 部署

### 单机部署

### 主从部署

**ps：** 目前项目仅支持mysql 5.7.12版本使用主从部署。

- 配置
	- 修改`start-mysql-master.sh`，定位并修改以下参数：
		- **MYSQL\_ROOT_PASSWORD** root用户密码
		- **MYSQL_DATABASE** 初始数据库
		- **REPL_USER** 从数据库用户名
		- **REPL_HOST** 允许的主机IP，如为所有IP则设置成%
		- **REPL_PWD** 从数据库用户密码
	- 修改`start-mysql-slave.sh`，定位并修改一下参数：
		- **MYSQL\_ROOT_PASSWORD** root用户密码
		- **MYSQL_DATABASE** 初始数据库
		- **MASTER_HOST** 主数据库的IP地址
		- **MASTER_USER** 主数据库的备份用户名（同REPL_USER）
		- **MASTER_PWD** 主数据库的备份用户密码（同REPL_PWD）
- 启动
	- 先启动master节点
	
		```
		./start-mysql-master.sh
		``` 
	- 再启动slave节点

		```
		./start-mysql-slave.sh
		```

## 备份
