-- 1
create table sale (
    sale_date date Not Null constraint PK_SALE_SALE_DATE Primary Key ,
    wine_code varchar2(6) Not Null,
    mem_id varchar(30) Not Null,
    sale_amount varchar2(5) Not null,
    sale_price varchar2(6) Not null,
    sale_tot_price varchar2(15) Not null,
        constraint FK_SALE_WINE_CODE_WINE Foreign Key (wine_code) references wine (wine_code),
        constraint FK_SALE_MEM_ID Foreign Key (mem_id) references member (mem_id)
    );
    
    -- 디폴트 값 설정
    alter table sale
    modify sale_amount default 0;
    alter table sale
    modify sale_price default 0;
    alter table sale
    modify sale_tot_price default 0;    
    
    -- 레코드 추가
    desc sale;
    
    insert into sale
    values (to_Date('2022/01/01', 'YYYY/MM/DD'), '100111', 'JANG', '1', default, default );
    insert into sale
    values (to_Date('2022/04/04', 'YYYY/MM/DD'), '100222', 'SHIN', '2', '4000', '50' );
    insert into sale
    values (sysdate, '100333', 'HYUN', '3', '5000', '100' );
    
    select * from sale;
    commit;

-- 2   0
create table member (
    mem_id varchar2(6) Not null constraint PK_MEMBER_MEM_ID Primary Key,
    mem_grade varchar2(20),
    mem_pw varchar2(20) Not null,
    mem_birth date Not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) Not null,
    constraints FK_MEMBER_MEM_GRADE Foreign Key (mem_grade) references grade_pt_rade (mem_grade)
    );
    
    -- 디폴트 값 설정     
    alter table member
    modify mem_birth default sysdate;
    alter table member
    modify mem_pt default 0;
    
    -- 레코드 추가
    insert into member
    values ('JANG','VIP','1234',to_Date('1994/04/06', 'YYYY/MM/DD'),'010-0000-0000',100);
    insert into member
    values ('SHIN','GOLD','1234',sysdate, null, default);
    insert into member
    values ('HYUN','SILVER','1234',default, null ,500);
    
    select * from member;
    commit;
    
-- 3 ㅇ
create table grade_pt_rade (
    mem_grade varchar2(20) Not Null constraint PK_GRADE_PT_RADE_MEM_GRADE Primary Key,
    grade_pt_rate number(3,2) null
    );
    
    -- 레코드 추가
    insert into grade_pt_rade
    values ('VIP', 0.5);
    insert into grade_pt_rade
    values ('GOLD', 0.35);
    insert into grade_pt_rade
    values ('SILVER', 0.2);
    
    select * from grade_pt_rade;
    commit;
-- 4 ㅇ
create table today (
    today_code varchar2(6) Not Null constraint PK_TODAY_TODAY_CODE Primary Key,
    today_sens_value number(3) null,
    today_intell_value number(3) null,
    today_phy_value number(3) null
    );

    -- 레코드 추가
    insert into today
    values ('11111', 80, 100, 70);
    insert into today
    values ('22222', 90, 90, 70);
    insert into today
    values ('33333', 100, 80, 70);
    
    select * from today;
    commit;
-- 5 0
create table nation (
    nation_code varchar2(26) Not Null constraint PK_NATION_NATION_CODE Primary Key,
    nation_name varchar2(50) Not Null
    );
    
    insert into nation
    values ('1', 'Korea');
    insert into nation
    values ('2', 'CHINA');
    insert into nation
    values ('3', 'JAPAN');
    
    select * from nation;
    commit;
    
-- 6    0
create table wine (
    wine_code varchar2(26) Not Null constraint PK_WINE_WINE_CODE Primary Key,
    wine_name varchar2(100) Not Null,
    wine_url blob null,
    nation_code varchar2(6) null,
    wine_type_code varchar2(6) null,
    wine_sugar_code number(2) null,
    wine_price number(15) Not Null,
    wine_vintage date null,
    theme_code varchar2(6) null, 
    today_code varchar2(6) null,
        constraint FK_WINE_NATION_CODE_NATION Foreign Key (nation_code) references nation (nation_code),
        constraint FK_WINE_WINE_TYPE_CODE Foreign Key (wine_type_code) references wine_type (wine_type_code),
        constraint FK_WINE_THEME_CODE_THEME Foreign Key (theme_code) references theme (theme_code),
        constraint FK_WINE_TODAY_CODE_TODAY Foreign Key (today_code) references today (today_code)
    );
    
    -- 디폴트 값 설정     
    alter table wine
    modify wine_price default 0;
    
    -- 레코드 추가
    insert into wine
    values ('100111', '1번 와인', NULL, '1', 'a', 10, default, sysdate, '1111','11111');
    insert into wine
    values ('100222', '2번 와인', NULL, '2', 'b', 20, 10000, sysdate, '2222','22222');
    insert into wine
    values ('100333', '3번 와인', NULL, '3', 'c', 30, 20000, sysdate, '3333','33333');
    select * from wine;
    commit;

-- 7  0
create table theme (
    theme_code varchar2(6) Not null constraint PK_THEME_THEME_CODE Primary Key,
    theme_name varchar2(50) Not null
    );
    
        -- 레코드 추가
    insert into theme
    values ('1111','RED');
    insert into theme
    values ('2222','WHITE');    
    insert into theme
    values ('3333','BLACK');
    
    select * from theme;
    commit;
-- 8 0
create table stock_management (
    stock_code varchar2(6) Not null constraint PK_STOCK_MANAGEMENT_STOCK_CODE Primary Key,
    wine_code varchar2(6) null,
    manager_id varchar2(30) null,
    ware_date date Not null,
    stock_amount number(5) Not null,
        constraint FK_STOCK_MG_WINE_CODE Foreign Key (wine_code) references wine (wine_code),
        constraint FK_STOCK_MG_MG_ID Foreign Key (manager_id) references manager (manager_id)
    );
    
    -- 디폴트 값 설정     
    alter table stock_management
    modify ware_date default sysdate;
    alter table stock_management
    modify stock_amount default 0;
    
    -- 레코드 추가 
    insert into stock_management
    values ('100', '100111', 'AAAA', default, 100);
    insert into stock_management
    values ('200', '100222', 'BBBB', sysdate, default);
    insert into stock_management
    values ('300', '100333', 'CCCC', default, 50);
    
    select * from stock_management;
    commit;
    
-- 9 0
create table manager (
    manager_id varchar2(30) Not null constraint PK_MANAGER_MANAGER_ID Primary key,
    manager_pwd varchar2(20) Not null,
    manager_tel varchar2(20) null
    );
    
    -- 레코드 추가
    insert into manager
    values ('AAAA',1234,NULL);
    insert into manager
    values ('BBBB',1234,NULL);
    insert into manager
    values ('CCCC',1234,'010-0000-0000');
    
    select * from manager;
    commit;
    
-- 10 0
create table wine_type (
    wine_type_code varchar2(6) Not null constraint PK_WINE_TYPE_WINE_TYPE_CODE Primary Key,
    wine_type_name varchar2(50) null
    );

-- 레코드 추가
    insert into wine_type
    values ('a', 'A 타입');
    insert into wine_type
    values ('b', 'B 타입');
    insert into wine_type
    values ('c', 'C 타입');
    
    select * from wine_type;
    commit;

select * from user_constraints
where table_name in ('SALE','MEMBER','GRADE_PT_RADE','TODAY','NATION','WINE','THEME','STOCK_MANAGEMENT','MANAGER','WINE_TYPE');