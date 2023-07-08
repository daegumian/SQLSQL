--상품테이블 생성
--컬럼 : 상품명, 가격, 재고, 판매자, 상품상세, 등록일
CREATE TABLE PRODUCT(
    P_NAME VARCHAR2(100) NOT NULL,
    PRICE NUMBER(10) NOT NULL,
    STOCK NUMBER(5),
    SELLER VARCHAR2(30) NOT NULL,
    P_DETAIL VARCHAR2(1000),
    REGDATE DATE DEFAULT SYSDATE
);
--상품명 PK설정
ALTER TABLE PRODUCT ADD CONSTRAINT P_NAME_PK PRIMARY KEY (P_NAME);

============================================================================
--회원테이블 생성
CREATE TABLE MEMBER (
    M_ID VARCHAR2(30),
    M_PW VARCHAR2(30) NOT NULL, 
    M_NAME VARCHAR2(30) NOT NULL,
    M_EMAIL VARCHAR2(30),
    M_ADRESS CHAR(50),
);
--회원 PK 설정
ALTER TABLE MEMBER ADD CONSTRAINTS MEMBER_PK PRIMARY KEY (M_ID);

============================================================================
--상품평테이블 생성

CREATE TABLE REVIEW(
    REVIEW VARCHAR2(600) NOT NULL,
    M_ID VARCHAR2(30),
    P_NAME VARCHAR2(100)
);


