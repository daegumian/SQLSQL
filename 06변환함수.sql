--형변환 함수
--자동 형변환
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; -- 자동 형변환 (문자->숫자)
SELECT SYSDATE - 5, SYSDATE - '5' FROM employees; --자동 형변환 (문자->숫자)

--강제 형변환
--TO_CHAR(날짜, 날짜 포맷)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS') FROM DUAL; --문자로
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS') FROM DUAL; --문자
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일"') FROM DUAL; --포맷문자가 아닌 경우는 ""로 묶기
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS 날짜 FROM EMPLOYEES;

--TO_CHAR(숫자, 숫자포맷)
SELECT TO_CHAR(200000, '$999,999,999.00') FROM DUAL;
SELECT TO_CHAR(200000.1234, '999999.999') FROM DUAL; --소수점 자리 표현
SELECT FIRST_NAME, TO_CHAR( SALARY/12 * 1300, 'L999,999,999') FROM EMPLOYEES; --지역화폐
SELECT FIRST_NAME, TO_CHAR( SALARY * 1300, 'L0999,999,999') FROM EMPLOYEES; --자리수를 0으로 채움

--TO_NUMBER(문자, 숫자포맷)
SELECT '3.15' + 2000 FROM DUAL; --자동형변환
SELECT TO_NUMBER('3.14') FROM DUAL; --명시적 형변환 강제 형변환
SELECT TO_NUMBER('$3,300', '$999,999') + 2000 FROM DUAL; --강제 형변환

--TO_DATE(문자, 날짜포맷)
SELECT '2023-05-16' - SYSDATE FROM DUAL;
SELECT  SYSDATE - TO_DATE('2023-05-16', 'YYYY-MM-DD')FROM DUAL; --날짜로 강제 형변환
SELECT SYSDATE - TO_DATE('2023/05/16 11:31:23', 'YYYY/MM/DD HH:MI:SS') FROM DUAL;

--아래값을 YYYY년 MM월 DD일 형태로 출력
SELECT '20050105' FROM DAUL;
SELECT TO_CHAR((TO_DATE('20050105')), 'YYYY"년"MM"월"DD"일"') FROM DUAL;
--TEACHER
SELECT TO_CHAR((TO_DATE('20050105', 'YYYYMMDD')), 'YYYY"년"MM"월"DD"일"') FROM DUAL; --같다

--아래 값과 현재 날짜와 일수 차이를 구하ㅔ요
SELECT '2005년01월05일' FROM DUAL;
SELECT SYSDATE - TO_DATE(REPLACE('2005년01월05일', '2005년01월05일', '2005/01/05')) FROM DUAL; --1번
SELECT SYSDATE - TO_DATE('2005년01월05일', 'YYYY"년"MM"월"DD"일"') FROM DUAL; --2번
--TEACHER
SELECT SYSDATE - TO_DATE('2005년01월05일', 'YYY"년"MM"월"DD"일"') FROM DUAL; --2번이랑 같음

-------------------------------------------------------------------------------------------
--NULL값에 대한 변환 
--NVL(컬럼, NULL일 경우 처리)
SELECT NVL(NULL, 0) FROM DUAL;
SELECT FIRST_NAME, COMMISSION_PCT*100 FROM EMPLOYEES; --NULL연산자 => NULL
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) * 100 FROM EMPLOYEES;

--NVL(컬럼, NULL이 아닌경우 처리, NULL인 경우처리)
SELECT NVL2(NULL, '널이 아닙니다', '널입니다') FROM DUAL;
SELECT SALARY,
       COMMISSION_PCT,
       NVL2(COMMISSION_PCT, (SALARY * (COMMISSION_PCT+1)), SALARY)AS 급여  FROM EMPLOYEES; --총 연봉이 얼마인가

--DECODE(COLUMN, 비교, 결과) - ELSE IF문을 대체하는 함수
SELECT DECODE('D', 'A', 'A입니다.', 
                   'B', 'B입니다.',
                   'C', 'C입니다.', 
                   'ABC가 아닙니다.') FROM DUAL;

SELECT JOB_ID, SALARY, DECODE(JOB_ID, 'IT_PROG', SALARY * 0.3,
                      'FI_MGR', SALARY * 0.2,
                      SALARY) AS 보너스급여 
FROM EMPLOYEES;
--CASE WHEN THEN ELSE
--1ST
SELECT JOB_ID,
        CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 0.3
                    WHEN 'FI_MGR' THEN SALARY * 0.2
                    ELSE SALARY
                    END
FROM EMPLOYEES;

--2ND (대소비교 OR 다른 컬럼의 비교 가능)
SELECT JOB_ID, FIRST_NAME,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 0.3
            WHEN JOB_ID = 'FI_MGR' THEN SALARY * 0.2
            WHEN FIRST_NAME = 'Steven' THEN SALARY * 0
            ELSE SALARY
       END AS급여
FROM EMPLOYEES;

--COALESCE(A, B) - NVL이랑 유사
SELECT COALESCE(COMMISSION_PCT, 0) FROM EMPLOYEES; --표현이 NULL이면 0을 반환.

------------------------------------------------------------------------
/*문제 1.
현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요.
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다*/
SELECT (SYSDATE - HIRE_DATE)/365 FROM EMPLOYEES;
SELECT employee_id AS 사원번호, FIRST_NAME AS 이름, HIRE_DATE AS 입사일자, 
            TRUNC((SYSDATE - HIRE_DATE)/365,0) AS 근속연수
            FROM EMPLOYEES WHERE TRUNC((SYSDATE - HIRE_DATE)/365,0) >= 20 ORDER BY (SYSDATE - HIRE_DATE)/356 DESC;
--TEACHER
SELECT EMPLOYEE_ID AS 사원번호, 
       FIRST_NAME || ' ' || LAST_NAME AS 이름, 
       HIRE_DATE AS 입사일자,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS 근속년수
FROM EMPLOYEES 
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10 -- 이 행에 맞는 조건만 나옴
ORDER BY  근속년수 DESC;
            
/*문제 2.
EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’,
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) manager_id가 50인 사람들을 대상으로만 조회합니다*/
SELECT MANAGER_ID,DEPARTMENT_ID FROM EMPLOYEES;
SELECT FIRST_NAME, MANAGER_ID,
                    CASE WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 100 THEN '사원'
                         WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 120 THEN '주임'
                         WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 121 THEN '대리'
                         WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 122 THEN '과장'
                         ELSE '임원'
                         END
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50 ORDER BY MANAGER_ID DESC;

--TEACHER
SELECT FIRST_NAME,
       MANAGER_ID,
       DECODE(MANAGER_ID, 100, '사원',
                          120, '주임',
                          121, '대리',
                          122, '과장',
                          '임원') AS 직급
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;






