-- 1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오.
select ename 이름, substr(hiredate, 1, 5) as "입사년도/달"
from employee;

-- 2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오. 
-- substr 사용
select *
from employee
where substr (hiredate,5,1) = 4;

-- substr 사용
select *
from employee
where substr (hiredate,4,2) = 04;

-- substr 사용x
select *
from employee
where hiredate like '___04%';

-- 3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select *
from employee
where MOD(manager, 2) = 1;

select *
from employee
where MOD(manager, 2) != 0;

-- 3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select *
from employee
where MOD(salary, 3) = 0;

-- 4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select to_char(hiredate, 'YY MON DY') as "입사년 / 월 / 요일"
from employee;

-- 5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
-- 데이터 형식을 일치 시키시오. 
select trunc (sysdate - to_date('2022/01/01', 'YYYY/MM/DD')) as "올해 지난 일 수 "
from dual;

-- 5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc (sysdate - to_date('19940406', 'YYYYMMDD')) as "생일 지난 일 수 "
from dual;

-- 5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요. 
select trunc (months_between (sysdate, to_date('19940406', 'YYYYMMDD'))) as "생일 지난 개월 수"
from dual;

-- 6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오. 
select ename 사원명 ,manager 상관사번 , NVL(manager, 0), NVL2(manager, manager, 0) as "null 대신 0"
from employee;


-- 7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANAIYST' 사원은 200 , 'SALESMAN' 사원은 180,
-- 'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select distinct job from employee; -- 직급 확인

-- 1번 DECODE 풀이
select ename 이름, job 직급, salary 급여, decode(job, 'ANALYST', salary + 200,
                                                    'SALESMAN', salary + 180,
                                                    'MANAGER', salary + 150,
                                                    'CLERK' , salary + 100,
                                                    salary) as "인상된 급여"
from employee;

-- 2번 case 풀이
select ename 이름, job 직급, salary 급여, case when job='ANALYST' then salary + 200
                                            when job='SALESMAN' then salary + 180
                                            when job='MANAGER' then salary + 150
                                            when job='CLERK'   then salary + 100
                                            ELSE salary
                                            END as "인상된 급여"
from employee;


-- 8. 사원번호, 사원번호 2자리만 출력 나머지는 *로 가림 as "가린번호"
--   이름[이름의 첫자만 출력 총 4자리, 세자리는 *로가려서 출력] as 가린이름
select eno 사원번호, rpad(substr(eno,1,2), length(eno), '*') as 가린번호,
ename 이름, rpad(substr(ename,1,1), 4, '*') as 가린이름
from employee;

select eno 사원번호, rpad(substr (eno, 1, 2), 4, '*') as 가린번호,
ename 이름, rpad (substr (ename, 1, 1), 4, '*') as 가린이름
from employee;

-- 9 . 주민번호를 출력하되 801210-1****** 출력하도록, 전화번호 : 010-11*******
    -- dual 테이블 사용
select length('801210-1011111'), -- 14
length('010-1111-1111')          -- 13
from dual;
    
select rpad(substr('801210-1011111', 1, 8), 14, '*') as 주민번호,
rpad (substr('010-1111-1111', 1, 6), 13, '*') as 전화번호
from dual;


-- 10. 사원번호, 사원명, 직속상관,
    -- [직속상관의 사원번호가 없을경우 : 0000 으로 출력]
    --  직속상관의 사원번호가 앞 2자리가 75일 경우 : 5555
    --  직속상관의 사원번호가 앞 2자리가 76일 경우 : 6666
    --  직속상관의 사원번호가 앞 2자리가 77일 경우 : 7777
    --  직속상관의 사원번호가 앞 2자리가 78일 경우 : 8888
    --  그외는 그대로 출력
select eno, ename, manager, decode(substr(manager,1,2), 75, '5555',
                                                        76, '6666',
                                                        77, '7777',
                                                        78, '8888',
                                                        null, '0000',
                                                        to_char(manager)) as 출력
from employee;

select eno, ename, manager, case when manager is null then '0000'
                                 when substr(manager,1,2)=75 then '5555'
                                 when substr(manager,1,2)=76 then '6666'
                                 when substr(manager,1,2)=77 then '7777'
                                 when substr(manager,1,2)=78 then '8888'
                                 else to_char(manager)
                            end as 직속상관처리
from employee;


    