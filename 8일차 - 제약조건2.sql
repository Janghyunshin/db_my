---- 테이블 정의서 ----

/*
    Foreign key로 참조되는 테이블 삭제시
        1. 자식 테이블을 먼저 삭제 후 부모 테이블 삭제
        2. 제약조건 제거 후 테이블 삭제
        3. cascade constraint 옵션으로 테이블을 강제 삭제
*/

-- 테이블 삭제시 주의 사항 : 다른 테이블에서 Foreign Key로 자신의 테이블을 참조 하고 있으면 삭제가 안됨.
    -- 다른 테이블이 참조 하고 있더라도 강제로 삭제하는 옵션 : cascade
        
drop talbe orders
drop table member;      -- 오류발생 : Orders 테이블의 id 컬럼이 member 테이블의 id컬럼을 참조하고 있다.
drop table tb_zipcode;  -- 오류발생 : member 테이블의 zipcode 컬럼이 tb_zipcode 테이블의 zipcode 컬럼을 참조하고 있다.
drop table products;


-- 테이블 생성 시 (Foreign Key) : 부모테이블 (FK 참조 테이블) 을 먼저 생성해야 한다. 자식 테이블 생성.
    -- 자식 테이블을 생성할때 FK를 넣지 않고 생성후, 부모테이블 생성후, Alter Table을 사용해서 나중에 FK를 넣어준다.

-- 제약 조건 제거 후에 테이블 삭제 
alter table member 
drop constraint FK_member_id_tb_zipcode;

alter table tb_zipcode 
drop constraint PK_tb_zipcode_zipcode;

alter table orders
drop constraint FK_ORDERS_ID_MEMBER;

alter table products 
drop constraint PK_products_product_code;

-- 제약 조건 확인 

select * from user_constraints
where table_name = 'TB_ZIPCODE';

drop table member;

-- cascade constraints 옵션을 사용해서 삭제, <== Foreign key 제약 조건을 먼저 후 삭제

drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

-- 트랜잭션 발생 : DML : insert, update, delete <== commit

-- 누락 컬럼 추가
alter table tb_zipcode
add zip_seq varchar2(30);

-- 컬럼 이름 변경 (bungi -> bunji, gugum -> gugun)
alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
rename column gugum to gugun;

-- 부족한 자리수 늘려주기

alter table tb_zipcode
modify zipcode varchar2 (100);

alter table tb_zipcode
modify dong varchar2 (100);

-- 제약 조건 잠시 비활성화 하기 ( 잠시 비활성화 하기)   
    -- <== Bulk Insert (대량으로 Insert) : 제약 조건으로 인해서 Insert 되는 속도가 굉장히 느립니다.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;    -- 오류 발생 : member 테이블의 zipcode 컬럼이 참조하고 있다.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;

select * from user_constraints
where table_name IN ( 'MEMBER', 'TB_ZIPCODE');

select * from user_constraints
where table_name = 'TB_ZIPCODE';

