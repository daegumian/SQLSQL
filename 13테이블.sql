--DDL�� CREATE, ALTER, DROP
--����Ŭ ��ǥ ������ Ÿ�� (VACHAR2(SIZE) - ��������, CHAR - ��������, NUMBER - ����, DATE - ��¥)

CREATE TABLE DEPT2 (
            DEPT_NO NUMBER(2), --�ڸ���
            DEPT_NAME VARCHAR2(20), -- �ִ� 20����Ʈ, ����������
            DEPT_YN CHAR(1), -- 1BYTE ����������, ���� ���, Y OR N���� �ѱ��ڸ� ���� �÷� ���� �� ȿ����!
            DEPT_DATE DATE,
            DEPT_BOBUS NUMBER(10, 3) -- 10�ڸ�, �Ҽ��� 3�ڸ�
);

DESC DEPT2;

INSERT INTO DEPT2 VALUES(99, 'SALES', 'Y', SYSDATE, 3.14);
INSERT INTO DEPT2 VALUES(98, 'SALES', 'ȫ', SYSDATE, 3.14); --�ѱ��� 2BYTE�� CHAR(1)�� ����. �������Է� X

SELECT * FROM DEPT2;

COMMIT;

---------------------------------------------------------------------------------------------------
--���߰�
ALTER TABLE DEPT2 ADD (DEPT_COUNT NUMBER(3) );

--�� �̸� ����
ALTER TABLE DEPT2 RENAME COLUMN DEPT_COUNT TO EMP_COUNT;

--�� ���� (Ÿ�Ժ���)
ALTER TABLE DEPT2 MODIFY (EMP_COUNT NUMBER(10));

--�� ����
ALTER TABLE DEPT2 DROP COLUMN EMP_COUNT;

SELECT * FROM DEPT2;

--���̺� ����
DROP TABLE DEPT2; --
--DROP TABLE DEPT2 CASCADE �������Ǹ� ; -- ��������FK�� ����, ���̺� ����.

---------------------------------------------------------------------------------------------------
--��������
--������ ��������(���̺� ���� ��ÿ� �� ���� ���´�)
SELECT * FROM user_constraints;

--�������� �̸��� �ڵ� �����ȴ�.
CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2)             PRIMARY KEY, 
    DEPT_NAME VARCHAR2(20)    NOT NULL,
    DEPT_DATE DATE                   DEFAULT SYSDATE, -- ��������X, (�÷��� �⺻��) 
    DEPT_PHONE VARCHAR2(20)   UNIQUE,
    DEPT_BONUS NUMBER(10)      CHECK(DEPT_BONUS > 0),
    LOCA NUMBER(4)                   REFERENCES LOCATIONS(LOCATION_ID) --FK
);

--�������� �̸��� ���� CONSTRAINT ~~ ��������
CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2)             CONSTRAINT DEPT2_PK PRIMARY KEY, 
    DEPT_NAME VARCHAR2(20)    CONSTRAINT DEPT2_NAME_NN NOT NULL,
    DEPT_DATE DATE                   DEFAULT SYSDATE, -- ��������X, (�÷��� �⺻��) 
    DEPT_PHONE VARCHAR2(20)   CONSTRAINT DEPT2_PHONE_UK UNIQUE,
    DEPT_BONUS NUMBER(10)      CONSTRAINT DEPT2_BONUS_CK CHECK(DEPT_BONUS > 0),
    LOCA NUMBER(4)                   CONSTRAINT DEPT2_LOCA_FK  REFERENCES LOCATIONS(LOCATION_ID) --FK
);
DROP TABLE DEPTS2;

--���̺� ���� �������� (����Ű��, ���� FK�� ������ ����)

CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2),            
    DEPT_NAME VARCHAR2(20)     NOT NULL,
    DEPT_DATE DATE                   DEFAULT SYSDATE, -- ��������X, (�÷��� �⺻��) 
    DEPT_PHONE VARCHAR2(20),   
    DEPT_BONUS NUMBER(10),     
    LOCA NUMBER(4),
    CONSTRAINT DEPT_PK PRIMARY KEY (DEPT_NO /*,DEPT_NAME*/),
    CONSTRAINT DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
    CONSTRAINT DEPT_BONUS_CK CHECK (DEPT_BONUS > 0),
    CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID)
    );
   



SELECT * FROM DEPTS2;

DESC DEPTS2;
INSERT INTO DEPTS2 VALUES(10, 'HOING', SYSDATE, '010...', 10000, 1000); --PK�� NULL���� �� �� ����
INSERT INTO DEPTS2 VALUES(10, 'HOING', SYSDATE, '010...', 10000, 1000); --��ü ���Ἲ(NULL�� �ߺ����� ������� �ʴ´�.)

