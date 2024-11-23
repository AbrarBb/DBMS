drop table depositor cascade constraints;
drop table borrower cascade constraints;
drop table account cascade constraints;
drop table loan cascade constraints;
drop table customer cascade constraints;
drop table branch cascade constraints;

create table account
   (account_number 	varchar(15)	not null,
    branch_name		varchar(15)	not null,
    balance 		number		not null,
    primary key(account_number));

create table branch
   (branch_name 	varchar(15)	not null,
    branch_city 	varchar(15)	not null,
    assets 		number		not null,
    primary key(branch_name));

create table customer
   (customer_name 	varchar(15)	not null,
    customer_street 	varchar(12)	not null,
    customer_city 	varchar(15)	not null,
    primary key(customer_name));

create table loan
   (loan_number 	varchar(15)	not null,
    branch_name		varchar(15)	not null,
    amount 		number		not null,
    primary key(loan_number));

create table depositor
   (customer_name 	varchar(15)	not null,
    account_number 	varchar(15)	not null,
    primary key(customer_name, account_number),
    foreign key(account_number) references account(account_number),
    foreign key(customer_name) references customer(customer_name));

create table borrower
   (customer_name 	varchar(15)	not null,
    loan_number 	varchar(15)	not null,
    primary key(customer_name, loan_number),
    foreign key(customer_name) references customer(customer_name),
    foreign key(loan_number) references loan(loan_number));

/* populate relations */

insert into customer	values ('Jones',	'Main',		'Harrison');
insert into customer	values ('Smith',	'Main',		'Rye');
insert into customer	values ('Hayes',	'Main',		'Harrison');
insert into customer	values ('Curry',	'North',	'Rye');
insert into customer	values ('Lindsay',	'Park',		'Pittsfield');
insert into customer	values ('Turner',	'Putnam',	'Stamford');
insert into customer	values ('Williams',	'Nassau',	'Princeton');
insert into customer	values ('Adams',	'Spring',	'Pittsfield');
insert into customer	values ('Johnson',	'Alma',		'Palo Alto');
insert into customer	values ('Glenn',	'Sand Hill',	'Woodside');
insert into customer	values ('Brooks',	'Senator',	'Brooklyn');
insert into customer	values ('Green',	'Walnut',	'Stamford');
insert into customer	values ('Jackson',	'University',	'Salt Lake');
insert into customer	values ('Majeris',	'First',	'Rye');
insert into customer	values ('McBride',	'Safety',	'Rye');

insert into branch	values ('Downtown',	'Brooklyn',	 900000);
insert into branch	values ('Redwood',	'Palo Alto',	2100000);
insert into branch	values ('Perryridge',	'Horseneck',	1700000);
insert into branch	values ('Mianus',	'Horseneck',	 400200);
insert into branch	values ('Round Hill',	'Horseneck',	8000000);
insert into branch	values ('Pownal',	'Bennington',	 400000);
insert into branch	values ('North Town',	'Rye',		3700000);
insert into branch	values ('Brighton',	'Brooklyn',	7000000);
insert into branch	values ('Central',	'Rye',		 400280);

insert into account	values ('A-101',	'Downtown',	500);
insert into account	values ('A-215',	'Mianus',	700);
insert into account	values ('A-102',	'Perryridge',	400);
insert into account	values ('A-305',	'Round Hill',	350);
insert into account	values ('A-201',	'Perryridge',	900);
insert into account	values ('A-222',	'Redwood',	700);
insert into account	values ('A-217',	'Brighton',	750);
insert into account	values ('A-333',	'Central',	850);
insert into account	values ('A-444',	'North Town',	625);

insert into depositor values ('Johnson','A-101');
insert into depositor values ('Smith',	'A-215');
insert into depositor values ('Hayes',	'A-102');
insert into depositor values ('Hayes',	'A-101');
insert into depositor values ('Turner',	'A-305');
insert into depositor values ('Johnson','A-201');
insert into depositor values ('Jones',	'A-217');
insert into depositor values ('Lindsay','A-222');
insert into depositor values ('Majeris','A-333');
insert into depositor values ('Smith',	'A-444');

insert into loan	values ('L-17',		'Downtown',	1000);
insert into loan	values ('L-23',		'Redwood',	2000);
insert into loan	values ('L-15',		'Perryridge',	1500);
insert into loan	values ('L-14',		'Downtown',	1500);
insert into loan	values ('L-93',		'Mianus',	500);
insert into loan	values ('L-11',		'Round Hill',	900);
insert into loan	values ('L-16',		'Perryridge',	1300);
insert into loan	values ('L-20',		'North Town',	7500);
insert into loan	values ('L-21',		'Central',	570);

