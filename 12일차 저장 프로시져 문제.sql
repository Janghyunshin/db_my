-- 12���� ���� ���ν��� ���� 

-- 1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
-- [employee ] ���̺� �̿�

set serveroutput on
create or replace procedure sp_ex1
is  -- ���� �����, Ŀ�� ���� 
    v_dno employee.dno%type;
    v_min employee.salary%type;
    v_max employee.salary%type;
    v_avg employee.salary%type;
    
    cursor c1
    is
    select min(salary), max(salary), avg(salary) into v_min , v_max, v_avg -- *����*
    from employee
    group by dno;
begin
    dbms_output.put_line ('�ּұ޿�   �ִ�޿�   ��ձ޿�');
    dbms_output.put_line ('--------------------------');
    open c1;    -- Ŀ�� ���� 
    loop
        fetch c1 into v_min, v_max, v_avg;
        exit when c1%notfound;  -- ���ڵ��� ���� ���̻� �������� ���� ��
        dbms_output.put_line (v_min || '   ' || v_max || '   ' || v_avg);
    end loop;
    close c1; 
end;
/
exec sp_ex1;


-- 2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
-- [employee, department ] ���̺� �̿�

set serveroutput on
create or replace procedure sp_ex2
is 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    
    cursor c2
    is
    select eno, ename, dname, loc  -- *����*
    from employee e, department d
    where e.dno = d.dno;
begin
    dbms_output.put_line ('�����ȣ   ����̸�   �μ���   �μ���ġ');
    dbms_output.put_line ('----------------------------------');
    open c2;
    loop
        fetch c2 into v_eno, v_ename, v_dname, v_loc;
        exit when c2%notfound;
        dbms_output.put_line ( v_eno || '   ' || v_ename|| '   ' || v_dname || '   ' || v_loc);
    end loop;
    close c2;
end;
/
exec sp_ex2;



-- 3-1. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
-- �������ν����� : sp_salary_b

create or replace procedure sp_ex3(
    v_salary in employee.salary%type
)
is 
    v_emp employee%rowtype; 
    cursor c1
    is
    select ename, salary, job   -- *����*
    from employee
    where salary > v_salary;
begin
    dbms_output.put_line ('����̸�   �޿�   ��å');
    dbms_output.put_line ('----------------------------------');
    open c1;
    loop
        fetch c1 into v_emp.ename, v_emp.salary, v_emp.job;
        exit when c1%notfound;
        dbms_output.put_line (v_emp.ename|| '   ' || v_emp.salary|| '   ' || v_emp.job);
    end loop;
    close c1;
end;
/
exec sp_ex3 (3000);

-- 3-2. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
-- �������ν����� : sp_salary_b

-- type���� Ǯ��
create or replace procedure sp_ex3 (
    v_sal in employee.salary%type
)
is
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_job employee.job%type;
    cursor c1
    is
    select ename, salary, job
    from employee
    where salary > v_sal;
begin
    dbms_output.put_line ('����̸�   �޿�   ��å');
    dbms_output.put_line ('-------------------');
    open c1;
    loop
        fetch c1 into v_ename, v_salary, v_job;
        exit when c1%notfound;
        dbms_output.put_line ( v_ename || '   ' || v_salary || '   ' || v_job);
    end loop;
    close c1;
end;
/






-- 4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
-- 	�������ν����� : sp_copy_table

    -- PL/SQL ���ο��� �͸� ������� ���̺��� ���� : grant create table to public;  << sys �������� ���� >>
    -- �������ν��� ������ : revoke create table from public;
set serveroutput on	
create or replace procedure sp_ex4 (
    v_emp in varchar2,
    v_dept in varchar2  -- ���� ; ������ �ȵ� , �ڷ����� ũ�⸦ �����ϸ� �ȵ�
    )
is
    cursor1 integer;     -- Ŀ�� ���� ����
    v_sql1 varchar2(500);   -- ���̺� ���� ������ ���� ����
    v_sql2 varchar2(500);
begin
    cursor1 := dbms_sql.open_cursor;   -- Ŀ�� ���
    v_sql1 := 'CREATE TABLE ' || v_emp || ' as select * from employee' ;  -- ���̺� ���������� ������ �Ҵ�.
    v_sql2 := 'CREATE TABLE ' || v_dept || ' as select * from department' ;  -- ���̺� ���������� ������ �Ҵ�.
    DBMS_SQL.PARSE ( cursor1, v_sql1, dbms_sql.v7);
    DBMS_SQL.PARSE ( cursor1, v_sql2, dbms_sql.v7);-- Ŀ���� ����ؼ� sql ������ ����
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- Ŀ�� ����
end;
/
exec sp_ex4('emp_c10', 'dept_c10');

select * from emp_c10;

-- 5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 
    
    desc dept_c10;
    
create or replace procedure sp_ex5 (
    v_dno in dept_c10.dno%type,
    v_dname in dept_c10.dname%type,
    v_loc in dept_c10.loc%type
)
is
begin
    INSERT INTO dept_c10(dno, dname, loc)
    VALUES(v_dno, v_dname, v_loc);
    dbms_output.put_line ('���������� �� �Է��� �Ǿ����ϴ�');
    COMMIT;
