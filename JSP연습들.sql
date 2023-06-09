CREATE TABLE USERS (
    ID VARCHAR2(30),
    PW VARCHAR2(30) NOT NULL, 
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    GENDER CHAR(1),
    REGDATE DATE DEFAULT SYSDATE
);

ALTER TABLE USERS ADD CONSTRAINTS USERS_PK PRIMARY KEY (ID);
ALTER TABLE USERS ADD CONSTRAINTS USERS_CHECK CHECK (GENDER IN ('M', 'F'));

SELECT * FROM USERS WHERE ID = '°ª';
INSERT INTO ~~~~ VALU;
select * from users;

select * from users where id = daegumian and pw = 1234;

select * from users where id = 'daegumian';

update users set (?,?,?,?,?) where in(id, pw, name, email, gender);
