--402ȣ�� ����Ǽ� Ȯ��
select * from BOOK where RNUM =402 ;
--192�� ���� ���� ����
select * from payment  where CNUM = 192;
--���Ǻ�(OCV)�� ���� Ȯ��
select * from ROOM where VCODE = 'OCV' ;
--6�� 21�� üũ�� ����
select * from BOOK where CHECKIN = '21-06-21';
--�达�� ��
select * from CUSTOM where CNAME like '��%';
--����ȣ�� 1�� ���� ����
select * from BOOK where CNUM =1;
--��Ƽ��� ������ ���� Ȯ��(���� �ݾ� ��)
select * from BOOK natural join ROOM where VCODE = 'CTV' order by RPRICE desc;
--�� ���� Ƚ��,�� �����
select * from PROFIT;
--����(�����ȣ ��)
select * from CAR order by BNUM desc;
--����� ��¥�� 21�� 12�� 10�� �� ����
select * from BOOK where BDATE='21/12/10';
--���ڱⰣ�� 1�� 2�� �� ����
select * from BOOK where CHECKOUT-CHECKIN=1;
--12���� ���Ǻ� ����Ǽ�
select VCODE, count(BNUM) from BOOK natural join ROOM where RNUM between 1200 and 1300 group by VCODE;
--checkout ���� 6�� �Ϻ� ����(��¥�� ����)
select CHECKOUT, sum(PAMOUNT) from BOOK natural join PAYMENT 
      group by CHECKOUT 
        having CHECKOUT between '21/06/01' and '21/6/30'
        order by CHECKOUT desc;
--checkIN 8������ OCV�� ���� (��¥�� ����
select * from ROOM natural join BOOK where CHECKIN between '21-08-01' and '21-08-31' and VCODE='OCV' order by checkin;
select CHECKIN ,count(VCODE) from ROOM natural join BOOK where  VCODE='OCV' group by CHECKIN  having CHECKIN between '21-08-01' and '21-08-31' order by CHECKIN;
