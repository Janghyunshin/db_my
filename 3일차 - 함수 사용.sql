-- 숫자 함수

/*
  ROUND : 특정 자릿수에서 반올림.
  TRUNC : 특정 자릿수에서 잘라낸다. (버린다.)
  MOD   : 입력 받은 수를 나눈 나머지 값만 출력
*/

-- round ( 대상 ) : 소숫점 뒷자리에서 반올림
-- round ( 대상, 소숫점자릿수 ) : 소숫점 뒷자리에서 반올림
    -- 소숫점 자릿수 : 양수일때 소숫점 오른쪽으로 자릿수 만큼 이동해서 그 자릿수 뒤에서 반올림.
    -- 소숫점 자릿수 : 음수일때 소숫점 왼쪽으로 자릿수 만큼 이동하고 그 자릿수에서 반올림.
        -- 정수를 반올림
        -- 소숫점 자리는 모두 버림
select 98.7654 , ROUND (98.7654), round (98.7654, 2) , round (98.7654, -1), round(98.7654, -2), round (98.7654, 3)
from dual;

select 12345.6789 , round (12345.6789) ,round (12345.6789,2),  round (12345.6789, -3) , round(123678.123456, -3)
from dual;

select 98.7654 , TRUNC (98.7654), TRUNC(98.7654, 2) , TRUNC (98.7654, -1), TRUNC (987.654, -2)
from dual;

-- mod (대상, 나누는수) : 대상을 나누어서 나머지만 출력
select mod (31 , 2) , mod ( 31,5), mod (31,8)
from dual;

select salary, mod (salary, 300)
from employee;

-- employee 테이블에서 사원번호가 짝수인 사원들만 출력. (MOD 함수를 사용)
select *
from employee
where MOD (eno, 2) = 0;

/*  날짜 함수
    sysdate : 시스템에 저장된 현재 날짜를 출력.
    months_between : 두 날짜 사이의 몇 개월 인지를 반환
    add_months : 특정 날짜에 개월수를 더한다.
    next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜
    last_day : 달의 마지막 날짜를 반환
    round    : 인자로 받은 날짜를 특정 기준으로 반올림 .
    trunc    : 인자로 받은 날짜를 특정 기준으로 버림.
*/

-- 자신의 시스템의 날짜 출력.
select sysdate
from dual;

select sysdate -1 as 어제날짜, sysdate as 오늘날짜, sysdate +1 as "내일 날짜"
from dual;

select * from employee
order by hiredate asc;

select hiredate, hiredate -1, hiredate + 10 
from employee;

desc employee;

-- 입사일에서 부터 현재까지의 근무일수 
select hiredate 입사일 , sysdate "현재 날짜" , round (sysdate - hiredate) as "총 근무일수"
from employee;

select hiredate 입사일 , sysdate "현재 날짜" , round ((sysdate - hiredate),2) as "총 근무일수"
from employee;

select hiredate 입사일 , sysdate "현재 날짜" , trunc (sysdate - hiredate) as "총 근무일수"
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 버림한 날짜 - trunc
select hiredate , trunc (hiredate, 'MONTH')
from employee;

-- 특정 날짜에서 월(Month)을 기준으로 반올림한 날짜 : 16일 이상일 경우 반올림. - round
select hiredate , round (hiredate, 'MONTH')
from employee;

-- months_between(data1, data2) : date1과 date2 사이의 개월수를 출력.

-- 입사일에서 현재까지 각 사원들의 근무한 개월 수 구하기
select ename, sysdate, hiredate, months_between (sysdate,hiredate) as "근무 개월수"
from employee;

select ename, sysdate, hiredate, trunc(months_between (sysdate,hiredate)) as "근무 개월수"
from employee;

-- add_months (date1, 개월수) : date1 날짜에 개월수를 더한 날짜를 출력.
-- 입사한 후 6개월이 지난 시점을 출력
select hiredate, add_months (hiredate, 6)
from employee;

-- 입사한 후 100일이 지난 시점의 날짜 
select hiredate, hiredate + 100 as "입사 후 100일 날짜"
from employee;

-- next_day (date, '요일') : date의 도래하는 요일에 대한 날짜를 출력하는 함수

select sysdate, next_day (sysdate,'토요일') as "이번주 토요일의 날짜"
from dual;

-- last_day (date) : date 에 들어간 달의 마지막 날을 출력

select hiredate, last_day (hiredate)
from employee;

-- 형 변환 함수  <-== 중요
/*
    TO_CHAR : 날짜형 또는 숫자형을 문자형으로 변환하는 함수
    TO_DATE : 문자형을 날짜형으로 변환하는 함수
    TO_NUMBER : 문자형을 숫자형으로 변환하는 함수
*/

-- 날짜 함수 사용하기
-- TO_CHAR (date, 'YYYYMMDD') 
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'), to_char(hiredate, 'YYMM'),
    to_char(hiredate, 'YYYYMMDD DAY'), to_char(hiredate, 'YYYYMMDD DY')
from employee;

-- 현재 시스템의 오늘 날짜를 출력하고, 시간 초까지 츌력
select sysdate, to_char( sysdate , 'YYYY-MM-DD HH:MI:SS DY') as "현재 시간"
from dual;

desc employee;

select hiredate, to_char (hiredate, 'YYYY-MM-DD HH:MI:SS DAY')
from employee;

