-- 4일차
/*
    그룹 함수 : 동일한 값에 대해서 그룹핑해서 처리하는 함수
        groupby 절에 특정 컬럼을 정의할 경우, 해당 컬럼에 동일한 값들을 그룹핑해서 연산을 적용.
        
    집계함수 : 
        - SUM : 그룹의 합계
        - AVG : 그룹의 평균
        - MAX : 그룹의 최대값
        - MIN : 그룹의 최소값
        - COUNT : 그룹의 총 개수 (레코드 수, record, 로우 수 row)
*/

select sum(salary), round( avg(salary), 2 ), max(salary), min(salary)
from employee;

-- 주의 : 집계 함수를 처리할 때, 출력 컬럼이 단일 값으로 나오는 컬럼을 정의

select sum(salary)
from employee;

select ename
from employee;

select *
from employee;

-- 집계함수는 null 값을 처리해서 연산한다.
select sum (commission), avg (commission), max(commission), min(commission)
from employee;

-- count () : 레코드 수, 로우 수
    -- null은 처리되지 않는다.
    
select eno from employee;         -- 14
select count (eno) from employee; -- 14

select commission from employee;            -- 14
select count (commission) from employee;    -- 4 (null은 카운트하지 않음)

select count (*) from employee;
select * from employee;

-- count () : 레코드 수 , 로우 수
    -- NULL은 처리하지 않는다.
    -- 테이블의 전체 레코드 수를 가져올 경우 : count (*) 또는 NOT NULL 컬럼을 count()
    
desc employee;

-- 전체 레코드 카운트

select count(*) from employee;
select count(eno) from employee;

-- 중복되지 않는 직업의 갯수

select job from employee;

select count(distinct job) from employee;

-- 부서의 갯수 (dno)

select count (distinct dno) from employee;


-- GROUP BY : 특정 컬럼의 값을 그룹핑한다. 주로 집계함수를 select 절에서 같이 사용합니다.
/*
    select 컬럼명, 집계함수 처리된 컬럼
    from 테이블
    where 조건
    group by 컬럼명
    having 조건 (group by에 대한 조건)
    order by 정렬
    
*/

-- 부서별 평균 급여
select dno as 부서번호 , avg(salary) as 평균급여
from employee
group by dno;      -- dno 컬럼의 중복된것을 그룹핑 함.

select dno from employee;

-- 전체 평균 급여
select avg(salary) as 평균급여
from employee;

-- groub by를 사용하면서 select 절에 가져올 컬럼을 잘 지정해야 한다.
    -- ex) ename 컬럼을 넣을 시  오류 
select dno 부서번호, count(dno), sum(salary) , avg(salary), max(commission), min(commission)      
from employee
group by dno
order by dno;

-- 
select job from employee;

-- 동일한 직책을 그룹핑해서 월급의 평균, 합계, 최대값, 최소값을 출력.
select job 직책, count(job), avg(salary) "월급의 평균", sum(salary) 합계, max(salary) 최대값, min(salary) 최소값
from employee 
group by job;       -- 동일한 직책을 그룹핑해서 집계를 한다.

-- 여러 컬럼을 그룹핑 하기.
select dno, job, count(*), sum(salary)
from employee
group by dno, job;      -- 두 컬럼 모두 일치하는 것을 그룹핑 

select dno, job
from employee
where dno = 20 and job = 'CLERK';

-- Having : group by 에서 나온 결과를 조건으로 처리할 때
    -- 별칭이름을 조건으로 사용하면 안된다.
    
-- 부서별 월급의 합계가 9000이상인 것만 출력
select dno, count(*), sum(salary) "부서별 합계", round(avg(salary), 2) as "부서별 평균"
from employee
group by dno
having sum(salary) >= 9000;

-- 부셔별 월급의 평균이 2000이상인 것만 출력
select dno, count(*), sum(salary) "부서별 합계", round(avg(salary), 2) as "부서별 평균"
from employee
group by dno
having round (avg(salary), 2) >= 2000.00;


-- where : 실제 테이블의 조건으로 검색
-- having : group by 결과에 대해서 조건을 처리.

select * from employee;

-- 월급 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력하라

