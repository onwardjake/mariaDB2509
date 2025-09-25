-- 변수 선언 및 사용
USE sqlDB;
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.5;
SET @myVar4 = '가수 이름==>';

SELECT @myVar1;
SELECT @myVar2 + @myVar3;
SELECT @myVar4, Name FROM userTBL WHERE height > 180;


-- 형 변환
USE sqlDB;
SELECT AVG(amount) AS '평균 구매 개수' FROM buyTBL; -- 결과로 2.9167이 나온다
-- 평균을 정수로 표현하기 위해 CAST, CONVERT를 사용할 수 있다.
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buyTBL; -- 결과로 3이 나온다
SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수' FROM buyTBL;


-- 다양한 구분자를 날짜로 변환할 수도 있다
-- 결과 : 2022-12-12
SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);


-- 쿼리 결과를 보기 좋게 만들기 위해 수식을 넣는다
USE sqlDB;
SELECT
    num,
    price,
    amount,
    CONCAT(CAST(price AS CHAR(10)), ' X ', CAST(amount AS CHAR(10)), ' =') AS '단가 x 수량',
    price*amount AS '구매액'
    FROM buyTBL;



-- 문자와 문자를 더함 (정수로 변환되어 연산된다)
-- 다른 DBMS에서는 CONCAT처럼 처리되기도 한다
SELECT '100' + '200'; -- 결과 : 300
SET @myVar1 = '5';
SET @myVar2 = '3';
SELECT @myVar1 + @myVar2; -- 결과 : 8

-- 문자와 문자를 연결한다 (문자로 처리된다)
SELECT CONCAT('100', '200'); -- 결과 : 100200
-- 정수와 문자를 연결한다 (정수가 문자로 변환된다)
SELECT CONCAT(100, '200'); -- 결과 : 100200

-- '2mega'는 정수 2로 변환되어 비교한다
SELECT 1 > '2mega';  -- 결과 : 0 (false)
-- '2MEGA'는 정수 2로 변환되어 비교한다
SELECT 3 > '2MEGA'; -- 결과 : 1 (true)
-- 문자는 0으로 변환된다.
SELECT 0 = 'mega2'; -- 결과 : 1 (true)


SELECT IF (100>200, '참', '거짓'); -- 결과 : 거짓이 출력된다.


SELECT
    IFNULL(NULL, 'NULL 입니다.'),
    IFNULL(100, 'NULL입니다.'); -- 결과 : NULL입니다. 100

SELECT NULLIF(100, 100), NULLIF(100, 200); -- 결과 : NULL 100

-- CASE 연산자
SELECT    CASE 10
                  WHEN 1    THEN '일'
                  WHEN 5    THEN '오'
                  WHEN 10  THEN '십'
                  ELSE '모름'
    END;

