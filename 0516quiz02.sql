--���� 1. EMPLOYEES ���̺����� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�.
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�.
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)

SELECT RPAD(SUBSTR(FIRST_NAME,1,3), 10, '*') AS name, lPAD(SALARY, 10, '*') AS salary FROM EMPLOYEES WHERE LOWER(JOB_ID) = 'it_prog';

--���� 1.
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
SELECT CONCAT(FIRST_NAME,LAST_NAME), REPLACE(HIRE_DATE,'/','') AS �Ի����� FROM EMPLOYEES ORDER BY FIRST_NAME ASC;
---TEACHER--
SELECT CONCAT(FIRST_NAME, ' ' || LAST_NAME),
       REPLACE(HIRE_DATE, '/', '') AS HIRE_DATE
FROM EMPLOYEES;
--���� 2.
--EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
SELECT CONCAT('(O2)',(SUBSTR(PHONE_NUMBER,4,15))) AS ��ȭ��ȣ FROM EMPLOYEES;
--TEACHER--
SELECT '(02)'||SUBSTR(PHONE_NUMBER, INSTR(PHONE_NUMBER, ','), LENGTH(PHONE_NUMBER) ) AS RESULT
FROM EMPLOYEES;

--���� 3.
--EMPLOYEES ���̺����� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�.
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�.
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
SELECT RPAD(SUBSTR(FIRST_NAME,1,3), 10, '*') AS name, 
       lPAD(SALARY, 10, '*') AS salary 
FROM EMPLOYEES WHERE LOWER(JOB_ID) = 'it_prog';
--TEACHER--
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE LOWER(JOB_ID) = 'it_prog';