insert into borrower values ('Jones',	'L-17');
insert into borrower values ('Smith',	'L-23');
insert into borrower values ('Hayes',	'L-15');
insert into borrower values ('Jackson',	'L-14');
insert into borrower values ('Curry',	'L-93');
insert into borrower values ('Smith',	'L-11');
insert into borrower values ('Williams','L-17');
insert into borrower values ('Adams',	'L-16');
insert into borrower values ('McBride',	'L-20');
insert into borrower values ('Smith',	'L-21');

commit;


/* Exercise offline answers ->https://github.com/AbrarBb/DBMS/blob/main/Lab-3/Manual.pdf*/ 
SELECT * FROM BRANCH;
SELECT * FROM CUSTOMER;
SELECT * FROM ACCOUNT;
SELECT * FROM LOAN;
SELECT * FROM DEPOSITOR;
SELECT * FROM BORROWER;

--01
SELECT BRANCH_NAME,BRANCH_CITY,ASSETS
FROM BRANCH 
WHERE ASSETS>1000000;

--02
SELECT ACCOUNT_NUMBER,BALANCE
FROM ACCOUNT 
WHERE BRANCH_NAME='Downtown' 
OR BALANCE BETWEEN 600 AND 750;

--03
SELECT ACCOUNT.ACCOUNT_NUMBER
FROM BRANCH JOIN ACCOUNT 
ON BRANCH.BRANCH_NAME=ACCOUNT.BRANCH_NAME
WHERE BRANCH.BRANCH_CITY='Rye';

--04
SELECT LOAN.LOAN_NUMBER
FROM LOAN JOIN BORROWER 
ON LOAN.LOAN_NUMBER=BORROWER.LOAN_NUMBER
JOIN CUSTOMER
ON BORROWER.CUSTOMER_NAME=CUSTOMER.CUSTOMER_NAME
WHERE LOAN.AMOUNT>=1000 AND CUSTOMER.CUSTOMER_CITY='Harrison';

--05
SELECT * 
FROM ACCOUNT
ORDER BY BALANCE DESC;

--06
SELECT * 
FROM CUSTOMER
ORDER BY CUSTOMER_CITY;

--07
SELECT CUSTOMER_NAME
FROM DEPOSITOR
INTERSECT
SELECT CUSTOMER_NAME
FROM BORROWER;

--08
SELECT C.CUSTOMER_NAME,C.CUSTOMER_STREET,C.CUSTOMER_CITY
FROM CUSTOMER C JOIN DEPOSITOR D
ON C.CUSTOMER_NAME=D.CUSTOMER_NAME
UNION
SELECT C.CUSTOMER_NAME,C.CUSTOMER_STREET,C.CUSTOMER_CITY
FROM CUSTOMER C JOIN BORROWER B
ON C.CUSTOMER_NAME=B.CUSTOMER_NAME;

--09
SELECT C.CUSTOMER_NAME, C.CUSTOMER_CITY
FROM CUSTOMER C JOIN BORROWER B 
ON C.CUSTOMER_NAME = B.CUSTOMER_NAME
MINUS
SELECT C.CUSTOMER_NAME, C.CUSTOMER_CITY
FROM CUSTOMER C JOIN DEPOSITOR D 
ON D.CUSTOMER_NAME = C.CUSTOMER_NAME;

--10
SELECT SUM(ASSETS) AS TOTAL_ASSETS
FROM BRANCH;

--11
SELECT BRANCH_NAME,AVG(BALANCE)
FROM ACCOUNT
GROUP BY BRANCH_NAME;

--12
SELECT B.BRANCH_CITY,AVG(A.BALANCE) AS AVG_BALANCE
FROM BRANCH B JOIN ACCOUNT A
ON B.BRANCH_NAME=A.BRANCH_NAME
GROUP BY B.BRANCH_CITY;

--13
SELECT BRANCH_NAME, MIN(AMOUNT) AS LOWEST_AMOUNT 
FROM LOAN
GROUP BY BRANCH_NAME;

--14
SELECT BRANCH_NAME,COUNT(AMOUNT) AS NUM_OF_LOAN
FROM LOAN
GROUP BY BRANCH_NAME;

--15
SELECT D.CUSTOMER_NAME,A.ACCOUNT_NUMBER,A.BALANCE AS MAX_BALANCE
FROM DEPOSITOR D JOIN ACCOUNT A
ON D.ACCOUNT_NUMBER=A.ACCOUNT_NUMBER
WHERE BALANCE=(SELECT MAX(BALANCE) FROM ACCOUNT);