-- 문자열 함수
SELECT ASCII('A'), CHAR(65); -- 결과 : 65 A
SET @myVar1 = 'abc';
SET @myVar2 = '가나다';
SELECT BIT_LENGTH(@myVar1), BIT_LENGTH(@myVar2); -- 결과 : 24 72
SELECT CHAR_LENGTH(@myVar1), CHAR_LENGTH(@myVar2);  -- 결과 : 3 3
SELECT LENGTH(@myVar1), LENGTH(@myVar2); -- 결과 : 3 9
SELECT CONCAT_WS('/', '2022', '01', '01'); -- 결과 : 2022/01/01
SELECT ELT(2, '하나', '둘', '셋'); -- 결과 : 둘
SELECT FIELD('둘', '하나', '둘', '셋'); -- 결과 : 2
SELECT FIELD('넷', '하나', '둘', '셋'); -- 결과 : 0
SELECT FIND_IN_SET('둘', '하나,둘,셋'); -- 결과 : 2
SELECT FIND_IN_SET('넷', '하나,둘,셋'); -- 결과 : 0
SELECT INSTR('하나둘셋', '둘'); -- 결과 : 3
SELECT INSTR('하나둘셋', '넷'); -- 결과 : 0
SELECT LOCATE('둘', '하나둘셋'); -- 결과 : 3
SELECT LOCATE('넷', '하나둘셋'); -- 결과 : 0
SELECT FORMAT(123456.123456, 4); -- 결과 : 123,456.1235
SELECT BIN(31), HEX(31), OCT(31); -- 결과 : 1111 1F 37
SELECT INSERT('abcdefghi', 3, 4, '@@@@'); -- 결과 : abc@@@@ghi
SELECT INSERT('abcdefghi', 3, 2, '@@@@'); -- SELECT LEFT('abcdefghi', 3); -- 결과 : abc
SELECT RIGHT('abcdefghi', 3); -- 결과 : ghi
SELECT LOWER('abcdEFGH'); -- 결과 : abcdefgh
SELECT UPPER('abcdEFGH'); -- 결과 : ABCDEFGH
SELECT LPAD('이것이', 5, '##'); -- 결과 : ##이것이
SELECT RPAD('이것이', 5, '##'); -- 결과 : 이것이##
SELECT LTRIM('    이것이'), RTRIM('이것이    '); -- 결과 : 이것이 이것이
SELECT TRIM('    이것이    '); -- 결과 : 이것이
SELECT TRIM(LEADING 'ㅋ' FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋ'); -- 결과 : 재밌어요.ㅋㅋㅋ
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋ'); -- 결과 : 재밌어요.
SELECT TRIM(TRAILING 'ㅋ' FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋ'); -- 결과 : ㅋㅋㅋ재밌어요.
SELECT REPEAT('이것이', 3); -- 결과 : 이것이이것이이것이
SELECT REPLACE('이것이 MariaDB다', '이것이', 'This is'); -- 결과 : This is MariaDB
SELECT REVERSE('MariaDB'); -- 결과 : BDairaM
SELECT CONCAT('이것이', SPACE(5), "'MariaDB'다"); -- 결과 : 이것이     'MariaDB'다
SELECT SUBSTRING('대한민국만세', 3, 2); -- 결과 : 민국
SELECT SUBSTRING('대한민국만세' FROM 3 FOR 2);  -- 결과 : 민국
SELECT SUBSTRING('대한민국만세', 3); -- 결과 : 민국만세
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', 2); -- 결과 : cafe.naver
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', -2); -- 결과 : naver.com


-- 수학 함수
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7); -- 결과 : 5 4 5
SELECT DEGREES(PI()), RADIANS(180); -- 결과 : 180 3.141592653589793
SELECT MOD(157, 10), 157%10, 157 MOD 10; -- 결과 : 7 7 7
-- 1 ~ 6까지 주사위 숫자를 랜덤으로 생성한다
SELECT FLOOR( 1 + RAND() * (7 - 1));


-- 날짜 및 시간 함수
SELECT CURDATE(); -- 결과 : 연-월-일
SELECT CURTIME(); -- 결과 : 시:분:초
SELECT NOW(); -- 결과 연-월-일 시:분:초
SELECT SYSDATE(); -- 결과 연-월-일 시:분:초

SELECT ADDDATE('2025-02-01', INTERVAL 31 DAY); -- 결과 : 2025-03-04
SELECT ADDDATE('2025-02-01', INTERVAL 1 MONTH); -- 결과 : 2025-03-01
SELECT SUBDATE('2025-03-01', INTERVAL 31 DAY); -- 결과 : 2025-01-29
SELECT SUBDATE('2025-03-01', INTERVAL 1 MONTH); -- 결과 : 2025-02-01

SELECT ADDTIME('2025-02-01 23:59:59', '1:1:1'); -- 결과 2025-02-02 01:01:00
SELECT ADDTIME('15:00:00', '1:1:1'); -- 결과 16:01:01
SELECT ADDTIME('23:59:00', '1,1,1'); -- 결과 25:00:01
SELECT SUBTIME('2025-02-01 00:59:59', '1:1:1'); -- 결과 2025-01-31 23:58:58
SELECT SUBTIME('15:00:00', '1:1:1'); -- 결과 13:58:59

SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE()); -- 결과 2025 9 23
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()), MICROSECOND(CURTIME());
SELECT DATE(NOW()); -- 결과 : 연-월-일
SELECT TIME(NOW()); -- 결과 : 시:분:초
SELECT DATEDIFF('2025-09-24', '2025-12-31'); -- 결과 : -98
SELECT TIMEDIFF('2025-02-01 00:00:00', '2025-02-02 00:00:00'); -- 결과 : -24:00:00
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE()); -- 결과 4 September 267
SELECT MAKEDATE(2025, 267); -- 결과 : 2025-09-24
SELECT MAKETIME(0, 16, 07); -- 결과 : 00:16:07
SELECT PERIOD_ADD(201908, 12); -- 결과 : 202008
SELECT PERIOD_DIFF(202507, 201908); -- 결과 : 71
SELECT TIME_TO_SEC('01:00:00'); -- 결과 : 3600


