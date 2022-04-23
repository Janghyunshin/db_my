-- 5일차 - 서브쿼리

--  Sub Query : Select 문 내에 select 문이 있는 쿼리

select ename, salary from employee;

select ename ,salary
from employee
where ename = 'SCOTT';

-- SCOTT 월급 보다 많은 사용자를 출력 하라 (서브 쿼리)

select ename, salary
from employee
where salary > 3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename = 'SCOTT');

-- SCOTT과 동일한 부서에 근무하는 사원들 출력하기 (5분) (sub query)
select ename, salary, dno
from employee
where dno = (select dno from employee where ename = 'SCOTT');

    -- sub query 사용 x
    select dno from employee where ename = 'SCOTT';
    select ename , dno from employee where dno = 20;


-- 최소 급여를 받는 사원의 이름, 담당업무, 급여 출력 하기 (sub query)
select min (salary) from employee;

select ename, job, salary
from employee
where salary = ( select min(salary) from employee);

-- 30번 부서(dno)에서 최소 월급을 받는 사원보다 많은 사원들 이름과, 부서번호와 월급을 출력해 보세요 (7분)
select min(salary)
from employee
where dno=30;   -- 최소 월급 950

select ename, dno, salary
from employee
where salary > ( select min(salary) from employee where dno = 30 );

-- Having 절에 Sub query 사용하기

-- 30번 부서의 최소 월급보다 큰 각 부서의 최소월급
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(Salary) from employee where dno = 30);

-- 단일행 서브 쿼리 : sub query의 결과 값이 단 하나면 출력
         -- 단일행 비교 연산자 :  >, =, >= , <, <=, <>
-- 다중행 서브 쿼리 : sub query의 결과 값이 여러개 출력
         -- 다중행 서브 쿼리 연산자 : IN, ANY, SOME, ALL , EXISTS
            -- IN : 메인 쿼리의 비교 조건 (' = ' 연산자로 비교할 경우) 이 서브쿼리의 결과 값 중에 하나라도 일치하면 참
            -- ANY, SOME : 메인 쿼리의 비교 조건이 서브쿼리의 검색 결과와 하나 이상 일치하면 참 
            -- ALL : 메인 쿼리의 비교조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참
            -- EXISTS: 메인 쿼리의 비교조건이 서브 쿼리의 결과 값 중에서 만족하는 값이 하나라도 존재하면 참
            
-- IN 연산자 사용하기
select ename, eno, dno, salary
from employee
order by dno asc;

-- 부서별로 최소 월급을 받는 사용자들 출력 하기 (sub query를 반드시 사용해서 출력)
-- SUBQUERY (x)
select dno, min(salary), count(*)
from employee
group by dno;

select ename, dno, salary
from employee
where salary in (950,800,1300);

-- SUB QUERY 사용시
select ename, dno, salary
from employee
where salary in ( select min(salary) from employee group by dno);


-- ANY 연산자 사용
    -- 서브 쿼리가 반환하는 각각의 값과 비교함
    -- ' < ANY' 는 최대값 보다 작음을 나타냄
    -- ' > ANY' 는 최소값 보다 크을 나타냄
    -- ' = ANY' 는 IN과 동일 함 

-- 예) 직급이 SALESMAN 이 아니면서 급여가 임의의 SALESMAN 보다 작은 사원을 출력
            -- 1600 (최대값) 보다 작은 모든 사원 (SALESMAN)이 아니고 
            
select eno, ename, job , salary
from employee 
where salary < any ( select salary from employee 
                    where job = 'SALESMAN')
                    and job <> 'SALESMAN' ;
                    
select ename, job, salary
from employee
order by job ;

-- ALL 연산자
    -- SUB QUERY의 반환하는 모든 값과 비교
    -- ' > all' : 최대값 보다 큼을 나타냄
    -- ' < all' : 최소값 보다 작음을 나타냄
    
-- 예) 직급이 SALESMAN이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력

    -- 1250 (최소값) 보다 작은 사원 ( 직급은 SALESMAN 이 아님)
select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'SALESMAN')
                    AND JOB <> 'SALESMAN';

-- 담당 업무가 분석가인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들 출력
select eno, ename, job, salary
from employee
where salary < all (select salary
                    from employee
                    where job = 'ANALYST')
                    AND JOB <> 'ANALYST';

-- 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과 급여에 대해서 오름차순 하시오.
select eno, ename, salary
from employee
where salary > (select round(avg(salary)) from employee)
order by salary asc;
