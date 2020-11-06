<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
request.setCharacterEncoding("UTF-8");
%>
<body>
<form name="checkForm" method="post" action="confirm.do">
<table width = "270" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td align="center">
		<p>사원번호는 ${empNo} 입니다. </p>
		<input type="button" value="확인" onclick="setempNo()">
		</td>
	</tr>
</table>
</form>
<script type = "text/javascript">
function setempNo(){
	opener.document.regist.empNo.value="${empNo}";
	self.close();
}
</script>
</body>
</html>