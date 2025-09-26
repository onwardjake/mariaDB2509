USE sqlDB;

-- 열을 정의하면서 기본 키로 지정한다
CREATE TABLE userTBL
(
    userID CHAR(8) PRIMARY KEY,
    name VARCHAR(8) NOT NULL,
    birthYear INT NOT NULL
);

-- PRIMARY KEY를 지정하면서 제약조건의 이름까지 지정할 수 있다.
CREATE TABLE userTBL2
(
    userID CHAR(8) NOT NULL,
    name VARCHAR(8) NOT NULL,
    birthYear INT NOT NULL,
    CONSTRAINT PRIMARY KEY PK_userTBL2_userID (userID)
);


-- 이미 만들어진 테이블에 제약 조건을 추가할 수도 있다
CREATE TABLE userTBL3
(
    userID CHAR(8) NOT NULL,
    name VARCHAR(8) NOT NULL,
    birthYear INT NOT NULL
);

ALTER TABLE userTBL3 -- userTBL3을 변경하는데,
    ADD CONSTRAINT PK_userTBL3_userID -- PK_userTBL_userID 이름의 제약 조건을 추가하고,
        PRIMARY KEY (userID); -- 제약 조건은 기본 키 제약 조건이고, 제약 조건을 설정할 열은 userID열이다.


-- 외래 키
DROP DATABASE IF EXISTS testDB;
CREATE DATABASE testDB;
USE testDB;
DROP TABLE IF EXISTS buyTbl, userTBL;
CREATE TABLE userTBL
(
    userID CHAR(3) PRIMARY KEY,
    name VARCHAR(8) NOT NULL,
    birthYear INT NOT NULL
);

CREATE TABLE buyTBL3
(
    num INT AUTO_INCREMENT PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL
);

-- 외래 키를 지정한다
ALTER TABLE buyTBL3
    ADD CONSTRAINT FK_userTBL_buyTBL3
        FOREIGN KEY(userID)
        REFERENCES userTBL(userID);

-- 외래 키를 삭제한다
ALTER TABLE buyTBL3
    DROP FOREIGN KEY FK_userTBL_buyTBL3;

-- 기준 테이블의 데이터가 변경되면 외래 키 테이블도 자동으로 업데이트 해준다
ALTER TABLE buyTBL3
    ADD CONSTRAINT FK_userTBL_buyTBL3
        FOREIGN KEY (userID)
        REFERENCES userTBL(userID)
        ON UPDATE CASCADE;

INSERT INTO userTBL VALUES('111', 'name', 2025);
INSERT INTO buyTBL3 VALUES(NULL, '111', 'mac');
UPDATE userTBL
    SET userID = '222'
    WHERE userID = '111'; -- buyTBL3의 userID 111도 222로 바뀐


-- 출생연도를 입력하지 않으면 1900을 입력하고, 주소를 입력하지 않았으면 '서울'을 입력한다
CREATE TABLE userTBL9
(
    userID CHAR(3) PRIMARY KEY,
    name VARCHAR(8) NOT NULL,
    birthYear INT NOT NULL DEFAULT 1900,
    addr CHAR(4) NOT NULL DEFAULT '서울'
);



-- 뷰 테이블
CREATE DATABASE sqlDB;
USE sqlDB;

-- 뷰를 생성한다
CREATE VIEW v_userbuyTBL
AS
    SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2)
        FROM userTBL U
            INNER JOIN buyTBL B
                ON U.userID = B.userID;

-- 뷰를 수정한다
ALTER VIEW v_userbuyTBL
AS
    SELECT U.userID AS '아이디', U.name AS '이름', B.prodName AS '상품명', U.addr AS '주소', CONCAT(U.mobile1, U.mobile2) AS '연락처'
        FROM userTBL U
            INNER JOIN buyTBL B
                ON U.userID = B.userID;

-- 뷰를 통해 데이터를 수정한다
UPDATE v_userbuyTBL SET `주소`='경남' WHERE `아이디`='KBS';

SELECT * FROM v_userbuyTBL;
SELECT * FROM userTBL;

-- 뷰를 삭제한다
DROP VIEW v_userbuyTBL;
