<%@page import="java.util.List"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	margin:0 auto;
	text-align:right;
	margin-right:450px;
}
</style>
</head>
<body>
<c:choose>
	<c:when test="${sessionScope.memberSession != null }">
	<h1  class="text_center">직원 목록</h1>
	<form action="list.do" >
	<table align="center" border="1">
	 		<tr bgcolor="#99ccff"> <td colspan ="7" align="center">포위즈 시스템 직원 현황</td></tr>
	 		<tr>
	 			<td width="75">성명</td>
	 			<td width="150"><input style="margin-left: 10px;" type="text" name="search_name" placeholder="성명" maxlength="10"></td>
	 			<td width="75">사원번호</td>
				 <td width="150"><input style="margin-left: 10px;" type="text" name="search_empNo" placeholder="사원번호" maxlength="10"></td>
	 			<td width="75">소속부서</td>
	 			<td width="150">
	 			<select style="margin-left: 10px;" name ="search_dept">
	      			<option value="">===== 부서 =====</option>
	      			<option value="D01">경영지원팀</option>
	      			<option value="D02">부설연구소</option>
	      			<option value="D03">SI사업1팀</option>
	      			<option value="D04">SI사업2팀</option>
	      			<option value="D05">SI사업3팀</option>
	      			<option value="D06">SI사업4팀</option>
	      			<option value="D07">SI사업본부</option>
	      			<option value="D08">전략사업본부</option>
	      			<option value="D09">경영지원본부</option>
	      			<option value="D10">대표이사</option>
	      		</select></td>
	      		 <td><input type="submit" value="조회"></td>
	      	</tr>
	</table>
			</form>

			<div class="btn">
			<c:if test="${memberSession.admin eq 'AUTH_ADMIN' }">
			<input type="button" value="추가" onclick="location.href='/forwiz2/registForm.do'">
			</c:if>
			<input type="button" value="로그아웃" onclick="location.href='/forwiz2/logout.do'">
			</div>
			<div>
			<table align="center" width="1000px">
			<c:choose>
				<c:when test="${empty memberList}">
 				<tr>
					<td colspan="5">
						<p align="center">
							<b><span style="font-size: 9pt;"> 등록된 직원이 없습니다.</span></b>
						</p>
					</td>
				</tr>
				</c:when>
				<c:otherwise>
					<tr align="center" bgcolor="#99ccff">
						<td>순번</td>
						<td>사원번호</td>
						<td>직위</td>
						<td>성명</td>
						<td>생년월일</td>
						<td>입사일자</td>
						<td>소속부서</td>
						<td>연락처</td>
					</tr>
					<c:forEach var="member" items="${memberList}" varStatus ="status">
				<tr align="center">
					<td>${status.count}</td>
					<td><a href="detailForm.do?empNo=${member.empNo}">${member.empNo}</a></td>
					<td>${member.position}</td>
					<td>${member.name}</td>
					<td>${member.birth}</td>
					<td>${member.joinDate}</td>
					<td>${member.dept}</td>
					<td>${member.phone}</td>
					</tr>
					</c:forEach>
				</c:otherwise>
				</c:choose>
				</table>
				</div>
	</c:when>
	<c:otherwise>
	<%
	response.sendRedirect("loginForm.do");
	%>
	</c:otherwise>
</c:choose>
</body>
</html>