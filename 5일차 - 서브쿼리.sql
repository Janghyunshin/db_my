-- 5���� - ��������

--  Sub Query : Select �� ���� select ���� �ִ� ����

select ename, salary from employee;

select ename ,salary
from employee
where ename = 'SCOTT';

-- SCOTT ���� ���� ���� ����ڸ� ��� �϶� (���� ����)

select ename, salary
from employee
where salary > 3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT�� ������ �μ��� �ٹ��ϴ� ����� ����ϱ� (5��) (sub query)
select ename, salary, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

    -- sub query ��� x
    select dno from employee where ename = 'SCOTT';
    select ename , dno from employee where dno = 20;


-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿� ��� �ϱ� (sub query)
select min (salary) from employee;

select ename, job, salary
from employee
where salary = ( select min(salary) from employee);

-- 30�� �μ�(dno)���� �ּ� ������ �޴� ������� ���� ����� �̸���, �μ���ȣ�� ������ ����� ������ (7��)
select min(salary)
from employee
where dno=30;   -- �ּ� ���� 950

select ename, dno, salary
from employee
where salary > ( select min(salary) from employee where dno = 30 );

-- Having ���� Sub query ����ϱ�

-- 30�� �μ��� �ּ� ���޺��� ū �� �μ��� �ּҿ���
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(Salary) from employee where dno = 30);

-- ������ ���� ���� : sub query�� ��� ���� �� �ϳ��� ���
         -- ������ �� ������ :  >, =, >= , <, <=, <>
-- ������ ���� ���� : sub query�� ��� ���� ������ ���
         -- ������ ���� ���� ������ : IN, ANY, SOME, ALL , EXISTS
            -- IN : ���� ������ �� ���� (' = ' �����ڷ� ���� ���) �� ���������� ��� �� �߿� �ϳ��� ��ġ�ϸ� ��
            -- ANY, SOME : ���� ������ �� ������ ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� �� 
            -- ALL : ���� ������ �������� ���� ������ �˻� ����� ��� ���� ��ġ�ϸ� ��
            -- EXISTS: ���� ������ �������� ���� ������ ��� �� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
            
-- IN ������ ����ϱ�
select ename, eno, dno, salary
from employee
order by dno asc;

-- �μ����� �ּ� ������ �޴� ����ڵ� ��� �ϱ� (sub query�� �ݵ�� ����ؼ� ���)
-- SUBQUERY (x)
select dno, min(salary), count(*)
from employee
group by dno;

select ename, dno, salary
from employee
where salary in (950,800,1300);

-- SUB QUERY ����
select ename, dno, salary
from employee
where salary in ( select min(salary) from employee group by dno);


-- ANY ������ ���
    -- ���� ������ ��ȯ�ϴ� ������ ���� ����
    -- ' < ANY' �� �ִ밪 ���� ������ ��Ÿ��
    -- ' > ANY' �� �ּҰ� ���� ũ�� ��Ÿ��
    -- ' = ANY' �� IN�� ���� �� 

-- ��) ������ SALESMAN �� �ƴϸ鼭 �޿��� ������ SALESMAN ���� ���� ����� ���
            -- 1600 (�ִ밪) ���� ���� ��� ��� (SALESMAN)�� �ƴϰ� 
            
select eno, ename, job , salary
from employee 
where salary < any ( select salary from employee 
                    where job = 'SALESMAN')
                    and job <> 'SALESMAN' ;
                    
select ename, job, salary
from employee
order by job ;

-- ALL ������
    -- SUB QUERY�� ��ȯ�ϴ� ��� ���� ��
    -- ' > all' : �ִ밪 ���� ŭ�� ��Ÿ��
    -- ' < all' : �ּҰ� ���� ������ ��Ÿ��
    
-- ��) ������ SALESMAN�� �ƴϸ鼭 ������ SALESMAN�� ������� �޿��� ���� ����� ��� ���

    -- 1250 (�ּҰ�) ���� ���� ��� ( ������ SALESMAN �� �ƴ�)
select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'SALESMAN')
                    AND JOB <> 'SALESMAN';

-- ��� ������ �м����� ������� �޿��� �����鼭 ������ �м����� �ƴ� ����� ���
select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'ANALYST')
                    AND JOB <> 'ANALYST';

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ��� �޿��� ���ؼ� �������� �Ͻÿ�.
select eno, ename, salary
from employee
where salary > (select round(avg(salary)) from employee)
order by salary asc;
