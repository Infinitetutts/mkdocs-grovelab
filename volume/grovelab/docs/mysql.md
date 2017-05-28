## Create a New User And Grant Privileges

**Local Access**
```
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';  
```

**External Access**
```
CREATE USER 'newuser'@'%' IDENTIFIED BY 'password';  
```

**Grant all privileges on all Databases and tables**
```
GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost' IDENTIFIED BY 'password';  
```

**Grant all privileges one a specific databases(wikimedia) and all tables with external access**
```
GRANT ALL PRIVILEGES ON wikimedia . * TO 'newuser'@'%' IDENTIFIED BY 'password'; 

FLUSH PRIVILEGES;
```


## Commands

**View All users**  
```
SELECT USER,Host FROM mysql.user\G; 
```
`\G` for neat output  

**Delete MySQL user**
```
DELETE FROM mysql.user WHERE USER = 'john'; 
```

**Delete MySQL user with specific host**
```
DELETE FROM mysql.user WHERE USER = 'john' AND Host = '%';
```

**MySQL Dump**
*Dump with correct DB encoding to be safe, see in section further down*
```
mysqldump -h localhost -u root -pP@ssw0rd db01 > db01.sql; 
```

**MySQL Restore**
```
mysql -h localhost -u root -pP@ssw0rd db01 < db01.sql; 
```

**Insert values to table**
```
INSERT INTO table01 (a, b, c) VALUES ('1','2','3');
```

**Update values in a field**
```
UPDATE table01 SET col1 = 'a', col2 = 'b', col3 = 'c' WHERE FIELD = '1';
```

Example:
```
UPDATE table01 SET token = '12312312asd' WHERE service_id = '100'";
```

**Delete row from table**
```
DELETE FROM orders WHERE id_users = 1 AND id_product = 2 LIMIT 1;
DELETE FROM table01 WHERE col1 LIKE 'abc'";
```

**Import tables to another database, keeps the same structure and primary keys**
```
INSERT IGNORE INTO db1.table1 SELECT * FROM db2.table1;
```

**Change root password with mysqladmin command**
```
mysqladmin -u root -p'oldpassword' password newpass 
```

## Status, process list, open connections

**Open connections**
```
mysql> SHOW STATUS LIKE 'Conn%';
```
```
+---------------+-------+
| Variable_name | VALUE |
+---------------+-------+
| Connections   | 8     | 
+---------------+-------+
```

**Process list**
```
mysql> SHOW processlist;
```
```
+----+------+-----------------+--------+---------+------+-------+------------------+
| Id | USER | Host            | db     | Command | TIME | State | Info             |
+----+------+-----------------+--------+---------+------+-------+------------------+
|  3 | root | localhost       | webapp | Query   |    0 | NULL  | SHOW processlist | 
|  5 | root | localhost:61704 | webapp | Sleep   |  208 |       | NULL             | 
|  6 | root | localhost:61705 | webapp | Sleep   |  208 |       | NULL             | 
|  7 | root | localhost:61706 | webapp | Sleep   |  208 |       | NULL             | 
+----+------+-----------------+--------+---------+------+-------+------------------+
```

**Status**
```
 mysqladmin STATUS
```     
```
Uptime: 4661  Threads: 1  Questions: 200  Slow queries: 0  Opens: 16  FLUSH
TABLES: 1  OPEN TABLES: 6  Queries per SECOND avg: 0.043 
```




## Allow remote access to MySQL

```
vim /etc/mysql/my.cnf 

bind-address=YOUR-SERVER-IP 
```


## Dumping and importing UTF-8 the safe way

**SQL Dump**
```
mysqldump -uroot -p DATABASE -r utf8.dump 
```

**Importing and setting UTF8**
```
mysql -uroot -p --default-character-set=utf8 database 
SET names='utf8'; 
SOURCE utf8.dump; 
```


## Resetting root password

**Stop MySQL**
```bash
sudo service mysql stop 
```

**Start MySQL in safe mode**
```bash
sudo mysqld_safe --skip-grant-tables & 
```

**Login as root**
```bash
mysql -uroot 
```

**Instruct MySQL which database to use**
```
USE mysql; 
```

**Reset Password**
```
UPDATE USER SET password=PASSWORD("mynewpassword") WHERE USER='root';
```

**Flush privileges**
```
FLUSH privileges;
```

**Start MySQL**
```bash
sudo service mysql start 
```

## Check Set Variables
```
mysqladmin -u USER -ph@ckm3  VARIABLES | grep max_connections 
```

## Display default mysql config files and execute order
```
mysql --help | grep Default -A 1 
```

## Migrate MySQL users, permissions and database

[Migrate MySQL Settings](http://www.it-iss.com/mysql/mysql-copying-a-database-users-and-privileges-between-two-servers/)


## MYSQL Engines

InnoDB is almost always the best option, since it has good concurrency support.

MyISAM may be faster in single-user or read-only installations. MyISAM databases tend to get corrupted more often than InnoDB databases.



## MYSQL Character Encoding

In binary mode, is more efficient than MySQL's UTF-8 mode, and allows you to use the full range of Unicode characters.

In UTF-8 mode, MySQL will know what character set your data is in, and can present and convert it appropriately, but it will not let you store characters above the Basic Multilingual Plane. | utf-8 | | 26 | 


## Create tables
```
     CREATE TABLE tutorials_tbl(
       tutorial_id INT NOT NULL AUTO_INCREMENT,
       tutorial_title VARCHAR(100) NOT NULL,
       tutorial_author VARCHAR(40) NOT NULL,
       submission_date DATE,
       PRIMARY KEY ( tutorial_id )
    );
```

Field Attribute NOT NULL is being used because we do not want this field to be NULL. So if user will try to create a record with NULL value, then MySQL will raise an error.

Field Attribute AUTO_INCREMENT tells MySQL to go ahead and add the next available number to the id field.

Keyword PRIMARY KEY is used to define a column as primary key. You can use multiple columns separated by comma to define a primary key. 

