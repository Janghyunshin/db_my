
-- 9���� - ��������, ���� ��������

-- ���� : usertest02 ������ ���� �Ŀ� users ���̺� �����̽����� ���̺� (tbl2) ������ insert . (18:15 ����)

-- ���� ���� ����Ȯ�� (�ְ� ������ sys�������� ��������)
show user;

-- usertest02 ���� ���� ���̵� usertest02 , ��й�ȣ 1234
create user usertest02 identified by 1234;

-- ���� ���� �ο�, -- ���̺� ���� ���� �ο�
grant create session, create table to usertest02; 

select * from dba_users;

-- ���� Ȯ�� (�ְ������ ���� sys����)
select username, default_tablespace , temporary_tablespace 
from dba_users
where username in ('HR', 'USERTEST02'); 

-- tablespace ���� (system -> users)
alter user usertest02
default tablespace users
temporary tablespace temp;

-- tablespace ������ �Ҵ� (quota �� 100m ���� ����)
alter user usertest02
quota 100m on users;

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