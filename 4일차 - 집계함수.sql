-- 4����
/*
    �׷� �Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ�
        groupby ���� Ư�� �÷��� ������ ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����.
        
    �����Լ� : 
        - SUM : �׷��� �հ�
        - AVG : �׷��� ���
        - MAX : �׷��� �ִ밪
        - MIN : �׷��� �ּҰ�
        - COUNT : �׷��� �� ���� (���ڵ� ��, record, �ο� �� row)
*/

select sum(salary), round( avg(salary), 2 ), max(salary), min(salary)
from employee;

-- ���� : ���� �Լ��� ó���� ��, ��� �÷��� ���� ������ ������ �÷��� ����

select sum(salary)
from employee;

select ename
from employee;

select *
from employee;

-- �����Լ��� null ���� ó���ؼ� �����Ѵ�.
select sum (commission), avg (commission), max(commission), min(commission)
from employee;

-- count () : ���ڵ� ��, �ο� ��
    -- null�� ó������ �ʴ´�.
    
select eno from employee;         -- 14
select count (eno) from employee; -- 14

select commission from employee;            -- 14
select count (commission) from employee;    -- 4 (null�� ī��Ʈ���� ����)

select count (*) from employee;
select * from employee;

-- count () : ���ڵ� �� , �ο� ��
    -- NULL�� ó������ �ʴ´�.
    -- ���̺��� ��ü ���ڵ� ���� ������ ��� : count (*) �Ǵ� NOT NULL �÷��� count()
    
desc employee;

-- ��ü ���ڵ� ī��Ʈ

select count(*) from employee;
select count(eno) from employee;

-- �ߺ����� �ʴ� ������ ����

select job from employee;

select count(distinct job) from employee;

-- �μ��� ���� (dno)

select count (distinct dno) from employee;


-- GROUP BY : Ư�� �÷��� ���� �׷����Ѵ�. �ַ� �����Լ��� select ������ ���� ����մϴ�.
/*
    select �÷���, �����Լ� ó���� �÷�
    from ���̺�
    where ����
    group by �÷���
    having ���� (group by�� ���� ����)
    order by ����
    
*/

-- �μ��� ��� �޿�
select dno as �μ���ȣ , avg(salary) as ��ձ޿�
from employee
group by dno;      -- dno �÷��� �ߺ��Ȱ��� �׷��� ��.

select dno from employee;

-- ��ü ��� �޿�
select avg(salary) as ��ձ޿�
from employee;

-- groub by�� ����ϸ鼭 select ���� ������ �÷��� �� �����ؾ� �Ѵ�.
    -- ex) ename �÷��� ���� ��  ���� 
select dno �μ���ȣ, count(dno), sum(salary) , avg(salary), max(commission), min(commission)      
from employee
group by dno
order by dno;

-- 
select job from employee;

-- ������ ��å�� �׷����ؼ� ������ ���, �հ�, �ִ밪, �ּҰ��� ���.
select job ��å, count(job), avg(salary) "������ ���", sum(salary) �հ�, max(salary) �ִ밪, min(salary) �ּҰ�
from employee 
group by job;       -- ������ ��å�� �׷����ؼ� ���踦 �Ѵ�.

-- ���� �÷��� �׷��� �ϱ�.
select dno, job, count(*), sum(salary)
from employee
group by dno, job;      -- �� �÷� ��� ��ġ�ϴ� ���� �׷��� 

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- Having : group by ���� ���� ����� �������� ó���� ��
    -- ��Ī�̸��� �������� ����ϸ� �ȵȴ�.
    
-- �μ��� ������ �հ谡 9000�̻��� �͸� ���
select dno, count(*), sum(salary) "�μ��� �հ�", round(avg(salary), 2) as "�μ��� ���"
from employee
group by dno
having sum(salary) >= 9000;

-- �μź� ������ ����� 2000�̻��� �͸� ���
select dno, count(*), sum(salary) "�μ��� �հ�", round(avg(salary), 2) as "�μ��� ���"
from employee
group by dno
having round (avg(salary), 2) >= 2000.00;


-- where : ���� ���̺��� �������� �˻�
-- having : group by ����� ���ؼ� ������ ó��.

select * from employee;

-- ���� 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� ���ϵ� ������ ����� 2500�̻��� �͸� ����϶�

