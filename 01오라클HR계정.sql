-- ����Ŭ �ּ���
/* 
������ �ּ�
����ū ��ҹ��� ���� X

*/
SELECT * from employees;
SELECT FIRST_name, email, hire_date From employees;
SELECT job_id, salary, department_id From employees;

SELECT * from departments;

--����
--�÷��� ��ȸ�ϴ� ��ġ���� * / +-
SELECT first_name, salary, salary + salary * 0.1 from employees;

--null
select first_name, commission_pct From employees;

--����� as
select first_name AS �̸�, 
       lasT_name AS ��, 
       SALARY �޿�, 
       SALARY + SALARY * 0.1 �ѱ޿� 
FROM employees;

--���ڿ��� ���� ||
--����Ŭ�� ���ڸ� ''�� ǥ��, ���ڿ� �ȿ��� '�� ����ϰ� ������ �ι� ���� ��.''
SELECT FIRST_NAME ||' '|| LAST_NAME || '''s IS salary $' || SALARY AS �޿�����
FROM employees;

--DISTINCT �ߺ��� ����
SELECT DISTINCT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES;

--ROWID(�������� �ּ�), ROWNUM(��ȸ�� ����)
SELECT ROWNUM, ROWID, EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES;

--WHERE ������ �����ϴ� ���� ���Ǹ� ����



