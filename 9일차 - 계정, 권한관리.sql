/* ���� ���� */
/*
    ��� ���� : DBMS�� �������� ���
        -- �� ����ں��� ������ ���� : DBMS�� ������ �� �ִ� ����ڸ� ����
            (���� (Authentication : Credential (Identity + Password) �� Ȯ��
            (�㰡 (Authorization : ������ ����ڿ��� Oracle�� �ý��� ���� , ��ü( ���̺�, ��, Ʈ����, �Լ�..) ����
                - System Privileges : ����Ŭ�� �������� ���� �Ҵ�
                - Object Privileges : (���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε��� ...) ���� ���� 
*/

-- Oracle ���� ���� ���� (�Ϲ� ���������� ������ ������ �� �ִ� ������ ����.)
show user;

-- �ְ� ������ ���� (sys) : ������ ������ �� �ִ� ������ ������ �ִ�.
-- ���̵� : usertest01 , ��ȣ :  1234 
create user usertest01 identified by 1234;

-- ������ ��ȣ�� �����ߴٰ� �ؼ� ����Ŭ�� ������ �� �ִ� ������ �ο��޾ƾ� ���� ����

-- system privileges : 
    -- Create Session : ����Ŭ�� ������ �� �ִ� ���� 
    -- Create Table : ����Ŭ���� ���̺��� ������ �� �ִ� ���� 
    -- Create Sequence : ����Ŭ���� �������� ������ �� �ִ� ����
    -- Create View  : ����Ŭ���� �並 ������ �� �ִ� ����



DDL : ��ü ���� (Create, Alter, drop )
DML : ���ڵ� ���� (Insert, Update, delete)
DQL : ���ڵ� �˻� ( Select )
DTL : Ʈ����� ( Begin transaction, rollback, commit)
DCL : ���Ѱ��� ( Grant , Revoke, Deny) 

-- ������ �������� ����Ŭ�� ������ �� �ִ� Create Session ���� �ο�.

-- grant  �ο��ұ���  to  ������ 
grant create session to usertest01;

-- ����Ŭ�� �����ߴٰ� �ؼ� ���̺��� ������ �� �ִ� ������ ����.
-- ���̺� ���� ���� �ο� 
grant create table to usertest01;

/* ���̺� �����̽� (Table Space) : ��ü ( ���̺�, ��, ������, �ε���, Ʈ����, �������ν���, �Լ�...)
    �� �����ϴ� ����. ������ �������� �� ����� �� ���̺� �����̽� Ȯ��.
    SYSTEM : DBA ( ������ ���������� ������ ����)
*/
select * from dba_users;    -- dba_ : sys ( �ְ� ������ �������� Ȯ�� )

select username, default_tablespace as DataFile , temporary_tablespace as LogFIle
from dba_users
where username in ('HR', 'USERTEST01'); 

-- �������� ���̺� �����̽� ���� (SYSTEM ==> USERS)
alter user usertest01
default tablespace users
temporary tablespace temp;

-- �������� Users ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�. ( users ���̺� �����̽��� 2mb�� ��� ���� �Ҵ�)
alter user usertest01
quota 2m on users;

-- < SQL command Line ���� �Է�>
--create table tbl1 (
--    a number(4) not null,
--    b number(4) 
--    );

-- ->  (���̺� �������)

===============================================================================
�Ϸ� �ð� 1�� 20�� 

������: wine_account
��ȣ : 1234

�⺻ ���̺� �����̽� : WINE_DATAFILE     100MB 100MB ���� ������  <= A �ϵ�
�ӽ� ���̺� �����̽� : WINE_LOG          100MB 100MB ���� 1GB    <= B �ϵ� 

���̺� 10�� ������ : �� ���̺� �� ( ���ڵ� : 3���� �߰�) 








