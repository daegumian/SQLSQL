--INSERT, UPDATE, DELETE 문을 작성하면 COMMIT 명령으로 실제 반영을 처리하는 작업이 필요
--INSERT

--테이블 구조 확인
DESC DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES(300, 'DEV', NULL, 1700); --전체행을 넣는 경우
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(310, 'SYSTEM'); --선택적으로 넣는 경우

ROLLBACK;

SELECT *
FROM DEPARTMENTS;

--사본테이블(테이블 구조만 복사)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 =2);
--사본테이블에 기존에 있는 것 복사.
INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'); --전체컬럼을 맞춤

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

--EX2 우리가 아는 WHERE절에 들어가는 것은 다 들어갈 수 있다.
UPDATE EMPS
SET COMMISSION_PCT = 0.1
WHERE JOB_ID IN('IT_PROG', 'SA_MAN');

--EX3 : ID 200인 사람을 200의 급여를 103번과 동일하게 변경 (서브쿼리)
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

--EX4 : 3개의 컬럼을 한번에 변경
UPDATE EMPS
SET (JOB_ID, SALARY, COMMISSION_PCT) = (SELECT JOB_ID, SALARY, COMMISSION_PCT FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

COMMIT;

----------------------------------------------------------------------------------------------------------------------------------
--DELETE구문
CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1 = 1); --테이블 복사 + 데이터 복사

SELECT * FROM DEPTS;
SELECT * FROM EMPS;
--EX1 - 삭제할 떄는 꼭 PK를 이용
DELETE FROM EMPS WHERE EMPLOYEE_ID = 200;
DELETE FROM EMPS WHERE SALARY >= 4000;


--EX2 -
SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT';

DELETE FROM EMPS WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');

ROLLBACK;

-- F.K - P.K로 연결되어 있는 것은 DELETE 되지 않는다. EMPLOYEE가 60번 부서를 사용하고 있기 때문에 삭제 불가
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
DELETE  FROM DEPARTMENTS WHERE DEPARTMENT_ID;

----------------------------------------------------------------------------------------------------------------------------------
--MERGE문
--두 테이블을 비교해서 데이터가 있으면 UPDATE, 없으면 INSERT.(또는 일치하는 데이터를 DELETE 할 수도 있음)
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
ON (E.EMPLOYEE_ID = 103) --P.K형태만 들어가야함
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
문제 1.
DEPTS테이블의 다음을 추가하세요
SELECT * FROM DEPTS;

--답
INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (320,'영업', 303,1700);
COMMIT;

문제 2.
DEPTS테이블의 데이터를 수정합니다
1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경

--답
UPDATE DEPTS 
SET DEPARTMENT_NAME = 'IT Bank'
WHERE DEPARTMENT_NAME = 'IT';

2. department_id가 290인 데이터의 manager_id를 301로 변경

--답
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;


3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를 1800으로 변경하세요

--답
UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT Help',
       MANAGER_ID = 303,
       LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';


4. 재정, 인사, 영업 의 매니저아이디를 301로 한번에 변경하세요.

--답
UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_ID IN (300,310,320);

SELECT * FROM DEPTS;

문제 3.
삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
1. 부서명 영업부를 삭제 하세요
2. 부서명 NOC를 삭제하세요

--답
DELETE FROM DEPTS WHERE DEPARTMENT_ID IN (320, 220);

SELECT * FROM DEPTS;


문제
문제4
1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.

--답
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;

SELECT * FROM DEPTS;

2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.

--답
UPDATE DEPTS
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;

SELECT * FROM DEPTS;

3. Depts 테이블은 타겟 테이블 입니다.
SELECT * FROM DEPTS;
COMMIT;

4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.

(GPT에 찾아본 결과 타겟 테이블은 MERGE INTO 뒤에 씀)
SELECT * FROM DEPARTMENTS;

--답
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

--반대로도 해봄
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





문제 5
SELECT * FROM JOBS_IT;

1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
CREATE TABLE JOBS_IT AS (SELECT * FROM JOBS WHERE MIN_SALARY > 6000);

SELECT * FROM JOBS_IT;

2. jobs_it 테이블에 다음 데이터를 추가하세요

--답
INSERT INTO JOBS_IT (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES('SEC_DEV','보안개발팀', 6000, 19000);
VALUES('NET_DEV','네트워크개발팀', 5000, 20000);
VALUES('SEC_DEV','보안개발팀', 6000, 19000);

3. jobs_it은 타겟 테이블 입니다
SELECT * FROM JOBS_IT;

4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
데이터는 그대로 추가해주는 merge문을 작성하세요
SELECT * FROM JOBS_IT;
SELECT * FROM JOBS;

SELECT MIN(MIN_SALARY), MAX(MAX_SALARY)  FROM JOBS;

--답
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





