select dno, count(*), round(avg(salary))
from employee
where salary > 1500
group by dno
having avg(salary) > 2500;

-- ROLLUP
-- CUBE
    -- Group by 절에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열할 수 있다.
    -- group by 절의 자세한 정보를 출력...

-- Rollup, cube를 사용하지 않는 경우    
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by dno
order by dno;

-- Rollup : 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계, 평균
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup (dno)
order by dno;

-- cube : 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계, 평균
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by cube (dno)
order by dno;

-- Rollup : 두 컬럼이상
select dno, job, count(*), Max(Salary), sum(salary), Round(avg(salary))
from employee
group by rollup (dno, job); -- 두개의 컬럼이 적용됨, 두 컬럼에 걸쳐서 동일할때 그룹핑.

select dno, job, count(*), Max(Salary), sum(salary), Round(avg(salary))
from employee
group by rollup(dno, job)
order by dno asc;

-- cube : rollup 보다 더 세밀한 정보를 줌 
select dno, job, count(*), max(Salary), sum(salary), Round(avg(salary))
from employee
group by cube (dno,job)
order by dno, job;

-- JOIN
    -- department 와 employee는 원래의 하나의 테이블이 었으나 모델링을(중복제거, 성능향상)을 통해서 두 테이블을 분리
    -- 두 테이블의 공통키 컬럼 (dno), employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조
    -- 두개 이상의 테이블의 컬럼을 JOIN구문을 사용해서 출력 
    
select * from department;   -- 부서정보를 저장하는 테이블
select * from employee;     -- 사원정보를 저장하는 테이블 

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN, Oracle 에서만 사용가능
    -- from 절 : 조인할 테이블을 ","로 처리
    -- where 절: 두 테이블의 공통의 키 컬럼을 " = " 로 처리
        -- and 절 : 조건을 처리

        
-- Where 절 : 공통 키 컬럼을 처리할 경우
select *
from employee, department
where department.dno = employee.dno  -- 공통 키 적용
and job = 'MANAGER';                 -- 조건을 처리

-- ANSI 호환 : INNER JOIN              <== 모든 SQL에서 사용 가능한 JOIN
-- ON 절: 공통 키컬럼을 처리한 경우
    -- on 절 : 두 테이블의 공통의 키 컬럼을 " = " 로 처리
        -- where 절: 조건을 처리

select *
from employee e JOIN department d
on e.dno = d.dno  -- 공통 키 적용
where job = 'MANAGER';                 -- 조건을 처리

-- JOIN시 테이블 알리어스 ( 테이블 이름을 별칭으로 두고 많이 사용)
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select 절에서 공통의 키 컬럼을 출력시에 어느 테이블의 컬럼인지 명시 : dno
select eno, job, d.dno, dname
from employee e, department d
where e.dno  = d.dno;

-- 두 테이블을 join해서 부서별(dname) 월급의 최대값을 부서명(dname)으로 출력
select  dname "부서명", count(*), max(salary) "월급의 최대값"
from employee e, department d
where e.dno = d.dno
group by dname;

-- NATURAL JOIN : Oracle 9i 지원 (where절 없이 join)
    -- EQUI JOIN의 Where 절을 없앰 : 두 테이블의 공통의 키 컬럼을 정의 " = "
    -- 공통의 키 컬럼을 Oracle 내부적으로 자동으로 감지해서 처리
    -- 공통 키컬럼을 별칭 이름을 사용하면 오류가 발생
    -- 반드시 공통 키 컬럼은 데이터 타입이 같아야 한다.
    -- from 절에 natural join 키워드를 사용

select eno, ename, dname, dno
from employee e natural join department d;

-- 주의 : select 절의 공통키 컬럼을 출력시 테이블명을 명시하면 오류 발생

-- EQUI JOIN vs NATURAL JOIN의 공통 키 컬럼 처리
    -- EQUI JOIN    :  select 에서 반드시 공통 키컬럼을 출력 할떄 테이블명을 반드시 명시
    -- natural join :  select 에서 반드시 공통 키컬럼을 출력 할떄 테이블명을 반드시 명시하지 않아야 한다.
    
