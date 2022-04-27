-- 08 ���̺� ���� ���� ����   <<�Ϸ� �ð� : 12: 20>>

-- 1. ���� ǥ�� ��õ� ��� DEPT ���̺��� ���� �Ͻÿ�. 

--�÷���	������Ÿ��	ũ��	NULL
-----------------------------------------------------------------
--DNO	number		2	NOT NULL
--DNAME	varchar2		14	NULL
--LOC	varchar2		13	NULL

create table DEPT (
    dno  number(2) not null,
    dname varchar(14) null,
    loc varchar(13) null
    );

commit;

-- 2. ���� ǥ�� ��õ� ��� EMP ���̺��� ���� �Ͻÿ�. 

--�÷���	������Ÿ��	ũ��	NULL
-----------------------------------------------------------------
--ENO	number		4	NOT NULL
--ENAME	varchar2		10	NULL
--DNO	number		2	NULL

create table EMP (
    eno number(4) not null,
    ename varchar2(10) null,
    dno number(2) null
    );

desc EMP;

commit;

-- 3. ���̸��� ���� �� �ֵ��� EMP ���̺��� ENAME �÷��� ũ�⸦ �ø��ÿ�. 

--�÷���	������Ÿ��	ũ��	NULL
-----------------------------------------------------------------
--ENO	number		4	NOT NULL
--ENAME	varchar2		25	NULL		<<==���� �÷�  : 10 => 25  �� �ø�
--DNO	number		2	NULL

alter table EMP
modify ename varchar (25);


-- 4. EMPLOYEE ���̺��� �����ؼ� EMPLOYEE2 �� �̸��� ���̺��� �����ϵ� �����ȣ, �̸�, �޿�, �μ���ȣ �÷��� �����ϰ�
    -- ���� ������ ���̺��� �÷����� ���� EMP_ID, NAME, SAL, DEPT_ID �� ���� �Ͻÿ�. 
create table EMPLOYEE2
as
select eno as EMP_ID, ename as NAME, salary as SAL, dno as DEPT_ID
from employee;

select * from employee2;

-- 5. EMP ���̺��� ���� �Ͻÿ�. 
drop table EMP;

select * from emp;

-- 6. EMPLOYEE2 �� ���̺� �̸��� EMP�� ���� �Ͻÿ�. 
rename EMPLOYEE2 TO EMP;

desc emp;

-- 7. DEPT ���̺��� DNAME �÷��� ���� �Ͻÿ�
alter table dept
drop column dname;

desc dept;

-- 8. DEPT ���̺��� LOC �÷��� UNUSED�� ǥ�� �Ͻÿ�. 
alter table dept
set unused (LOC);

desc dept;

-- 9. UNUSED Ŀ���� ��� ���� �Ͻÿ�. 
alter table dept
drop unused column;

-- 09 - ������ ���۰� Ʈ����� ����. 
-- ========================================

-- 1. EMP ���̺��� ������ �����Ͽ� EMP_INSERT �� �̸��� �� ���̺��� ����ÿ�. + hiredate �÷� date �ڷ������� �߰��ϱ�
create table EMP_INSERT
as
select *
from EMP
where 0 = 1;

alter table EMP_INSERT
add (hiredate date);

select * from EMP_INSERT;
desc EMP_INSERT;
-- 2. ������ EMP_INSERT ���̺� �߰��ϵ� SYSDATE�� �̿��ؼ� �Ի����� ���÷� �Է��Ͻÿ�. 

insert into EMP_INSERT (EMP_ID, NAME, SAL, DEPT_ID, HIREDATE)
values (1111, '������', 55555, 10, sysdate);  
commit;

-- 3. EMP_INSERT ���̺� �� ����� �߰��ϵ� TO_DATE �Լ��� �̿��ؼ� �Ի����� ������ �Է��Ͻÿ�. 
insert into EMP_INSERT (EMP_ID, NAME, SAL, DEPT_ID, HIREDATE)
values (2222, '������', 66666, 20, to_date('2022-04-25','YYYY-MM-DD'));

select * from EMP_INSERT;
commit;

-- 4. employee���̺��� ������ ������ �����Ͽ� EMP_COPY�� �̸��� ���̺��� ����ÿ�. 
create table EMP_COPY
as
select *
from employee;

select * from EMP_COPY;
commit;

-- 5. �����ȣ�� 7788�� ����� �μ���ȣ�� 10������ �����Ͻÿ�. [ EMP_COPY ���̺� ���] 
update EMP_COPY
set dno = 10
where eno = 7788;

select * from EMP_COPY;
commit;

-- 6. �����ȣ�� 7788 �� ��� ���� �� �޿��� �����ȣ 7499�� ������ �� �޿��� ��ġ �ϵ��� �����Ͻÿ�. [ EMP_COPY ���̺� ���] 

update EMP_COPY 
set job = (select job from EMP_COPY where eno = 7499) , salary = (select salary from EMP_COPY where eno = 7499)
where eno = 7788;

select * from EMP_COPY;
commit;

-- 7. �����ȣ 7369�� ������ ������ ����� �μ���ȣ�� ��� 7369�� ���� �μ���ȣ�� ���� �Ͻÿ�. [ EMP_COPY ���̺� ���] 
select * from EMP_COPY;

update EMP_COPY 
set dno = (select dno from EMP_COPY where eno = 7369)
where job = 'CLERK';
commit;

-- 8. department ���̺��� ������ ������ �����Ͽ� DEPT_COPY �� �̸��� ���̺��� ����ÿ�. 
create table DEPT_COPY
as
select *
from department;

commit;

-- 9. DEPT_COPY�� ���̺��� �μ����� RESEARCH�� �μ��� ���� �Ͻÿ�. 
select * from dept_copy;

delete DEPT_COPY
where dname = 'RESEARCH';

commit;

-- 10. DEPT_COPY ���̺��� �μ���ȣ�� 10 �̰ų� 40�� �μ��� ���� �Ͻÿ�. 
delete DEPT_COPY
where dno in (10,40);

select * from dept_copy;
commit;