-- 7일차 테이블 정의서

create table member (
    id varchar2(20) not null constraints PK_member_id Primary key,
    pwd varchar2(20) ,
    name varchar2(50),
    zipcode varchar2(7),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate,
            constraints FK_member_id_tb_zipcode Foreign Key (zipcode) references tb_zipcode (zipcode)
            );

select * from member;

insert into member
values ('aaaaa', '1234', '홍길동', '111-111', '서울시 금천구', '010-1111-1111', default); 

insert into member
values ('bbbbb', '1234', '광개토대왕', '123-123', '서울시 관악구', '010-2222-2222', to_Date('2022-01-01', 'YYYY-MM-DD'));         

insert into member
values ('ddddd', '1234', '선덕여왕', '222-222', '서울시 구로구', '010-3333-3333', to_Date('2022-03-01', 'YYYY-MM-DD'));

commit;

create table tb_zipcode (
    zipcode varchar2(7) not null constraints PK_tb_zipcode_zipcode Primary Key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
    );

select * from tb_zipcode;

insert into tb_zipcode
values ('111-111', '서울시', '금천구', '가산동', '1번지');

insert into tb_zipcode
values ('222-222', '서울시', '구로구', '구로동', '2번지');

insert into tb_zipcode
values ('123-123', '서울시', '관악구', '신림동', '3번지');

commit;
    
create table products (
    product_code varchar2(20) not null constraints PK_products_product_code Primary Key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
    );

select * from products;

insert into products
values ('1000', '우산', 'Y', '1500', '5000', '접이식 우산', '우산 1', 'SMALL', 'LARGE', '100', 'N', to_Date('2022-04-04', 'YYYY-MM-DD'));

insert into products (product_code, product_name, product_price1, product_price2, product_quantity)
values ('2000', '모자', '1000', '3000', 99);

insert into products
values ('3000', '신발', 'Y', '15000', '89000', '편안한 운동화', '운동화 3', '230', '290', '50', 'Y', sysdate);

insert into products
values ('4000', '팔찌', 'N', '10000', 55000, '은색 팔찌', '팔찌 1', 'SMALL', 'LARGE', '10', 'Y', sysdate);

commit; 
    
create table orders (
    o_seq number(10) not null constraints PK_orders_o_seq Primary Key,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date,
        constraints FK_Orders_product_code Foreign Key (product_code) references products (product_code),
        constraints FK_Orders_id_member Foreign Key (id) references member (id)
    );

insert into orders
values (12345, '1000', 'aaaaa', 'SMALL', '2', 'Y', to_Date('2022/04/19', 'YYYY/MM/DD'));

insert into orders 
values (23456, '2000', 'bbbbb', 'LARGE', '1', 'N', to_Date('20220423', 'YYYYMMDD'));

insert into orders (o_seq, product_code, id, product_size, quantity, indate)
values (34567, '3000', 'ddddd', 'LARGE', '10', sysdate);

rollback;
commit;
select * from orders;

desc member;
desc tb_zipcode;
desc products;
desc orders;