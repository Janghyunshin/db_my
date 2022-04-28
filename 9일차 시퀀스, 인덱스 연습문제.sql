-- 9���� ������, �ε��� ��������


-- <<������ ����>>

-- 1. emp01 ���̺��� �Ʒ��� ���� �����Ͻÿ�. 

--�÷���	������Ÿ��	ũ��	NULL		��������
-------------------------------------------------------------------------------------
--empno	number		4	NOT NULL	Primary key
--ename	varchar2		10	NULL
--hiredate	date			NULL

create table emp01 (
    empno number(4) constraint NN_emp01_empno not null constraint PK_emp01_empno primary Key,
    ename varchar2(10) null,
    hiredate date null
    );

desc emp01;

select * from user_constraints
where table_name = 'EMP01';


-- 2. emp01 ���̺��� �����ȣ�� �ڵ����� �����ǵ��� �������� ���� �Ͻÿ�. 
--   �ʱⰪ : 1
--   ������ : 1
--   �ִ밪 : 100000

create sequence emp01_seq
    increment by 1 
    start with 1
    maxvalue 100000
    nocache;


-- 3. �����ȣ�� �������� ���� �߱� �����ÿ�. 
insert into emp01
values ( emp01_seq.nextval, 'SCOTT', sysdate);

select * from emp01;