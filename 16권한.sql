
--1. USER ����
CREATE USER USER01 IDENTIFIED BY USER01; --���̵� USER01, ��й�ȣ USER01

--2. USER ���Ѻο�
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO USER01;

--3. ���̰� �����Ǵ� �������ΰ��� (���̺����̽� ����)
--ALTER USER ������ DEFAULT TABLESPACE ���̺����̽��� QUOTA LIMITED ON ���̺����̽���
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--4. ���� ���� (���̺� ���� -> ������ ���� -> ~~~����)
DROP USER USER01 CASCADE;

-------------------------------------------------------------------------------------------------------------------------------------
--ROLE�� �̿��� ��������
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT /* DBA */ TO USER01;

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--��й�ȣ ���湮
ALTER USER USER01 IDENTIFIED BY 1234;

-------------------------------------------------------------------------------------------------------------------------------------
--���콺�� �����ϱ�
--1. ���̺����̽� ���� > ���� > DBA
--1. DAB���� ������ > �ٸ� ����� > ����� ����








