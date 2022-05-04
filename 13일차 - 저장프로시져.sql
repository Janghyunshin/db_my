13일차 - 저장프로시져 (Stored Procedure), 함수 (Function), 트리거 (Trigger)

/*
    저장프로시져의 장점
        1. PL/SQL을 사용가능하다. 자동화
        2. 성능이 빠르다.
            일반적인 SQL 구문 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행 
            저장프로시저 처음 실행 : 구문분석 -> 개체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
            저장프로시저 두번째 부터 :컴파일(메모리에 로드) -> 실행
            
        3. 입력 매개변수, 출력 매개변수를 사용할 수 있다.
        4. 일련의 작업을 묶어서 저장 (모듈화된 프로그래밍이 가능하다)
*/

1. 저장 프로시져 생성
    -- 스콧 사원의 월급을 출력하는 저장 프로시져 
    
Create procedure sp_salary
is
    v_salary employee.salary%type; -- 저장프로시져는 is 블락에서 변수를 선언
begin
    select salary into v_salary
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line ('SCOTT의 급여는 : ' || v_salary || ' 입니다' );
end;
/

/* 저장프로시져 정보를 확인하는 데이터 사전 */
select * from user_source
where name = 'SP_SALARY';

3. 저장 프로시져 실행
EXECUTE sp_salary; -- 전체 이름
EXEC sp_salary; -- 약식 이름

4. 저장 프로시져 수정

Create or replace procedure sp_salary -- sp_salary가 존재하지 않으면 생성, 존재하면 수정 
is
    v_salary employee.salary%type; -- 저장프로시져는 is 블락에서 변수를 선언
    v_commission employee.commission%type;
begin
    select salary, commission into v_salary, v_commission
    from employee
    where ename = 'SCOTT';
    if (v_commission is null )then v_commission := 0 ;
    end if;
    dbms_output.put_line ('SCOTT의 급여는 : ' || v_salary || 
                           ', 보너스는 : ' || v_commission || ' 입니다'  );
end;
/

5. 저장 프로시져 삭제
drop procedure sp_salary;

------------- << 인풋 매개변수를 처리하는 저장 프로시져 >> --------------
create or replace procedure sp_salary_ename ( -- 입력 매개변수 (in) , 출력 매개변수를 정의 (out)를 정의
    v_ename in employee.ename%type         -- 변수명 in 자료형   <== 주의 :   <<  ;를 사용하면 안된다. >> 
)
is  -- 변수선언 (저장 프로시져에서 사용할 변수 선언블락)
    v_salary employee.salary%type;
begin
    select salary into v_salary     -- 변수
    from employee 
    where ename = v_ename;          -- 인풋 매개변수 : v_ename
    
    DBMS_OUTPUT.PUT_LINE( v_ename || ' 의 급여는 ' || v_salary || ' 입니다' );
end;
/

exec sp_salary_ename ('SCOTT');
exec sp_salary_ename ('KING');

/* 부서번호를 인풋 받아서 이름, 직책, 부서번호를 출력하는 저장 프로시져를 생성*/
create or replace procedure sp_dno (   -- 입력 매개변수 (in) , 출력 매개변수를 정의 (out)를 정의
    v_dno in employee.dno%type         -- 변수명 in 자료형   <== 주의 :   <<  ;를 사용하면 안된다. >> 
)
is  -- 변수선언 (저장 프로시져에서 사용할 변수 선언블락)
    v_emp employee%rowtype;
    cursor c2
    is
    select *   -- *주의*
    from employee
    where dno = v_dno;
begin
    FOR v_emp IN c2 LOOP
        DBMS_OUTPUT.PUT_LINE( v_emp.ename || ' 의 직책은 ' || v_emp.job || ' , 이고 부서번호는 ' || v_emp.dno || ' 입니다' );
        end loop;
end;
/

exec sp_dno(10);
/* 테이블이름을 인풋 받아서 employee 테이블을 복사해서 생성하는 저장 프로시져를 생성 하세요.
    인풋 값 : emp_copy33
*/

/* 저장 프로시져를 사용해서 테이블 생성 */

create or replace procedure sp_createTable (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100) ;  -- SQL 쿼리를 저장하는 변수

begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee' ;  -- 테이블 생성쿼리를 변수에 할당.
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- 커서를 사용해서 sql 쿼리를 실행
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- 커서 중지
end;
/

grant create table to public;           -- << sys 계정에서 실행 >>

EXEC sp_createTable('emp_copy89');

select * from emp_copy89;
drop table emp_copy89;

----------------------- << 출력 매개변수 사용 >> -----------------------
/* 저장 프로시져 : 출력 매개변수가 지원 (여러개의) , 함수 : 출력 매개변수를 하나만 가짐.
    -- OUT 키워드를 사용.
    -- 저장 프로시져를 호출시 먼저 출력매개변수 변수선언후 호출이 가능.
    -- 호출시 출력매개변수 이름앞에 ': 변수명(출력매개변수명)'
    -- 출력 매개변수를 출력하기 위해서 PRINT 명령문이나 PL/SQL을 사용해서 출력할수 있다.
*/

create or replace procedure sp_salary_ename2 ( -- 입력/ 출력 매개변수 선언부
    v_ename in employee.ename%type,     -- 입력 매개 변수
    v_salary out employee.salary%type   -- 출력 매개 변수
    )
is
begin
    select salary into v_salary
    from employee
    where ename = v_ename;
end;
/

select * from user_source
where name = 'SP_SALARY_ENAME2';    -- 데이터 사전에서 확인

   -- 호출부에서 아웃풋 매개변수를 선언    -- : var_salary <==  : 주의
   -- 주석 처리 주의:
variable var_salary varchar2(50);
exec sp_salary_ename2 ('KING', :var_salary);   
print var_salary;




-- OUT 파라미터를 여러개 가지는 저장프로시져 생성 및 출력 (PL/SQL)
-- 사원번호를 인풋 받아서 사원이름, 급여, 직책을 OUT 파라미터에 넘겨주는 프로시져를 PL/SQL을 사용해서 출력 
create or replace procedure sel_empno ( -- in, out : 자료형은 참조 자료형,
    v_eno in number,                          -- 기본 자료형 바이트 수를 생략
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
    )
is
begin
    select ename, salary, job into v_ename, v_sal, v_job
    from employee
    where eno = v_eno;
end;
/
-- PL/SQL에서 저장프로시저 호출 
declare
    var_ename varchar2(50);
    var_sal number;
    var_job varchar2(50);
begin
    -- 익명 블록에서는 저장프로 시져 호출시 exec를 붙이지 않는다.
    sel_empno (7788, var_ename, var_sal, var_job);  -- 저장프로시져 호출
    dbms_output.put_line('조회결과 : ' || var_ename || '   ' || var_sal || '   ' || var_job);
end;
/

/* 함수 (Function ) : 값을 넣어서 하나의 값을 반환 받아온다.          <-- SQL 구문 내에서 사용가능
    -- 비교, 저장프로시져는 out 매개변수를 여러개 반환받아올수 있다.     <-- SQL 구문 내에서 사용불가
*/

create or replace function fn_salary_ename ( -- 인풋 매개변수
    v_ename in employee.ename%type
    )
Return number           -- 호출하는 곳으로 값을 던져줌    
is
    v_salary number (7,2);
begin
    select salary into v_salary
    from employee
    where ename = v_ename;      -- 인풋 매개변수
    return v_salary;
end;
/

-- 함수의 데이터 사전
select * from user_source
where name = 'FN_SALARY_ENAME';

-- 1. 함수사용
variable var_salary number;
exec :var_salary := fn_salary_ename('SCOTT');
print var_salary;

-- 2. 함수사용(SQL 구문 내에서 함수 사용)
select ename, fn_salary_ename('SCOTT')
from employee
where ename = 'SCOTT';









