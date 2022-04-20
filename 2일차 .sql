-- 2일차  : DQL : Select

-- desc 테이블명 : 테이블의 구조를 확인
desc department;

select * from department;

/*
SQL : 구조화된 질의 언어 

Select 구문의 전체 필드 내용

Select      <== 컬럼명
Distinct    <== 컬럼내의 값의 중복을 제거해라.
From        <== 테이블명, 뷰명
Where       <== 조건
Group By    <== 특정 값을 그룹핑
Having      <== 그룹핑한 값을 정렬
Order by    <== 값을 정렬해서 가져옴
*/

desc employee;
select *
from employee;

-- 특정 컬럼만 출력하기
select eno, ename from employee;

-- 특정 컬럼을 여러번 출력
select eno, ename, eno, ename, ename from employee;

select eno, ename, salary from employee;

-- 컬럼에 연산을 적용할 수 있다.

select eno, ename, salary, salary * 12 from employee;

-- 컬럼명 알리어스 (Alias) : 컬럼의 이름을 변경,
-- 컬럼에 연산하거나 함수를 사용하면 컬럼명이 없어진다.
select eno, ename, salary, salary * 12 as 연봉 from employee;
select eno as 사원번호, ename as 사원명, salary as 월급 , salary * 12 as 연봉 from employee;
select eno 사원번호, ename 사원명, salary 월급 , salary * 12 연봉 from employee;
    -- 공백이나 특수문자가 들어 갈때는 "" 으로 처리해야 한다.
select eno "사원 #번호", ename "사원?명", salary 월급 , salary * 12 연봉 from employee;

-- nvl 함수 :  null을 처리하는 함수
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산. ( null이 포함된 컬럼에 연산을 적용하면 null)
    -- null 을 0으로 처리해서 연산해야함. : NVL
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary * 12 + commission        -- 전체연봉
from employee;

-- nvl 함수를 사용해서 연산
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary * 12 + NVL(commission, 0)        -- 전체연봉
from employee;

-- 특정 컬럼의 내용을 중복 제거후 출력
select * from employee;
select dno from employee;
select distinct dno from employee;

select ename, dno from employee;

select ename, distinct dno from employee;   -- 다른 컬럼 때문에 오류가 날 수 있다.

-- 조건을 사용해서 검색 (Where)
select * from employee;
select eno 사원번호, ename 사원명, job 직책, manager 직속상사, hiredate 입사날짜,
    salary 월급, commission 보너스, dno 부서번호
from employee;

-- 사원 번호가 7788인 사원의 이름을 검색.
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- 사원 번호가 7788인 사원의 부서번호, 월급과 입사날짜를 검색
select dno 부서번호, salary 월급, hiredate 입사날짜
from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- 레코드를 가져올때
    -- number 일때는 ''를 붙이지 않는다.
    -- 문자 데이터(char, varchar)나 날짜 (date) 를 가져올때는 ' ' 를 처리.
    -- 대소문자를 구분
    
-- 입사 날짜가 '81/12/03' 인 사원 출력
select ename
from employee
where hiredate = '81/12/03';

-- 부서 코드가 10인 모든 사원들을 출력

select ename , dno
from employee
where dno = 10;

select * from employee;

-- 월급이 3000 이상인 사원의 이름과 부서와 입사날짜, 월급을 출력
select ename, dno, hiredate, salary
from employee
where salary >= 3000;

-- Null 검색 : is 키워드 사용.     <== 주의 : = 를 사용하면 안된다.
select *
from employee
where commission is null;

-- commission이 300 이상인 사원이름과, 직책, 월급을 출력
select ename 사원이름, job 직책, salary 월급, commission 보너스
from employee
where commission >= 300;

-- 커미션이 없는 사원들의 이름을 출력.

select ename 사원이름 , commission 보너스
from employee
where commission is null;

-- 조건에서 and , or, not 연산

-- 월급이 500 이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜를 출력

select ename 사원이름, eno 사원번호, hiredate 입사날짜, salary 월급
from employee
where salary >= 500 and salary < 2500;

-- 1.직책이 SALESMAN 이거나, 부서코드가 20인 사원이름, 직책, 월급, 부서코드를 출력
select * from employee;