-- EQUI JOIN (d.dno/e.dno 명시)
select ename, salary, dname, d.dno
from employee e, department d
where e.dno = d.dno
and salary > 2000;

-- natural join (테이블명 명시x)
select ename, salary, dname, dno
from employee e natural join department d
where salary > 2000;

-- ANSI호환의 INNER JOIN
select ename, salary, dname, d.dno
from employee e join department d
on  e.dno = d.dno
where salary > 2000;

-- NON EQUI JOIN : EQUI JOIN에서 Where 절의 " = " 를 사용하지 않는 join

select * from salgrade;  -- : 월급의 등급을 표시 하는 테이블

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- 테이블 3개 조인

select ename, dname, salary, grade
from employee e , department d, salgrade s 
where e.dno = d.dno
and salary between losal and hisal;

-- SELF JOIN : 자기 자신의 테이블을 조인한다. (주로 사원의 상사 정보를 출력 할때 사용함. 조직도 ...)
    -- 별칭을 반드시 사용해야 한다.
    -- select 절 : 테이블이름별칭.컬럼명 , 

select eno, ename, manager
from employee
where manager = '7788';

-- SELF JOIN을 사용해서 사원의 직속 상관 이름을 출력

-- EQUI JOIN으로 Self JOIN을 처리
select e.eno as "사원번호", e.ename as "사원이름" , e.manager as "직속상관번호" , m.ename as "직속상관이름"
from employee e, employee m -- SELF JOIN :
where e.manager = m.eno
order by e.ename asc;

select eno, ename, manager, eno, ename
from employee;

-- ANSI 호환 : INNER JOIN으로 처리

select e.eno as "사원번호", e.ename as "사원이름" , e.manager as "직속상관번호" , m.ename as "직속상관이름"
from employee e inner JOIN employee m -- SELF JOIN :
on e.manager = m.eno
order by e.ename asc;


select e.ename || '의 직속상관은' || e.manager || '입니다.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

-- ANSI 호환: INNER JOIN으로 처리
select e.ename || '의 직속상관은' || e.manager || '입니다.'
from employee e INNER JOIN employee m
on e.manager = m.eno
order by e.ename asc;

-- OUTER JOIN :
    -- 특정 컬럼의 두 테이블에서 공통적이지 않는 내용을 출력해야 할때
    -- 공통적이지 않는 컬럼은 NULL 출력
    -- + 기호를 사용해서 출력 : Oracle
    -- ANSI 호환: OUTER JOIN 구문을 사용해서 출력 <== 모든 DBMS 에서 호환

-- Oracle
select e.ename, m.ename
from employee e join employee m
on e.manager = m.eno (+)
order by e.ename asc;

-- ANSI 호환을 사용해서 출력.
    -- Left Outer JOIN : 공통적인 부분이 없더라도 왼쪽은 무조건 모두 출력
    -- Right Outer JOIN : 공통적인 부분이 없더라도 오른쪽은 무조건 모두 출력
    -- Full Outer Join : 공통적인 부분이 없더라도 무조건 양쪽 모두 출력

-- Left Outer JOIN
select e.ename, m.ename
from employee e left outer join employee m
on e.manager = m.eno
order by e.ename asc;






-- 제약 조건 : 테이블 컬럼에 할당되어서 데이터의 무결성을 확보
    -- Primary Key: 테이블에 하번만 사용할 수 있다. 하나의 컬럼, 두개 이상을 그룹핑해서 적용
        -- 중복된 값을 넣을수 없다. NULL을 넣을 수 없다.
    -- UNIQUE     : 테이블에 여러 컬럼에 할당할 수 있다. 중복된 값을 넣을수 없다.
        -- NULL 넣을 수 있다. 단 한번만 NULL
    -- Foreign Key : 다른 테이블의 특정 컬럼의 값을 참조해서만 값을 넣을 수 있다.
        -- 자신의 컬럼에 임의의 값을 할당하지 못한다.
    -- NOT NULL : NULL 값을 컬럼에 할당할 수 없다.
    -- CHECK    : 컬럼에 값을 할당할 때 체크해서 (조건에 만족) 값을 할당.
    -- DEFAULT  : 값을 넣지 않을때 기본값이 할당.
    

