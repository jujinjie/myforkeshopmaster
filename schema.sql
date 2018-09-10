CREATE DATABASE IF NOT EXISTS group_db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE group_db;

CREATE TABLE users
(
	userid int NOT NULL AUTO_INCREMENT,
	username varchar(255) NOT NULL,
	phonenum varchar(255) ,
	addr varchar(255),
	wxid text NOT NULL,
	PRIMARY KEY (userid)
);

CREATE TABLE commodity
(
	commodityid int NOT NULL AUTO_INCREMENT,
	commodity_name varchar(255) NOT NULL,
	price decimal(10, 2) NOT NULL,
	descr text NOT NULL,
	imgpath varchar(255) NOT NULL,
	group_status tinyint(4) Not NULL DEFAULT 0,
	CreateTime DATETIME,
	expiration_date DATETIME NOT NULL,
	PRIMARY KEY (commodityid)
);


CREATE TABLE myorder
(
	orderid int NOT NULL AUTO_INCREMENT,
	userid int NOT NULL,
	commodityid int NOT NULL,
	num int NOT NULL,
	PRIMARY KEY (orderid),
	FOREIGN KEY (userid) references users(userid),
	FOREIGN KEY (commodityid) references commodity(commodityid)
);

CREATE TABLE track
(
	commodityid int NOT NULL,
	totalnum int NOT NULL,
	arrivaldate DATE NOT NULL,
	is_all_arrival boolean NOT NULL,
	num_arrival int NOT NULL,
	num_pending int NOT NULL,
	FOREIGN KEY (commodityid) references commodity(commodityid)
);

CREATE TABLE pocket
(
	userid int NOT NULL,
	pocketno int NOT NULL,
	PRIMARY KEY (pocketno),
	FOREIGN KEY (userid) references users(userid)
);

CREATE TABLE goods_pocket
(
	orderid int NOT NULL,
	userid int NOT NULL,
	commodityid int NOT NULL,
	pocketno int NOT NULL,
	FOREIGN KEY (orderid) references myorder(orderid),
	FOREIGN KEY (userid) references users(userid),
	FOREIGN KEY (commodityid) references commodity(commodityid),
	FOREIGN KEY (pocketno) references pocket(pocketno)
);


CREATE TABLE getgoods
(
	orderid int NOT NULL,
	userid int NOT NULL,
	commodityid int NOT NULL,
	gettime DATETIME NOT NULL,
	FOREIGN KEY (orderid) references myorder(orderid),
	FOREIGN KEY (userid) references users(userid),
	FOREIGN KEY (commodityid) references commodity(commodityid)
);

CREATE TABLE payment
(
	orderid int NOT NULL,
	userid int NOT NULL,
	pay decimal (10,2) NOT NULL,
	is_pay boolean NOT NULL,
	FOREIGN KEY (orderid) references myorder(orderid),
	FOREIGN KEY (userid) references users(userid)
);

CREATE TABLE account 
(
  Id int(100) NOT NULL AUTO_INCREMENT,
  AccountName char(50) NOT NULL,
  AccountPass char(50) NOT NULL,
  CreateTime datetime NOT NULL,
  Role varchar(255) DEFAULT NULL,
  AccountState tinyint(4) DEFAULT '1' COMMENT '1：正常，2：冻结',
  wxid text NOT NULL,
  PRIMARY KEY (Id),
  UNIQUE KEY Id (Id) USING BTREE,
  UNIQUE KEY AccountName (AccountName,AccountPass) USING BTREE
);

INSERT INTO `account` VALUES ('100002', 'admin', 'admin', '2016-10-17 14:20:49', '管理员', '1','100002');

