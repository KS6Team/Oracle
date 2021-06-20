drop table PROFIT;
drop table CAR;
drop table PAYMENT;
drop table BOOK;
drop table ROOM;
drop table ROOMTYPE;
drop table CUSTOM;
drop table HOTEL;
drop sequence B_SEQ;
purge recyclebin;

create table HOTEL(
  HNAME varchar2(30) constraint HOTEL_HNAME_PK primary key,
  HOWNER varchar2(30) constraint HOTEL_HOWNER_NN not null,
  HADDR varchar2(99) constraint HOTEL_HADDR_NN not null,
  HPN varchar2(13) constraint HOTEL_HPN_NN not null,
  HADDR_CODE varchar2(99) constraint HOTEL_HADDR_CODE_NN not null,
  OPEND date constraint HOTEL_OPEND_NN not null
);

create table CUSTOM(
  CNUM NUMBER(5)constraint CUSTOM_CNUM_PK primary key,
  CNAME varchar2(30) constraint CUSTOM_CNAME_NN not null,
  CPN varchar2(13)  constraint CUSTOM_CPN_NN not null,
  CRRN varchar2(14) constraint CUSTOM_CRRN_NN not null,
  HNAME varchar2(30),
  constraint CUSTROM_HNAME_FK foreign key (HNAME)references HOTEL(HNAME)on delete cascade
);

create table ROOMTYPE(
  VCODE varchar2(3) constraint ROOMTYPE_VCODE_PK primary key,
  VNAME varchar2(10) constraint ROOMTYPE_VNAME_NN not null
);


create table ROOM(
  RNUM number(4) constraint ROOM_RUNUM_PK primary key,
  RGRD varchar2(1)constraint ROOM_RGRD_CHK check (RGRD in(0,1,2,3,4,5,6,7)),
  VCODE varchar2(3) constraint ROOM_VCODE_FK references ROOMTYPE(VCODE) on delete cascade,
  RPRICE number constraint ROOM_RPRICE_NN not null
);

create table BOOK(
  BNUM NUMBER,
  CNUM NUMBER(5) constraint BOOK_CNUM_FK references CUSTOM(CNUM)on delete cascade,
  CHECKIN date constraint BOOK_CHECKIN_NN not null,
  CHECKOUT date constraint BOOK_CHECKOUT_NN not null,
  BREAKFAST NUMBER(1) constraint BOOK_BREAKFAST_CHK check (BREAKFAST in('0','1')),
  PEOPLE NUMBER(1) constraint BOOK_PEOPLE_CHK check (PEOPLE BETWEEN 1 and 4),--체크해볼것
  BDATE date constraint BOOK_BADTE_NN not null,
  RNUM number(4) constraint BOOK_RNUM_FK references ROOM(RNUM)on delete cascade,
  constraint BOOK_PK primary key(BNUM)
  --constraint BOOK_ROOM_UNQ UNIQUE (CHECKIN,CHECKOU,)
  );

create table CAR(
  BNUM NUMBER primary key,
  CNUM NUMBER(5),
  CARNUM varchar2(8),
  constraint CAR_FK foreign key(BNUM) references BOOK(BNUM)on delete cascade
);

create table PAYMENT(
  BNUM NUMBER constraint PAYMENT_BNUM_PK primary key,
  PTYPE number(1) constraint PAYMENT_PTYPE_CHK check (PTYPE in(0,1,2)),
  PAMOUNT number(8)constraint PAYMENT_PAMOUNT_NN not null,
  CNUM NUMBER(5),
  constraint PAYMENT_FK foreign key (BNUM) references BOOK(BNUM)
);

create table PROFIT(
  BCOUNT number,
  BTOTAL number
);

select CONSTRAINT_NAME, CONSTRAINT_TYPE from user_constraints order by CONSTRAINT_NAME;

create sequence B_SEQ start with 1 increment by 1 maxvalue 9999;

create or replace trigger B_COUNT_TRG
after insert on BOOK
for each row
begin
update PROFIT set BCOUNT=B_SEQ.currval;
end;
/

create or replace trigger B_TCOUNT_TRG
after insert on PAYMENT
for each row 
begin
update PROFIT set BTOTAL=BTOTAL+:NEW.PAMOUNT;
end;
/


 --예약을할떄
create or replace procedure B_PRO (
P_CNUM CUSTOM.CNUM%TYPE,P_CHKIN BOOK.CHECKIN%TYPE,P_LOS number,P_BRF BOOK.BREAKFAST%TYPE,
P_HEAD BOOK.PEOPLE%TYPE,P_RNUM ROOM.RNUM%TYPE,P_CARNUM CAR.CARNUM%TYPE,P_PTYPE PAYMENT.PTYPE%TYPE)

is
PAY PAYMENT.PAMOUNT%TYPE;
R_PRICE ROOM.RPRICE%TYPE;

begin
select RPRICE*P_LOS into PAY from ROOM where RNUM=P_RNUM;
insert all 
into BOOK values(B_SEQ.nextval,P_CNUM,P_CHKIN,P_CHKIN+P_LOS,P_BRF,P_HEAD,P_CHKIN-14,P_RNUM)
into CAR values(B_SEQ.currval,P_CNUM,P_CARNUM)
into PAYMENT values(B_SEQ.currval,P_PTYPE,PAY,P_CNUM) select  * from DUAL;

end;
/
        

       -- insert all  /into into into/ select * from DUAL;
 insert into PROFIT values(0,0);

 insert into HOTEL values('S_SPY','홍길동','서울금천가산','010-0000-0000','123-456',sysdate);
 insert into CUSTOM values('12345','구스','11111111','22133','S_SPY');
 insert into ROOMTYPE values('OCV','오션뷰');
 insert into ROOMTYPE values('CTV','씨티뷰');
 
 --call B_pro(고객번호,체크인,숙박기간(며칠),조식(0,1),인원수(1~4),객실,차량번호(or null),결제수단(0,1,2));
 
select * from HOTEL;
select * from CUSTOM;
select * from BOOK;
select * from PAYMENT;
select * from ROOM;
select * from ROOMTYPE;
select * from CAR;
select * from PROFIT;
--자료(고객,차량,뷰타입,객실정보),요구사항,테이블 제약조건(필요시),사진 바꾸기
