Create Table freeboard (
    id number constraint PK_freeboard_id Primary Key ,  -- �ڵ� ���� �÷�
    name varchar2(100) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,     -- �� ���� 
    content varchar2(2000) not null,    -- �� ���� 
    inputdate varchar2(100) not null,   -- �� �� ��¥
    masterid number default 0,          -- ���� �亯�� �Խ��ǿ��� �亯�� ���� �׷���
    readcount number default 0,         -- �� ��ȸ��
    replaynum number default 0,         
    step number default 0               
    );
    
    select * from freeboard;
    
    delete freeboard
    where id =4 ;
    
    INSERT INTO freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replaynum, step) 
    values (1,'ȫ�浿','1234','ccc@ccc.com', 'ù��° ���Դϴ�.','ù ��° �����Դϴ�. �� �����Դϴ�. �� ���� 2 �Դϴ�.','22-52-11 11:52 ����',1,0,0,0);
    
    commit;
    
    select * from freeboard where id = 3;
    desc freeboard;
    
    -- �亯���� �����ϴ� ���̺��� ����� ��, ������ ���ؼ� �����;� �Ѵ�.
    select * from freeboard
    order by masterid desc, replaynum asc, step asc, id asc;
        -- masterid �÷��� �ߺ��� ���� ���� ���, replaynum �÷��� asc
        -- replaynum�� �ߺ��� ���� ���� �Ҷ� step�� asc
        -- step�� �ߺ��� ���� �����Ҷ� id�� asc 
    
    select * from freeboard
    order by id desc;
    
    -- id �÷� : ���ο� ���� ��ϵɶ� ������ id �÷��� �ִ밪�� �����ͼ� +1  <= 
        -- �� �� ��ȣ�� �ѹ��� 
-- �亯 ���� ó���ϴ� �÷��� 3�� �ʿ��ϴ� (masterid, replayNum, step  

    -- masterid     :   ���� �亯�� ���� �׷���, id �÷��� ���� �״�� �� ���, �亯���� �ƴϴ�. ó����
    -- replayNum    :   �亯 �ۿ� ���� �ѹ���.  (1,2,3...)
    -- step         :   �亯 ���� ���� 
        -- 0 : ó�� �� (�ڽ��� ��, �亯 X)
        -- 1 : �亯 �� 
        -- 2 : �亯�� �亯 
        -- 3 : �亯�� �亯�� �亯
            ...