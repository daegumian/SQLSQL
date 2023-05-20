--INSERT, UPDATE, DELETE ���� �ۼ��ϸ� COMMIT ������� ���� �ݿ��� ó���ϴ� �۾��� �ʿ�
--INSERT

--���̺� ���� Ȯ��
DESC DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES(300, 'DEV', NULL, 1700); --��ü���� �ִ� ���
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(310, 'SYSTEM'); --���������� �ִ� ���

ROLLBACK;

SELECT *
FROM DEPARTMENTS;

--�纻���̺�(���̺� ������ ����)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 =2);
--�纻���̺� ������ �ִ� �� ����.
INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'); --��ü�÷��� ����

INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES(200, 
            (SELECT LAST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
            (SELECT EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
             SYSDATE,
             'TEST'
             );
             
SELECT * FROM EMPS;

---------------------------------------------------------------------------------------------------

SELECT * FROM EMPS;
--EX1
UPDATE EMPS
SET SALARY = SALARY +1000,
       HIRE_DATE = SYSDATE,
       FIRST_NAME = 'HOING'
WHERE EMPLOYEE_ID = 103;

--EX2 �츮�� �ƴ� WHERE���� ���� ���� �� �� �� �ִ�.
UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID IN('IT_PROG', 'SA_MAN');

--EX3 : ID 200�� ����� 200�� �޿��� 103���� �����ϰ� ���� (��������)
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

--EX4 : 3���� �÷��� �ѹ��� ����
UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT) = (SELECT JOB_ID, SALARY, COMMISSION_PCT FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

COMMIT;

----------------------------------------------------------------------------------------------------------------------------------
--DELETE����
CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1 = 1); --���̺� ���� + ������ ����

SELECT * FROM DEPTS;
SELECT * FROM EMPS;
--EX1 - ������ ���� �� PK�� �̿�
DELETE FROM EMPS WHERE EMPLOYEE_ID = 200;
DELETE FROM EMPS WHERE SALARY >= 4000;


--EX2 -
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT';

DELETE FROM EMPS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');

ROLLBACK;

-- F.K - P.K�� ����Ǿ� �ִ� ���� DELETE ���� �ʴ´�. EMPLOYEE�� 60�� �μ��� ����ϰ� �ֱ� ������ ���� �Ұ�
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE  FROM DEPARTMENTS WHERE DEPARTMENT_ID;

----------------------------------------------------------------------------------------------------------------------------------
--MERGE��
--�� ���̺��� ���ؼ� �����Ͱ� ������ UPDATE, ������ INSERT.(�Ǵ� ��ġ�ϴ� �����͸� DELETE �� ���� ����)
SELECT * FROM EMPS;

MERGE INTO EMPS E1
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN')) E2
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID)
WHEN MATCHED THEN 
    UPDATE SET
                        E1.SALARY = E2.SALARY,
                        E1.HIRE_DATE = E2.HIRE_DATE,
                        E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN
    INSERT VALUES(
            E2.EMPLOYEE_ID,
            E2.FIRST_NAME,
            E2.LAST_NAME,
            E2.EMAIL,
            E2.PHONE_NUMBER,
            E2.HIRE_DATE,
            E2.JOB_ID,
            E2.SALARY,
            E2.COMMISSION_PCT,
            E2.MANAGER_ID,
            E2.DEPARTMENT_ID);

-- MERGE2
SELECT * FROM EMPS;

MERGE INTO EMPS E
USING DUAL
ON (E.EMPLOYEE_ID = 103) --P.K���¸� ������
WHEN MATCHED THEN
        UPDATE SET LAST_NAME = 'DEMO'
WHEN NOT MATCHED THEN
        INSERT(EMPLOYEE_ID, 
                    LAST_NAME,
                    EMAIL,
                    HIRE_DATE,
                    JOB_ID) VALUES(1000, 'DEMO', 'DEMO', SYSDATE, 'DEMO');

DELETE FROM EMPS WHERE EMPLOYEE_ID = 103;


----------------------------------------------------------------------------------------------------------------------------------
���� 1.
DEPTS���̺��� ������ �߰��ϼ���
SELECT * FROM DEPTS;

--��
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (320,'����', 303,1700);
COMMIT;

���� 2.
DEPTS���̺��� �����͸� �����մϴ�
1. department_name �� IT Support �� �������� department_name�� IT bank�� ����

--��
UPDATE DEPTS 
SET DEPARTMENT_NAME = 'IT Bank'
WHERE DEPARTMENT_NAME = 'IT';

2. department_id�� 290�� �������� manager_id�� 301�� ����

--��
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;


3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵� 1800���� �����ϼ���

--��
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
       MANAGER_ID = 303,
       LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';


4. ����, �λ�, ���� �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.

--��
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID IN (300,310,320);

SELECT * FROM DEPTS;

���� 3.
������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
1. �μ��� �����θ� ���� �ϼ���
2. �μ��� NOC�� �����ϼ���

--��
DELETE FROM DEPTS WHERE DEPARTMENT_ID IN (320, 220);

SELECT * FROM DEPTS;


����
����4
1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.

--��
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;

SELECT * FROM DEPTS;

2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.

--��
UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

SELECT * FROM DEPTS;

3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
SELECT * FROM DEPTS;
COMMIT;

4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.

(GPT�� ã�ƺ� ��� Ÿ�� ���̺��� MERGE INTO �ڿ� ��)
SELECT * FROM DEPARTMENTS;

--��
MERGE INTO DEPTS S
USING DEPARTMENTS D
ON (S.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHEN MATCHED THEN
        UPDATE SET
                            S.DEPARTMENT_NAME = D.DEPARTMENT_NAME,
                            S.MANAGER_ID = D.MANAGER_ID,
                            S.LOCATION_ID = D.LOCATION_ID
WHEN NOT MATCHED THEN
        INSERT VALUES(
                            D.DEPARTMENT_ID,
                            D.DEPARTMENT_NAME,
                            D.MANAGER_ID,
                            D.LOCATION_ID);

SELECT * FROM DEPTS;

--�ݴ�ε� �غ�
MERGE INTO Departments AS D
USING Depts AS S
ON (D.department_id = S.department_id)
WHEN MATCHED THEN
  UPDATE SET
    D.department_name = S.department_name,
    D.manager_id = S.manager_id,
    D.location_id = S.location_id
WHEN NOT MATCHED THEN
  INSERT (department_id, department_name, manager_id, location_id)
  VALUES (S.department_id, S.department_name, S.manager_id, S.location_id);





���� 5
SELECT * FROM JOBS_IT;

1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);

SELECT * FROM JOBS_IT;

2. jobs_it ���̺� ���� �����͸� �߰��ϼ���

--��
INSERT INTO JOBS_IT (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES('SEC_DEV','���Ȱ�����', 6000, 19000);
VALUES('NET_DEV','��Ʈ��ũ������', 5000, 20000);
VALUES('SEC_DEV','���Ȱ�����', 6000, 19000);

3. jobs_it�� Ÿ�� ���̺� �Դϴ�
SELECT * FROM JOBS_IT;

4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
SELECT * FROM JOBS_IT;
SELECT * FROM JOBS;

SELECT MIN(MIN_SALARY), MAX(MAX_SALARY)  FROM JOBS;

--��
MERGE INTO JOBS_IT J1
USING JOBS J2
ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
            UPDATE SET
                            J1.MIN_SALARY = J2.MIN_SALARY,
                            J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
            INSERT VALUES
                            (J2.JOB_ID, J2.JOB_TITLE, J2.MIN_SALARY, J2.MAX_SALARY);
                            
SELECT * FROM JOBS_IT;





















