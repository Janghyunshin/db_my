m-- 5���� �������� - subquery

-- 7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
-- 	������ ��Ī���� �ѱ۷� �����ÿ�. 
select e.ename as "������̸�" , e.eno as "�����ȣ", e.manager as "������ ��ȣ", m.ename as "������ �̸�"
from employee e , employee m
where e.manager = m.eno;

select e.ename as "������̸�" , e.eno as "�����ȣ", e.manager as "������ ��ȣ", m.ename as "������ �̸�"
from employee e JOIN employee m
on e.manager = m.eno;

-- EQUI JOIN : ����Ŭ������ ����ϴ� ���� , �� ���̺��� Ű�� ��ġ�ϴ� �͸� ���
-- ANSI : INNER JOIN���� ��ȯ ���� (��� DBMS���� ���� ����, MSSQL, MYSQL, IBM DB2)

-- 8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
select e.ename as �����, e.eno as �����ȣ, e.manager �����ڹ�ȣ, m.ename as �����ڸ�
from employee e join employee m 
on e.manager = m.eno (+)
order by e.eno desc;

select e.ename as �����, e.eno as �����ȣ, e.manager �����ڹ�ȣ, m.ename as �����ڸ�
from employee e left outer join employee m 
on e.manager = m.eno 
order by e.eno desc;

--9. SELF JOIN�� ����Ͽ� ������ ���(SCOTT)�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   -- ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
select * from employee where ename = 'SCOTT';   
select * from employee where dno = 20;

select e.ename �̸� , e.dno �μ���ȣ, m.ename ����
from employee e, employee m
where e.dno = m.dno
and e.ename = 'SCOTT' and m.ename != 'SCOTT';



--10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
select * from employee where ename = 'WARD';
select * from employee where hiredate > '81/02/22';
select * from employee where hiredate > to_date ( 19810222, 'YYYYMMDD');
select * from employee where hiredate > to_date ( '1981_02_22', 'YYYY_MM_DD');

select e2.ename �̸�, e2.hiredate �Ի���
from employee e1, employee e2
where e2.hiredate > e1.hiredate
and e1.ename = 'WARD'
order by e2.hiredate asc;

--11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    -- ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
select e.ename �����, e.hiredate �Ի���, m.ename �������̸�, m.hiredate �������Ի���
from employee e , employee m
where e.manager = m.eno
and e.hiredate < m.hiredate;

select eno, ename, manager, hiredate,   eno,ename,manager,hiredate from employee;


-- <<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>


select * from employee order by eno;
-- 1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
select job from employee where eno = '7788';
select ename from employee where job = 'ANALYST';

select ename, job
from employee
where job = (select job from employee where eno = 7788);

-- 2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename, job, salary
from employee
where salary >  (select salary from employee where eno = 7499); 

-- 3. �ּ� �޿��� �޴� <<���޺�>>��, ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select job, count(*), min(salary)
from employee
group by job;

select ename ����̸�, job ������ , salary �޿�
from employee
where salary in (Select min(salary) from employee group by job)
order by job;


-- 4. <<���޺��� ��� �޿��� ���ϰ�, ���� ����  ���� ��տ���   ���� ����  �����  ���ް�  �޿��� ǥ���Ͻÿ�.>>
select job, round(AVG(SALARY)) from employee group by job;

select job ����, min(salary)
from employee
group by job
having avg(salary) <= all (select avg(salary) from employee group by job);

select ename �̸� ,job ����, salary �޿�
from employee
where salary = (select min(salary) from employee 
                                    group by job 
                                    having avg (salary) = (select min (avg(salary))
                                                            from employee
                                                            group by job));


-- 5. �� �μ��� �ʼ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename, salary, dno
from employee
where salary in (select min(salary) from employee group by dno);

-- 6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select eno, ename, job, salary
from employee
where salary < all (select salary from employee where job = 'ANALYST')
                                            AND JOB <> 'ANALYST';
-- 7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select e.ename ��������, m.ename ���
from employee e right outer join employee m
on e.manager = m.eno
where e.ename is null;

select ename
from employee m
where not exists (select ename from employee e where e.manager = m.eno); 

select eno, ename 
from employee
where eno not in (Select manager from employee where manager is not null);

-- 8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select distinct m.ename ���
from employee e right outer join employee m
on e.manager = m.eno
where e.ename is not null;

select ename
from employee m
where exists (select ename from employee e where e.manager = m.eno and e.ename is not null); 

select eno, ename 
from employee
where eno in (Select manager from employee where manager is not null);


-- 9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select ename, hiredate, dno
from employee
where dno = (select dno from employee where ename = 'BLAKE')
                                    AND ENAME <> 'BLAKE';

-- 10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)
order by salary asc;
 
-- 11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select eno, ename, dno
from employee
where dno in (select dno from employee where ename like '%K%');

-- 12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 

-- JOIN
select ename, e.dno, job, loc
from employee e, department d
where e.dno = d.dno
and loc = 'DALLAS';

-- SUB QUERY
select ename, e.dno, job, loc
from employee e, department d
where e.dno = d.dno
and e.dno in (select dno from department where loc = 'DALLAS');

select ename, dno, job
from employee
where dno = (select dno from department where loc = 'DALLAS');


-- 13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select * from employee;

select ename �̸�, salary �޿�, manager
from employee 
where manager = (select eno from employee where ename = 'KING'); 


-- 14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
select * from department;

select dno �μ���ȣ, ename ����̸�, job "��� ����"
from employee
where dno = (select dno from department where dname = 'RESEARCH');

-- JOIN
select e.dno , ename, job
from employee e, department d
where e.dno = d.dno
and d.dname = 'RESEARCH';

-- sub query
select e.dno , ename, job
from employee e, department d
where e.dno = d.dno
and e.dno in (select dno from department where dname = 'RESEARCH');


-- 15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� 
-- ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select eno �����ȣ, ename �̸� , salary �޿�, dno
from employee
where salary > (select avg(salary) from employee)
    and dno in (select dno from employee where ename like '%M%');

-- 16. ��� �޿��� ���� ���� ������ ã���ÿ�. 
select avg(salary) ��ձ޿�, job ����
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job);

-- 17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select * from employee order by job;

select ename , dno
from employee
where dno in (select dno from employee where job = 'MANAGER'); 
