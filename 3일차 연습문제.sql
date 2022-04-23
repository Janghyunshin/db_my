-- 1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�.
select ename �̸�, substr(hiredate, 1, 5) as "�Ի�⵵/��"
from employee;

-- 2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 
-- substr ���
select *
from employee
where substr (hiredate,5,1) = 4;

-- substr ���
select *
from employee
where substr (hiredate,4,2) = 04;

-- substr ���x
select *
from employee
where hiredate like '___04%';

-- 3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select *
from employee
where MOD(manager, 2) = 1;

select *
from employee
where MOD(manager, 2) != 0;

-- 3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select *
from employee
where MOD(salary, 3) = 0;

-- 4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select to_char(hiredate, 'YY MON DY') as "�Ի�� / �� / ����"
from employee;

-- 5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
-- ������ ������ ��ġ ��Ű�ÿ�. 
select trunc (sysdate - to_date('2022/01/01', 'YYYY/MM/DD')) as "���� ���� �� �� "
from dual;

-- 5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc (sysdate - to_date('19940406', 'YYYYMMDD')) as "���� ���� �� �� "
from dual;

-- 5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc (months_between (sysdate, to_date('19940406', 'YYYYMMDD'))) as "���� ���� ���� ��"
from dual;

-- 6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select ename ����� ,manager ������ , NVL(manager, 0), NVL2(manager, manager, 0) as "null ��� 0"
from employee;


-- 7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
-- 'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
select distinct job from employee; -- ���� Ȯ��

-- 1�� DECODE Ǯ��
select ename �̸�, job ����, salary �޿�, decode(job, 'ANALYST', salary + 200,
                                                    'SALESMAN', salary + 180,
                                                    'MANAGER', salary + 150,
                                                    'CLERK' , salary + 100,
                                                    salary) as "�λ�� �޿�"
from employee;

-- 2�� case Ǯ��
select ename �̸�, job ����, salary �޿�, case when job='ANALYST' then salary + 200
                                            when job='SALESMAN' then salary + 180
                                            when job='MANAGER' then salary + 150
                                            when job='CLERK'   then salary + 100
                                            ELSE salary
                                            END as "�λ�� �޿�"
from employee;


-- 8. �����ȣ, �����ȣ 2�ڸ��� ��� �������� *�� ���� as "������ȣ"
--   �̸�[�̸��� ù�ڸ� ��� �� 4�ڸ�, ���ڸ��� *�ΰ����� ���] as �����̸�
select eno �����ȣ, rpad(substr(eno,1,2), length(eno), '*') as ������ȣ,
ename �̸�, rpad(substr(ename,1,1), 4, '*') as �����̸�
from employee;

select eno �����ȣ, rpad(substr (eno, 1, 2), 4, '*') as ������ȣ,
ename �̸�, rpad (substr (ename, 1, 1), 4, '*') as �����̸�
from employee;

-- 9 . �ֹι�ȣ�� ����ϵ� 801210-1****** ����ϵ���, ��ȭ��ȣ : 010-11*******
    -- dual ���̺� ���
select length('801210-1011111'), -- 14
length('010-1111-1111')          -- 13
from dual;
    
select rpad(substr('801210-1011111', 1, 8), 14, '*') as �ֹι�ȣ,
rpad (substr('010-1111-1111', 1, 6), 13, '*') as ��ȭ��ȣ
from dual;


-- 10. �����ȣ, �����, ���ӻ��,
    -- [���ӻ���� �����ȣ�� ������� : 0000 ���� ���]
    --  ���ӻ���� �����ȣ�� �� 2�ڸ��� 75�� ��� : 5555
    --  ���ӻ���� �����ȣ�� �� 2�ڸ��� 76�� ��� : 6666
    --  ���ӻ���� �����ȣ�� �� 2�ڸ��� 77�� ��� : 7777
    --  ���ӻ���� �����ȣ�� �� 2�ڸ��� 78�� ��� : 8888
    --  �׿ܴ� �״�� ���
select eno, ename, manager, decode(substr(manager,1,2), 75, '5555',
                                                        76, '6666',
                                                        77, '7777',
                                                        78, '8888',
                                                        null, '0000',
                                                        to_char(manager)) as ���
from employee;

select eno, ename, manager, case when manager is null then '0000'
                                 when substr(manager,1,2)=75 then '5555'
                                 when substr(manager,1,2)=76 then '6666'
                                 when substr(manager,1,2)=77 then '7777'
                                 when substr(manager,1,2)=78 then '8888'
                                 else to_char(manager)
                            end as ���ӻ��ó��
from employee;


    