--�������Ἲ(�������̺��� PK�� �ƴ� ���� FK�� �� �� ����)
--500�� LOCATIONS�� PK�� �ƴ�
INSERT INTO DEPTS2 VALUES(20, 'HOING', SYSDATA, '0101111111', 10000, 500);
--������ ���Ἲ(���� �������� ���ǵ� ���̾�� �Ѵ�)
INSERT INTO DEPTS2 VALUES(30, 'HONG', SYSDATE, '01010123', -10000, 1000);



---------------------------------------------------------------------------------------------------
--���������� �߰� OR ����
SELECT * FROM DEPTS2;

CREATE TABLE DEPTS2 (
    DEPT_NO NUMBER(2),            
    DEPT_NAME VARCHAR2(20),
    DEPT_DATE DATE                   DEFAULT SYSDATE, -- ��������X, (�÷��� �⺻��) 
    DEPT_PHONE VARCHAR2(20),   
    DEPT_BONUS NUMBER(10),     
    LOCA NUMBER(4)
--    CONSTRAINT DEPT_PK PRIMARY KEY (DEPT_NO /*,DEPT_NAME*/),
--    CONSTRAINT DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
--    CONSTRAINT DEPT_BONUS_CK CHECK (DEPT_BONUS > 0),
--    CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID)
    );

--���������� ������ ����.
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_PK PRIMARY KEY (DEPT_NO);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_BONUS_CK CHECK (DEPT_BONUS > 0 );
ALTER TABLE DEPTS2 ADD CONSTRAINT DEPT_LOCA_FK FOREIGN KEY (LOCA) REFERENCES LOCATIONS (LOCATION_ID);
--NOT NULL�� MODIFIY �������� �����Ѵ�
ALTER TABLE DEPTS2 MODIFY DEPT_NAME VARCHAR2(20) NOT NULL;
--�������� ����
ALTER TABLE DEPTS2 DROP CONSTRAINT SYS_C007032;

--���콺�� ������ ���� ����!
CREATE TABLE DEPT2 
(
  DEPT_NO NUMBER(2) NOT NULL 
, DEPT_NAME VARCHAR2(20) NOT NULL 
, DEPT_DATE DATE DEFAULT SYSDATA 
, DEPT_PHONE VARCHAR2(20) 
, DEPT_BONUS NUMBER(10) 
, LOCA NUMBER(4) 
, CONSTRAINT DEPT2_PK PRIMARY KEY ( DEPT_NO ) ENABLE );

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_UK1 UNIQUE (DEPT_PHONE) ENABLE;

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_FK1 FOREIGN KEY(LOCA) REFERENCES LOCATIONS(LOCATION_ID) ENABLE;

ALTER TABLE DEPT2 ADD CONSTRAINT DEPT2_CHK1 CHECK  (DEPT_BONUS > 0) ENABLE;


-------------------------------------------------------------------------------------------------------------------------------------
--��������
/*���� 1.
������ ���� ���̺��� �����ϰ� �����͸� insert�ϼ��� (Ŀ��)
����) M_NAME �� ����������, �ΰ��� ������� ����
����) M_NUM �� ������, �̸�(mem_memnum_pk) primary key
����) REG_DATE �� ��¥��, �ΰ��� ������� ����, �̸�:(mem_regdate_uk) UNIQUEŰ
����) GENDER ���������� 1�� 'M' OR 'F'�� �� �� �ְ�
����) LOCA ������, �̸�:(mem_loca_loc_locid_fk) foreign key ? ���� locations���̺�(location_id)
���� 2.
MEMBERS���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� m_name, m_mum, street_address, location_id
�÷��� ��ȸ
m_num�������� �������� ��ȸ*/

--��
CREATE TABLE PARK 
(
  M_NAME VARCHAR2(20) NOT NULL
, M_NUM NUMBER(10) CONSTRAINT mem_memnum_pk PRIMARY KEY
, REG_DATE DATE DEFAULT SYSDATE  CONSTRAINT mem_regdate_uk UNIQUE NOT NULL 
, GENDER VARCHAR2(20) CHECK (GENDER = 'F' OR GENDER ='M')
, LOCA NUMBER(4)  CONSTRAINT mem_loca_loc_locid_fk REFERENCES LOCATIONS(LOCATION_ID)
);

DESC PARK;
SELECT * FROM PARK;

INSERT INTO PARK VALUES ('AAA', 1, '2018-07-01', 'M', 1800);
INSERT INTO PARK VALUES ('BBB', 2, '2018-07-02', 'F', 1900);
INSERT INTO PARK VALUES ('CCC', 3, '2018-07-03', 'M', 2000);
INSERT INTO PARK VALUES ('DDD', 4, SYSDATE, 'M', 2000);

/*���� 2.
PARK���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� m_name, m_Num, street_address, location_id
�÷��� ��ȸ
m_num�������� �������� ��ȸ*/

SELECT P.M_NAME, P.M_NUM, L.STREET_ADDRESS, L.LOCATION_ID
FROM PARK P
JOIN LOCATIONS L
ON P.LOCA = L.LOCATION_ID
ORDER BY P.M_NUM;


