select dno, count(*), round(avg(salary))
from employee
where salary > 1500
group by dno
having avg(salary) > 2500;

-- ROLLUP
-- CUBE
    -- Group by ������ ����ϴ� Ư���� �Լ�
    -- ���� �÷��� ������ �� �ִ�.
    -- group by ���� �ڼ��� ������ ���...

-- Rollup, cube�� ������� �ʴ� ���    
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

-- Rollup : �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�, ���
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup (dno)
order by dno;

-- cube : �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�, ���
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by cube (dno)
order by dno;

-- Rollup : �� �÷��̻�
select dno, job, count(*), Max(Salary), sum(salary), Round(avg(salary))
from employee
group by rollup (dno, job); -- �ΰ��� �÷��� �����, �� �÷��� ���ļ� �����Ҷ� �׷���.

select dno, job, count(*), Max(Salary), sum(salary), Round(avg(salary))
from employee
group by rollup(dno, job)
order by dno asc;

-- cube : rollup ���� �� ������ ������ �� 
select dno, job, count(*), max(Salary), sum(salary), Round(avg(salary))
from employee
group by cube (dno,job)
order by dno, job;

-- JOIN
    -- department �� employee�� ������ �ϳ��� ���̺��� ������ �𵨸���(�ߺ�����, �������)�� ���ؼ� �� ���̺��� �и�
    -- �� ���̺��� ����Ű �÷� (dno), employee ���̺��� dno �÷��� department ���̺��� dno �÷��� ����
    -- �ΰ� �̻��� ���̺��� �÷��� JOIN������ ����ؼ� ��� 
    
select * from department;   -- �μ������� �����ϴ� ���̺�
select * from employee;     -- ��������� �����ϴ� ���̺� 

-- EQUI JOIN : ����Ŭ���� ���� ���� ����ϴ� JOIN, Oracle ������ ��밡��
    -- from �� : ������ ���̺��� ","�� ó��
    -- where ��: �� ���̺��� ������ Ű �÷��� " = " �� ó��
        -- and �� : ������ ó��

        
-- Where �� : ���� Ű �÷��� ó���� ���
select *
from employee, department
where department.dno = employee.dno  -- ���� Ű ����
and job = 'MANAGER';                 -- ������ ó��

-- ANSI ȣȯ : INNER JOIN              <== ��� SQL���� ��� ������ JOIN
-- ON ��: ���� Ű�÷��� ó���� ���
    -- on �� : �� ���̺��� ������ Ű �÷��� " = " �� ó��
        -- where ��: ������ ó��

select *
from employee e JOIN department d
on e.dno = d.dno  -- ���� Ű ����
where job = 'MANAGER';                 -- ������ ó��

-- JOIN�� ���̺� �˸�� ( ���̺� �̸��� ��Ī���� �ΰ� ���� ���)
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select ������ ������ Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ��� : dno
select eno, job, d.dno, dname
from employee e, department d
where e.dno  = d.dno;

-- �� ���̺��� join�ؼ� �μ���(dname) ������ �ִ밪�� �μ���(dname)���� ���
select  dname "�μ���", count(*), max(salary) "������ �ִ밪"
from employee e, department d
where e.dno = d.dno
group by dname;

-- NATURAL JOIN : Oracle 9i ���� (where�� ���� join)
    -- EQUI JOIN�� Where ���� ���� : �� ���̺��� ������ Ű �÷��� ���� " = "
    -- ������ Ű �÷��� Oracle ���������� �ڵ����� �����ؼ� ó��
    -- ���� Ű�÷��� ��Ī �̸��� ����ϸ� ������ �߻�
    -- �ݵ�� ���� Ű �÷��� ������ Ÿ���� ���ƾ� �Ѵ�.
    -- from ���� natural join Ű���带 ���

select eno, ename, dname, dno
from employee e natural join department d;

-- ���� : select ���� ����Ű �÷��� ��½� ���̺���� ����ϸ� ���� �߻�

-- EQUI JOIN vs NATURAL JOIN�� ���� Ű �÷� ó��
    -- EQUI JOIN    :  select ���� �ݵ�� ���� Ű�÷��� ��� �ҋ� ���̺���� �ݵ�� ���
    -- natural join :  select ���� �ݵ�� ���� Ű�÷��� ��� �ҋ� ���̺���� �ݵ�� ������� �ʾƾ� �Ѵ�.
    
