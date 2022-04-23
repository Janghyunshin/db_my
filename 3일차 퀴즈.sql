-- 완료시간 : 4:50분 까지
-- dno 컬럼이 10번 부서일 경우 월급에서 + 300을 처리하고, 20번 부서일 경우 + 월급 +500을
    -- 부서번호가 30일 경우 월급에 + 700을 해서 이름, 월급 , 부서별 월급 플러스한 결과를 출력

select ename 이름 , dno 부서번호 ,  salary 월급, decode (dno, 10, salary + 300,
                                                           20, salary + 500,
                                                           30, salary + 700) as 최종월급
from employee
order by dno asc;

select * from employee;

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
