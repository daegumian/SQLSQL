/*문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요*/
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT TRUNC(AVG(SUM(SALARY)))
                                        FROM EMPLOYEES
                                        WHERE JOB_ID = 'IT_PROG'
                                        GROUP BY SALARY);
                    
                         
--TEACHER
SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.

SELECT E.*
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE MANAGER_ID = 100);

--TEACHER
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);




문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.

--1
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID 
                                   FROM EMPLOYEES
                                   WHERE FIRST_NAME = 'Pat');
--TEACHER            
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');



--2
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');

--TEACHER
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');




문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요

SELECT FIRST_NAME
FROM EMPLOYEES
ORDER BY FIRST_NAME DESC;

SELECT *
FROM ( SELECT E.*,
                        ROWNUM AS RN
            FROM (SELECT *
                        FROM EMPLOYEES
                        ORDER BY FIRST_NAME DESC) E
                        )
WHERE RN BETWEEN 41 AND 50; 


--TEACHER

SELECT *
FROM (SELECT E.*,
                         ROWNUM AS RN
          FROM (SELECT * 
                        FROM EMPLOYEES 
                        ORDER BY FIRST_NAME DESC) E
           )
WHERE RN >= 40 AND RN < 50;

SELECT E.*,
             ROWNUM AS RN
FROM (SELECT * 
           FROM EMPLOYEES 
           ORDER BY FIRST_NAME DESC) E;


SELECT * FROM EMPLOYEES ORDER BY FIRST_NAME DESC;





/*문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호,
입사일을 출력하세요.*/

SELECT *FROM EMPLOYEES ORDER BY HIRE_DATE;

SELECT *
FROM (SELECT ROWNUM AS RN, 
                        EMPLOYEE_ID, 
                        FIRST_NAME,
                        PHONE_NUMBER, 
                        HIRE_DATE
            FROM(SELECT * 
                        FROM EMPLOYEES 
                        ORDER BY HIRE_DATE)
                        )
WHERE RN BETWEEN 31 AND 40;
   
--TEACHER
SELECT *
FROM(SELECT E.*,
                        ROWNUM RN
            FROM   (SELECT EMPLOYEE_ID,
                                      FIRST_NAME|| ' ' ||LAST_NAME AS NAME,
                                      PHONE_NUMBER,
                                      HIRE_DATE
             FROM EMPLOYEES
             ORDER BY HIRE_DATE DESC) E
             )
WHERE RN BETWEEN 31 AND 40;            
            
SELECT E.*,
             ROWNUM RN
FROM   (SELECT EMPLOYEE_ID,
                          FIRST_NAME || ' ' || LAST_NAME AS NAME,
                          PHONE_NUMBER,
                          HIRE_DATE
             FROM EMPLOYEES
             ORDER BY HIRE_DATE DESC) E;
             
    
           
SELECT EMPLOYEE_ID,
             FIRST_NAME || ' ' || LAST_NAME AS NAME,
             PHONE_NUMBER,
            HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC) E;


/*문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬*/

SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,LAST_NAME) AS 이름, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--TEACHER
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,LAST_NAME) AS 이름, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


*/문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요*/

SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,LAST_NAME) AS 이름, E.DEPARTMENT_ID, 
            (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;


/*문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬*/

SELECT D.*, STREET_ADDRESS, POSTAL_CODE, CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;

--TEACHER
SELECT D.DEPARTMENT_ID,
             D.DEPARTMENT_NAME,
             D.MANAGER_ID,
             D.LOCATION_ID,
             L.POSTAL_CODE,
             L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;



/*문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요*/

SELECT D.*,
            (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID),
            (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID),
            (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID)
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

SELECT STREET_ADDRESS, POSTAL_CODE, CITY FROM LOCATIONS;


/*문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬*/

SELECT LOCATION_ID, STREET_ADDRESS, CITY, L.COUNTRY_ID, COUNTRY_NAME
FROM LOCATIONS L
LEFT JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;


--TEACHER

SELECT L.LOCATION_ID,  
             L.STREET_ADDRESS, 
             L.CITY, 
             L.COUNTRY_ID, 
             C.COUNTRY_NAME 
FROM LOCATIONS L 
LEFT JOIN COUNTRIES C 
ON L.COUNTRY_ID = C.COUNTRY_ID 
ORDER BY COUNTRY_NAME;




/*문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요*/

SELECT LOCATION_ID, STREET_ADDRESS, CITY, L.COUNTRY_ID,
            (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;

--TEACHER
SELECT L.LOCATION_ID,  
             L.STREET_ADDRESS, 
             L.CITY, 
             L.COUNTRY_ID, 
             (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID)
FROM LOCATIONS L;


조인과 서브쿼리
문제 12.
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 1-10번째 데이터만 출력합니다
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.

--TEACHER : 조인 필요한 것 SELECT절에 다 -> FROM절에 넣고 ->

SELECT *
FROM(SELECT A.*,
                        ROWNUM RN
            FROM ( SELECT E.EMPLOYEE_ID,
                                    E.FIRST_NAME,
                                    E.PHONE_NUMBER,
                                    E.HIRE_DATE,
                                    E.DEPARTMENT_ID,
                                     D.DEPARTMENT_NAME
                        FROM EMPLOYEES E
                        LEFT JOIN DEPARTMENTS D
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                        ORDER BY HIRE_DATE) A
                         )
WHERE RN  >1 AND  RN <=10;


문제 13.
--EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID,
--DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN';

--동훈
SELECT E.LAST_NAME, E.JOB_ID, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM (SELECT *
            FROM EMPLOYEES E
            WHERE JOB_ID = 'SA_MAN') E
LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;



문제 14
--DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다


SELECT * FROM DEPARTMENTS;
--동훈

SELECT D.DEPARTMENT_ID,
             D.DEPARTMENT_NAME,
             D.MANAGER_ID,
             E.사원수
FROM DEPARTMENTS D
RIGHT JOIN (SELECT DEPARTMENT_ID, 
                              COUNT(*) AS 사원수
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID IS NOT NULL
                GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.사원수 DESC;


--인원수
SELECT D.MANAGER_ID, D.DEPARTMENT_NAME, COUNT(*)
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.MANAGER_ID, D.DEPARTMENT_NAME
ORDER BY COUNT(*);

--TEACHER
SELECT D.DEPARTMENT_ID,
             D.DEPARTMENT_NAME,
             D.MANAGER_ID,
             E.인원수
FROM DEPARTMENTS D
INNER JOIN (SELECT DEPARTMENT_ID,
                         COUNT(*) AS 인원수
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.인원수 DESC;






문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요
--부서별 평균이 없으면 0으로 출력하세요 

--부서에 대한 정보
SELECT * FROM DEPARTMENTS;

--주소,우편번호
SELECT STREET_ADDRESS, POSTAL_CODE FROM LOCATIONS;

--부서에 대한 정보 + 주소,우편번호
SELECT D.*, STREET_ADDRESS AS 주소, POSTAL_CODE AS 우편번호
FROM DEPARTMENTS D
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;

--부서별 평균 연봉
SELECT E.DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS 부서별평균연봉
FROM EMPLOYEES E
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY E.DEPARTMENT_ID;

--부서에 대한 정보 + 주소,우편번호 + 부서별 평균 연봉
SELECT D.*, STREET_ADDRESS AS 주소, POSTAL_CODE AS 우편번호, A.*
FROM DEPARTMENTS D
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN (SELECT E.DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS 부서별평균연봉
        FROM EMPLOYEES E
        GROUP BY E.DEPARTMENT_ID) A
ON D.DEPARTMENT_ID = A.DEPARTMENT_ID;

--TEACHER -> NVL을 배웠다.
SELECT D.*,
            NVL(E.SALARY, 0) AS SALARY,
            L.STREET_ADDRESS AS 주소, 
            L.POSTAL_CODE AS 우편번호
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                               TRUNC(AVG(SALARY)) AS SALARY
                 FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID) E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY D.DEPARTMENT_ID DESC;



문제 16
-문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
출력하세요

--TEACHER

SELECT *
FROM (SELECT ROWNUM RN,
             X.*
                FROM(SELECT D.*,
                                        NVL(E.SALARY, 0) AS SALARY,
                                        L.STREET_ADDRESS AS 주소, 
                                        L.POSTAL_CODE AS 우편번호
                            FROM DEPARTMENTS D
                            LEFT JOIN (SELECT DEPARTMENT_ID,
                                                           TRUNC(AVG(SALARY)) AS SALARY
                                             FROM EMPLOYEES
                                             GROUP BY DEPARTMENT_ID) E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                            JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
                            ORDER BY D.DEPARTMENT_ID DESC
                            ) X
                        )
WHERE RN >10 AND RN <=20;

            