-- EQUI JOIN (d.dno/e.dno ���)
select ename, salary, dname, d.dno
from employee e, department d
where e.dno = d.dno
and salary > 2000;

-- natural join (���̺�� ���x)
select ename, salary, dname, dno
from employee e natural join department d
where salary > 2000;

-- ANSIȣȯ�� INNER JOIN
select ename, salary, dname, d.dno
from employee e join department d
on  e.dno = d.dno
where salary > 2000;

-- NON EQUI JOIN : EQUI JOIN���� Where ���� " = " �� ������� �ʴ� join

select * from salgrade;  -- : ������ ����� ǥ�� �ϴ� ���̺�

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- ���̺� 3�� ����

select ename, dname, salary, grade
from employee e , department d, salgrade s 
where e.dno = d.dno
and salary between losal and hisal;

-- SELF JOIN : �ڱ� �ڽ��� ���̺��� �����Ѵ�. (�ַ� ����� ��� ������ ��� �Ҷ� �����. ������ ...)
    -- ��Ī�� �ݵ�� ����ؾ� �Ѵ�.
    -- select �� : ���̺��̸���Ī.�÷��� , 

select eno, ename, manager
from employee
where manager = '7788';

-- SELF JOIN�� ����ؼ� ����� ���� ��� �̸��� ���

-- EQUI JOIN���� Self JOIN�� ó��
select e.eno as "�����ȣ", e.ename as "����̸�" , e.manager as "���ӻ����ȣ" , m.ename as "���ӻ���̸�"
from employee e, employee m -- SELF JOIN :
where e.manager = m.eno
order by e.ename asc;

select eno, ename, manager, eno, ename
from employee;

-- ANSI ȣȯ : INNER JOIN���� ó��

select e.eno as "�����ȣ", e.ename as "����̸�" , e.manager as "���ӻ����ȣ" , m.ename as "���ӻ���̸�"
from employee e inner JOIN employee m -- SELF JOIN :
on e.manager = m.eno
order by e.ename asc;


select e.ename || '�� ���ӻ����' || e.manager || '�Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- ANSI ȣȯ: INNER JOIN���� ó��
select e.ename || '�� ���ӻ����' || e.manager || '�Դϴ�.'
from employee e INNER JOIN employee m
on e.manager = m.eno
order by e.ename asc;

-- OUTER JOIN :
    -- Ư�� �÷��� �� ���̺��� ���������� �ʴ� ������ ����ؾ� �Ҷ�
    -- ���������� �ʴ� �÷��� NULL ���
    -- + ��ȣ�� ����ؼ� ��� : Oracle
    -- ANSI ȣȯ: OUTER JOIN ������ ����ؼ� ��� <== ��� DBMS ���� ȣȯ

-- Oracle
select e.ename, m.ename
from employee e join employee m
on e.manager = m.eno (+)
order by e.ename asc;

-- ANSI ȣȯ�� ����ؼ� ���.
    -- Left Outer JOIN : �������� �κ��� ������ ������ ������ ��� ���
    -- Right Outer JOIN : �������� �κ��� ������ �������� ������ ��� ���
    -- Full Outer Join : �������� �κ��� ������ ������ ���� ��� ���

-- Left Outer JOIN
select e.ename, m.ename
from employee e left outer join employee m
on e.manager = m.eno
order by e.ename asc;






-- ���� ���� : ���̺� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ��
    -- Primary Key: ���̺� �Ϲ��� ����� �� �ִ�. �ϳ��� �÷�, �ΰ� �̻��� �׷����ؼ� ����
        -- �ߺ��� ���� ������ ����. NULL�� ���� �� ����.
    -- UNIQUE     : ���̺� ���� �÷��� �Ҵ��� �� �ִ�. �ߺ��� ���� ������ ����.
        -- NULL ���� �� �ִ�. �� �ѹ��� NULL
    -- Foreign Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ��� ���� ���� �� �ִ�.
        -- �ڽ��� �÷��� ������ ���� �Ҵ����� ���Ѵ�.
    -- NOT NULL : NULL ���� �÷��� �Ҵ��� �� ����.
    -- CHECK    : �÷��� ���� �Ҵ��� �� üũ�ؼ� (���ǿ� ����) ���� �Ҵ�.
    -- DEFAULT  : ���� ���� ������ �⺻���� �Ҵ�.
    

