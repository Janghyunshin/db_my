select *
from employee;

desc employee;

select eno as 사원번호, ename 사원명, job 직책, manager "직속상관 ID", hiredate 입사날짜, salary 월급, commission 보너스, dno 부서번호
from employee;

-- 1. 덧셈연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요.

select ename 사원이름, salary 급여, salary + 300 인상된급여
from employee;

-- 2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오. 
-- 연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 

select ename 이름, salary 급여, (salary*12) + 100 연간총수입
from employee
order by (salary*12) + 100 desc;


select ename, salary, commission from employee;

select ename, salary ,commission, salary *12, ( salary * 12 )+ NVL(commission,0) + 100 as 총연봉
from employee;

-- 3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 
select ename 이름, salary 급여      -- 컬럼명
from employee                      -- 테이블, 뷰
where salary >= 2000               -- 조건
order by salary desc;              

-- 4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요. 
select ename 이름, dno 부서번호, eno 사원번호
from employee
where eno = 7788;

-- 5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
select ename 이름, salary 급여
from employee
where salary not between 2000 and 3000;

-- 6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오
select ename 이름, job 담당업무, hiredate 입사일
from employee
where hiredate between '81/02/20' and '81/05/01' ;

-- 7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오. 
select ename 이름, dno 부서번호          -- 1번풀이
from employee
where dno = 20 or dno = 30
order by ename desc;

select ename 이름, dno 부서번호          -- 2번풀이
from employee
where dno in (20,30)
order by ename desc;

-- 8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 
-- 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
select ename 이름,salary 급여, dno 부서번호     -- 1번풀이
from employee
where (salary between 2000 and 3000) and
(dno = 20 or dno = 30)
order by ename asc;

select ename 이름,salary 급여, dno 부서번호     -- 2번풀이
from employee
where (salary between 2000 and 3000) and
(dno in (20,30))
order by ename asc;

-- 9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용)
select ename 이름, hiredate 입사일           -- like 쓸때
from employee
where hiredate like '81%';

select ename 이름, hiredate 입사일           -- like 안쓸때
from employee
where substr (hiredate, 1, 2) = '81';


-- 10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
select ename 이름, job 담당업무
from employee
where manager is null;

-- 11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 
-- 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하시오. 
select ename 이름, salary 급여, commission 커미션
from employee
where commission is not null
order by salary desc, commission desc; 

-- 12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오. 
select ename 이름                 -- like
from employee
where ename like '__R%';

select ename 이름                 -- substr
from employee
where substr(ename, 3,1) = 'R';

-- 13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오. 
select ename 이름
from employee
where ename like '%A%' and ename like '%E%'; 

-- 14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서
-- 급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 

select ename 이름, job 담당업무, salary 급여         -- 1번
from employee
where (job in ('CLERK','SALESMAN')) and (salary not in(1600,950,1300));

select ename 이름, job 담당업무, salary 급여         -- 2번
from employee
where (job = 'CLERK' or job = 'SALESMAN') and ( not (salary = 1600 or salary = 950 or salary = 1300));

select ename 이름, job 담당업무, salary 급여         -- 3번
from employee
where (job = 'CLERK' or job = 'SALESMAN') and ( salary not in (1600,950,1300));

-- 15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.  

select ename 이름, salary 급여, commission 커미션
from employee
where commission >= 500;






-- 이름이 N으로 끝나는 사원들 출력하기 (substr 함수를 사용해서 사용)
select ename
from employee
where substrb (ename, -1, 1) = 'N';

select ename
from employee
where ename like '%N';

-- 87년도 입사한 사원들 출력 하기 (substr 함수를 사용해서 사용)
select * 
from employee
where substr (hiredate, 1,2) = '87';

select *
from employee
where hiredate like '87%';