-- 8���� - ��, ������, �ε���
/*
    �� (view) : ������ ���̺��� ��(view)�� �Ѵ�.
        -- ���̺��� ������ ���� ������ �ִ�.
        -- ��� ������ ���� ������ �ʴ´�. ���� �ڵ常 �� �ִ�.
        -- �並 ����ϴ� ����:
            1. ������ ���ؼ� : ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ����� �ִ�.
            2. ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�. (������ JOIN ����
        -- ��� �Ϲ������� select ������ �´�
        -- ��� insert, update, delete ������ �� �� ����.
        -- �信 ���� insert �ϸ� ���� ���̺� ������ �ȴ�. ���� ���̺��� ���������� �� �����ؾ� �ȴ�.
        -- �信 ���� insert �� ��� ���� ���̺��� �������ǿ� ���� insert �� ���� �ְ�, �׷��� ���� ���� �ִ�.
        -- �׷��Լ��� ������ view ���� insert �� �� ����.
*/
Create table emp_copy60
as
select * from employee;

Create table dept_copy60
as
select * from department;

-- �� ����
Create view v_emp_job
as
select eno, ename, dno, job
from emp_copy60
where job like 'SALESMAN';

-- �� ���� Ȯ��
select * from user_views;

-- ���� ����    ( select * from  ���̸� )
select * from v_emp_job;

-- ������ ���� ������ �信 ����� �α�
create view v_join
as
select e.dno, ename, job, dname, loc
from employee e , department d
where e.dno = d.dno
and job = 'SALESMAN';

select * from v_join;
drop view v_join;

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� ����� (����)
select * from emp_copy60;

create view simple_emp
as
select ename, job, dno
from emp_copy50;

select * from simple_emp;   -- view�� ����ؼ� ���� ���̺��� �߿� �÷��� �����.

select * from user_views;

-- �並 �����Ҷ� �ݵ�� ��Ī �̸��� ����ؾ� �ϴ� ���, group by �� ��

create view v_groupping
as
select dno, count(*) groupCount, avg(salary) avg, sum(salary) sum
from emp_copy60
group by dno;

select * from v_groupping;

-- �並 ������ �� as ������ select ���� �;��Ѵ�. insert, update, delete ���� �� �� ����.
create view v_error
as
insert into dno
values (60, 'HR', 'PUSAN');

-- view�� ���� insert �� �� ������? �÷��� ���� ������ �����ϸ� view ���� ���� ���� �� �ִ�.
    -- ���� ���̺� ���� insert �ȴ�.

create view v_dept
as
select dno, dname
from dept_copy60;

select * from v_dept;

insert into v_dept      -- View �� ���� insert, ���������� ��ġ�Ҷ� �� insert �ȴ�.
values ( 70 , 'HR');

select * from dept_copy60;

create or replace view v_dept   -- v_dept�� �������� ���� ��� : create , ������ ��� : replace (����)
as
select dname , loc
from dept_copy60;

insert into v_dept
values ( 'HR2', 'PUSAN');

select * from v_dept;
select * from dept_copy60;

update dept_copy60
set dno = 80
where dno is null;
commit;

alter table dept_copy60
add constraint PK_dept_copy60 Primary Key (dno);

select * from user_constraints
where table_name = 'DEPT_COPY60';

insert into v_dept
values ( 'HR3', 'PUSAN2');

select * from user_views;

select * from v_groupping;  -- �׷��ε� view ���� insert �� �� ����.

create or replace view v_groupping
as
select dno, count(*) groupCount, round(avg(salary), 2) avg, sum(salary) sum
from emp_copy60
group by dno;

drop view v_groupping;  -- View ����

-- insert, update, delete �� ������ ��

create view v_dept10
as
select dno, dname, loc
from dept_copy60;

insert into v_dept10
values ( 90, 'HR4', 'PUSAN4');

select * from v_dept10;

update v_dept10
set dname = 'HR5', loc = 'PUSAN5'
where dno = 90;

delete v_dept10
where dno = 90;
commit;

-- �б⸸ ������ �並 ���� (insert, update, delete ���ϵ��� ����)
create view v_readonly
as
select dno, dname ,loc
from dept_copy60 with read only;

select * from v_readonly;

insert into v_readonly
values (88, 'HR7', 'PUSAN7');

update v_readonly
set dname = 'HR77', LOC = 'PUSAN77'
where dno = 88;

delete v_readonly
where dno = 88;
