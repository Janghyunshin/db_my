select *
from employee;

desc employee;

select eno as �����ȣ, ename �����, job ��å, manager "���ӻ�� ID", hiredate �Ի糯¥, salary ����, commission ���ʽ�, dno �μ���ȣ
from employee;

-- 1. ���������ڸ� ����Ͽ� ��� ����� ���ؼ� $300�� �޿� �λ��� ������� ����̸�, �޿�, �λ�� �޿��� ����ϼ���.

select ename ����̸�, salary �޿�, salary + 300 �λ�ȱ޿�
from employee;

-- 2. ����� �̸�, �޿�, ���� �� ������ ������ ���� ���������� ��� �Ͻÿ�. 
-- ���� �� ������ ���޿� 12�� ������ $100�� �󿩱��� ���ؼ� ��� �Ͻÿ�. 

select ename �̸�, salary �޿�, (salary*12) + 100 �����Ѽ���
from employee
order by (salary*12) + 100 desc;


select ename, salary, commission from employee;

select ename, salary ,commission, salary *12, ( salary * 12 )+ NVL(commission,0) + 100 as �ѿ���
from employee;

-- 3. �޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ������ ���� ���������� ����ϼ���. 
select ename �̸�, salary �޿�      -- �÷���
from employee                      -- ���̺�, ��
where salary >= 2000               -- ����
order by salary desc;              

-- 4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����ϼ���. 
select ename �̸�, dno �μ���ȣ, eno �����ȣ
from employee
where eno = 7788;

-- 5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ��� �ϼ���. 
select ename �̸�, salary �޿�
from employee
where salary not between 2000 and 3000;

-- 6. 1981�� 2�� 20�Ϻ��� 81�� 5�� 1�� ������ �Ի��� ����� �̸� ������, �Ի����� ����Ͻÿ�
select ename �̸�, job ������, hiredate �Ի���
from employee
where hiredate between '81/02/20' and '81/05/01' ;

-- 7. �μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� ����(��������)���� ����Ͻÿ�. 
select ename �̸�, dno �μ���ȣ          -- 1��Ǯ��
from employee
where dno = 20 or dno = 30
order by ename desc;

select ename �̸�, dno �μ���ȣ          -- 2��Ǯ��
from employee
where dno in (20,30)
order by ename desc;

-- 8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� ����� �̸�, 
-- �޿��� �μ���ȣ�� ����ϵ� �̸��� ������������ ����ϼ���. 
select ename �̸�,salary �޿�, dno �μ���ȣ     -- 1��Ǯ��
from employee
where (salary between 2000 and 3000) and
(dno = 20 or dno = 30)
order by ename asc;

select ename �̸�,salary �޿�, dno �μ���ȣ     -- 2��Ǯ��
from employee
where (salary between 2000 and 3000) and
(dno in (20,30))
order by ename asc;

-- 9. 1981�⵵ �Ի��� ����� �̸��� �Ի����� ��� �Ͻÿ� ( like �����ڿ� ���ϵ� ī�� ���)
select ename �̸�, hiredate �Ի���           -- like ����
from employee
where hiredate like '81%';

select ename �̸�, hiredate �Ի���           -- like �Ⱦ���
from employee
where substr (hiredate, 1, 2) = '81';


-- 10. �����ڰ� ���� ����� �̸��� �������� ����ϼ���.
select ename �̸�, job ������
from employee
where manager is null;

-- 11. Ŀ�Լ��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� ����ϵ� 
-- �޿��� Ŀ�Լ��� �������� �������� �����Ͽ� ǥ���Ͻÿ�. 
select ename �̸�, salary �޿�, commission Ŀ�̼�
from employee
where commission is not null
order by salary desc, commission desc; 

-- 12. �̸��� ����° ������ R�� ����� �̸��� ǥ���Ͻÿ�. 
select ename �̸�                 -- like
from employee
where ename like '__R%';

select ename �̸�                 -- substr
from employee
where substr(ename, 3,1) = 'R';

-- 13. �̸��� A �� E �� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�. 
select ename �̸�
from employee
where ename like '%A%' and ename like '%E%'; 

-- 14. ��� ������ �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭
-- �޿��� $1600, $950, �Ǵ� $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 

select ename �̸�, job ������, salary �޿�         -- 1��
from employee
where (job in ('CLERK','SALESMAN')) and (salary not in(1600,950,1300));

select ename �̸�, job ������, salary �޿�         -- 2��
from employee
where (job = 'CLERK' or job = 'SALESMAN') and ( not (salary = 1600 or salary = 950 or salary = 1300));

select ename �̸�, job ������, salary �޿�         -- 3��
from employee
where (job = 'CLERK' or job = 'SALESMAN') and ( salary not in (1600,950,1300));

-- 15. Ŀ�̼��� $500�̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�.  

select ename �̸�, salary �޿�, commission Ŀ�̼�
from employee
where commission >= 500;






-- �̸��� N���� ������ ����� ����ϱ� (substr �Լ��� ����ؼ� ���)
select ename
from employee
where substrb (ename, -1, 1) = 'N';

select ename
from employee
where ename like '%N';

-- 87�⵵ �Ի��� ����� ��� �ϱ� (substr �Լ��� ����ؼ� ���)
select * 
from employee
where substr (hiredate, 1,2) = '87';

select *
from employee
where hiredate like '87%';