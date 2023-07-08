CREATE TABLE USERS (
    ID VARCHAR2(30),
    PW VARCHAR2(30) NOT NULL, 
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    GENDER CHAR(1),
    REGDATE DATE DEFAULT SYSDATE
);
select * from users;

insert into users(id, pw,name) values(daegumian,1234,¹Ú);