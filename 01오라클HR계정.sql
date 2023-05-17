-- 오라클 주석문
/* 
여러줄 주석
오라큰 대소문자 구분 X

*/
SELECT * from employees;
SELECT FIRST_name, email, hire_date From employees;
SELECT job_id, salary, department_id From employees;

SELECT * from departments;

--연산
--컬럼을 조회하는 위치에서 * / +-
SELECT first_name, salary, salary + salary * 0.1 from employees;

--null
select first_name, commission_pct From employees;

--엘리어스 as
select first_name AS 이름, 
       lasT_name AS 성, 
       SALARY 급여, 
       SALARY + SALARY * 0.1 총급여 
FROM employees;

--문자열의 연결 ||
--오라클은 문자를 ''로 표현, 문자열 안에서 '를 사용하고 싶으면 두번 쓰면 됨.''
SELECT FIRST_NAME ||' '|| LAST_NAME || '''s IS salary $' || SALARY AS 급여내역
FROM employees;

--DISTINCT 중복행 제거
SELECT DISTINCT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES;

--ROWID(데이터의 주소), ROWNUM(조회된 순서)
SELECT ROWNUM, ROWID, EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES;

--WHERE 조건을 만족하는 행의 질의를 제한