-- 시스템 정보 함수
SELECT USER(), SESSION_USER(), CURRENT_USER(); -- 모두 동일한 결과를 가져온다
SELECT DATABASE(), SCHEMA();

SELECT * FROM userTBL;
SELECT FOUND_ROWS(); -- 결과 : 10 (userTBL에 10명의 회원이 있다)

UPDATE buyTBL SET price=price*2;
SELECT ROW_COUNT(); -- 결과 : 12 (buyTBL에 12개의 구매 기록이 있다)

SELECT SLEEP(5);
SELECT '5초 후에 이게 보여요';


-- JOIN
-- 1) buyTBL에서 userID가 EJW을 추출한다 (여러 건인 경우 모두 추출한다)
-- 2) userTBL에서 userID가 EJW을 찾아서
-- 3) buyTBL과 userTBL 테이블의 두 행을 결합(JOIN)한다.
USE sqlDB;
SELECT *
    FROM buyTBL
        INNER JOIN userTBL
            ON buyTBL.userID = userTBL.userID
    WHERE buyTBL.userID = 'EJW';

-- 테이블에 별칭(alias)을 줄 수 있다.
SELECT B.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.`mobile2`) AS '연락처'
    FROM buyTBL B
        INNER JOIN userTBL U
            ON B.userId = U.userID;

-- 한번이라도 구매한 적이 있는 고객을 추출한다
SELECT DISTINCT U.userID, U.name, U.addr
    FROM userTBL U
        INNER JOIN buyTBL B
            ON U.userID = B.userID
    ORDER BY U.userID;



-- 3개의 테이블 조인
USE sqlDB;

-- 3개의 테이블을 만든다 (학생, 동아리, 학생동아리)
CREATE TABLE stdTBL
(
    stdName		VARCHAR(10) NOT NULL PRIMARY KEY,
    addr			CHAR(4) NOT NULL
);
CREATE TABLE clubTBL
(
    clubName	VARCHAR(10) NOT NULL PRIMARY KEY,
    roomNo			CHAR(4) NOT NULL
);
CREATE TABLE stdclubTBL
(
    num			INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    stdName		VARCHAR(10) NOT NULL,
    clubName		VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdTBL(stdName),
FOREIGN KEY(clubName) REFERENCES clubTBL(clubName)
);

-- 테이블에 데이터를 넣어준다
INSERT INTO stdTBL VALUES (N'김범수', N'경남'), (N'성시경', N'서울'), (N'조용필', N'경기'), (N'은지원', N'경북'), (N'바비킴', N'서울');
INSERT INTO clubTBL VALUES (N'수영', N'101호'), (N'바둑', N'102호'), (N'축구', N'103호'), (N'봉사', N'104호');
INSERT INTO stdclubTBL VALUES (NULL, n'김범수', n'바둑'), (NULL, n'김범수', n'축구'), (NULL, n'조용필', n'축구'), (NULL, n'은지원', n'축구'), (NULL, n'은지원', n'봉사'), (NULL, n'바비킴', n'봉사');


-- 조인해서 데이터를 가져온다
-- 학생동아리 테이블과 학생 테이블의 일대다 관계를 INNER JOIN하고,
-- 학생동아리 테이블과 동아리 테이블의 일대다 관계를 INNER JOIN한다.
SELECT S.stdName, S.addr, C.clubName, C.roomNo
    FROM stdTBL S
        INNER JOIN stdclubTBL SC
            ON S.stdName = SC.stdName
        INNER JOIN clubTBL C
            ON SC.clubName = C.clubName
    ORDER BY S.stdName;

-- 동아리를 기준으로 가입한 학생의 목록을 출력한다
SELECT C.clubName, C.roomNo, S.stdName, S.addr
    FROM clubTBL C
        INNER JOIN stdclubTBL SC
            ON C.clubName = SC.clubName
        INNER JOIN stdTBL S
            ON SC.stdName = S.stdName
    ORDER BY C.clubName;


-- LEFT OUTER JOIN (모든 회원 정보가 출력된다)
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM userTBL U
        LEFT JOIN buyTBL B
            ON U.userID = B.userID
    ORDER BY U.userID;

-- RIGHT OUTER JOIN (모든 구매내역이 출력된다)
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM userTBL U
        RIGHT JOIN buyTBL B
            ON U.userID = B.userID
    ORDER BY U.userID;

-- LEFT OUTER JOIN (구매내역이 없는 회원 정보가 출력된다)
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM userTBL U
        LEFT OUTER JOIN buyTBL B
            ON U.userID = B.userID
    WHERE B.prodName IS NULL
    ORDER BY U.userID;


-- 3개의 테이블로 OUTER JOIN 실습
-- 모든 학생의 정보가 출력된다
SELECT S.stdName, S.addr, C.clubName, C.roomNo
    FROM stdTBL S
        LEFT OUTER JOIN stdclubTBL SC
            ON S.stdName = SC.stdName
        LEFT OUTER JOIN clubTBL C
            ON SC.clubName = C.clubName
    ORDER BY S.stdName;

-- 모든 동아리 정보가 출력된다
SELECT C.clubName, C.roomNo, S.stdName, S.addr
    FROM clubTBL C
        LEFT OUTER JOIN stdclubTBL SC
            ON C.clubName = SC.clubName
        LEFT OUTER JOIN stdTBL S
            ON SC.stdName = S.stdName
    ORDER BY C.clubName;

-- 모든 동아리 정보가 출력된다
SELECT C.clubName, C.roomNo, S.stdName, S.addr
    FROM stdTBL S
        LEFT OUTER JOIN stdclubTBL SC
            ON S.stdName = SC.stdName
        RIGHT OUTER JOIN clubTBL C
            ON SC.clubName = C.clubName
    ORDER BY C.clubName;

-- CROSS JOIN : 120개 행이 만들어진다 (회원 10개 x 구매내역 12개)
SELECT *
    FROM buyTBL
        CROSS JOIN userTBL;

-- SELF JOIN
CREATE TABLE empTBL
(
    emp		CHAR(3) NOT NULL PRIMARY KEY,
    manager	CHAR(3),
    empTel	VARCHAR(8)
);

INSERT INTO empTBL VALUES (N'나사장', NULL, '0000');
INSERT INTO empTBL VALUES (N'김재무', N'나사장', '2222');
INSERT INTO empTBL VALUES (N'김부장', N'김재무', '2222-1');
INSERT INTO empTBL VALUES (N'이부장', N'김재무', '2222-2');
INSERT INTO empTBL VALUES (N'우대리', N'이부장', '2222-2-1');
INSERT INTO empTBL VALUES (N'지사원', N'이부장', '2222-2-2');
INSERT INTO empTBL VALUES (N'이영업', N'나사장', '1111');
INSERT INTO empTBL VALUES (N'한과장', N'이영업', '1111-1');
INSERT INTO empTBL VALUES (N'최정보', N'나사장', '3333');
INSERT INTO empTBL VALUES (N'윤차장', N'최정보', '3333-1');
INSERT INTO empTBL VALUES (N'이주임', N'윤차장', '3333-1-1');

-- 우대리의 상관 연락처를 가져오는 쿼리
SELECT A.emp AS '부하직원', B.emp AS '직속상관', B.empTel AS '직속상관 연락처'
    FROM empTBL A
        INNER JOIN empTBL B
            ON A.manager = B.emp
    WHERE A.emp = '우대리';


-- 두 쿼리의 결과를 합쳐서 출력한다
-- UNOIN : 중복된 열 제거
SELECT stdName, addr FROM stdTBL
    UNION
SELECT clubName, roomNo FROM clubTBL;

-- UNION ALL : 중복된 열 포함
SELECT stdName, addr FROM stdTBL
    UNION ALL
SELECT clubName, roomNo FROM clubTBL;

-- NOT IN : 첫 번째 쿼리의 결과 중에서, 두 번째 쿼리에 해당하는 것을 제외한다.
-- 전화번호 있는 고객만 추출
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호' FROM userTBL
    WHERE name NOT IN (SELECT name FROM userTBL WHERE mobile1 IS NULL);

-- IN : 첫 번째 쿼리의 결과 중에서, 두 번째 쿼리에 해당하는 것을 포함한다.
-- 전화번호 없는 고객만 추출
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호' FROM userTBL
    WHERE name IN (SELECT name FROM userTBL WHERE mobile1 IS NULL);


-- SQL 프로그래밍
DROP PROCEDURE IF EXISTS ifProc;
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
    DECLARE var1 INT;
    SET var1 = 10;

    IF var1 = 100 THEN
        SELECT '100입니다.';
    ELSE
        SELECT '100이 아닙니다.';
    END IF;
END $$
DELIMITER ;

CALL ifProc();


-- 직원번호 100001 번에 해당하는 직원의 입사일이 5년이 넘었는지 확인한다
DROP PROCEDURE IF EXISTS svcYear;
DELIMITER $$
CREATE PROCEDURE svcYear()
BEGIN
    DECLARE hireDate DATE; -- 입사일
    DECLARE curDate DATE; -- 오늘
    DECLARE days INT; -- 근무 일수

    -- SELECT ... INT 변수 : 쿼리 결과를 변수에 저장한다.
    SELECT hire_date INTO hireDate
        FROM employees.employees
        WHERE emp_no = 100001;

    SET curDate = CURDATE();
    SET days = DATEDIFF(curDate, hireDate); -- 근무 일수를 구한다

    IF (days/365) >= 5 THEN
        SELECT CONCAT('오! 입사한지 ', FLOOR(days/365), '년 되었어요! ', days, '일이나 근무하셨습니다. 축하합니다!');
    ELSE
        SELECT CONCAT('오! 입사한지 ', FLOOR(days/365), '년 되었어요! ', days, '일 근무하셨습니다. 파이팅!');
    END IF;
END $$
DELIMITER ;

CALL svcYear();

-- IF ELSEIF ELSE END IF로 구현한 학점에 따른 grade
DROP PROCEDURE IF EXISTS ifGrade;
DELIMITER $$
CREATE PROCEDURE ifGrade()
BEGIN
    DECLARE point INT; -- 점수
    DECLARE grade CHAR(1); -- 학점(grade)
    SET point = 88;

    IF point >= 90 THEN
        SET grade = 'A';
    ELSEIF point >= 80 THEN
        SET grade = 'B';
    ELSEIF point >= 70 THEN
        SET grade ='C';
    ELSEIF point >= 60 THEN
        SET grade ='D';
    ELSE
        SET grade = 'F';
    END IF;

    SELECT CONCAT('점수 : ', point), CONCAT('학점 : ', grade);
END $$
DELIMITER ;
CALL ifGrade();

