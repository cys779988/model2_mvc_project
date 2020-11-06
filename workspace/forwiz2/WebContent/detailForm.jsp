<%@page import="vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
table{
	width: 1000px;
	border: 1px solid #444444;
    border-collapse: collapse;
}
tr, td{
    border: 1px solid #444444;
}
.btn{
display:block;
width:100%;
margin:0 auto;
text-align:center;
}

</style>
<script src="//code.jquery.com/jquery.min.js"></script>
</head>
<body>
<form name="detailForm" method="post">
	<h1  class="text_center">직원 상세정보</h1>
			<table align="center">
  			<tr>
				<td width="100"><p align="right">성명</td>
				<td width="400">${member.name }</td>
				<td width="100"><p align="right">생년월일</td>
				<td width="400">${member.birth }</td>
			</tr>
			<tr>
			<td width="100"><p align="right">부서/직위</td>
				<td width="400">${member.dept } / ${member.position }</td>
				<td width="100"><p align="right">성별</td>
				<td width="400">${member.gen eq '남자' ? '남자' : '여자'}</td>
			</tr>
			<tr>
				<td width="100"><p align="right">사원번호</td>
				<td width="400">${member.empNo }</td>
				<td width="100"><p align="right">입사일</td>
				<td width="400">${member.joinDate }</td>
			</tr>
			<tr>
				<td width="100"><p align="right">연락처</td>
				<td width="100">${member.phone }</td>
				<td width="100"><p align="right">내선번호</td>
				<td width="100">${member.tel }</td>
			</tr>
			<tr>
				<td width="100"><p align="right"/>주소</td>
				<td colspan="3">${member.addr }</td>
			</tr>
			<tr>
				<td width="100"><p align="right">이메일</td>
				<td colspan="3">${member.email }</td>
			</tr>

	</table>
			<div class="btn">
				<c:if test="${memberSession.admin eq 'AUTH_ADMIN' || memberSession.empNo eq member.empNo}">
					<input type="button" value="수정" onclick="location.href='/forwiz2/updateForm.do?empNo=${member.empNo }'">
					<input type="button" value="삭제" onclick="btn_delbtn();">
				</c:if>
					<input type="button" value="목록" onclick="location.href='/forwiz2/list.do'"> 
			</div>
	</form>
<script>
function btn_delbtn(){
	if(confirm('삭제하시겠습니까?')){
	location.href = 'delete.do?empNo=${member.empNo }';
	}else{
	alert('삭제가 취소되었습니다.');
	}
}
</script>
</body>
</html>