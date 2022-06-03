Create table t_member (
    id varchar2(10) primary key,
    pwd varchar2(10) not null,
    name varchar2(50) not null,
    email varchar2(100) null, 
    joinDate date default sysdate
    );

-- 더미 데이터 입력
insert into t_member 
values ('hong', '1234', '홍길동', 'hong@gmail.com', sysdate);
insert into t_member 
values ('lee', '1234', '이순신', 'lee@gmail.com', sysdate);
insert into t_member 
values ('kim', '1234', '김유신', 'kim@gmail.com', sysdate);   

select * from t_member;