select ename 사원이름, job 직책, salary 월급, dno 부서코드
from employee
where job = 'SALESMAN' or 
dno = 20;

-- 2. 커미션이 없는 사용자중에 부서코드가 20인 사용자의 이름과 부서코드와 입사날짜를 출력. (AND)
select ename 사원이름, dno 부서코드, hiredate 입사날짜
from employee
where commission is null and 
dno = 20;

-- 3. 커미션이 NULL이 아닌 사용자의 이름, 입사날짜, 월급을 출력
select ename 사원이름, hiredate 입사날짜, salary 월급
from employee
where commission is not null;

-- 날짜 검색 : 
select * from employee;

-- 1982/1/1 ~ 1983/12/31 사이에 입사한 사원의 이름, 직책, 입사날짜

select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate >= '1982/01/01' and hiredate < '1983/12/31';

-- 1981년도에 입사한 사원들
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate >= '1981/01/01' and hiredate < '1981/12/31';

-- between A and B : A이상 B 이하
select ename 사원이름, job 직책, hiredate 입사날짜
from employee
where hiredate between '1981/01/01' and '1981/12/31';


-- IN 연산자

-- 커미션이 300, 500, 1400 인 사원의 이름, 직책, 입사일을 출력.

select * from employee;
-- In 없이
select ename 사원이름, job 직책, hiredate 입사날짜, commission
from employee
where commission = 300 or commission = 500 or commission = 1400;

select ename 사원이름, job 직책, hiredate 입사날짜, commission
from employee
where commission in (300,500,1400);

-- like     : 컬럼내의 특정한 문자열을 검색      <== 글검색 기능을 사용할때
    -- %    : 뒤에 어떤글자가 와도 상관없다.
    --_     : 한글자가 어떤값이 와도 상관없다.

-- F로 시작하는 이름을 가진 사원을 모두 검색하기
Select * from employee
where ename like 'F%';

-- 이름이 ES로 끝나는 사원을 검색하기.
select ename 
from employee
where ename like '%ES';

-- J로 시작되고 J뒤에 두글자가 어떤것이 와도 상관없는 사원 출력. 뒤에는 ES로 마무리됨
select ename
from employee
where ename like 'J__ES'; 

-- 마지막 글자가 R로 끝나는 사원출력 하기
Select *
from employee
where ename like '%R';

-- MAN 단어가 들어간 직책을 출력
select *
from employee
where job like '%MAN%';

-- 81년도에 입사한 사원을 출력하기.
select *
from employee
where hiredate >= '81/1/1' and hiredate <= '81/12/31';

select *
from employee
where hiredate between '81/1/1' and '81/12/31';

select *
from employee
where hiredate like '81%';

-- 81년 2월에 입사한 사원을 출력

select *
from employee
where hiredate like '81/02%';

---- 정렬 : order by  , asc (오름차순정렬), desc (내림차순 정렬)
select *
from employee
order by eno; -- asc 생략

select *
from employee
order by eno asc  ;

select *
from employee
order by eno desc  ;

--- 이름 컬럼을 정렬\select *
select *
from employee
order by ename asc ; 

select *
from employee
order by ename desc ; 

-- 날짜 정렬
select *
from employee 
order by hiredate asc;

select *
from employee 
order by hiredate desc;

-- 질문 답변형 게시판에서 주로 사용. 두개이상의 컬럼을 정렬할때

select * 
from employee
order by dno desc;

-- 두 개의 컬럼이 정렬 : 제일 처음 컬럼이 정렬을 하고, 동일한 값에 대해서 두번째 컬럼을 정렬.

select dno, ename
from employee
order by dno, ename;

select dno, ename
from employee
order by dno desc, ename desc;

-- where 절과 order by 절이 같이 사용될 때

select *
from employee
where commission is null
order by ename asc;

select *
from employee
where commission is null
order by ename desc;

-- 다양한 함수 사용하기
/*
    1. 문자를 처리하는 함수
        - UPPER : 대문자로 변환
        - LOWER : 소문자로 변환
        - INITCAP : 첫자는 대문자로 나머지는 소문자로 변환
        
        dual 테이블 : 하나의 결과를 출력 하도록 하는 테이블
*/
select '안녕하세요' as 안녕
from dual;

