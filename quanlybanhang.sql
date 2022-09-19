CREATE DATABASE QUANLYBANHANG;
USE QUANLYBANHANG;
CREATE TABLE CUSTOMER(
CID INT NOT NULL PRIMARY KEY auto_increment,
CNAME VARCHAR(50) NOT NULL,
CAGE INT CHECK(CAGE >=18)
);
select * from CUSTOMER;
insert into CUSTOMER(cname,cage)
value('Hoang Hieu',36),('Truong Giang',31),('Duy Duong',28);
CREATE TABLE ORDERLIST(
OID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
CID INT NOT NULL,
ODATE DATETIME NOT NULL,
OTOTALPRICE DOUBLE CHECK(OTOTALPRICE > 0)
);
select * from ORDERLIST;
insert into ORDERLIST(cid, odate,ototalprice)
values (1, '2006-03-21',2300),(2,'2006-03-23',1800),(1,'2006-03-16',3400);
CREATE TABLE PRODUCT (
PID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
PNAME VARCHAR(50) NOT NULL,
PPRICE DOUBLE CHECK(PPRICE > 0)
);
select * from PRODUCT;
insert into PRODUCT(pname,pprice)
values ('Iphone 12',1800000),('Iphone 13',2000000),('Iphone 14',3500000);
CREATE TABLE ORDERDETAIL(
OID INT NOT NULL,
PID INT NOT NULL,
ODQTY DOUBLE,
PRIMARY KEY(OID,PID),
foreign key (OID) references ORDERLIST(OID),
foreign key (PID) references PRODUCT(PID)
);
select * from ORDERDETAIL;
insert into ORDERDETAIL(oid,pid,odqty)
values(1,2,3),(2,1,1),(2,3,3);
alter TABLE ORDERLIST ADD foreign key (CID) references CUSTOMER(CID);
/*Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order*/
select oid, odate, ototalprice
from orderlist;
/*Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách*/
select c.cid, c.cname, p.pname, ordt.odqty
from customer c join orderlist ord on c.cid = ord.cid join orderdetail ordt on ord.oid = ordt.oid join product p on ordt.pid = p.pid;
/*Hiển thị những khách hàng không mua sản phẩm nào*/
select c.cid, c.cname
from customer c
where c.cid not in (select orderlist.cid from orderlist);
/*Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn*/
select  o.oid, o.odate, sum(p.pprice * ord.odqty) "oTotalPrice"
from orderlist o join product p join orderdetail ord
where o.oid = ord.oid and ord.pid = p.pid
/*sắp xếp danh sách theo ID*/
group by oid;