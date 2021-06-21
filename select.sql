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
select * from CAR order by BNUM desc;
--예약시 날짜가 21년 12월 10일 인 예약
select * from BOOK where BDATE='21/12/10';
--숙박기간이 1박 2일 인 예약
select * from BOOK where CHECKOUT-CHECKIN=1;
--12층의 객실별 예약건수
select VCODE, count(BNUM) from BOOK natural join ROOM where RNUM between 1200 and 1300 group by VCODE;
--checkout 기준 6월 일별 매출(날짜순 정렬)
select CHECKOUT, sum(PAMOUNT) from BOOK natural join PAYMENT 
      group by CHECKOUT 
        having CHECKOUT between '21/06/01' and '21/6/30'
        order by CHECKOUT desc;
--checkIN 8월달의 OCV인 예약 (날짜순 정렬
select * from ROOM natural join BOOK where CHECKIN between '21-08-01' and '21-08-31' and VCODE='OCV' order by checkin;
select CHECKIN ,count(VCODE) from ROOM natural join BOOK where  VCODE='OCV' group by CHECKIN  having CHECKIN between '21-08-01' and '21-08-31' order by CHECKIN;
