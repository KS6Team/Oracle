drop table PROFIT;
drop table CAR;
drop table BOOK;
drop table ROOM;
drop table ROOMTYPE;
drop table CUSTOM;
drop table PAYMENT;
drop table HOTEL;
purge recyclebin;

create table HOTEL(
HCODE varchar2(5)constraint HOTEL_HCODE_PK primary key,
  HNAME varchar2(99) constraint HOTEL_HNAME_NN not null,
  HOWNER varchar2(10) constraint HOTEL_HOWNER_NN not null,
  HADDR varchar2(99) constraint HOTEL_HADDR_NN not null,
  HPN varchar2(99) constraint HOTEL_HPN_NN not null,
  HADDR_CODE varchar2(99) constraint HOTEL_HADDR_CODE_NN not null,
  OPEND date constraint HOTEL_OPEND_NN not null
);

create table CUSTOM(
  CNUM NUMBER(5)constraint CUSTOM_CNUM_PK primary key,
  CNAME varchar(20)constraint CUSTOM_CNAME_NN not null,
  CPN varchar(11)constraint CUSTOM_CPN_NN not null,
  CRRN varchar(13)constraint CUSTOM_CRRN_NN not null,
  HCODE varchar(5),
  constraint CUSTROM_HCODE_FK foreign key (HCODE)references HOTEL(HCODE)on delete cascade
);

create table ROOMTYPE(
  VCODE varchar2(3) constraint ROOMTYPE_VCODE_PK primary key,
  VNAME varchar2(10) constraint ROOMTYPE_VNAME_NN not null
);

create table ROOM(
  RNUM number(4) constraint ROOM_RUNUM_PK primary key,
  RGRD varchar2(1)constraint ROOM_RGRD_CHK check (RGRD in(0,1,2,3,4)),
  RBED number (1) constraint ROOM_RBED_CHK check (RBED in(0,1,2,3)),
  VCODE varchar2(3) constraint ROOM_VCODE_FK references ROOMTYPE(VCODE) on delete cascade
);

create table BOOK(
  BNUM varchar2(15)constraint BOOK_BNUM_PK primary key,
  CNUM NUMBER(5) constraint BOOK_CNUM_FK references CUSTOM(CNUM)on delete cascade,
  CHECKIN date constraint BOOK_CHECKIN_NN not null,
  CHECKOUT date constraint BOOK_CHECKOUT_NN not null,
  BREAKFAST NUMBER(1) constraint BOOK_BREAKFAST_CHK check (BREAKFAST in('0','1')),
  VALLET NUMBER(1) constraint BOOK_VALLET_CHK check (VALLET in('0','1')),
  PEOPLE NUMBER(1) constraint BOOK_PEOPLE_CHK check (PEOPLE BETWEEN 1 and 4),--체크해볼것
  BDATE date ,
  constraint BOOK_CNUM_UNQ UNIQUE (CNUM),
  RNUM number(4) constraint BOOK_RNUM_FK references ROOM(RNUM)on delete cascade
);

create table CAR(
  CARNUM varchar2(8) constraint CAR_CARNUM_PK primary key,
  BNUM varchar2(15) constraint CAR_BNUM_FK references BOOK(BNUM)on delete cascade,
  CNUM NUMBER(5) constraint CAR_CNUM_FK references BOOK(CNUM)on delete cascade
);

create table PAYMENT(
  BNUM varchar2(15)constraint PAYMENT_BNUM_PK primary key,
  PTYPE number(1) constraint PAYMENT_PTYPE_CHK check (PTYPE in(0,1,2)),
  PAMOUNT number(8)constraint PAYMENT_PAMOUNT_NN not null,
  CNUM NUMBER(5) constraint PAYMENT_CNUM_FK references BOOK(CNUM)on delete cascade,
  constraint PAYMENT_BNUM_FK foreign key(BNUM) references BOOK(BNUM)on delete cascade
);

create table PROFIT(
  BCOUNT number,
  BTOTAL number
);
 insert into HOTEL values('KSM08','수스호텔','홍길동','서울금천가산','01000000000','123-456',sysdate);
 insert into CUSTOM values('12345','구스','11111111','22133','KSM08');
 insert into ROOMTYPE values(123,123);
 insert into ROOM values(401,1,1,123);
 insert into BOOK values('1','12345',sysdate,sysdate,1,1,1,sysdate,401);
 insert into CAR values(123,1,12345);
 insert into PAYMENT values(1,1,10000,12345);
 
select * from HOTEL;
select * from CUSTOM;
select * from BOOK;
select * from PAYMENT;
select * from ROOM;
select * from ROOMTYPE;
select * from CAR;
select * from PROFIT;
--자료,트리거,시퀀스,요구사항,테이블 제약조건, 추가
select CONSTRAINT_NAME, CONSTRAINT_TYPE from user_constraints order by CONSTRAINT_NAME;
