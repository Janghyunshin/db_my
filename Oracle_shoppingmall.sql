create table product(
id		    number primary key,
category	varchar2(10) not null,
wname		varchar2(20) not null,
pname		varchar2(20) not null,
sname		varchar2(20) not null,
price		number default 0,
downprice	number default 0,
inputdate	varchar2(20),
stock		number default 0,
description	varchar2(100),
small		varchar2(20),
large		varchar2(20)
);

create table saleorder(
id		    number primary key,
name		varchar2(20) not null,
orderdate	varchar2(20) not null,
addr		varchar2(50) not null,
tel		    varchar2(20) not null,
pay		    varchar2(10) not null,
cardno		varchar2(20) not null,
prodcount	number default 0,
total		number default 0
);

create table item(
orderid		number not null,
mynum		number not null,
prodid		number not null,
pname		varchar2(40),
quantity	number default 0,
price		number default 0
);

select * from product;

select * from item; 		-- 주문한 상품의 자세한 정보

select * from saleorder; 	-- 주문 테이블 

commit;

drop table product;
drop table saleorder;
drop table item;