/* 권한 관리 */
/*
    사용 권한 : DBMS는 여러명이 사용
        -- 각 사용자별로 계정을 생성 : DBMS에 접속할 수 있는 사용자를 생성
            (인증 (Authentication : Credential (Identity + Password) 을 확인
            (허가 (Authorization : 인증된 사용자에게 Oracle의 시스템 권한 , 객체( 테이블, 뷰, 트리거, 함수..) 권한
                - System Privileges : 오라클의 전반적인 권한 할당
                - Object Privileges : (테이블, 뷰, 트리거, 함수, 저장프로시저, 시퀀스, 인덱스 ...) 접근 권한 
*/

-- Oracle 에서 계정 생성 (일반 계정에서는 계정을 생성할 수 있는 권한이 없다.)
show user;

-- 최고 관리자 계정 (sys) : 계정을 생성할 수 있는 권한을 가지고 있다.
-- 아이디 : usertest01 , 암호 :  1234 
create user usertest01 identified by 1234;

-- 계정과 암호를 생성했다고 해서 오라클에 접속할 수 있는 권한을 부여받아야 접속 가능

-- system privileges : 
    -- Create Session : 오라클에 접속할 수 있는 권한 
    -- Create Table : 오라클에서 테이블을 생성할 수 있는 권한 
    -- Create Sequence : 오라클에서 시퀀스를 생성할 수 있는 권한
    -- Create View  : 오라클에서 뷰를 생성할 수 있는 권한



DDL : 객체 생성 (Create, Alter, drop )
DML : 레코드 조작 (Insert, Update, delete)
DQL : 레코드 검색 ( Select )
DTL : 트랜잭션 ( Begin transaction, rollback, commit)
DCL : 권한관리 ( Grant , Revoke, Deny) 

-- 생성한 계정에게 오라클에 접속할 수 있는 Create Session 권한 부여.

-- grant  부여할권한  to  계정명 
grant create session to usertest01;

-- 오라클에 접속했다고 해서 테이블을 접근할 수 있는 권한이 없다.
-- 테이블 생성 권한 부여 
grant create table to usertest01;

/* 테이블 스페이스 (Table Space) : 객체 ( 테이블, 뷰, 시퀀스, 인덱스, 트리거, 저장프로시져, 함수...)
    를 저장하는 공간. 관리자 계정에서 각 사용자 별 테이블 스페이스 확인.
    SYSTEM : DBA ( 관리자 계정에서만 접근이 가능)
*/
select * from dba_users;    -- dba_ : sys ( 최고 관리자 계정에서 확인 )

select username, default_tablespace as DataFile , temporary_tablespace as LogFIle
from dba_users
where username in ('HR', 'USERTEST01'); 

-- 계정에게 테이블 스페이스 변경 (SYSTEM ==> USERS)
alter user usertest01
default tablespace users
temporary tablespace temp;

-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간 할당. ( users 테이블 스페이스에 2mb를 사용 공간 할당)
alter user usertest01
quota 2m on users;

-- < SQL command Line 으로 입력>
--create table tbl1 (
--    a number(4) not null,
--    b number(4) 
--    );

-- ->  (테이블 만들어짐)

===============================================================================
완료 시간 1시 20분 

계정명: wine_account
암호 : 1234

기본 테이블 스페이스 : WINE_DATAFILE     100MB 100MB 증가 무제한  <= A 하드
임시 테이블 스페이스 : WINE_LOG          100MB 100MB 증가 1GB    <= B 하드 

테이블 10개 생성후 : 각 테이블 값 ( 레코드 : 3개씩 추가) 








