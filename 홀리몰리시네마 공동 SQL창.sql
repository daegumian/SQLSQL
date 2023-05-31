CREATE TABLE HMEMBER (
	HID	VARCHAR2(100)	CONSTRAINT HID_PK PRIMARY KEY,
	HNAME	VARCHAR2(100) NOT NULL,	
	HPHONE	VARCHAR2(100) NOT NULL,	
	HADDRESS	VARCHAR2(100) NOT NULL
);

SELECT * FROM HMEMBER;
SELECT * FROM MOVIE;

INSERT INTO HMEMBER VALUES('PARKDONG', '�ڵ���', '010-1234-5678', '���');
INSERT INTO HMEMBER VALUES('PARKSU', '�ڼ���', '010-1234-5678', '����');
INSERT INTO HMEMBER VALUES('KIMMIN', '���ö', '010-1234-5678', '�λ�');
INSERT INTO HMEMBER VALUES('KIMHYE', '������', '010-1234-5678', '�뱸');
INSERT INTO HMEMBER VALUES('PARKIN', '���ο�', '010-1234-5678', '����');
INSERT INTO HMEMBER VALUES('IU', '������', '010-1234-5678', '����');
INSERT INTO HMEMBER VALUES('NEWJEANS', '����', '010-1234-5678', '����');
INSERT INTO HMEMBER VALUES('KIMTAERI', '���¸�', '010-1234-5678', '����');
INSERT INTO HMEMBER VALUES('HOLY', '����', '010-1234-5678', '����');
INSERT INTO HMEMBER VALUES('MOLY', 'Ȧ��', '010-1234-5678', '��ô');

ALTER TABLE HMEMBER RENAME COLUMN HADDRESS TO HPW;

--EX2 �츮�� �ƴ� WHERE���� ���� ���� �� �� �� �ִ�.
UPDATE HMEMBER
SET COMMISSION_PCT = 0.1
WHERE HPW '��ô';

--EX3 : ID 200�� ����� 200�� �޿��� 103���� �����ϰ� ���� (��������)
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

CREATE TABLE SEAT (    --�¼� ���λ������̺�
    SERINUM  VARCHAR2(30) CONSTRAINT SEAT_SERINUM_PK PRIMARY KEY, 
    SEATNUM VARCHAR2(100),
    THEANUM VARCHAR2(100) CONSTRAINT SEAT_THEANUM_FK REFERENCES THEATER(THEANUM)
);

CREATE SEQUENCE SEAT_SEQ NOCACHE;

INSERT INTO seat VALUES (seat_seq.nextval, 'A-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'A-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'B-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'C-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'D-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'E-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'F-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'G-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'H-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'I-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'J-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'K-10', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-1', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-2', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-3', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-4', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-5', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-6', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-7', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-8', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-9', '1��');
INSERT INTO seat VALUES(seat_seq.nextval, 'L-10', '1��');
SELECT * FROM SEAT;

COMMIT;

CREATE TABLE TICKETLIST (  --���ų��� ���λ������̺�
    TLSERIAL NUMBER(38) CONSTRAINT TICKETLIST_PK PRIMARY KEY,
    TICKNO VARCHAR2(100) CONSTRAINT TICKETLIST_TICKET_FK REFERENCES TICKETING(TICKNO),
    MEMID VARCHAR2(100) CONSTRAINT TICKETLIST_HMEMBER_FK REFERENCES HMEMBER(MEMID),
    SEATNUM VARCHAR2(100)
);

CREATE SEQUENCE TICKLIST_SEQ NOCACHE;

INSERT INTO TICKETLIST VALUES (TICKLIST_SEQ.NEXTVAL, 'TICK0001', 'werty1111','A-7');
INSERT INTO TICKETLIST VALUES (TICKLIST_SEQ.NEXTVAL, 'TICK0002', 'JOONGANG1','A-1');
INSERT INTO TICKETLIST VALUES (TICKLIST_SEQ.NEXTVAL, 'TICK0003', 'JOONGANG2','A-2');
INSERT INTO TICKETLIST VALUES (TICKLIST_SEQ.NEXTVAL, 'TICK0004', 'JOONGANG2','A-3');
INSERT INTO TICKETLIST VALUES (TICKLIST_SEQ.NEXTVAL, 'TICK0005', 'JOONGANG4','B-1');
INSERT INTO TICKETLIST VALUES (TICKLIST_SEQ.NEXTVAL, 'TICK0006', 'JOONGANG4','B-1');
