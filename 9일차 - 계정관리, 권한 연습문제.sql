
-- 9일차 - 계정관리, 권한 연습문제

-- 문제 : usertest02 계정을 생성 후에 users 테이블 스페이스에서 테이블 (tbl2) 생성후 insert . (18:15 까지)

-- 현재 접속 계정확인 (최고 관리자 sys계정으로 만들어야함)
show user;

-- usertest02 계정 생성 아이디 usertest02 , 비밀번호 1234
create user usertest02 identified by 1234;

-- 접속 권한 부여, -- 테이블 생성 권한 부여
grant create session, create table to usertest02; 

select * from dba_users;

-- 권한 확인 (최고관리자 계정 sys에서)
select username, default_tablespace , temporary_tablespace 
from dba_users
where username in ('HR', 'USERTEST02'); 

-- tablespace 변경 (system -> users)
alter user usertest02
default tablespace users
temporary tablespace temp;

-- tablespace 사용공간 할당 (quota 를 100m 으로 설정)
alter user usertest02
quota 100m on users;

/* tbl2에 값 insert (command line으로)
create table tbl2 (
    a number(4) not null,
    b number(4)
    );
    
select * from tbl2; 

insert into tbl2
values (1111,2222);

insert into tbl2
values (2222,3333);
*/