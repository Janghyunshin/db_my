
/*
    저장프로시져의 장점
        1. PL/SQL을 사용가능하다. 자동화
        2. 성능이 빠르다.
            일반적인 SQL 구문 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
            저장프로시져 처음실행 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
            저장프로시져 두번째실행부터 : 컴파일(메모리에로드) -> 실행
        3. 입력 매개변수, 출력 매개변수 사용가능
        4. 일련의 작업을 묶어서 저장 ( 모듈화된 프로그래밍이 가능하다)

*/

--1. 저장프로시져 생성
--스콧 사원의 월급을 출력 하는 저장 프로시져
SET SERVEROUTPUT ON;
CREATE PROCEDURE sp_salary
is
    v_salary employee.ename%type;   --저장프로시져 is 블락에서 변수를 선언
BEGIN
    SELECT salary INTO v_salary
    FROM employee
    WHERE ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('SCOTT의 급여는 : '|| v_salary ||' 입니다');
END;
/



/*저장프로시져 정보를 확인하는 데이터 사전 */
SELECT * FROM user_source
WHERE name ='SP_SALARY';

--3.저장 프로시져 실행

EXECUTE sp_salary; --전체이름 -- 주석이랑 같이 실행하면 안되네
EXEC sp_salary; -- 약식 이름

--4.저장 프로시져 수정

CREATE or replace PROCEDURE sp_salary
is
    v_salary employee.salary%type;   --저장프로시져 is 블락에서 변수를 선언
    v_commission employee.commission%type;
BEGIN
    SELECT salary,commission INTO v_salary, v_commission
    FROM employee
    WHERE ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('SCOTT의 급여는 : '|| v_salary ||
                            '보너스는: '||v_commission|| ' 입니다');
END;
/

--4. 저장 프로시져 삭제

drop PROCEDURE sp_salary;

--------------<<인풋 매개변수를 처리하는 저장 프로시져>>------------------------------------------------------------
CREATE or REPLACE PROCEDURE sp_salary_ename(    --괄호 안에 입력매개변수(in), 출력 매개변수(out)를 정의
    v_ename in employee.ename%type          --변수명 in 자료형<== 주의: ;을 사용하지 않는다 여러개일 경우,로 처리
)
is                                           --변수선언(저장 프로시져에서 사용할 변수 선언블락)
    v_salary employee.salary%type;
BEGIN
    SELECT salary INTO v_salary --변수
    FROM employee
    WHERE ename = v_ename;      --인풋 매개변수
    
    DBMS_OUTPUT.PUT_LINE(v_ename||' 의 급여는 ' || v_salary || '입니다');
end;
/

EXEC sp_salary_ename('SCOTT');
EXEC sp_salary_ename('SMITH');
EXEC sp_salary_ename('KING');

/*부서번호를 인풋 받아서 이름, 직책, 부서번호를 출력하는 저장 프로시져를 생성하기*/
CREATE or replace PROCEDURE sp_dno(
    v_dno in employee.dno%type
)
is
    v_emp employee%rowtype;
    CURSOR c1
    is
    SELECT * FROM employee
    WHERE dno=v_dno;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('사원이름   직책   부서번호');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
        FOR v_emp IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE(v_emp.ename||'   '||v_emp.job||'   '||v_emp.dno);
    END LOOP;
END;
/

EXEC sp_dno(10);


/*테이블이름을 인풋 받아서 employee 테이블을 생성하는 저장프로시져를 생성하세요.
    인풋 값: emp_copy33 ????????????????????????????????
*/

CREATE OR REPLACE PROCEDURE PRO_CRE(v_name varchar2)
IS
cursor1 INTEGER;
credbsql VARCHAR2(100);

BEGIN
credbsql := 'CREATE TABLE ' || emp_c10 || ' as select * from employee';

-- 테이블 생성
        cursor1 := DBMS_SQL.OPEN_CURSOR;  
        DBMS_SQL.PARSE(cursor1, credbsql, dbms_sql.v7);
        DBMS_SQL.CLOSE_CURSOR(cursor1);
                
END;
/

GRANT CREATE TABLE TO PUBLIC;
EXEC sp_createTable ('emp_copy33');
SELECT * FROM emp_copy33;
    