end;
/
exec sp_ex5 (50,'HR','SEOUL');
exec sp_ex5 (60,'HR2','PUSAN');

select * from dept_c10;
-- 6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
select * from emp_c10;

set serveroutput on
create or replace procedure sp_ex6(
    v_eno in emp_c10.eno%type,
    v_ename in emp_c10.ename%type, 
    v_job in emp_c10.job%type, 
    v_manager in emp_c10.manager%type,
    v_hiredate in emp_c10.hiredate%type, 
    v_salary in emp_c10.salary%type, 
    v_commission in emp_c10.commission%type, 
    v_dno in emp_c10.dno%type 
)
is
begin
    INSERT INTO emp_c10
    values (v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno);
    dbms_output.put_line('���������� �� �Է��� �Ǿ����ϴ�.');
    commit;
end;
/
exec sp_ex6 (8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);



-- 7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
--	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է°� : 50  PROGRAMMER 
create or replace procedure sp_ex7(
    v_dno in dept_c10.dno%type, 
    v_dname in dept_c10.dname%type
)
is   
begin
    UPDATE dept_c10 
    SET dname = v_dname 
    where dno = v_dno ;   
    commit;
    dbms_output.put_line('������ �Ϸ� �Ǿ����ϴ�.');
end;
/

exec sp_ex7(50,'PROGRAMER');

select * from dept_c10 ;

-- 8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000

select * from emp_c10;

set serveroutput on 
create or replace procedure sp_ex8(
    v_eno in emp_c10.eno%type, v_salary in emp_c10.salary%type
)
is
begin
    UPDATE emp_c10 
    SET salary = v_salary 
    where eno = v_eno ;  
    commit;
    dbms_output.put_line('������ �Ϸ� �Ǿ����ϴ�.');
end;
/
exec sp_ex8(8000,6000);

select * from emp_c10;

-- 9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 

set serveroutput on
create or replace procedure sp_ex9 (
    v_name1 in varchar2, 
    v_name2 in varchar2
    )
is
    cursor1 INTEGER;
    v_sql1 varchar2(100) ;
    v_sql2 varchar2(100) ;
begin   
    v_sql1 := 'drop table ' || v_name1 ;    -- ����ó�� ����
    v_sql2 := 'drop table ' || v_name2 ;    -- ����ó�� ���� 
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql1, dbms_sql.v7);  -- Ŀ���� ����ؼ� sql ������ ����
    DBMS_SQL.PARSE ( cursor1, v_sql2, dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- Ŀ�� ����
end;
/

exec sp_ex9('emp_c10','dept_c10');

select * from dept_c10;
select * from emp_c10;

-- 10. ����̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
create or replace procedure sp_ex10 (
    v_i_ename in employee.ename%type,       -- ��ǲ�޴� �����
    v_o_ename out employee.ename%type,      -- �ƿ�ǲ�Ǵ� �����
    v_salary out employee.salary%type,
    v_dno out employee.dno%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
)
is
begin
    select ename, salary, e.dno, dname, loc into v_o_ename, v_salary, v_dno, v_dname, v_loc
    from employee e , department d
    where e.dno = d.dno
    and ename = v_i_ename;
end;
/

set serveroutput on
declare     -- <OUT �Ķ��Ÿ ���� ���� ����>
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    -- �͸� ��Ͽ����� �������� ���� ȣ��� exec�� ������ �ʴ´�.
    sp_ex10 ('SCOTT', v_ename, v_salary, v_dno, v_dname, v_loc );  -- �������ν��� ȣ��
    dbms_output.put_line('�����   ����   �μ���ȣ   �μ���   �μ���ġ ');
    dbms_output.put_line(v_ename || '   ' || v_salary || '   ' || v_dno || '   ' || v_dname || '   ' || v_loc);
end;
/

-- 11. �����ȣ�� �޾Ƽ� �����, �޿�, ��å, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL/SQL���� ȣ�� 
create or replace procedure sp_ex11 (
    v_eno in employee.eno%type,
    v_ename out employee.ename%type,
    v_salary out employee.salary%type,
    v_job out employee.job%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
    )
is
    cursor c1
    is
    select ename, salary, job, dname, loc 
    from employee e, department d
    where e.dno = d.dno
    and eno = v_eno;    
begin
    open c1;
    loop
        fetch c1 into v_ename, v_salary, v_job, v_dname, v_loc;
        exit when c1%notfound;
        dbms_output.put_line(v_ename || '   ' || v_salary || '   ' || v_job || '   ' || v_dname || '   ' || v_loc );
    end loop;
    close c1;
end;
/

select * from employee; 
declare    
    var_ename employee.ename%type;
    var_sal employee.salary%type;
    var_job employee.job%type;
    var_dname department.dname%type;
    var_loc department.loc%type;
begin 
    sp_ex11 (7788, var_ename, var_sal, var_job, var_dname, var_loc);
    
    dbms_output.put_line('�����   ����   ��å   �μ���   ��ġ');
    dbms_output.put_line('----------------------------------');
    dbms_output.put_line(var_ename || '   ' || var_sal || '   ' || var_job || '   ' || var_dname || '   ' || var_loc);
end;
/
