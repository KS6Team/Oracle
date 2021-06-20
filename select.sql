--402호실 예약건수 확인
select * from BOOK where RNUM =402 ;
--192번 고객의 결제 내역
select * from payment  where CNUM = 192;
--오션뷰(OCV)인 객실 확인
select * from ROOM where VCODE = 'OCV' ;
--6월 21일 체크인 예약
select * from BOOK where CHECKIN = '21-06-21';
--김씨인 고객
select * from CUSTOM where CNAME like '김%';
--고객번호가 1인 고객의 예약
select * from BOOK where CNUM =1;
--씨티뷰로 예약한 예약 확인(높은 금액 순)
select * from BOOK natural join ROOM where VCODE = 'CTV' order by RPRICE desc;
--총 예약 횟수,총 매출액
select * from PROFIT;
--차량(예약번호 순)
select * from CAR order by BNUM;
--예약시 날짜가 21년 12월 10일 인 예약
select * from BOOK where BDATE = '21-12-10';
--숙박기간이 1박 2일 인 예약
select * from BOOK where CHECKOUT - CHECKIN =1;