--�׷��Լ�
--AVG, SUM, MIN, MAX, COUNT
SELECT AVG(SALARY), SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE) FROM EMPLOYEES;
SELECT MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

--COUNT(�÷�) : NULL�� �ƴ� ������ ����
--COUNT(*) : ��ü���� ����
SELECT COUNT(FIRST_NAME) FROM EMPLOYEES;
SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES;
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;
SELECT COUNT(*) FROM EMPLOYEES;

--------------���� ����------------------
--�׷��Լ� : �׷��Լ��� �Ϲ��÷��� ���ÿ� ����� �� ����. (����Ŭ��) 
SELECET FIRST_NAME,  SUM(SALARY) FROM EMPLOYEES; --SUM()�� �׷� �Լ�

------------------------------------------------------------------------------------------------------------------
SELECT DEPARTMENT_ID,  ROUND(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

--�������� ( �׷����� ����� �÷���, SELECT���� ����մϴ�)
SELECT DEPARTMENT_ID --, FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --ERR

--2�� �̻��� �׷�ȭ
SELECT DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

--�׷��Լ��� WHERE�� ������ �� ����.
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE AVG(SALARY) >= 1000 --< �̰� �Ұ��� / DEPARTMENT_ID = 50 <- �̰� ����
GROUP BY JOB_ID;

---------------------------------------------------------------------------------------------------------------------------
--�׷��� ������ HAVING���� ���
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),2)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 8000;

SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) >= 10000;

SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 30;

SELECT JOB_ID, SUM(SALARY), SUM( NVL(COMMISSION_PCT, 0))
FROM EMPLOYEES
WHERE JOB_ID NOT IN('IT_PROG')
GROUP BY JOB_ID
HAVING SUM(SALARY) >= 20000
ORDER BY SUM(SALARY) DESC;

--�μ� ���̵� 50�� �̻��� �μ��� �׷�ȭ ��Ű�� �׷� ��� �޿� 5000�̻� ���
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY))
FROM EMPLOYEES
WHERE DEPARTMENT_ID >= 50
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000
ORDER BY DEPARTMENT_ID;
--TEACHER
SELECT DEPARTMENT_ID, SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID >= 50
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 5000;

---------------------------------------------------------------------------------------------------------------------------
--ROLLUP - �� �׷��� �Ѱ踦 �Ʒ��� ���
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID);


SELECT DEPARTMENT_ID, JOB_ID, TRUNC(SUM(SALARY))
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);

--CUBE -����׷쿡 ���� �÷����
SELECT DEPARTMENT_ID, JOB_ID, TRUNC(SUM(SALARY))
FROM EMPLOYEES
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;

--GROUPING
SELECT DEPARTMENT_ID, 
             JOB_ID,
             DECODE(GROUPING(JOB_ID), 1 , '�Ұ�', JOB_ID) AS A,
             GROUPING(DEPARTMENT_ID),
             GROUPING(JOB_ID),
             SUM(SALARY), 
             COUNT(*)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;
---------------------------------------------------------------------------------------------------------------------------
/*���� 1.
��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���*/
SELECT JOB_ID, COUNT(*)AS �����, AVG(SALARY)AS �������
FROM EMPLOYEES
GROUP BY JOB_ID, ROLLUP (SALARY)
ORDER BY SALARY DESC;

--���� ***�ٽ� �غ���***
/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���
*/
SELECT HIRE_DATE, COUNT(*)AS �����
CASE HIRE_DATE WHEN '01%' THEN HIRE_DATE
                    WHEN '02%' THEN HIRE_DATE
                    WHEN '03%' THEN HIRE_DATE
                    WHEN '04%' THEN HIRE_DATE
                    WHEN '05%' THEN HIRE_DATE
                    WHEN '06%' THEN HIRE_DATE
                    WHEN '07%' THEN HIRE_DATE
                    WHEN '08%' THEN HIRE_DATE
                    ELSE HIRE_DATE
                    END 
FROM EMPLOYEES
GROUP BY HIRE_DATE;
--TEACHER
SELECT TO_CHAR(HIRE_DATE, 'YY'), COUNT(*) -- �װ͸� �̾Ƽ� �ű⼭ ã�ڵ�.
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');



/*--���� 3.
�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���*/
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
WHERE SALARY >=1000
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >=2000;


--TEACHER
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING  TRUNC(AVG(SALARY)) >= 2000;

--����4 ����
/*���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.*/
SELECT DEPARTMENT_ID, 
             COMMISSION_PCT, 
             TRUNC(AVG((SALARY) * (COMMISSION_PCT+1)), 2)AS ��տ���, 
             SUM(SALARY + SALARY * COMMISSION_PCT) AS �޿���,
            COUNT(*)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY ROLLUP(DEPARTMENT_ID,COMMISSION_PCT);

--TEACHER
SELECT DEPARTMENT_ID,
            TRUNC(AVG(SALARY + SALARY * COMMISSION_PCT),2) AS �޿� ���,
            SUM(SALARY + SALARY * COMMISSION_PCT) AS �޿���,
            COUNT(*)AS �����
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENET_ID;


--����5
--������ ������, ���հ踦 ����ϼ���
SELECT JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;


--TEACHER
SELECT DECODE(GROUPING(JOB_ID),  1, '�հ�', JOB_ID) AS JOB_ID,
            SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);



--����6
/*���� 6.
�μ���, JOB_ID�� �׷��� �Ͽ�
��Ż, �հ踦 ����ϼ���.
GROUPING() �� �̿��Ͽ�
�Ұ� �հ踦 ǥ���ϼ���*/

SELECT DECODE(GROUPING(DEPARTMENT_ID), 1 , '�հ�', DEPARTMENT_ID)AS DEPARTMENT_ID,
             DECODE(GROUPING(JOB_ID), 1 , '�Ұ�', JOB_ID)AS JOB_ID,
             COUNT(*)AS TOTAL, 
             SUM(SALARY)AS SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID,JOB_ID)
ORDER BY SUM ASC;

--TEACHER
SELECT DECODE(GROUPING(DEPARTMENT_ID), 1 , '�հ�', DEPARTMENT_ID)AS DEPARTMENT_ID,
            DECODE(GROUPING(JOB_ID), 1 , '�Ұ�', JOB_ID)AS JOB_ID,
            COUNT(*), 
            SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);









