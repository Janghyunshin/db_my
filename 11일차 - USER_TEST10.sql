
create table test10Tbl (
    a number not null,
    b varchar(50) null
    );
    
-- user_test10���� HR�� �������� employee ���̺��� ���� �Ҷ� -- ��ü�� ���ٱ����� �ʿ��ϴ�.

select * from hr.employee; 

-- �⺻������ �ڽ��� ��ü�� ����Ҷ� ���� ����.
show user;

select * from user_test10.test10Tbl;

-- �ٸ� ������� ��ü�� ���� �Ҷ� �����ָ�.��ü��
select * from employee;     -- �����ָ� (user_test10);
select * from hr.employee;  -- �ٸ� ������� ��ü�� �����Ҷ� ������ �־�� �Ѵ�.

-- �ٸ� ����� ���̺��� insert ����,
desc hr.employee;

select * from hr.emp_copy55;

desc hr.emp_copy55;

-- insert 
insert into hr.emp_copy55
values (3333);

-- with grant option�� �ο� �޾Ҵ�. (Select , hr.employee)
    -- user_test11 ���� hr.employee ���̺� ���� ���� �ο�
grant select on hr.employee to user_test11;
    -- user_test11 ���� hr.dept_copy55 ���̺� ���� ���� �ο�
grant select on hr.dept_copy55 to user_test11;

select * from hr.dept_copy56;

select * from user_role_privs;

select * from hr.dept_copy57;

