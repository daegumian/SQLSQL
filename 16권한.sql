
--1. USER 생성
CREATE USER USER01 IDENTIFIED BY USER01; --아이디 USER01, 비밀번호 USER01

--2. USER 권한부여
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO USER01;

--3. 데이가 저정되는 물리적인공간 (테이블스페이스 연결)
--ALTER USER 유저명 DEFAULT TABLESPACE 테이블스페이스명 QUOTA LIMITED ON 테이블스페이스명
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--4. 계정 삭제 (테이블 삭제 -> 시퀀스 삭제 -> ~~~삭제)
DROP USER USER01 CASCADE;

-------------------------------------------------------------------------------------------------------------------------------------
--ROLE을 이용한 계정생성
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT /* DBA */ TO USER01;

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--비밀번호 변경문
ALTER USER USER01 IDENTIFIED BY 1234;

-------------------------------------------------------------------------------------------------------------------------------------
--마우스로 생성하기
--1. 테이블스페이스 생성 > 보기 > DBA
--1. DAB계정 접속해 > 다른 사용자 > 사용자 생성








