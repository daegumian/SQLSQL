--Ʈ�����  (���� �۾�����)

SHOW AUTOCOMMIT;
--����Ŀ�� �ѱ�
SET AUTOCOMMIT ON;
--����Ŀ�� ����
SET AUTOCOMMIT OFF;

DELETE FROM DEPTS;
ROLLBACK;
SELECT * FROM DEPTS;

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 10;

SAVEPOINT DELETE10; -- ���̺�����Ʈ ���

DELETE FROM DEPTS WHERE DEPARTMENT_ID = 20;

SAVEPOINT DELETE20; --���̺�����Ʈ ���

ROLLBACK TO DELETE10;

ROLLBACK; --������ Ŀ�� ����

SELECT * FROM DEPTS;

---------------------------------------------------------------------------------------------
INSERT INTO DEPTS VALUES(300, 'DEMO', NULL, 1800);

COMMIT; --������ �ݿ�

SELECT * FROM DEPTS;






