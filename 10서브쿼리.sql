--서브쿼리
--SELECT문이 SELECT구문으로 들어가는 형태 : 스칼라 서브쿼리
--SELECT문이 FROM구문으로 들어가는 형태 : 인라인뷰
--SELECT문이 WHERE구문으로 들어가면 : 서브쿼리
--서브쿼리는 반드시 () 안에 적어야한다.

--단인행 서브쿼리 - 리턴되는 행이 1개인 서브쿼리

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT *
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID가 103번인 사람과 동일한 직군
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--주의할점, 단일행 이어야 한다. 컬럼값도 1개 여야 한다.
--ERR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 OR EMPLOYEE_ID = 104);

------------------------------------------------------------------------------------------------------------
--다중행 서브쿼리 - 행이 여러개라면 IN, ANY, ALL로 비교함.
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David';

-- in 동일한 값을 찾는 in (4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY 최솟값 보다 큼, 최댓값 보다 작음
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- 급여가 4800보다 큰 사람들

SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- 급여가 9500보다 작은 사람들

--ALL 최솟값 보다 작음, 최댓값 보다 큼.
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- 급여가 9500보다 큰 사람들


SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- 급여가 4800보다 작은 사람들

--직업이 IT_PROG인 사람들의 최솟값 보다 큰 급여를 받는 사람들
SELECT *
FROM EMPLOYEES
WHERE SALARY >ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


------------------------------------------------------------------------------------------------------------
--스칼라 서브쿼리
--JOIN시에 특정테이블의 1컬럼을 가지고 오 때 유리하다.
--주의할점 단일행 출력을 할때만 가능하다
SELECT FIRST_NAME,
             EMAIL,
             (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;
--위와 같은 결과
SELECT FIRST_NAME,
             EMAIL,
             DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;

--각 부서의 매니저 이름을 출력하고 싶다?
--JOIN
SELECT D.*,
             E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
--스칼라
SELECT D.*,
             (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--스칼라 쿼리 여러번 가능
SELECT * FROM JOBS; --JOB_TILTE
SELECT * FROM DEPARTMENTS; --DEPARTMENT_NAME
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
             E.JOB_ID,
             (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_ID,
             (SELECT DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_ID
FROM EMPLOYEES E;

--각 부서의 사원 수를 출력 + 부서정보 COUNT?
SELECT DEPARTMENT_ID, COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT D.*,
             NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID) , 0) AS 사원수
FROM DEPARTMENTS D;


------------------------------------------------------------------------------------------------------------
--인라인 뷰(FROM절에 들어간다)
--가짜 테이블 형태를 만들어서 그곳에서 불러온다. 오라클에서는 이것 때문에 많이 사용.

--ROWNUM은 조회된 순서이기 때문에, ORDER와 같이 사용되면 ROWNUM 섞이는 문제
SELECT FIRST_NAME,
             SALARY,
             ROWNUM
FROM (SELECT FIRST_NAME,
                        SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC);
            
            

SELECT ROWNUM,
             A.*
FROM(SELECT FIRST_NAME,
                       SALARY
          FROM EMPLOYEES
          ORDER BY SALARY
          ) A;
          
          
-- ROWNUM는 무조건 1번째부터 조회값이 나타난다
SELECT FIRST_NAME,
             SALARY,
             ROWNUM
FROM (SELECT FIRST_NAME,
                        SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 11 AND 20;


--2번째 인라인뷰에서 ROWNUM을 AS로 RN으로 컬럼화
SELECT *
FROM (SELECT  FIRST_NAME,
                         SALARY,
                        ROWNUM AS RN
            FROM (SELECT FIRST_NAME,
                        SALARY
                        FROM EMPLOYEES
                        ORDER BY SALARY DESC)
                        )
WHERE RN >= 10 AND RN <= 20;

--인라인 뷰의 예시

SELECT TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,
             NAME
FROM(SELECT '홍길동' AS NAME, SYSDATE AS REGDATE FROM DUAL
            UNION ALL
            SELECT '이순신', SYSDATE FROM DUAL);

--인라인 뷰의 응용
--부서별 사원수
SELECT D.*,
             E.TOTAL
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, 
                              COUNT(*) AS TOTAL
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--부서별 사원수 <- 위에 조인할 테이블 자리에 들어감.
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

--정리
--단일행( 대소비교 ) VS 다중행 서브쿼리 (IN, ANY, ALL)
--스칼라쿼리 - SELECT절에 들어가 LEFT JOIN과 같은 역할, 한번에 1개의 컬럼을 가져올 때
--인라인뷰 - FROM절에 들어가는 가짜 테이블, 응용 많이 해봐야한다.

                        
            
            
            
            



