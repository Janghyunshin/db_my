-- 1. TYPE
set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno, ename, salary, dno into v_eno, v_ename, v_salary, v_dno
    from employee
    where commission = 1400;
        
    dbms_output.put_line('사원번호   사원명   급여   부서번호');
    dbms_output.put_line('-------------------------------');
    dbms_output.put_line(v_eno || '   ' || v_ename || '   ' || v_salary || '   ' || v_dno);
end;
/

-- 2. ROWTYPE
set serveroutput on
declare 
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;
    
    dbms_output.put_line('사원번호   사원명   급여   부서번호');
    dbms_output.put_line('-------------------------------');
    dbms_output.put_line(v_employee.eno || '   ' || v_employee.ename || '   ' || v_employee.salary || '   ' || v_employee.dno);
end;
/