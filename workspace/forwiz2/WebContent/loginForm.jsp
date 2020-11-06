<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.box{
margin-top:100px;
text-align:center;
}
</style>
</head>
<body>

<form name="loginForm" align="center">
<table width="100" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
  <div align="center" style="padding: 30px;" ><img src="/forwiz2/image/logo.PNG"/></div>
    
  </tr>
  <tr>
    <td height="150" width="250"margin="10px"></td>
    <td width="270" valign="top"><table width="270" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="4" height="14"></td>
      </tr>
      <tr>
        <td width="100" height="16">사원번호</td>
        
        <td width="10">&nbsp;</td>
        <td colspan="2"><input type="text" name="empNo" style="width:100%; line-height:140%; height:21px;color: #000000; border: 1px #bebebe solid; font-family: Dotum; font-size: 12px; text-decoration: none; background-color: #ffffff; ime-mode:inactive;ime-mode:disabled;" tabindex="1" onkeypress="checkKey(event);" maxlength="10"/></td>
      </tr>
      <tr>
        <td height="13" colspan="4"></td>
      </tr>
      <tr>
        <td width="100" height="16">비밀번호</td>
        
        <td width="10"></td>
        <td height="16" width="146"><input type="password" name="pwd" style="width:100%; height:21px;color: #000000; border: 1px #bebebe solid; font-family: Dotum; font-size: 12px; text-decoration: none; background-color: #ffffff; ime-mode:inactive;ime-mode:disabled;" tabindex="2" onkeypress="checkKey(event);" maxlength="10"/></td>
         <td align="right" style="padding:15px;">
        <input type="button" value="로그인" id="btnLogin">
   		</td>
      </tr>
    </table></td>
    <td width="178"></td>
  </tr>
</table>
</form>
<script>
window.onload = function(){
    var btn = document.getElementById("btnLogin");
    if(btn){
         btn.addEventListener("click", funcLogin, false);   
    }
}

function funcLogin(){
    if(loginForm.empNo.value == "" || loginForm.empNo.value == null){
        alert("아이디를 입력하세요.");
        loginForm.empNo.focus();
    }else if(loginForm.pwd.value == "" || loginForm.pwd.value == null){
		alert("비밀번호를 입력하세요.")
    }else{
        loginForm.action ="login.do";
        loginForm.method="post";
        loginForm.submit();
    	}    
    }
</script>
</body>
</html>