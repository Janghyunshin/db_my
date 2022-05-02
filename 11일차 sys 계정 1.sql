-- sys ���� < �ְ� ������ �������� ����>
-- Authentication (����) : Credential (ID + PASS)
create user user_test10 identified by 1234;

-- Authorization (�㰡) : system ���� �Ҵ�.
grant create session, create table, create view to user_test10;

-- ������ �����ϸ� system ���̺� �����̽��� ����Ѵ�.  <== �����ڸ� ��밡���� ���̺� �����̽�
-- ���̺� �����̽� �ٲٱ�. (USERS)
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- ���̺� �����̽� �뷮 �Ҵ�.
Alter user "USER_TEST10" quota unlimited on "USERS";

-- Ư�� �������� ��ü�� �����ϸ� �� ������ �� ��ü�� �����ϰ� �ȴ�.
select * from dba_tables
where owner in ('HR', 'USER_TEST10');

-- �ٸ� ������� ���̺��� �����ҷ��� ������ ������ �Ѵ�.
grant select on hr.employee to user_test10;

-- grant ��ü�Ǳ��� on ��ü�� to ����ڸ�;

grant select on hr.emp_copy55 to USER_TEST10;

-- ������ �ο��ҋ�
grant insert, update, delete on hr.emp_copy55 to USER_TEST10;

-- ������ �����Ҷ�
revoke insert, update, delete on hr.emp_copy55 from USER_TEST10; 

/* with grant option : Ư�� �������� ������ �ο��ϸ鼭 �ش������ �ٸ� ����ڿ��Ե� �ο��� �� �ִ� ���� */
    -- �ο� ���� ������ �ٸ� ����ڵ鿡�� �ο��� �� �� �ִ� ���� 

grant select on hr.employee to user_test10 with grant option ;
    -- user_test10 ������ hr.employee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ִ�.
    
grant select on hr.dept_copy55 to user_test10 with grant option;
    -- user_test10 ������ hr.dept_copy55 ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ִ�.

/* Public : ��� ����ڿ��� ������ �ο��ϴ� �� */

grant select, insert, update, delete on hr.dept_copy56 to public ;

/* �� (Role) : ���� ����ϴ� �������� ������ ���� ���� ��

    1. dba : �ý����� ��� ������ ����� role, -- sys (�ְ� ������ ����)
    2. connect :
    3. resource : 
*/

-- ����� ���� Role ���� : ���� ����ϴ� ���ѵ��� ��� role�� ����.
1. �� ���� :
    create role roletest1;

2. �ѿ� ���� ����ϴ� ������ ����.
    grant create session, create table, create view, create sequence, create trigger 
    to roletest1;
    
3. ������ ���� �������� ����.
    grant roletest1 to user_test10;

/* ���� ����ڿ��� �ο��� �� Ȯ�� */
select * from user_role_privs;

/* �ѿ� �ο��� ���� ���� Ȯ�� */
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

/* ��ü ������ role�� �ο� �ϱ� */

create role roletest2;

grant select on hr.employee to roletest2; -- �������� ��ü ������ ������ ���� �ƴ϶� �ѿ� ����.

grant roletest2 to user_test10 ; -- ���� �������� ���� 

-- �ǽ� :

-- : hr.dept_copy57�� ���� 

-- �� ���� : roletest3
create role roletest3;

-- roletest3 : hr.dept_copy57 (Select, insert, delete) :  ��ü �� hr.dept_copy57 �� ����
grant select, insert, delete on hr.dept_copy57 to roletest3;

-- user_test10�� ����
grant roletest3 to user_test10;