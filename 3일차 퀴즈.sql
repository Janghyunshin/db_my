-- �Ϸ�ð� : 4:50�� ����
-- dno �÷��� 10�� �μ��� ��� ���޿��� + 300�� ó���ϰ�, 20�� �μ��� ��� + ���� +500��
    -- �μ���ȣ�� 30�� ��� ���޿� + 700�� �ؼ� �̸�, ���� , �μ��� ���� �÷����� ����� ���

select ename �̸� , dno �μ���ȣ ,  salary ����, decode (dno, 10, salary + 300,
                                                           20, salary + 500,
                                                           30, salary + 700) as ��������
from employee
order by dno asc;

select * from employee;

-- case : if ~ else if , else if ~~~
    /*
        case ǥ���� WHEN ���� 1 THEN ��� 1
                   WHEN ���� 2 THEN ��� 2
                   WHEN ���� 3 THEN ��� 3
                   ELSE ���n
        END          
    */

select ename, dno, case when dno=10 then 'ACCOUNTING'
                        when dno=20 then 'RESEARCH'
                        when dno=30 then 'SALES'
                        ELSE 'DEFAULT'
                   END as �μ���
from employee
order by dno;