select constraint_name, table_name, status from user_constraints
where table_name in('MEMBER', 'TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode   -- 기존의 레코드만 모두 제거 ( 빠르게 모든 레코드 삭제)

delete tb_zipcode;          -- 기존의 레코드만 모두 제거 ( 삭제가 느리다 - 대량일 경우)

-- 제약조건 활성화 하기

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipcode;    

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipcode cascade;

-- zip.sql insert

select count(*) from tb_zipcode;

-- zip.seq 컬럼의 정렬이 제대로 안된 이유 제대로 정렬 되도록 해보기.
    -- 문자 정렬 형식으로 출력됨 , to_number 로 숫자로 형변환후 정렬
    
select * from tb_zipcode
order by to_number (zip_seq, 9999999 );

truncate table tb_zipcode;

desc tb_zipcode;

/* 제약 조건 수정 (Alter Table) : 기존의 테이블에 제약 조건을 수정 */

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;

select * from emp_copy50;
select * from dept_copy50;

select * from user_constraints
where table_name in ('EMPLOYEE' , 'DEPARTMENT');

select * from user_constraints
where table_name in ('EMP_COPY50' , 'DEPT_COPY50');

-- 테이블을 복사하면 레코드만 복사가 된다. (테이블의 제약조건은 복사되어 오지 않는다. Alter table을 사용해서 제약조건을 적용)
    -- Alter table 를 사용해서 제약조건을 적용

select * from emp_copy50;
select * from dept_copy50;

-- primary key

alter table emp_copy50
add constraint PK_EMP_COPY50_eno Primary Key (eno);

alter table dept_copy50
add constraint PK_DEPT_COPY50_DNO Primary key (dno) ; 

-- Foreign Key

alter table emp_copy50
add constraint FK_EMP_COPY50_Dno_dept_copy50 Foreign Key (dno) references dept_copy50(dno);

-- NOT NULL 제약 조건 추가. (구문이 다르다, add 대신에 modify를 사용)
desc employee;
desc emp_copy50;     -- Not Null 을 넣지 않았지만, Primary key 제약 조건을 할당,
desc department;
desc dept_copy50;    -- Primary key 적용으로 자동으로 Not null

    -- 기존의 null 이 들어가 있는 곳에는 not null 컬럼으로 지정할 수 없다.
select ename from emp_copy50
where ename is null;

alter table emp_copy50
modify ename constraint NN_EMP_COPY50_ENAME not null ;

    -- commission 컬럼에 not null 할당 하기 : null 이 들어가 있는 경우 null 을 처리 
select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_EMP_COPY50_COMMISSION not null;

-- NULL -> 0으로 값 수정
update emp_copy50
set commission = 0
where commission is null;

-- Unique 제약 조건 추가 : 컬럼에 중복된 값이 있으면 할당 하지 못한다.

select ename, count(*)
from emp_copy50
group by ename
having count(*) > 1;

alter table emp_copy50
add constraint UK_emp_copy50_ename Unique (Ename);

-- check 제약 조건 추간

select * from emp_copy50;

alter table emp_copy50
add constraint CK_EMP_COPY50_SALARY Check (salary > 0 and salary < 10000);

-- default 제약 조건 추가 << 사실 제약조건이 아님 : 제약조건 이름을 할당할 수 없다. 
    -- 값을 넣지 않을 경우 default 로 설정된 값이 들어간다.
alter table emp_copy50
modify salary default 1000; 

desc emp_copy50;

insert into emp_copy50 ( eno, ename, commission)
values ( 9999, 'JULI', 100);

insert into emp_copy50 
values ( 8888, 'JULIA', null, null, default, default, 1500, null);

select * from emp_copy50;

/* 제약 조건 제거 : Alter Table 테이블 명 drop*/

-- Primary key 제거 : 테이블에 하나만 존재함.

alter table emp_copy50   -- 오류 없이 제거됨.
drop primary key;

alter table dept_copy50  -- 오류 발생 : foreign key가 참조 하기 때문에 삭제 안됨. 
drop primary key;

alter table dept_copy50  -- foreign key를 먼저 제거하고 primary key 제거
drop primary key cascade;

select * from user_constraints
where table_name in('EMP_COPY50', 'DEPT_COPY50');

-- not null 컬럼 제거 하기 : 제약 조건 이름으로 삭제
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME ;

-- Unique, check 제약조건 제거 << 제약조건 이름으로 제거 >>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint CK_EMP_COPY50_SALARY;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

-- defualt는 null 허용 컬럼은 default null 로 셋팅 : default 제약 조건을 제거하는 것.
alter table emp_copy50
modify hiredate default null;

/* 제약 조건 disable / enable 
    - 제약조건을 잠시 중지 시킴.
    - 대량 (Bulk Insert) 으로 값을 테이블에 추가할때 부하가 많이 걸린다. disable ==> enable
    - Index를 생성시 부하가 많이 걸린다.    disable ==> enable
*/

alter table dept_copy50
add constraint PK_dept_copy50_dno Primary Key (dno);

alter table emp_copy50
add constraint PK_emp_copy50_eno Primary Key (eno);

alter table emp_copy50
add constraint FK_emp_copy50_dno Foreign Key (dno) references dept_copy50 (dno);

select * from user_constraints
where table_name in ('EMP_COPY50', 'DEPT_COPY50');

select * from emp_copy50;
select * from dept_copy50;

alter table emp_copy50
disable constraint FK_EMP_COPY50_DNO;

insert into emp_copy50 (eno, ename, dno)
values (8989, 'aaaa', 50);

insert into dept_copy50 
values (50, 'HR', 'SEOUL');

alter table emp_copy50
enable constraint FK_emp_copy50_dno;

