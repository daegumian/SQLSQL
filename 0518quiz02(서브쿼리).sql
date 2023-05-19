/*���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���*/
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

���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.

SELECT E.*
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE MANAGER_ID = 100);

--TEACHER
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);




���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.

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




���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���

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





/*���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ,
�Ի����� ����ϼ���.*/

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


/*���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����*/

SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,LAST_NAME) AS �̸�, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--TEACHER
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,LAST_NAME) AS �̸�, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


*/���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���*/

SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,LAST_NAME) AS �̸�, E.DEPARTMENT_ID, 
            (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;


/*���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����*/

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



/*���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���*/

SELECT D.*,
            (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID),
            (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID),
            (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID)
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

SELECT STREET_ADDRESS, POSTAL_CODE, CITY FROM LOCATIONS;


/*���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����*/

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




/*���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���*/

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


���ΰ� ��������
���� 12.
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.

--TEACHER : ���� �ʿ��� �� SELECT���� �� -> FROM���� �ְ� ->

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


���� 13.
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID,
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN';

--����
SELECT E.LAST_NAME, E.JOB_ID, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM (SELECT *
            FROM EMPLOYEES E
            WHERE JOB_ID = 'SA_MAN') E
LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;



���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�


SELECT * FROM DEPARTMENTS;
--����

SELECT D.DEPARTMENT_ID,
             D.DEPARTMENT_NAME,
             D.MANAGER_ID,
             E.�����
FROM DEPARTMENTS D
RIGHT JOIN (SELECT DEPARTMENT_ID, 
                              COUNT(*) AS �����
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID IS NOT NULL
                GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.����� DESC;


--�ο���
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
             E.�ο���
FROM DEPARTMENTS D
INNER JOIN (SELECT DEPARTMENT_ID,
                         COUNT(*) AS �ο���
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.�ο��� DESC;






���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
--�μ��� ����� ������ 0���� ����ϼ��� 

--�μ��� ���� ����
SELECT * FROM DEPARTMENTS;

--�ּ�,�����ȣ
SELECT STREET_ADDRESS, POSTAL_CODE FROM LOCATIONS;

--�μ��� ���� ���� + �ּ�,�����ȣ
SELECT D.*, STREET_ADDRESS AS �ּ�, POSTAL_CODE AS �����ȣ
FROM DEPARTMENTS D
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID;

--�μ��� ��� ����
SELECT E.DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS �μ�����տ���
FROM EMPLOYEES E
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY E.DEPARTMENT_ID;

--�μ��� ���� ���� + �ּ�,�����ȣ + �μ��� ��� ����
SELECT D.*, STREET_ADDRESS AS �ּ�, POSTAL_CODE AS �����ȣ, A.*
FROM DEPARTMENTS D
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN (SELECT E.DEPARTMENT_ID, TRUNC(AVG(SALARY)) AS �μ�����տ���
        FROM EMPLOYEES E
        GROUP BY E.DEPARTMENT_ID) A
ON D.DEPARTMENT_ID = A.DEPARTMENT_ID;

--TEACHER -> NVL�� �����.
SELECT D.*,
            NVL(E.SALARY, 0) AS SALARY,
            L.STREET_ADDRESS AS �ּ�, 
            L.POSTAL_CODE AS �����ȣ
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                               TRUNC(AVG(SALARY)) AS SALARY
                 FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID) E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY D.DEPARTMENT_ID DESC;



���� 16
-���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
����ϼ���

--TEACHER

SELECT *
FROM (SELECT ROWNUM RN,
             X.*
                FROM(SELECT D.*,
                                        NVL(E.SALARY, 0) AS SALARY,
                                        L.STREET_ADDRESS AS �ּ�, 
                                        L.POSTAL_CODE AS �����ȣ
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

            





