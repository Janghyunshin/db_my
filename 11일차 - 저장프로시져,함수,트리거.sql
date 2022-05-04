
/*
    �������ν����� ����
        1. PL/SQL�� ��밡���ϴ�. �ڵ�ȭ
        2. ������ ������.
            �Ϲ����� SQL ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            �������ν��� ó������ : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            �������ν��� �ι�°������� : ������(�޸𸮿��ε�) -> ����
        3. �Է� �Ű�����, ��� �Ű����� ��밡��
        4. �Ϸ��� �۾��� ��� ���� ( ���ȭ�� ���α׷����� �����ϴ�)

*/

--1. �������ν��� ����
--���� ����� ������ ��� �ϴ� ���� ���ν���
SET SERVEROUTPUT ON;
CREATE PROCEDURE sp_salary
is
    v_salary employee.ename%type;   --�������ν��� is ������� ������ ����
BEGIN
    SELECT salary INTO v_salary
    FROM employee
    WHERE ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('SCOTT�� �޿��� : '|| v_salary ||' �Դϴ�');
END;
/



/*�������ν��� ������ Ȯ���ϴ� ������ ���� */
SELECT * FROM user_source
WHERE name ='SP_SALARY';

--3.���� ���ν��� ����

EXECUTE sp_salary; --��ü�̸� -- �ּ��̶� ���� �����ϸ� �ȵǳ�
EXEC sp_salary; -- ��� �̸�

--4.���� ���ν��� ����

CREATE or replace PROCEDURE sp_salary
is
    v_salary employee.salary%type;   --�������ν��� is ������� ������ ����
    v_commission employee.commission%type;
BEGIN
    SELECT salary,commission INTO v_salary, v_commission
    FROM employee
    WHERE ename = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('SCOTT�� �޿��� : '|| v_salary ||
                            '���ʽ���: '||v_commission|| ' �Դϴ�');
END;
/

--4. ���� ���ν��� ����

drop PROCEDURE sp_salary;

--------------<<��ǲ �Ű������� ó���ϴ� ���� ���ν���>>------------------------------------------------------------
CREATE or REPLACE PROCEDURE sp_salary_ename(    --��ȣ �ȿ� �Է¸Ű�����(in), ��� �Ű�����(out)�� ����
    v_ename in employee.ename%type          --������ in �ڷ���<== ����: ;�� ������� �ʴ´� �������� ���,�� ó��
)
is                                           --��������(���� ���ν������� ����� ���� ������)
    v_salary employee.salary%type;
BEGIN
    SELECT salary INTO v_salary --����
    FROM employee
    WHERE ename = v_ename;      --��ǲ �Ű�����
    
    DBMS_OUTPUT.PUT_LINE(v_ename||' �� �޿��� ' || v_salary || '�Դϴ�');
end;
/

EXEC sp_salary_ename('SCOTT');
EXEC sp_salary_ename('SMITH');
EXEC sp_salary_ename('KING');

/*�μ���ȣ�� ��ǲ �޾Ƽ� �̸�, ��å, �μ���ȣ�� ����ϴ� ���� ���ν����� �����ϱ�*/
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
    DBMS_OUTPUT.PUT_LINE('����̸�   ��å   �μ���ȣ');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
        FOR v_emp IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE(v_emp.ename||'   '||v_emp.job||'   '||v_emp.dno);
    END LOOP;
END;
/

EXEC sp_dno(10);


/*���̺��̸��� ��ǲ �޾Ƽ� employee ���̺��� �����ϴ� �������ν����� �����ϼ���.
    ��ǲ ��: emp_copy33 ????????????????????????????????
*/

CREATE OR REPLACE PROCEDURE PRO_CRE(v_name varchar2)
IS
cursor1 INTEGER;
credbsql VARCHAR2(100);

BEGIN
credbsql := 'CREATE TABLE ' || emp_c10 || ' as select * from employee';

-- ���̺� ����
        cursor1 := DBMS_SQL.OPEN_CURSOR;  
        DBMS_SQL.PARSE(cursor1, credbsql, dbms_sql.v7);
        DBMS_SQL.CLOSE_CURSOR(cursor1);
                
END;
/

GRANT CREATE TABLE TO PUBLIC;
EXEC sp_createTable ('emp_copy33');
SELECT * FROM emp_copy33;
    