-- CASE WHEN ELSE END CASE로 구현한 학점에 따른 grade
DROP PROCEDURE IF EXISTS caseGrade;
DELIMITER $$
CREATE PROCEDURE caseGrade()
BEGIN
    DECLARE point INT; -- 점수
    DECLARE grade CHAR(1); -- 학점(grade)
    SET point = 88;

    CASE
        WHEN point >= 90 THEN
            SET grade = 'A';
        WHEN point >= 80 THEN
            SET grade = 'B';
        WHEN point >= 70 THEN
            SET grade = 'C';
        WHEN point >= 60 THEN
            SET grade = 'D';
        ELSE
            SET grade = 'F';
    END CASE;

    SELECT CONCAT('점수 : ', point), CONCAT('학점 : ', grade);
END $$
DELIMITER ;
CALL caseGrade();


-- 1에서 100까지 더하는 기능
DROP PROCEDURE IF EXISTS sumWhileProc;
DELIMITER $$
CREATE PROCEDURE sumWhileProc()
BEGIN
    DECLARE i INT;
    DECLARE sum INT;
    SET i = 1;
    SET sum = 0;

    WHILE (i <= 100) DO
        SET sum = sum + i;
        SET i = i + 1;
    END WHILE;

    SELECT sum;
END $$
DELIMITER ;
CALL sumWhileProc();

-- 1에서 100까지 더하는데, 7의 배수는 제외하고, 합이 1000이 넘으면 계산을 중단한다.
DROP PROCEDURE IF EXISTS sumWhileProc2;
DELIMITER $$
CREATE PROCEDURE sumWhileProc2()
BEGIN
    DECLARE i INT;
    DECLARE sum INT;
    SET i = 1;
    SET sum = 0;

    sumWhile: WHILE (i<=100) DO
        IF (i%7 = 0) THEN
            SET i = i + 1;
            ITERATE sumWhile;
        END IF;

        IF (sum>1000) THEN
            LEAVE sumWhile;
        END IF;

        SET sum = sum + i;
        SET i = i + 1;
    END WHILE;

    SELECT sum;
END $$
DELIMITER ;
CALL sumWhileProc2();


-- 존재하지 않는 테이블에 대한 오류 처리
DROP PROCEDURE IF EXISTS errorProc;
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR 1146
        BEGIN
            SELECT '테이블이 존재하지 않습니다.' AS '오류 메시지';
        END;

    -- 오류가 있는 SQL
    SELECT * FROM noTable; -- 없는 테이블

    -- CONTINUE HANDLER 이므로 오류 이후의 SQL도 계속 수행한다
    -- 만약, EXIT HANDLER 였다면, 오류 이후의 SQL 구문이 실행되지 않는다 (프로시저가 종료된다)
    INSERT INTO userTBL VALUES ('LLL', n'이상구', 1988, n'서울', NULL, NULL, 170, CURRENT_DATE());
END $$
DELIMITER ;
CALL errorProc();
select * from usertbl where userid='LLL';


-- PK로 지정된 열에 동일한 값을 추가할 경우 오류 처리
USE sqlDB;
DROP PROCEDURE IF EXISTS insertErrProc;
DELIMITER $$
CREATE PROCEDURE insertErrProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SHOW ERRORS; -- 오류 메시지를 보여준다
            ROLLBACK; -- 오류 발생 시 작업을 롤백한다
        END;
    INSERT INTO userTBL VALUES ('LSG', n'이상구', 1988, n'서울', NULL, NULL, 170, CURRENT_DATE()); -- LSG ID는 이미 존재하는 ID이다
END $$
DELIMITER ;
CALL insertErrProc();


-- 동적 SQL
PREPARE myQuery FROM 'SELECT * FROM userTBL WHERE userID="EJW"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;


-- 동적 SQL에서 ?로 파라미터 전달
SET @sql = 'SELECT * FROM userTbl WHERE userID = ?';
SET @userID = 'EJW';

PREPARE stmt1 FROM @sql;       -- 쿼리 준비
EXECUTE stmt1 USING @userID;   -- 실행 시 변수 삽입
DEALLOCATE PREPARE stmt1;      -- 준비된 쿼리 해제
