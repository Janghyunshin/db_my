-- 10 : ������ ���Ἲ�� ���� ����, 11 ��

-- 1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
-- ��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 

-- ���̺� ����
create table emp_sample
as
select *
from employee
where 0=1 ;

select * from emp_sample;

-- Primary Key �������� �߰�
alter table emp_sample
add constraint PK_EMP_SAMPLE_ENO Primary Key(eno);

-- �������� Ȯ��
select * from user_constraints
where table_name = 'EMP_SAMPLE';

-- 2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
-- �μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 

-- ���̺� ���� (������ ����)
create table dept_sample
as
select *
from department
where 0=1;

-- Primary Key �������� �߰�
alter table dept_sample
add constraint PK_DEPT_SAMPLE_DNO Primary Key(dno);

-- �������� Ȯ��
select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

-- 3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ�
-- ���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
select * from emp_sample;

-- Foreign �������� �߰�
alter table emp_sample
add constraint FK_EMP_SAMPLE_DNO_DEPT_SAMPLE Foreign key (dno) references dept_sample (dno);

-- ���� ���� Ȯ�� 
select * from user_constraints
where table_name in ( 'EMP_SAMPLE', 'DEPT_SAMPLE');

-- 4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
select * from emp_sample;

-- Check ���� ���� �߰�
alter table emp_sample
add constraint CK_EMP_SAMPLE_COMMISSION check ( commission > 0);

-- 5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
-- alter table
-- modify               <= default, Not Null

-- default �������� �߰�
alter table emp_sample
modify salary default 1000;

-- 6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

-- Unique �������� �߰�
alter table emp_sample 
add constraint UK_EMP_SAMPLE_ENAME Unique (ename);

-- 7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
select * from emp_sample;

-- �������� disable 
alter table emp_sample
disable constraint CK_EMP_SAMPLE_COMMISSION;

-- null�� 0���� ����
update emp_sample
set commission = 0
where commission is null;

-- NOT NULL �������� �߰�
alter table emp_sample
modify commission constraint NN_EMP_SAMPLE_COMMISSION not null;

-- 8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 

-- �������� Ȯ��
select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

-- ���������� ���� �� : Foreign Key �����ϸ� ���Ű� �ȵȴ�
    -- 1. Foreign Key�� ���� ���� �� Primary Key ����
    -- 2. Primary Key�� �����Ҷ� cascade �ɼ��� ��� : Foreign Key ���� ���� �ǰ� Primary Key�� ���ŵ�
    
alter table emp_sample 
drop primary key;   -- PK ����

alter table dept_sample
drop primary key cascade; -- fk ������ pk�� ����

alter table emp_sample 
drop constraint NN_EMP_SAMPLE_COMMISSION; -- NOT NULL ����

alter table emp_sample 
drop constraint CK_EMP_SAMPLE_COMMISSION;   -- CHECK ����

alter table emp_sample 
drop constraint UK_EMP_SAMPLE_ENAME;    -- UNIQUE ����

-- �������� ���� Ȯ��
select * from user_constraints
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

-- <<< �� ���� >>>> 

-- 1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
-- ���� �̸� : v_em_dno  
    -- �� : ������ ���̺�, select ���� �� �� �ִ�.
        -- ������ ���ؼ� : ���� ���̺��� �÷��� ���� �� �ִ�.
        -- ���Ǽ��� ���ؼ� : ������ ������ view�� �����ϸ�, ������ Join
    create table emp_view
    as
    select * from employee;

-- �� ���� 
create view v_em_dno  
as
select eno, ename, dno
from emp_view
where dno = 20;

-- �� ���� 
select * from v_em_dno;

-- 2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 

-- �� ���� / ����
create or replace view v_em_dno  
as
select eno, ename, dno, salary
from emp_view
where dno = 20;

select * from v_em_dno;

-- 3. ������  �並 ���� �Ͻÿ�. 
-- �� ����
drop view v_em_dno;

-- 4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
--	���̸� : v_sal_emp

-- �׷��� �� ���� (��Ī�� �ٿ������)
create view v_sal_emp
as
select min(salary) min, max(salary) max, round(avg(salary)) avg, sum(salary) sum
from emp_view
group by dno;

select * from v_sal_emp;

-- 5. �̹� ������ ��( v_em_dno ) �� ���ؼ� <<�б����� ���>> �����Ͻÿ�. 

-- �б����� ��� ���� (read only)
create or replace view v_em_dno  
as
select eno, ename, dno, salary
from employee 
where dno = 20 with read only;

select * from v_em_dno;
