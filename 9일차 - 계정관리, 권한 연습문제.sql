
-- 9일차 - 계정관리, 권한 연습문제

-- 문제 : usertest02 계정을 생성 후에 users 테이블 스페이스에서 테이블 (tbl2) 생성후 insert . (18:15 까지)

    -- 각 사용자별로 계정을 생성 : DBMS에 접속할 수 있는 사용자를 생성.
        ( 인증 ( Authentication : Credential (Identity + password) 확인
        ( 허가 (Authorization : 인증된 사용자에게 Oracle의 시스템 권한 객체,
            -- System Privileges : 오라클의 
-- 오라클에서 계정 생성 ( 일반 계정에서는 계정을 생성할 수 있는 권한이 없다.)
-- 현재 접속 계정확인 (최고 관리자 sys계정으로 만들어야함)
show user;

-- usertest02 계정 생성 아이디 usertest02 , 비밀번호 1234
create user usertest02 identified by 1234;

-- Object privileges : 테이블, 뷰, 트리거, 함수,
    -- 저장프로시져, 시퀀스, 인덱스에 부여되는 권한할당.
    ============================================
    권한      Table   view    SEQUENCE    PROCEDURE
    Alter       0               0   
    Delete      0      0        
    Execute                                 0
    Index       0                   
    Insert      0      0
    Reference   0
    Select      0      0        0
    Update      0      0

    -- 특정 테이블에 select 권한 부여 하기
        create user user_test10 identified by 1234;

-- system Privileges :
    -- Create Session : dhfkzmfdp wjqthrgkf tn dlTsms rnjsgks
    -- Create Table : 오라클에서 테이블을 생성할 수 있는 권한
    -- Create Sequence : 시퀀스 생성할 수 있는 권한
    -- Create View : 뷰를 생성할 수 있는 권한

DDL: 객체 생성  (Create, Alter, Drop)
DML: 레코드 조작 (Insert, Update, Delete)
DQL: 레코드 검색 (Select)
DTL: 트랜잭션 (Begin Transaction, rollback, commit)
DCL: 권한 관리 (Grant, Revoke, Deny)

-- 접속 권한 부여, -- 테이블 생성 권한 부여
grant create session, create table to usertest02; 

select * from dba_users;

-- 권한 확인 (최고관리자 계정 sys에서)
select username, default_tablespace , temporary_tablespace 
from dba_users
where username in ('HR', 'USERTEST02'); 

-- tablespace 변경 (system -> users)
alter user usertest02
default tablespace users    -- DataFile 저장 : 객체가 저장되는 공간 (테이블, 뷰, 트리거, 인덱스 .....)
temporary tablespace temp;  -- Log 를 저장 :  DML (Insert, Update, Delete) ,
                            -- Log 를 호칭할 때  Transaction Log. 시스템의 문제 발생시 백업시점이 아니라 오류난 시점까지 복구

-- 테이블 스페이스 : 객체와 Log를 저장하는 물리적인 파일
    -- DATAFILE : 객체를 저장하고 있다. (테이블, 뷰, 인덱스....)
    -- Log : Transaction Log를 저장
    
    -- DataFile과 Log 파일은 물리적으로 다른 하드공간에 저장해야 성능을 높일 수 있다.


-- tablespace 사용공간 할당 (quota 를 100m 으로 설정)
alter user usertest02
quota 100m on users;

select * from all_tables   -- 테이블의 소유주를 출력해 준다. 계정별로 소유한 테이블을 출력할 수 있따.
where owner in ('HR','USERTEST01','USERTEST02');

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