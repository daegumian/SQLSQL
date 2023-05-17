--����ȯ �Լ�
--�ڵ� ����ȯ
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; -- �ڵ� ����ȯ (����->����)
SELECT SYSDATE - 5, SYSDATE - '5' FROM employees; --�ڵ� ����ȯ (����->����)

--���� ����ȯ
--TO_CHAR(��¥, ��¥ ����)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS') FROM DUAL; --���ڷ�
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS') FROM DUAL; --����
SELECT TO_CHAR(SYSDATE, 'YYYY"��"MM"��"DD"��"') FROM DUAL; --���˹��ڰ� �ƴ� ���� ""�� ����
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS ��¥ FROM EMPLOYEES;

--TO_CHAR(����, ��������)
SELECT TO_CHAR(200000, '$999,999,999.00') FROM DUAL;
SELECT TO_CHAR(200000.1234, '999999.999') FROM DUAL; --�Ҽ��� �ڸ� ǥ��
SELECT FIRST_NAME, TO_CHAR( SALARY/12 * 1300, 'L999,999,999') FROM EMPLOYEES; --����ȭ��
SELECT FIRST_NAME, TO_CHAR( SALARY * 1300, 'L0999,999,999') FROM EMPLOYEES; --�ڸ����� 0���� ä��

--TO_NUMBER(����, ��������)
SELECT '3.15' + 2000 FROM DUAL; --�ڵ�����ȯ
SELECT TO_NUMBER('3.14') FROM DUAL; --����� ����ȯ ���� ����ȯ
SELECT TO_NUMBER('$3,300', '$999,999') + 2000 FROM DUAL; --���� ����ȯ

--TO_DATE(����, ��¥����)
SELECT '2023-05-16' - SYSDATE FROM DUAL;
SELECT  SYSDATE - TO_DATE('2023-05-16', 'YYYY-MM-DD')FROM DUAL; --��¥�� ���� ����ȯ
SELECT SYSDATE - TO_DATE('2023/05/16 11:31:23', 'YYYY/MM/DD HH:MI:SS') FROM DUAL;

--�Ʒ����� YYYY�� MM�� DD�� ���·� ���
SELECT '20050105' FROM DAUL;
SELECT TO_CHAR((TO_DATE('20050105')), 'YYYY"��"MM"��"DD"��"') FROM DUAL;
--TEACHER
SELECT TO_CHAR((TO_DATE('20050105', 'YYYYMMDD')), 'YYYY"��"MM"��"DD"��"') FROM DUAL; --����

--�Ʒ� ���� ���� ��¥�� �ϼ� ���̸� ���ϤĿ�
SELECT '2005��01��05��' FROM DUAL;
SELECT SYSDATE - TO_DATE(REPLACE('2005��01��05��', '2005��01��05��', '2005/01/05')) FROM DUAL; --1��
SELECT SYSDATE - TO_DATE('2005��01��05��', 'YYYY"��"MM"��"DD"��"') FROM DUAL; --2��
--TEACHER
SELECT SYSDATE - TO_DATE('2005��01��05��', 'YYY"��"MM"��"DD"��"') FROM DUAL; --2���̶� ����

-------------------------------------------------------------------------------------------
--NULL���� ���� ��ȯ 
--NVL(�÷�, NULL�� ��� ó��)
SELECT NVL(NULL, 0) FROM DUAL;
SELECT FIRST_NAME, COMMISSION_PCT*100 FROM EMPLOYEES; --NULL������ => NULL
SELECT FIRST_NAME, NVL(COMMISSION_PCT, 0) * 100 FROM EMPLOYEES;

--NVL(�÷�, NULL�� �ƴѰ�� ó��, NULL�� ���ó��)
SELECT NVL2(NULL, '���� �ƴմϴ�', '���Դϴ�') FROM DUAL;
SELECT SALARY,
       COMMISSION_PCT,
       NVL2(COMMISSION_PCT, (SALARY * (COMMISSION_PCT+1)), SALARY)AS �޿�  FROM EMPLOYEES; --�� ������ ���ΰ�

--DECODE(COLUMN, ��, ���) - ELSE IF���� ��ü�ϴ� �Լ�
SELECT DECODE('D', 'A', 'A�Դϴ�.', 
                   'B', 'B�Դϴ�.',
                   'C', 'C�Դϴ�.', 
                   'ABC�� �ƴմϴ�.') FROM DUAL;

SELECT JOB_ID, SALARY, DECODE(JOB_ID, 'IT_PROG', SALARY * 0.3,
                      'FI_MGR', SALARY * 0.2,
                      SALARY) AS ���ʽ��޿� 
FROM EMPLOYEES;
--CASE WHEN THEN ELSE
--1ST
SELECT JOB_ID,
        CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 0.3
                    WHEN 'FI_MGR' THEN SALARY * 0.2
                    ELSE SALARY
                    END
FROM EMPLOYEES;

--2ND (��Һ� OR �ٸ� �÷��� �� ����)
SELECT JOB_ID, FIRST_NAME,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 0.3
            WHEN JOB_ID = 'FI_MGR' THEN SALARY * 0.2
            WHEN FIRST_NAME = 'Steven' THEN SALARY * 0
            ELSE SALARY
       END AS�޿�
FROM EMPLOYEES;

--COALESCE(A, B) - NVL�̶� ����
SELECT COALESCE(COMMISSION_PCT, 0) FROM EMPLOYEES; --ǥ���� NULL�̸� 0�� ��ȯ.

------------------------------------------------------------------------
/*���� 1.
�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������.
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�*/
SELECT (SYSDATE - HIRE_DATE)/365 FROM EMPLOYEES;
SELECT employee_id AS �����ȣ, FIRST_NAME AS �̸�, HIRE_DATE AS �Ի�����, 
            TRUNC((SYSDATE - HIRE_DATE)/365,0) AS �ټӿ���
            FROM EMPLOYEES WHERE TRUNC((SYSDATE - HIRE_DATE)/365,0) >= 20 ORDER BY (SYSDATE - HIRE_DATE)/356 DESC;
--TEACHER
SELECT EMPLOYEE_ID AS �����ȣ, 
       FIRST_NAME || ' ' || LAST_NAME AS �̸�, 
       HIRE_DATE AS �Ի�����,
       TRUNC((SYSDATE - HIRE_DATE)/365) AS �ټӳ��
FROM EMPLOYEES 
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10 -- �� �࿡ �´� ���Ǹ� ����
ORDER BY  �ټӳ�� DESC;
            
/*���� 2.
EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������,
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) manager_id�� 50�� ������� ������θ� ��ȸ�մϴ�*/
SELECT MANAGER_ID,DEPARTMENT_ID FROM EMPLOYEES;
SELECT FIRST_NAME, MANAGER_ID,
                    CASE WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 100 THEN '���'
                         WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 120 THEN '����'
                         WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 121 THEN '�븮'
                         WHEN DEPARTMENT_ID = 50 AND MANAGER_ID = 122 THEN '����'
                         ELSE '�ӿ�'
                         END
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50 ORDER BY MANAGER_ID DESC;

--TEACHER
SELECT FIRST_NAME,
       MANAGER_ID,
       DECODE(MANAGER_ID, 100, '���',
                          120, '����',
                          121, '�븮',
                          122, '����',
                          '�ӿ�') AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;