select 'Oracle mania' , upper ('Oracle mania'), LOWER ('Oracle mania'), initcap ('Oracle mania')
from dual;

select ename, lower (ename), initcap(ename), upper (ename)
from employee;

select * from employee
where ename = 'allen';   -- 검색이 안됨

select * from employee
where lower (ename) = 'allen';

select * from employee
where initcap (ename) = 'Allen';

select ename, initcap (ename) 
from employee
where initcap (ename) = 'Allen';

-- 문자 길이를 출력 하는 함수
    -- length : 문자의 길이를 반환, 영문이나 한글 관계없이 글자수를 리턴, 1byte
    
    -- lengthb: 문자의 길이를 반환, 영문 1byte, 한글 3byte로 반환,
    
select length ('Oracle mania'), length ('오라클 매니아') from dual;

select lengthb ('Oracle mania'), lengthb ('오라클 매니아') from dual;

select * from employee;

select ename, length(ename), job, length(job) from employee;

-- 문자 조작 함수
    -- concat : 문자와 문자를 연결해서 출력
    -- substr : 문자를 특정 위치에서 잘라오는 함수 , (영문,한글 모두 1byte로 처리)
    -- substrb : 문자를 특정 위치에서 잘라오는 함수, (영문은 1byte, 한글은 3byte로 처리)
    -- instr : 문자의 특정 위치의 인덱스 값을 반환
    -- instrb : 문자의 특정 위치의 인덱스 값을 반환 (영문은 1byte, 한글은 3byte로 처리)
    -- lpad, rpad : 입력 받은 문자열에서 특수문자를 적용
    -- trm : 잘라내고 남은 문자를 반환
    
select 'Oracle', 'mania', concat('Oracle', 'mania') from dual;

select concat ( ename, '    ' || job)
from employee;

select '이름은 : ' || ename || ' 이고, 직책은 : '  || job || ' 입니다' as 컬럼연결
from employee;

select '이름은 : ' || ename || ' 이고, 직속상관사번은 : ' || manager || ' 입니다' as 직속상관출력
from employee;

-- substr (대상, 시작위치, 추출갯수) : 특정위치에서 문자를 잘라온다.

select 'Oracle mania' , substr ('Oracle mania' ,  4, 3) , substr ('오라클 매니아', 2,4)
from dual;

select 'Oracle mania' , substr ('Oracle mania' ,  -4, 3) , substr ('오라클 매니아', -6,4)
from dual;

select ename, substr (ename, 2,3), substr (ename, -5, 2)
from employee;

select substrb ('Oracle mania', 3, 3), substrb ('오라클 매니아', 3,6)
from dual;

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

-- instr (대상, 찾을글자, 시작위치, 몇번째 발견) :대상에서 찾을 글자의 인덱스 값을 출력.

select 'Oracle mania' , instr ('Oracle mania', 'a')
from dual;

select 'Oracle mania' , instr ('Oracle mania', 'a', 5, 2)
from dual;

select 'Oracle mania' , instr ('Oracle mania', 'a', -5, 1)
from dual;

select distinct instr (job, 'A', 1, 1)
from employee
where lower(job) = 'manager';

-- lpad, rpad : 특정 길이만큼 문자열을 지정해서 왼쪽, 오른쪽에 공백을 특정 문자로 처리
    -- lpad (대상, 늘려줄문자열크기, 특수문자적용)
select lpad (1234, 10, '#') from dual;
select rpad (1234, 10, '#') from dual;

select salary from employee;

select lpad (salary, 10, '*')from employee;
select rpad (salary, 10, '*')from employee;

-- Trim : 공백 제거, 특정 문자도 제거
    -- LTRIM : 왼쪽의 공백을 제거
    -- RTRIM : 오른쪽의 공백을 제거
    -- TRIM : 왼쪽, 오른쪽의 공백을 제거
    
select ltrim ('    Oracle mania    ') as a, rtrim ('    Oracle mania    ') as b, trim ('    Oracle mania    ') as c
from dual;