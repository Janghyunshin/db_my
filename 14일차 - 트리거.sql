-- 14���� Ʈ����

/* Ʈ���� (Trigger) : ������ ��Ƽ� (Ʈ����), ��Ƽ踦 ���� �Ѿ��� �߻��.
        - ���̺� �����Ǿ� �ִ�.
        - ���̺� �̺�Ʈ�� �߻��ɶ� �ڵ����� �۵��Ǵ� ���α׷� �ڵ�
        - ���̺� �߻��Ǵ� �̺�Ʈ (Insert, update, delete) 
        - Ʈ���ſ��� ���ǵ� begin ~ end ������ ������ �����.
        - before Ʈ���� : ���̺��� Ʈ���Ÿ� ���� ������ Insert, Update, Delete�� ����
        - after  Ʈ���� : Insert, Update, Delete�� ������ Ʈ���Ÿ� ����
        -- ��) �ֹ� ���̺� ���� �־����� ��� ���̺� �ڵ����� ���� 
        -- ��) �߿� ���̺��� �α׸� ���拚�� ����.
        -- :new : ���� �ӽ����̺�, Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ� ���̺� 
        -- :old : ���� �ӽ����̺�, Ʈ���Ű� ������ ���̺� �����Ǵ� ���ڵ��� �ӽ����̺� 
        -- Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������, (insert, update, delete)
*/

-- �ǽ� ���̺� 2�� ���� : ���̺��� ������ ���� (Dept_original, dept_copy)
create table dept_original
as
select *
from department
where 0=1;

create table dept_copy
as
select * from department
where 0=1;

select * from dept_original;
select * from dept_copy;

-- Ʈ���� ���� (dept_original ���̺� ����, Insert �̺�Ʈ�� �߻��ɶ� �ڵ����� �۵�)

create or replace trigger tri_sample1
    -- Ʈ���Ű� ������ ���̺� , �̺�Ʈ(Insert, Update, Delete) , Before, After
    after insert        -- insert �̺�Ʈ�� �۵� �� Ʈ���Ű� �۵� ( begin ~ end ������ �ڵ�)    
    on dept_original    -- on ������ ���̺�
    for each row        -- ��� row�� ���ؼ�
    
begin   -- Ʈ���Ű� ������ �ڵ�
    if inserting then
        DBMS_OUTPUT.PUT_LINE('Insert Trigger �߻� !!!!');
        insert into dept_copy
        values ( :new.dno, :new.dname, :new.loc );  -- new ���� �ӽ� ���̺�
    end if;
end;
/

/* Ʈ���� Ȯ�� ������ ���� : user_source */
select * from user_source
where name = 'TRI_SAMPLE1';

select * from dept_original;
select * from dept_copy;

insert into dept_original
values (15, 'PROGRAM5' ,'PUSAN5');
commit;
/* delete Ʈ���� : dept_original ���� ���� ===> dept_copy ���� �ش� ������ ���� */

create or replace trigger tri_del
        -- Ʈ���Ű� �۵���ų ���̺�, �̺�Ʈ
        after delete        -- ���� ���̺��� delete�� ���� ������ Ʈ���� �۵�
        on dept_original    -- dept_original ���̺� Ʈ���� ����
        for each row
        
begin   -- Ʈ���Ű� �۵��� �ڵ�
    dbms_output.put_line('Delete Trigger �߻���!!!!');
    delete dept_copy
    where dept_copy.dno = :old.dno ;          -- dept_original���� �����Ǵ� ���� �ӽ� ���̺� : old 
end;
/

select * from dept_original;
select * from dept_copy;

delete dept_original
where dno = 15;

/* update Ʈ���� : dept_original ���̺��� Ư�� ���� �����ϸ� dept_copy ���̺��� ������ ������Ʈ �� */

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin 
    dbms_output.put_line('update trigger �߻� !!!');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 13;
end;
/

select * from dept_original;    -- �ֹ� ���̺� ����
select * from dept_copy;        -- ��� ���̺� ����

update dept_original
set dname = 'PROGRAM3'
where dno = 13;