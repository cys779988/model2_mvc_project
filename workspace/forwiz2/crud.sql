
-- 1. 이름, 사원번호, 부서로 검색 시 해당 조건문으로 쿼리 추가하여 해당 직원을 조회하는 쿼리
SELECT A.USER_EMPNO
		, A.USER_NAME
		, A.USER_BIRTH
		, A.USER_JOINDT
		, A.USER_PHONE
		, B.DEPT_NAME
		, C.POS_NAME 
FROM FORWIZ_USER_TB A 
LEFT JOIN FORWIZ_DEPT_TB B ON B.DEPT_CODE=A.DEPT_CODE 
LEFT JOIN FORWIZ_POSITION_TB C ON C.POS_CODE=A.POS_CODE 
WHERE 1=1
		if(search_name != null && search_name!="")
			AND A.USER_NAME=?
		if(search_empNo != null && search_empNo!="")	
			AND A.USER_EMPNO=?
		if(search_dept != null && search_dept!="")	
			AND A.DEPT_CODE=?


			
-- 2. 로그인 시 사원번호,권한을 세션에 바인딩 위한 쿼리
SELECT USER_EMPNO 
		, ADMIN_CODE 
FROM FORWIZ_USER_TB 
WHERE 1=1 
		AND USER_EMPNO=?
		AND USER_PASSWD=?


		
-- 3. 로그인 검증 쿼리
SELECT USER_PASSWD 
FROM FORWIZ_USER_TB 
WHERE USER_EMPNO=? 



-- 4. 직원상세정보화면 쿼리
SELECT USER_EMPNO
		, USER_NAME
		, USER_ADDR
		, USER_BIRTH
		, USER_JOINDT
		, B.C_NAME USER_GEN
		, USER_JOINDT
		, USER_PHONE
		, USER_TEL
		, C.DEPT_NAME
		, D.POS_NAME
		, USER_EMAIL
		, E.C_CODE USER_ADMIN 
FROM FORWIZ_USER_TB A 
LEFT JOIN FORWIZ_COMMONCODE_TB B ON B.C_CODE=A.GEN_CODE 
LEFT JOIN FORWIZ_DEPT_TB C ON C.DEPT_CODE=A.DEPT_CODE 
LEFT JOIN FORWIZ_POSITION_TB D ON D.POS_CODE=A.POS_CODE 
LEFT JOIN FORWIZ_COMMONCODE_TB E ON E.C_CODE=A.ADMIN_CODE 
WHERE 1=1 
		AND USER_EMPNO=?

		

-- 5. 사원번호 입력받기 위해 테이블에 중복되는 값이 있는지 조회하는 쿼리
SELECT USER_EMPNO 
FROM FORWIZ_USER_TB 
WHERE USER_EMPNO=?



-- 6. 직원정보등록 쿼리
INSERT INTO FORWIZ_USER_TB
		(USER_EMPNO
		, USER_PASSWD
		, USER_NAME
		, USER_ADDR
		, USER_BIRTH
		, GEN_CODE
		, USER_JOINDT
		, USER_PHONE
		, USER_TEL
		, DEPT_CODE
		, POS_CODE
		, USER_EMAIL
		, ADMIN_CODE)
		VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		
		
-- 7. 직원정보삭제 쿼리
DELETE FROM FORWIZ_USER_TB 
WHERE USER_EMPNO=?



-- 8. 직원정보 수정 쿼리
UPDATE FORWIZ_USER_TB 
SET USER_PASSWD=?
	, USER_NAME=?
	, USER_ADDR=?
	, USER_BIRTH=?
	, GEN_CODE=?
	, USER_PHONE=?
	, USER_TEL=?
	, DEPT_CODE=?
	, POS_CODE=?
	, USER_EMAIL=?
	, ADMIN_CODE=? 
WHERE USER_EMPNO=?
