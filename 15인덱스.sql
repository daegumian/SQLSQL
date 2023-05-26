--������ (���������� �����ϴ� �� ) - pk�� ���� ����

SELECT * FROM USER_SEQUENCES;

--����� ������ ���� (���̺��_SEQ)
CREATE SEQUENCE  DEPTS_SEQ
        START WITH 1
        INCREMENT BY 1
        MAXVALUE 10
        MINVALUE 1
        NOCACHE
        NOCYCLE;

--������ ���� (��, ���ǰ� �ִ� ��������� ����)
DROP SEQUENCE DEPTS_SEQ;

DROP TABLE DEPTS;

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS WHERE 1=2);
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID);


SELECT * FROM DEPTS;

--������ ���
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; --�������� ������ (����)
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --�������� ���簪

INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL ,'TEST', 100, 1000 ); -- X10 (���������� �ִ� �����ϸ� ���̻� ��� X

--������ ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

--������ ���� ����(�⺻�ɼ����� ����)
CREATE SEQUENCE DEPTS2_SEQ NOCACHE;
SELECT * FROM user_sequences;


--������ �ʱ�ȭ (�������� ���̺��� ���ǰ� �ִ� ����, �������� DROP�ϸ� �ȵ�.)
-- 1. ��������� Ȯ��
DROP SEQUENCE DEPTS_SEQ;
CREATE SEQUENCE DEPTS_SEQ NOCACHE;
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
-- 2. �������� ������ ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -39; --���� ������ -1 ����
-- 3. ������ ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--������ �������� �ٽ� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--���ĺ��� �������� 2���� ����.....

--������ VS ������ ������ �ʱ�ȭ VS ������ ���ڿ�
--20220523-00001-��ǰ��ȣ
CREATE TABLE DEPTS3(
        DEPT_NO VARCHAR2(30) PRIMARY KEY,
        DEPT_NAME VARCHAR2(30)
);
CREATE SEQUENCE DEPTS3_SEQ NOCACHE;
--TO_CHAR(SYSDATE, 'YYYYMMDD'), LPAD(�ڸ���, 'ä�ﰪ')
--INSERT INTO DEPTS3 VALUES (TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || TO_CHAR(DEPTS3_SEQ.NEXTVAL)|| '-' ||'��ǰ��ȣ', 'TEST');
INSERT INTO DEPTS3 
VALUES (TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(DEPTS3_SEQ.NEXTVAL, 5, '0')|| '-' ||'��ǰ��ȣ', 'TEST');

SELECT * FROM DEPTS3;

SELECT  TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || LPAD(DEPTS3_SEQ.NEXTVAL, 5, '0')|| '-' ||'��ǰ��ȣ' FROM DUAL;

------------------------------------------------------------------------------------------------------------------------------------
--INDEX
--�ε����� PK, UK���� �ڵ������Ǵ� UNIQUE�ε����� �ִ�.
--�ε����� ������ ��ȸ�� ������ ���ִ� HINT������ �Ѵ�.
--���� ������� �ʴ� �Ϲ��÷��� �ε����� ������ �� �ִ�.

CREATE TABLE EMPS_IT AS (SELECT *FROM EMPLOYEES WHERE 1=1);
--�ε����� ���� �� ��ȸ VS �ε��� ���� �� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan';
--�ε������� (�ε����� ��ȸ�� ������ �ϱ� ������, ������ �ϰ� ���� �����ϸ�, ������ ������ ������ �� �ִ�)
CREATE UNIQUE INDEX  EMPS_IT_IDX ON EMPS_IT ( FIRST_NAME); --����ũ�ε���(�÷����� �����ؾ���=�ߺ��� �÷����� ������ �ȵȴ�.) 
--�ε��� ����
DROP INDEX EMPS_IT_IDX;
--�ε����� (�����ε���) �����÷��� ������ �� �ִ�.
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan'; --�ε��� �����
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen'; --�ε��� �����, �ٵ� LAST_NAME ���� �ϸ� �ȵ�.

--FIRST_NAME �������� ����
--�ε����� �������� ��Ʈ�� �ִ� ��� /*+ INDEX_ASC(DESC) (�÷��� �ε�����) */
SELECT *
FROM (SELECT  /*+ INDEX_DESC (E EMPS_IT_IDX) */ --���� �־����.
             ROWNUM RN,
             E.*
FROM EMPS_IT E
ORDER BY FIRST_NAME DESC)
WHERE RN > 10 AND RN <= 20;














