---- ���̺� ���Ǽ� ----

/*
    Foreign key�� �����Ǵ� ���̺� ������
        1. �ڽ� ���̺��� ���� ���� �� �θ� ���̺� ����
        2. �������� ���� �� ���̺� ����
        3. cascade constraint �ɼ����� ���̺��� ���� ����
*/

-- ���̺� ������ ���� ���� : �ٸ� ���̺��� Foreign Key�� �ڽ��� ���̺��� ���� �ϰ� ������ ������ �ȵ�.
    -- �ٸ� ���̺��� ���� �ϰ� �ִ��� ������ �����ϴ� �ɼ� : cascade
        
drop talbe orders
drop table member;      -- �����߻� : Orders ���̺��� id �÷��� member ���̺��� id�÷��� �����ϰ� �ִ�.
drop table tb_zipcode;  -- �����߻� : member ���̺��� zipcode �÷��� tb_zipcode ���̺��� zipcode �÷��� �����ϰ� �ִ�.
drop table products;


-- ���̺� ���� �� (Foreign Key) : �θ����̺� (FK ���� ���̺�) �� ���� �����ؾ� �Ѵ�. �ڽ� ���̺� ����.
    -- �ڽ� ���̺��� �����Ҷ� FK�� ���� �ʰ� ������, �θ����̺� ������, Alter Table�� ����ؼ� ���߿� FK�� �־��ش�.

-- ���� ���� ���� �Ŀ� ���̺� ���� 
alter table member 
drop constraint FK_member_id_tb_zipcode;

alter table tb_zipcode 
drop constraint PK_tb_zipcode_zipcode;

alter table orders
drop constraint FK_ORDERS_ID_MEMBER;

alter table products 
drop constraint PK_products_product_code;

-- ���� ���� Ȯ�� 

select * from user_constraints
where table_name = 'TB_ZIPCODE';

drop table member;

-- cascade constraints �ɼ��� ����ؼ� ����, <== Foreign key ���� ������ ���� �� ����

drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

-- Ʈ����� �߻� : DML : insert, update, delete <== commit

-- ���� �÷� �߰�
alter table tb_zipcode
add zip_seq varchar2(30);

-- �÷� �̸� ���� (bungi -> bunji, gugum -> gugun)
alter table tb_zipcode
rename column bungi to bunji;

alter table tb_zipcode
rename column gugum to gugun;

-- ������ �ڸ��� �÷��ֱ�

alter table tb_zipcode
modify zipcode varchar2 (100);

alter table tb_zipcode
modify dong varchar2 (100);

-- ���� ���� ��� ��Ȱ��ȭ �ϱ� ( ��� ��Ȱ��ȭ �ϱ�)   
    -- <== Bulk Insert (�뷮���� Insert) : ���� �������� ���ؼ� Insert �Ǵ� �ӵ��� ������ �����ϴ�.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;    -- ���� �߻� : member ���̺��� zipcode �÷��� �����ϰ� �ִ�.

alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode cascade;

select * from user_constraints
where table_name IN ( 'MEMBER', 'TB_ZIPCODE');

select * from user_constraints
where table_name = 'TB_ZIPCODE';

select constraint_name, table_name, status from user_constraints
where table_name in('MEMBER', 'TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode   -- ������ ���ڵ常 ��� ���� ( ������ ��� ���ڵ� ����)

delete tb_zipcode;          -- ������ ���ڵ常 ��� ���� ( ������ ������ - �뷮�� ���)

-- �������� Ȱ��ȭ �ϱ�

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipcode;    

alter table tb_zipcode
enable novalidate constraint PK_tb_zipcode_zipcode cascade;

-- zip.sql insert

select count(*) from tb_zipcode;

-- zip.seq �÷��� ������ ����� �ȵ� ���� ����� ���� �ǵ��� �غ���.
    -- ���� ���� �������� ��µ� , to_number �� ���ڷ� ����ȯ�� ����
    
select * from tb_zipcode
order by to_number (zip_seq, 9999999 );

truncate table tb_zipcode;

desc tb_zipcode;

/* ���� ���� ���� (Alter Table) : ������ ���̺� ���� ������ ���� */

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

-- ���̺��� �����ϸ� ���ڵ常 ���簡 �ȴ�. (���̺��� ���������� ����Ǿ� ���� �ʴ´�. Alter table�� ����ؼ� ���������� ����)
    -- Alter table �� ����ؼ� ���������� ����

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

-- NOT NULL ���� ���� �߰�. (������ �ٸ���, add ��ſ� modify�� ���)
desc employee;
desc emp_copy50;     -- Not Null �� ���� �ʾ�����, Primary key ���� ������ �Ҵ�,
desc department;
desc dept_copy50;    -- Primary key �������� �ڵ����� Not null

    -- ������ null �� �� �ִ� ������ not null �÷����� ������ �� ����.
select ename from emp_copy50
where ename is null;

alter table emp_copy50
modify ename constraint NN_EMP_COPY50_ENAME not null ;

    -- commission �÷��� not null �Ҵ� �ϱ� : null �� �� �ִ� ��� null �� ó�� 
select * from emp_copy50;

alter table emp_copy50
modify commission constraint NN_EMP_COPY50_COMMISSION not null;

-- NULL -> 0���� �� ����
update emp_copy50
set commission = 0
where commission is null;

-- Unique ���� ���� �߰� : �÷��� �ߺ��� ���� ������ �Ҵ� ���� ���Ѵ�.

select ename, count(*)
from emp_copy50
group by ename
having count(*) > 1;

alter table emp_copy50
add constraint UK_emp_copy50_ename Unique (Ename);

-- check ���� ���� �߰�

select * from emp_copy50;

alter table emp_copy50
add constraint CK_EMP_COPY50_SALARY Check (salary > 0 and salary < 10000);

-- default ���� ���� �߰� << ��� ���������� �ƴ� : �������� �̸��� �Ҵ��� �� ����. 
    -- ���� ���� ���� ��� default �� ������ ���� ����.
alter table emp_copy50
modify salary default 1000; 

desc emp_copy50;

insert into emp_copy50 ( eno, ename, commission)
values ( 9999, 'JULI', 100);

insert into emp_copy50 
values ( 8888, 'JULIA', null, null, default, default, 1500, null);

select * from emp_copy50;

/* ���� ���� ���� : Alter Table ���̺� �� drop*/

-- Primary key ���� : ���̺� �ϳ��� ������.

alter table emp_copy50   -- ���� ���� ���ŵ�.
drop primary key;

alter table dept_copy50  -- ���� �߻� : foreign key�� ���� �ϱ� ������ ���� �ȵ�. 
drop primary key;

alter table dept_copy50  -- foreign key�� ���� �����ϰ� primary key ����
drop primary key cascade;

select * from user_constraints
where table_name in('EMP_COPY50', 'DEPT_COPY50');

-- not null �÷� ���� �ϱ� : ���� ���� �̸����� ����
alter table emp_copy50
drop constraint NN_EMP_COPY50_ENAME ;

-- Unique, check �������� ���� << �������� �̸����� ���� >>
alter table emp_copy50
drop constraint UK_EMP_COPY50_ENAME;

alter table emp_copy50
drop constraint CK_EMP_COPY50_SALARY;

alter table emp_copy50
drop constraint NN_EMP_COPY50_COMMISSION;

-- defualt�� null ��� �÷��� default null �� ���� : default ���� ������ �����ϴ� ��.
alter table emp_copy50
modify hiredate default null;

/* ���� ���� disable / enable 
    - ���������� ��� ���� ��Ŵ.
    - �뷮 (Bulk Insert) ���� ���� ���̺� �߰��Ҷ� ���ϰ� ���� �ɸ���. disable ==> enable
    - Index�� ������ ���ϰ� ���� �ɸ���.    disable ==> enable
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

