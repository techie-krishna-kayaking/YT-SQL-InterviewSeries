--- ================================================
ORACLE DATABASE SETUP Video 
--- ================================================
🔴▶️Playlist - https://youtube.com/playlist?list=PLhXtefn-T4nip7Y5iZEheT4cj3aFiz1g5&si=QonoN6RTXriTj4fR

--- ===============
🔴▶️ DBeaver SETUP 
--- ===============
----- BASIC 
HOST - localhost
PORT - 1521
DATABASE - XEPDB1
SERVICE NAME - Service Name

----- AUTHENTICATION
USERNAME - system
ROLE - Normal
PASSWORD - 
CLIENT - OraDB21Home1


--- ================================================
--- ================================================
--- ================================================
-- DDL & DML
--- ================================================
--- ================================================
--- ================================================
create table tkk.dept(
  deptno number(2,0),
  dname  varchar2(14),
  loc    varchar2(13),
  constraint pk_dept primary key (deptno)
);
 
create table tkk.emp(
  empno    number(4,0),
  ename    varchar2(10),
  job      varchar2(9),
  mgr      number(4,0),
  hiredate date,
  sal      number(7,2),
  comm     number(7,2),
  deptno   number(2,0),
  constraint pk_emp primary key (empno),
  constraint fk_deptno foreign key (deptno) references dept (deptno)
);

ALTER USER tkk QUOTA UNLIMITED ON USERS;


insert into tkk.dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into tkk.dept values(20, 'RESEARCH', 'DALLAS');
insert into tkk.dept values(30, 'SALES', 'CHICAGO');
insert into tkk.dept values(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM tkk.dept; 

insert into emp
values(
 7839, 'KING', 'PRESIDENT', null,
 to_date('17-11-1981','DD-MM-YYYY'), 
 5000, null, 10
);
insert into emp
values(
 7698, 'BLAKE', 'MANAGER', 7839,
 to_date('1-5-1981','DD-MM-YYYY'),
 2850, null, 30
);
insert into emp
values(
 7782, 'CLARK', 'MANAGER', 7839,
 to_date('9-6-1981','DD-MM-YYYY'),
 2450, null, 10
);
insert into emp
values(
 7566, 'JONES', 'MANAGER', 7839,
 to_date('2-4-1981','DD-MM-YYYY'),
 2975, null, 20
);
insert into emp
values(
 7788, 'SCOTT', 'ANALYST', 7566,
 to_date('13-JUL-87','DD-MM-YYYY'),
 3000, null, 20
);
insert into emp
values(
 7902, 'FORD', 'ANALYST', 7566,
 to_date('3-12-1981','DD-MM-YYYY'),
 3000, null, 20
);
insert into emp
values(
 7369, 'SMITH', 'CLERK', 7902,
 to_date('17-12-1980','DD-MM-YYYY'),
 800, null, 20
);
insert into emp
values(
 7499, 'ALLEN', 'SALESMAN', 7698,
 to_date('20-2-1981','DD-MM-YYYY'),
 1600, 300, 30
);
insert into emp
values(
 7521, 'WARD', 'SALESMAN', 7698,
 to_date('22-2-1981','DD-MM-YYYY'),
 1250, 500, 30
);
insert into emp
values(
 7654, 'MARTIN', 'SALESMAN', 7698,
 to_date('28-9-1981','DD-MM-YYYY'),
 1250, 1400, 30
);
insert into emp
values(
 7844, 'TURNER', 'SALESMAN', 7698,
 to_date('8-9-1981','DD-MM-YYYY'),
 1500, 0, 30
);
insert into emp
values(
 7876, 'ADAMS', 'CLERK', 7788,
 to_date('13-JUL-87','DD-MM-YYYY'),
 1100, null, 20
);
insert into emp
values(
 7900, 'JAMES', 'CLERK', 7698,
 to_date('3-12-1981','DD-MM-YYYY'),
 950, null, 30
);
insert into emp
values(
 7934, 'MILLER', 'CLERK', 7782,
 to_date('23-1-1982','DD-MM-YYYY'),
 1300, null, 10
);





--- ================================================
-- SCENARIO 1 - DEPT wise highest salary in an org
--- ================================================
SELECT * FROM tkk.dept;

SELECT * FROM tkk.emp;

--- solution 1 
SELECT deptno, max(sal) FROM tkk.EMP 
GROUP BY deptno
ORDER BY deptno;


-- solution 2
SELECT d.dname, max(sal) FROM tkk.emp e INNER JOIN tkk.dept d 
ON e.deptno = d.deptno
GROUP BY d.dname;

-- solution 3 
SELECT * FROM 
(SELECT e.DEPTNO, d.DNAME, e.sal, 
dense_rank() OVER (PARTITION BY e.deptno order BY sal desc) AS rn 
FROM tkk.emp e, tkk.dept d 
WHERE e.DEPTNO = d.DEPTNO) 
WHERE rn = 1;

--- ================================================
-- SCENARIO 2 - WAQ to display the details of the employees who are in a department where at least 3 employees are working.
--- ================================================
-- SOLUTION 1 - sub query
SELECT * FROM EMP 
WHERE 
DEPTNO IN (SELECT DEPTNO FROM TKK.EMP 
GROUP BY DEPTNO 
HAVING COUNT(*) > 3);

-- SOLUTION 2 
SELECT * FROM EMP E JOIN
(SELECT DEPTNO FROM TKK.EMP 
GROUP BY DEPTNO 
HAVING COUNT(*) > 3) D 
ON E.DEPTNO = D.DEPTNO;
