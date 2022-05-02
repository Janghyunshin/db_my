-- �ָ� ����
	
-- [����1] ������ ���� ���� ���̺��� �������� �Ʒ� ���׿� ���Ͻÿ�

-- EQUI ������ ����Ͽ� SCOTT ����� �����ȣ, ����̸�, ��å, �μ���ȣ,  �μ��̸��� ��� �Ͻÿ�

select eno, ename, job, e.dno, dname
from employee e, department d
where e.dno = d.dno
and ename =  'SCOTT';

-- [����2] ANSI ȣȯ�� INNER ������ ����Ͽ� SCOTT ����� �����ȣ, ����̸�, ��å, �μ���ȣ,  �μ��̸��� ��� �Ͻÿ� .

select eno, ename, job, e.dno, dname
from employee e inner join department d
on e.dno = d.dno
where ename = 'SCOTT';

-- 	[����3] employee ���̺��� �����ؼ� emp_copy ���̺��� ���� �Ͻÿ�, department ���̺��� �����ؼ� dept_copy ���̺��� �����Ͻÿ�.
create table emp_copy
as
select *
from employee;

select * from emp_copy;
commit;

create table dept_copy
as
select *
from department;

select * from dept_copy;
commit;

	
-- [����4] Alter Table �� ����ؼ� 3�� ������ emp_copy, dept_copy ���̺��� ���� ������ �߰� �Ͻÿ�.

--    - emp_copy ���̺��� eno �÷��� Primary Key ���� ������ �߰��Ͻÿ�. ( ���������̸�: emp_copy_eno_pk )
--    - dept_copy ���̺��� dno �÷��� Primary Key ���������� �߰��Ͻÿ� ( ���������̸�: dept_copy_don_pk )
--    - emp_copy ���̺��� dno �÷��� Foreign Key ���� ������ �߰� �Ͻÿ� ( ���������̸�: emp_copy_dno_fk )

Alter table emp_copy
add constraint emp_copy_eno_pk Primary key (eno);
Alter table dept_copy
add constraint dept_copy_don_pk Primary key (dno);
Alter table emp_copy
add constraint emp_copy_dno_fk Foreign Key (dno) references dept_copy (dno); 

select * from user_constraints
where table_name in ('EMP_COPY', 'DEPT_COPY');

-- 	[����5] employee ���̺��� ��å�� ��SALESMAN�� �� ����� �����ȣ, ����̸�, �μ���ȣ, ��å��
    -- ����ϴ� �並 �����Ͻÿ� (���̸� : v_emp_job) ??������ �並 ����ϴ� ������ �ۼ��Ͻÿ�.
    
create view v_emp_job
as
select eno, ename, dno, job
from employee
where job = 'SALESMAN';

select * from v_emp_job;

--	[����6] v_auto_join �� �̸�����  1�� ������ JOIN ������ �����ϴ� �並 ����ÿ�. �並 ����ϴ� ������ �ۼ��Ͻÿ�.

create view v_auto_join
as
select eno, ename, job, e.dno, dname
from employee e, department d
where e.dno = d.dno
and ename =  'SCOTT';

select  * from v_auto_join;

--	[����7] employee ���̺��� ename �÷��� �˻��� ���� ����ϴ� �÷��Դϴ�. ���÷��� index �� �����Ͻÿ�. ?
-- ( �ε��� �̸� : idx_employee_ename )

create index idx_employee_ename
on employee(ename);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE');

-- 	[����8] NVL2 �Լ��� ����Ͽ� �� ����� ������ ����ϴ� ������ �ۼ��Ͻÿ�. 
    -- ��� �÷��� [����̸�], [����] ���� ��Ī �̸��� ����Ͽ� ��� �Ͻÿ�.
    
select ename as ����̸� , NVL2(commission, salary * 12 + commission, salary * 12) as ���� 
from employee;

	
-- [����9] �ʱⰪ 1 ������ 1�� �����ϴ� �������� �����Ͻÿ�. �� cache�� �������� �ʵ��� �����Ͻÿ�.
-- department ���̺��� ������ �����Ͽ� dept_copy ���̺��� �����Ͽ� dno �÷��� ������ �������� ���� �Ͻÿ�.
drop table dept_copy cascade constraints;

create table dept_copy
as 
select *
from department
where 0=1;

create sequence dept_seq
    increment by 10
    start with 10
    nocache;

insert into dept_copy
values (dept_seq.nextval, 'SALES', 'SEOUL');
commit;

select * from dept_copy;

--	[����10] self ������ ����ؼ� Employee ���̺���  ���޻���ȣ�� �ش� �ϴ� ���� ������ ����Ͻÿ�.
-- ��� �÷��� [�����ȣ], [����̸�], [���޻���ȣ],[���޻���] ���� ��Ī�̸����� ����Ͻÿ�. 

select e.eno �����ȣ, e.ename ����̸�, e.manager ���޻���ȣ, m.ename ���޻���
from employee e , employee m
where e.manager = m.eno;

select * from employee;