-- to_char 에서 숫자와 관련된 형식
/*
    0 : 자릿 수를 나타내며 자릿수가 맞지 않을 경우 0으로 채웁니다.
    9 : 자릿 수를 나타내며 자릿수가 맞지 않을 경우 채우지 않습니다.
    L : 각 지역별 통화기호를 출력
    . : 소숫점으로 표현
    , : 천 단위의 구분자.
*/
desc employee;

select ename, salary, to_char(salary, 'L999,999'), to_char(salary, 'L0000,000')
from employee;

-- to_date ('char', 'format') : 날짜 형식으로 변환

-- 오류 발생 : date - char
select sysdate, sysdate  - '20000101'
from dual;

-- 2000년 1월 1일 에서 오늘까지의 일수
select sysdate, trunc (sysdate  - to_date('20000101', 'YYYYMMDD'))
from dual;

select sysdate, trunc (sysdate - to_date ('021010', 'YYMMDD')) as "날짜의 차"
from dual;

select sysdate, to_date ('02/10/10', 'YY/MM/DD'),trunc (sysdate - to_date ('021010', 'YYMMDD')) as "날짜의 차"
from dual;

select ename, hiredate
from employee
where hiredate = to_date (19810222, 'YYYYMMDD');

select ename, hiredate
from employee
where hiredate = to_date ('1981-02-22', 'YYYY-MM-DD');

-- 2000년 12월 25일부터 오늘까지 총 몇달이 지났는지 출력
select trunc (months_between (sysdate, to_date('20001225', 'YYYYMMDD'))) as "걸린 달"
from dual;

select trunc (months_between (sysdate, to_date('2000/12/25', 'YYYY/MM/DD'))) as "걸린 달"
from dual;

-- to_number : number 데이터 타입으로 변환 ,
select 100000 - 50000
from dual;

-- 오류 발생 : 문자열 - 문자열 
select '100,000' - '50,000'
from dual;

select to_number('100,000', '999,999') - to_number('50,000' , '999,999')
from dual;

-- NVL 함수 : null을 다른 값으로 치환해주는 함수
    -- nvl (expr1, expr2) : expr1 에서 null 을 expr2로 치환
    
select commission
from employee;

select commission, NVL (commission, 0)
from employee;

select manager
from employee;

select manager , NVL( manager, 1111)
from employee;

-- NVL2 함수
    -- nvl2 (expr1, expr2, expr3) : expr1이 null이 아니면 expr2 를 출력, expr1이 null 이면 expr3를 출력.
    
    select salary, commission
    from employee;

-- NVL 함수로 연봉 계산하기
select salary * 12 + commission as 연봉
from employee;


-- NVL 함수를 사용해서 연봉 계산 하기
select salary , salary * 12, commission, nvl (commission, 0), 
    salary *12 + nvl(commission, 0 ) as 연봉
from employee;

-- NVL2 함수를 사용해서 연봉 계산 하기
select salary, commission, NVL2(commission, salary * 12 + commission, salary * 12) as 연봉 
from employee;

-- nullif : 두 표현식을 비교해서 동일한 경우 Null 을 반환하고 동일하지 않는 경우 첫번째 표현식을 반환
    -- null (expr1, expr2) : 
select nullif ('A', 'A'), nullif ('A', 'B')
from dual;

-- coalesce 함수
-- coalesce (expr1, expr2, expr3.....expr-n) :
    -- expr1 이 null 이아니면 expr1 을 반환하고,
    -- expr1 이 null 이면 expr2가 null이 아니면 expr2를 반환
    -- exprl 이 null 이고 expr2가 null 이면, 반환한다......
    
select coalesce ('abc','bcd','def','efg','fgi')
from dual;

select coalesce ( null,'bcd','def','efg','fgi')
from dual;

select coalesce ( null, null,'def','efg','fgi')
from dual;

select coalesce ( null, null, null,'efg','fgi')
from dual;

select ename, salary, commission, coalesce (commission, salary, 0)
from employee; 

-- decode 함수 : switch case 문과 동일한 구문 

/*
    DECODE ( 표현식, 조건, 결과1, 
                    조건, 결과2,
                    조건, 결과3,
                    기본결과n
            )        
*/

select ename, dno, decode (dno, 10, 'ACCOUNTING',
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATIONS',
                                'DEFAULT' ) as DNAME
from employee;

-- 

select * from employee;

-- dno 컬럼이 10번 부서일 경우 월급에서 + 300을 처리하고, 20번 부서일 경우 + 월급 +500을
    -- 부서번호가 30일 경우 월급에 + 700을 해서 이름, 월급 , 부서별 월급 플러스한 결과를 출력

select ename 이름 , dno 부서번호 ,  salary 월급, decode (dno, 10, salary + 300,
                                   20, salary + 500,
                                   30, salary + 700,
                                   'DEFAULT') as 최종월급
from employee;

-- case : if ~ else if , else if ~~~
    /*
        case 표현식 WHEN 조건 1 THEN 결과 1
                   WHEN 조건 2 THEN 결과 2
                   WHEN 조건 3 THEN 결과 3
                   ELSE 결과n
        END
    */

select ename, dno, case when dno=10 then 'ACCOUNTING'
                        when dno=20 then 'RESEARCH'
                        when dno=30 then 'SALES'
                        ELSE 'DEFAULT'
                   END as 부서명
from employee
order by dno;






