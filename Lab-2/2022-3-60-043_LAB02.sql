--1.1
CREATE TABLE account (
    account_no CHAR(5) PRIMARY KEY,
    balance NUMBER NOT NULL CHECK (balance >= 0)
);

desc account;
--1.2
CREATE TABLE customer (
    customer_no CHAR(5) PRIMARY KEY,
    customer_name VARCHAR2(20) NOT NULL,
    customer_city VARCHAR2(10)
);
desc customer;

--1.3
CREATE TABLE depositor (
    account_no CHAR(5),
    customer_no CHAR(5),
    PRIMARY KEY (account_no, customer_no),
    FOREIGN KEY (account_no) REFERENCES account(account_no),
    FOREIGN KEY (customer_no) REFERENCES customer(customer_no)
);
desc customer;

--2.1
ALTER TABLE customer ADD date_of_birth DATE;
desc account;

--2.2
ALTER TABLE customer DROP COLUMN date_of_birth;
desc customer;
--2.3
ALTER TABLE depositor RENAME COLUMN account_no TO a_no;
ALTER TABLE depositor RENAME COLUMN customer_no TO c_no;
desc depositor;
--2.4
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'DEPOSITOR';
ALTER TABLE depositor DROP CONSTRAINT SYS_C00171903934;
ALTER TABLE depositor DROP CONSTRAINT SYS_C00171903935;

ALTER TABLE depositor ADD CONSTRAINT depositor_fk1 FOREIGN KEY (a_no) REFERENCES account(account_no);
ALTER TABLE depositor ADD CONSTRAINT depositor_fk2 FOREIGN KEY (c_no) REFERENCES customer(customer_no);



--3.1
INSERT INTO account (account_no, balance) VALUES ('A-101', 12000);
INSERT INTO account (account_no, balance) VALUES ('A-102', 6000);
INSERT INTO account (account_no, balance) VALUES ('A-103', 2500);
SELECT*FROM account;
--3.2
INSERT INTO customer (customer_no, customer_name, customer_city) VALUES ('C-101', 'Alice', 'Dhaka');
INSERT INTO customer (customer_no, customer_name, customer_city) VALUES ('C-102', 'Annie', 'Dhaka');
INSERT INTO customer (customer_no, customer_name, customer_city) VALUES ('C-103', 'Bob', 'Chittagong');
INSERT INTO customer (customer_no, customer_name, customer_city) VALUES ('C-104', 'Charlie', 'Khulna');
SELECT*FROM customer;
--3.3
INSERT INTO depositor (a_no, c_no) VALUES ('A-101', 'C-101');
INSERT INTO depositor (a_no, c_no) VALUES ('A-103', 'C-102');
INSERT INTO depositor (a_no, c_no) VALUES ('A-103', 'C-104');
INSERT INTO depositor (a_no, c_no) VALUES ('A-102', 'C-103');
SELECT*FROM depositor;
--4.1
SELECT customer_name, customer_city FROM customer;

--4.2
SELECT DISTINCT customer_city FROM customer;

--4.3
SELECT account_no FROM account WHERE balance > 7000;

--4.4
SELECT customer_no, customer_name FROM customer WHERE customer_city = 'Khulna';

--4.5
SELECT customer_no, customer_name FROM customer WHERE customer_city <> 'Dhaka';

--4.6
SELECT customer.customer_name, customer.customer_city 
FROM customer JOIN depositor ON customer.customer_no = depositor.c_no
JOIN account ON depositor.a_no = account.account_no
WHERE account.balance > 7000;

--4.7
SELECT customer.customer_name, customer.customer_city
FROM customer
JOIN depositor ON customer.customer_no = depositor.c_no
JOIN account ON depositor.a_no = account.account_no
WHERE account.balance > 7000 AND customer.customer_city <> 'Khulna';

--4.8
SELECT account.account_no, account.balance
FROM account
JOIN depositor ON account.account_no = depositor.a_no
WHERE depositor.c_no = 'C-102';

--4.9
SELECT account.account_no, account.balance
FROM account
JOIN depositor ON account.account_no = depositor.a_no
JOIN customer ON depositor.c_no = customer.customer_no
WHERE customer.customer_city IN ('Dhaka', 'Khulna');

--4.10
SELECT customer.customer_no, customer.customer_name
FROM customer LEFT JOIN depositor ON customer.customer_no = depositor.c_no
WHERE depositor.a_no IS NULL;



