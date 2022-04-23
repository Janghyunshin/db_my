--���̺� ���� ���� - 06 �Ϸ�ð� : 6:20

-- 1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select *
from department, employee;  -- ī��þ� ��

select *
from employee e, department d
where e.dno = d.dno;

select ename ����� , e.dno �μ���ȣ, dname �μ��̸�       -- dno ����Ű �÷�.
from employee e, department d
where e.dno = d.dno
and ename = 'SCOTT';

-- 2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 

select ename ����̸�, dname �μ��̸�, loc ������
from employee e join department d
on e.dno = d.dno;

-- 3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������ ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 

-- JOIN���� USING�� ����ϴ� ��� :
    -- NATURAL JOIN : ���� Ű �÷��� Oracle ���ο��� �ڵ� ó��, 
    -- �ݵ�� �� ���̺��� ���� Ű �ø��� ������ Ÿ���� ���ƾ� �Ѵ�.
    -- �� ���̺��� ���� Ű �÷��� ������ Ÿ���� �ٸ���� USING�� ����Ѵ�.
    -- �� ���̺��� ���� Ű �÷��� �������� ��� USING�� ����Ѵ�.
    
select distinct job ������, loc ������
from employee e inner join department d
using (dno)
where dno = 10;

-- 4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
-- commission null ����
select ename �̸�, dname �μ��̸�, loc ������, commission Ŀ�Լ�
from employee e natural join department d
where commission is not null;

-- commission null + 0 ����
select ename �̸�, dname �μ��̸�, loc ������, commission Ŀ�Լ�
from employee e natural join department d
where (commission is not null ) and commission != 0;

-- 5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename �̸� , dname �μ���
from employee e, department d 
where e.dno = d.dno
and ename like '%A%';

-- 6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� ����� �̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename �̸�, job ����, dno �μ���ȣ, dname �μ���
from employee e natural join department d
where loc = 'NEW YORK';

