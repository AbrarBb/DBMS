 -- 1.(a).
 CREATE TABLE INSTRUCTOR_2022_3_60_043( 
 INSTRUCTOR_ID NUMBER(5), 
 INSTRUCTOR_NAME VARCHAR2(20), 
 INSTRUCTOR_DEPT VARCHAR2(10), 
 INSTRUCTOR_SALARY NUMBER(6) 
 );
desc  INSTRUCTOR_2022_3_60_043;


--1.(b).
CREATE TABLE course_2022_3_60_043 (
    course_id VARCHAR2(50),  
    title VARCHAR2(100),     
    dept_name VARCHAR2(100), 
    credits NUMBER(3)        
);
desc  course_2022_3_60_043;


--2.(a).
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (10101, 'Srinivasan', 'Comp. Sci.', 65000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (12121, 'Wu', 'Finance', 90000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (15151, 'Mozart', 'Music', 40000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (22222, 'Einstein', 'Physics', 95000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (32343, 'El Said', 'History', 60000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (33456, 'Gold', 'Physics', 87000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (45565, 'Katz', 'Comp. Sci.', 75000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (58583, 'Califieri', 'History', 62000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (76543, 'Singh', 'Finance', 80000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (76766, 'Crick', 'Biology', 72000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (83821, 'Brandt', 'Comp. Sci.', 92000);
INSERT INTO INSTRUCTOR_2022_3_60_043 VALUES (98345, 'Kim', 'Elec. Eng.', 80000);

SELECT * FROM INSTRUCTOR_2022_3_60_043;


--2.(b).
INSERT INTO course_2022_3_60_043 VALUES ('BIO-101', 'Intro. to Biology', 'Biology', 4);
INSERT INTO course_2022_3_60_043 VALUES ('BIO-301', 'Genetics', 'Biology', 4);
INSERT INTO course_2022_3_60_043 VALUES ('BIO-399', 'Computational Biology', 'Biology', 3);
INSERT INTO course_2022_3_60_043 VALUES ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4);
INSERT INTO course_2022_3_60_043 VALUES ('CS-190', 'Game Design', 'Comp. Sci.', 4);
INSERT INTO course_2022_3_60_043 VALUES ('CS-315', 'Robotics', 'Comp. Sci.', 3);
INSERT INTO course_2022_3_60_043 VALUES ('CS-319', 'Image Processing', 'Comp. Sci.', 3);
INSERT INTO course_2022_3_60_043 VALUES ('CS-347', 'Database System Concepts', 'Comp. Sci.', 3);
INSERT INTO course_2022_3_60_043 VALUES ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3);
INSERT INTO course_2022_3_60_043 VALUES ('FIN-201', 'Investment Banking', 'Finance', 3);
INSERT INTO course_2022_3_60_043 VALUES ('HIS-351', 'World History', 'History', 3);
INSERT INTO course_2022_3_60_043 VALUES ('MU-199', 'Music Video Production', 'Music', 3);
INSERT INTO course_2022_3_60_043 VALUES ('PHY-101', 'Physical Principles', 'Physics', 4);

SELECT * FROM course_2022_3_60_043;


--3.1
SELECT INSTRUCTOR_NAME FROM INSTRUCTOR_2022_3_60_043;


--3.2
SELECT course_id, title FROM course_2022_3_60_043;


--3.3
SELECT INSTRUCTOR_NAME, INSTRUCTOR_DEPT 
FROM INSTRUCTOR_2022_3_60_043 
WHERE INSTRUCTOR_ID = 22222;


--3.4
SELECT title, credits 
FROM course_2022_3_60_043 
WHERE dept_name = 'Comp. Sci.';


--3.5
SELECT INSTRUCTOR_NAME, INSTRUCTOR_DEPT 
FROM INSTRUCTOR_2022_3_60_043 
WHERE INSTRUCTOR_SALARY > 70000;


--3.6
SELECT title 
FROM course_2022_3_60_043 
WHERE credits >= 4;


--3.7
SELECT INSTRUCTOR_NAME, INSTRUCTOR_DEPT 
FROM INSTRUCTOR_2022_3_60_043 
WHERE INSTRUCTOR_SALARY BETWEEN 80000 AND 100000;


--3.8
SELECT title, credits 
FROM course_2022_3_60_043 
WHERE dept_name <> 'Comp. Sci.';


--3.9
SELECT * FROM INSTRUCTOR_2022_3_60_043;


--3.10
SELECT * 
FROM course_2022_3_60_043 
WHERE dept_name = 'Biology' AND credits <> 4;


