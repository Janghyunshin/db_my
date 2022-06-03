select * from member01;

create table member02 (
    u_id varchar2(50) not null primary key,
    u_pass varchar2(50) not null,
    u_Name varchar2(50) not null,
    r_date date default sysdate not null,
    u_address varchar(200) not null,
    u_tel varchar2(50) not null,
    u_birthday varchar2(50) not null
    );

select * from member02;

insert into member02
values ('admin@kosmo.com', '1234', '관리자', default, '서울', '010-1111-1111', sysdate);
insert into member02
values ('hongkd@kosmo.com', '1234', '홍길동', default, '경기', '010-2222-2222', sysdate);

commit;


create table member (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    primary key (id)
    );

-- 더미 데이터 입력
insert into member ( id, pass, name) 
values ('admin','1234','관리자');
insert into member ( id, pass, name) 
values ('hong','1234','홍길동');

select * from member;
commit;

create table member03 (
    id varchar2(10) not null,
    pass varchar2(10) not null,
    name varchar2(30) not null,
    regidate date default sysdate not null,
    grade varchar2(50) not null,
    primary key (id)
    );
    
-- 더미 데이터 입력
insert into member ( id, pass, name) 
values ('admin','1234','관리자');
insert into member ( id, pass, name) 
values ('hong','1234','홍길동');


select * from member03;

