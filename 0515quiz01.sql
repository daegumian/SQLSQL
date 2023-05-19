SELECT * FROM EMPLOYEES;
--1. ��� ����� �����ȣ, �̸�, �Ի���, �޿��� ����ϼ���.
SELECT employee_id, FIRST_NAME, hire_date, salary FROM EMPLOYEES;
--2. ��� ����� �̸��� ���� �ٿ� ����ϼ���. �� ��Ī�� name���� �ϼ���.
SELECT FIRST_NAME||' '||LAST_NAME FROM EMPLOYEES;
--3. 50�� �μ� ����� ��� ������ ����ϼ���.
SELECT * FROM EMPLOYEES WHERE department_id = 50;
--4. 50�� �μ� ����� �̸�, �μ���ȣ, �������̵� ����ϼ���.
SELECT FIRST_NAME, DEPARTMENT_ID, JOB_ID FROM EMPLOYEES;
--5. ��� ����� �̸�, �޿� �׸��� 300�޷� �λ�� �޿��� ����ϼ���.
SELECT FIRST_NAME, salary+300 FROM EMPLOYEES; 
--6. �޿��� 10000���� ū ����� �̸��� �޿��� ����ϼ���.
SELECT * FROM EMPLOYEES WHERE SALARY >10000;
--7. ���ʽ��� �޴� ����� �̸��� ����, ���ʽ����� ����ϼ���.
SELECT FIRST_NAME, JOB_ID, COMMISSION_PCT FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
--8. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(BETWEEN ������ ���)
SELECT FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '2003/01/01' AND '2003/12/31';
--9. 2003�⵵ �Ի��� ����� �̸��� �Ի��� �׸��� �޿��� ����ϼ���.(LIKE ������ ���)
SELECT FIRST_NAME, HIRE_DATE, SALARY FROM EMPLOYEES WHERE HIRE_DATE LIKE '03/_____';
--10. ��� ����� �̸��� �޿��� �޿��� ���� ������� ���� ��������� ����ϼ���.
SELECT FIRST_NAME,SALARY FROM EMPLOYEES ORDER BY SALARY DESC;
--11. �� ���Ǹ� 60�� �μ��� ����� ���ؼ��� �����ϼ���. (�÷�: department_id)
SELECT FIRST_NAME,SALARY,department_id FROM EMPLOYEES WHERE department_id = 50 ORDER BY SALARY DESC;
--12. �������̵� IT_PROG �̰ų�, SA_MAN�� ����� �̸��� �������̵� ����ϼ���.
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'SA_MAN';
--13. Steven King ����� ������ ��Steven King ����� �޿��� 24000�޷� �Դϴ١� �������� ����ϼ���.
SELECT ''''||first_name||' '||last_name||'����� �޿���'||SALARY ||'�޷� �Դϴ�'''
FROM EMPLOYEES WHERE First_NAME = 'Steven' and last_name = 'King';
--14. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� ����ϼ���. (�÷�:job_id)
select FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%';
--15. �Ŵ���(MAN) ������ �ش��ϴ� ����� �̸��� �������̵� �������̵� ������� ����ϼ���
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES ORDER BY JOB_ID ASC;