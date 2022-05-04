-- 14일차 트리거

/* 트리거 (Trigger) : 권총의 방아쇠 (트리거), 방아쇠를 당기면 총알이 발사됨.
        - 테이블에 부착되어 있다.
        - 테이블에 이벤트가 발생될때 자동으로 작동되는 프로그램 코드
        - 테이블에 발생되는 이벤트 (Insert, update, delete) 
        - 트리거에서 정의된 begin ~ end 사이의 문장이 실행됨.
        - before 트리거 : 테이블에서 트리거를 먼저 실행후 Insert, Update, Delete가 적용
        - after  트리거 : Insert, Update, Delete가 실행후 트리거를 실행
        -- 예) 주문 테이블에 값을 넣었을때 배송 테이블에 자동으로 저장 
        -- 예) 중요 테이블의 로그를 남길떄도 사용됨.
        -- :new : 가상 임시테이블, 트리거가 부착된 테이블에 새롭게 들어오는 레코드의 임시 테이블 
        -- :old : 가상 임시테이블, 트리거가 부착된 테이블에 삭제되는 레코드의 임시테이블 
        -- 트리거는 하나의 테이블에 총 3개까지 부착됨, (insert, update, delete)
*/

-- 실습 테이블 2개 생성 : 테이블의 구조만 복사 (Dept_original, dept_copy)
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

-- 트리거 생성 (dept_original 테이블에 부착, Insert 이벤트가 발생될때 자동으로 작동)

create or replace trigger tri_sample1
    -- 트리거가 부착될 테이블 , 이벤트(Insert, Update, Delete) , Before, After
    after insert        -- insert 이벤트가 작동 후 트리거가 작동 ( begin ~ end 사이의 코드)    
    on dept_original    -- on 부착될 테이블
    for each row        -- 모든 row에 대해서
    
begin   -- 트리거가 실행할 코드
    if inserting then
        DBMS_OUTPUT.PUT_LINE('Insert Trigger 발생 !!!!');
        insert into dept_copy
        values ( :new.dno, :new.dname, :new.loc );  -- new 가상 임시 테이블
    end if;
end;
/

/* 트리거 확인 데이터 사전 : user_source */
select * from user_source
where name = 'TRI_SAMPLE1';

select * from dept_original;
select * from dept_copy;

insert into dept_original
values (15, 'PROGRAM5' ,'PUSAN5');
commit;
/* delete 트리거 : dept_original 에서 제거 ===> dept_copy 에서 해당 내용을 제거 */

create or replace trigger tri_del
        -- 트리거가 작동시킬 테이블, 이벤트
        after delete        -- 원본 테이블의 delete를 먼저 실행후 트리거 작동
        on dept_original    -- dept_original 테이블에 트리거 부착
        for each row
        
begin   -- 트리거가 작동할 코드
    dbms_output.put_line('Delete Trigger 발생됨!!!!');
    delete dept_copy
    where dept_copy.dno = :old.dno ;          -- dept_original에서 삭제되는 가상 임시 테이블 : old 
end;
/

select * from dept_original;
select * from dept_copy;

delete dept_original
where dno = 15;

/* update 트리거 : dept_original 테이블의 특정 값을 수정하면 dept_copy 테이블의 내용을 업데이트 함 */

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin 
    dbms_output.put_line('update trigger 발생 !!!');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 13;
end;
/

select * from dept_original;    -- 주문 테이블 가정
select * from dept_copy;        -- 배송 테이블 가정

update dept_original
set dname = 'PROGRAM3'
where dno = 13;