--그룹함수 문제. 

select * from employee;

-- 1. 모든 사원의 급여 최고액, 최저액, 총액, 및 평균 급여를 출력 하시오.
    -- 컬럼의 별칭은 동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 
select max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round (avg(salary) )평균
from employee;


-- 2. 각 담당업무 유형별로 급여 최고액, 최저액, 총액 및 평균액을 출력하시오. 
-- 컬럼의 별칭은 동일(최고액, 최저액, 총액, 평균)하게 지정하고 평균에 대해서는 정수로 반올림 하시오. 

select job 담당업무, max(salary) 최고액, min(salary) 최저액, sum(salary) 총액, round (avg(salary) )평균
from employee
group by job;

-- 3. count(*)함수를 사용하여 담당 업무가 동일한 사원수를 출력하시오. 
select job 담당업무 , count(*) as "동일한 사원수"
from employee
group by job;

-- 4. 관리자 수를 나열 하시오. 컬럼의 별칭은 "관리자수" 로 나열 하시오. 
select manager, count(*) as "관리자수"
from employee
group by manager;

-- 5. 급여 최고액, 최저 급여액의 차액을 출력 하시오, 컬럼의 별칭은 "DIFFERENCE"로 지정하시오. 
select max(salary) "급여 최고액" , min(salary) "최저 급여액", max(salary)- min(salary) as "DIFFERENCE"
from employee;

-- 6. 직급별 사원의 최저 급여를 출력하시오. 관리자를 알 수 없는 사원 및 최저 급여가 2000미만인 그룹은 제외 시키고
    -- 결과를 급여에 대한 내림차순으로 정렬하여 출력 하시오. 
      
select job , min(salary)
from employee
where manager is not null
group by job
having (min(salary) > 2000 )
order by min(salary) desc;

-- 7. 각 부서에대해 부서번호, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오. 
-- 컬럼의 별칭은 [부서번호, 사원수, 평균급여] 로 부여하고 평균급여는 소숫점 2째자리에서 반올림 하시오. 
select dno, COUNT(*), round(avg(salary),2)
from employee
group by dno;

-- 8. 각 부서에 대해 부서번호이름, 지역명, 사원수, 부서내의 모든 사원의 평균 급여를 출력하시오.
-- 결럼의 별칭은 [출력예시] 로 지정하고 평균급여는 정수로 반올림 하시오.  

select * from department;

select dno "부서", decode(dno, 10, 'ACCOUNTING',
                        20, 'RESEARCH',
                        30, 'SALES',
                        40, 'OPERATIONS') as "dname", decode(dno, 10, 'NEW YORK',
                                                                20, 'DALLAS',
                                                                30, 'CHICAGO',
                                                                40, 'BOSTON') as "Location" , count(*) as "Number of people",
                                                                Round(avg(salary)) as "Salary"
from employee
group by dno;


 