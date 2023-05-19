--��������
--SELECT���� SELECT�������� ���� ���� : ��Į�� ��������
--SELECT���� FROM�������� ���� ���� : �ζ��κ�
--SELECT���� WHERE�������� ���� : ��������
--���������� �ݵ�� () �ȿ� ������Ѵ�.

--������ �������� - ���ϵǴ� ���� 1���� ��������

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT *
FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID�� 103���� ����� ������ ����
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--��������, ������ �̾�� �Ѵ�. �÷����� 1�� ���� �Ѵ�.
--ERR
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 OR EMPLOYEE_ID = 104);

------------------------------------------------------------------------------------------------------------
--������ �������� - ���� ��������� IN, ANY, ALL�� ����.
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David';

-- in ������ ���� ã�� in (4800, 6800, 9500)
SELECT *
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

--ANY �ּڰ� ���� ŭ, �ִ� ���� ����
SELECT *
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- �޿��� 4800���� ū �����

SELECT *
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- �޿��� 9500���� ���� �����

--ALL �ּڰ� ���� ����, �ִ� ���� ŭ.
SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- �޿��� 9500���� ū �����


SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David'); -- �޿��� 4800���� ���� �����

--������ IT_PROG�� ������� �ּڰ� ���� ū �޿��� �޴� �����
SELECT *
FROM EMPLOYEES
WHERE SALARY >ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');


------------------------------------------------------------------------------------------------------------
--��Į�� ��������
--JOIN�ÿ� Ư�����̺��� 1�÷��� ������ �� �� �����ϴ�.
--�������� ������ ����� �Ҷ��� �����ϴ�
SELECT FIRST_NAME,
             EMAIL,
             (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY FIRST_NAME;
--���� ���� ���
SELECT FIRST_NAME,
             EMAIL,
             DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY FIRST_NAME;

--�� �μ��� �Ŵ��� �̸��� ����ϰ� �ʹ�?
--JOIN
SELECT D.*,
             E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
--��Į��
SELECT D.*,
             (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--��Į�� ���� ������ ����
SELECT * FROM JOBS; --JOB_TILTE
SELECT * FROM DEPARTMENTS; --DEPARTMENT_NAME
SELECT * FROM EMPLOYEES;

SELECT E.FIRST_NAME,
             E.JOB_ID,
             (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_ID,
             (SELECT DEPARTMENT_ID FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_ID
FROM EMPLOYEES E;

--�� �μ��� ��� ���� ��� + �μ����� COUNT?
SELECT DEPARTMENT_ID, COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT D.*,
             NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID GROUP BY DEPARTMENT_ID) , 0) AS �����
FROM DEPARTMENTS D;


------------------------------------------------------------------------------------------------------------
--�ζ��� ��(FROM���� ����)
--��¥ ���̺� ���¸� ���� �װ����� �ҷ��´�. ����Ŭ������ �̰� ������ ���� ���.

--ROWNUM�� ��ȸ�� �����̱� ������, ORDER�� ���� ���Ǹ� ROWNUM ���̴� ����
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
          
          
-- ROWNUM�� ������ 1��°���� ��ȸ���� ��Ÿ����
SELECT FIRST_NAME,
             SALARY,
             ROWNUM
FROM (SELECT FIRST_NAME,
                        SALARY
            FROM EMPLOYEES
            ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 11 AND 20;


--2��° �ζ��κ信�� ROWNUM�� AS�� RN���� �÷�ȭ
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

--�ζ��� ���� ����

SELECT TO_CHAR(REGDATE, 'YY-MM-DD') AS REGDATE,
             NAME
FROM(SELECT 'ȫ�浿' AS NAME, SYSDATE AS REGDATE FROM DUAL
            UNION ALL
            SELECT '�̼���', SYSDATE FROM DUAL);

--�ζ��� ���� ����
--�μ��� �����
SELECT D.*,
             E.TOTAL
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, 
                              COUNT(*) AS TOTAL
                FROM EMPLOYEES
                GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--�μ��� ����� <- ���� ������ ���̺� �ڸ��� ��.
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

--����
--������( ��Һ� ) VS ������ �������� (IN, ANY, ALL)
--��Į������ - SELECT���� �� LEFT JOIN�� ���� ����, �ѹ��� 1���� �÷��� ������ ��
--�ζ��κ� - FROM���� ���� ��¥ ���̺�, ���� ���� �غ����Ѵ�.

                        
            
            
            
            



