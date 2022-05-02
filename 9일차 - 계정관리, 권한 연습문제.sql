
-- 9���� - ��������, ���� ��������

-- ���� : usertest02 ������ ���� �Ŀ� users ���̺� �����̽����� ���̺� (tbl2) ������ insert . (18:15 ����)

    -- �� ����ں��� ������ ���� : DBMS�� ������ �� �ִ� ����ڸ� ����.
        ( ���� ( Authentication : Credential (Identity + password) Ȯ��
        ( �㰡 (Authorization : ������ ����ڿ��� Oracle�� �ý��� ���� ��ü,
            -- System Privileges : ����Ŭ�� 
-- ����Ŭ���� ���� ���� ( �Ϲ� ���������� ������ ������ �� �ִ� ������ ����.)
-- ���� ���� ����Ȯ�� (�ְ� ������ sys�������� ��������)
show user;

-- usertest02 ���� ���� ���̵� usertest02 , ��й�ȣ 1234
create user usertest02 identified by 1234;

-- Object privileges : ���̺�, ��, Ʈ����, �Լ�,
    -- �������ν���, ������, �ε����� �ο��Ǵ� �����Ҵ�.
    ============================================
    ����      Table   view    SEQUENCE    PROCEDURE
    Alter       0               0   
    Delete      0      0        
    Execute                                 0
    Index       0                   
    Insert      0      0
    Reference   0
    Select      0      0        0
    Update      0      0

    -- Ư�� ���̺� select ���� �ο� �ϱ�
        create user user_test10 identified by 1234;

-- system Privileges :
    -- Create Session : dhfkzmfdp wjqthrgkf tn dlTsms rnjsgks
    -- Create Table : ����Ŭ���� ���̺��� ������ �� �ִ� ����
    -- Create Sequence : ������ ������ �� �ִ� ����
    -- Create View : �並 ������ �� �ִ� ����

DDL: ��ü ����  (Create, Alter, Drop)
DML: ���ڵ� ���� (Insert, Update, Delete)
DQL: ���ڵ� �˻� (Select)
DTL: Ʈ����� (Begin Transaction, rollback, commit)
DCL: ���� ���� (Grant, Revoke, Deny)

-- ���� ���� �ο�, -- ���̺� ���� ���� �ο�
grant create session, create table to usertest02; 

select * from dba_users;

-- ���� Ȯ�� (�ְ������ ���� sys����)
select username, default_tablespace , temporary_tablespace 
from dba_users
where username in ('HR', 'USERTEST02'); 

-- tablespace ���� (system -> users)
alter user usertest02
default tablespace users    -- DataFile ���� : ��ü�� ����Ǵ� ���� (���̺�, ��, Ʈ����, �ε��� .....)
temporary tablespace temp;  -- Log �� ���� :  DML (Insert, Update, Delete) ,
                            -- Log �� ȣĪ�� ��  Transaction Log. �ý����� ���� �߻��� ��������� �ƴ϶� ������ �������� ����

-- ���̺� �����̽� : ��ü�� Log�� �����ϴ� �������� ����
    -- DATAFILE : ��ü�� �����ϰ� �ִ�. (���̺�, ��, �ε���....)
    -- Log : Transaction Log�� ����
    
    -- DataFile�� Log ������ ���������� �ٸ� �ϵ������ �����ؾ� ������ ���� �� �ִ�.


-- tablespace ������ �Ҵ� (quota �� 100m ���� ����)
alter user usertest02
quota 100m on users;

select * from all_tables   -- ���̺��� �����ָ� ����� �ش�. �������� ������ ���̺��� ����� �� �ֵ�.
where owner in ('HR','USERTEST01','USERTEST02');

/* tbl2�� �� insert (command line����)
create table tbl2 (
    a number(4) not null,
    b number(4)
    );
    
select * from tbl2; 

insert into tbl2
values (1111,2222);

insert into tbl2
values (2222,3333);
*/