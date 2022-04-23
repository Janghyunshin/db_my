--�׷��Լ� ����. 

select * from employee;

-- 1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�.
    -- �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round (avg(salary) )���
from employee;


-- 2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�. 
-- �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 

select job ������, max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round (avg(salary) )���
from employee
group by job;

-- 3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job ������ , count(*) as "������ �����"
from employee
group by job;

-- 4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select manager, count(*) as "�����ڼ�"
from employee
group by manager;

-- 5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select max(salary) "�޿� �ְ��" , min(salary) "���� �޿���", max(salary)- min(salary) as "DIFFERENCE"
from employee;

-- 6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڸ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű��
    -- ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
      
select job , min(salary)
from employee
where manager is not null
group by job
having (min(salary) > 2000 )
order by min(salary) desc;

-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. 
-- �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno, COUNT(*), round(avg(salary),2)
from employee
group by dno;

-- 8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.
-- �ᷳ�� ��Ī�� [��¿���] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  

select * from department;

select dno "�μ�", decode(dno, 10, 'ACCOUNTING',
                        20, 'RESEARCH',
                        30, 'SALES',
                        40, 'OPERATIONS') as "dname", decode(dno, 10, 'NEW YORK',
                                                                20, 'DALLAS',
                                                                30, 'CHICAGO',
                                                                40, 'BOSTON') as "Location" , count(*) as "Number of people",
                                                                Round(avg(salary)) as "Salary"
from employee
group by dno;


 