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
select * from CAR order by BNUM;
--����� ��¥�� 21�� 12�� 10�� �� ����
select * from BOOK where BDATE = '21-12-10';
--���ڱⰣ�� 1�� 2�� �� ����
select * from BOOK where CHECKOUT - CHECKIN =1;