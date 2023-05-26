/*
VIEW�� �������� �ڷḦ ���� ���� ����ϴ� �������̺��̴�.
VIEW�� �̿��ؼ� �ʿ��� �÷��� �����صθ�, ������ ������ ����.
VIEW�� ���ؼ� �����Ϳ� �����ϸ�, ���� �����ϰ� �����͸� ������ �� �ִ�.
*/

SELECT * FROM emp_details_view;

--�並 �����Ϸ��� ������ �ʿ��մϴ�.
SELECT * FROM user_sys_privs;

CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
             FIRST_NAME || ' ' || LAST_NAME AS NAME,
             JOB_ID,
             SALARY
FROM EMPLOYEES
);

SELECT * FROM EMPS_VIEW;
--���� ������ OR REPLACE�� ������ �ȴ�
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
             FIRST_N|| ' ' || LAST_NAME AS NAMAME E,
             JOB_ID,
             SALARY,
             COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
);
SELECT * FROM EMPS_VIEW;

--���պ�
--JOIN�� �̿��ؼ� �ʿ��� �����͸� ��� ������
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT E.EMPLOYEE_ID,
              FIRST_NAME || ' ' || LAST_NAME AS NAME,
              D.DEPARTMENT_NAME,
              J.JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
);

SELECT * FROM EMPS_VIEW WHERE NAME LIKE '%Nancy%';

--���� ����
DROP VIEW EMPS_VIEW;

----------------------------------------------------------------------------------------------------------------------------------
/*
view�� ���� DML�� �����ϱ� ������, ��� ��������� �ִ�.
1. �����̸� �ȵȴ�.
2. JOIN�� �̿��� ���̺��� ��쿡�� �ȵȴ�
3. �������̺� NOT NULL������ �ִٸ� �ȵȴ�.
*/

SELECT * FROM EMPS_VIEW;
--1. �����̸� �ȵȴ�.(NAME�� ����)
INSERT INTO EMPS_VIEW(EMPLOYEE_ID, NAME, DEPARTMENT_NAME, JOB_TITLE) 
VALUES ( 1000, 'DEMO HONG', 'DEMO IT', 'DEMO IT PROG');
--2. JOIN�� �̿��� ���̺��� ��쿡�� �ȵȴ�
INSERT INTO EMPS_VIEW( DEPARTMENT_NAME) VALUES ('DEMO');
--3. �������̺� NOT NULL������ �ִٸ� �ȵȴ�.
INSERT INTO EMPS_VIEW(EMPLOYEE_ID, JOB_TITLE) VALUES(300,'TEST');

DESC DEPARTMENTS;

--���� �������� READ ONLY
--DML ������ �並 ���ؼ��� �� �� ����.
CREATE OR REPLACE VIEW EMPS_VIEW
AS(
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM EMPLOYEES
) WITH READ ONLY;
SELECT * FROM EMPS_VIEW;









