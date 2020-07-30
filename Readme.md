## Setup the training project
1.) Go to docker folder and build docker
- $ docker-compose build
- $ docker-compose up -d

2.) Access to mysqldb container and edit file my.cnf
- $ docker exec -it mysqldb bash
- $ vim /etc/mysql/my.cnf
- add 'default-authentication-plugin=mysql_native_password' to below [mysqld] 
- $ docker restart mysqldb

3.) Access to mysqldb container and edit file my.cnf
- $ docker exec -it mysqldb bash
- $ vim /etc/mysql/my.cnf
- add 'default-authentication-plugin=mysql_native_password' to below [mysqld] 
- $ docker restart mysqldb

3.) Create user with mode mysql_native_password
- $ docker exec -it mysqldb bash
- $ CREATE USER 'devuser' identified with mysql_native_password by 'devpass';
- $ GRANT ALL PRIVILEGES ON webike.* TO 'devuser'@'%';
- $ docker restart mysqldb

4.) Create database and data for webike (view file script at drive)

5.) Create schema webike_testing for unit test (view file script at project's folder test_schema/)

6.) Open browser with URL: http://localhost:8081/



