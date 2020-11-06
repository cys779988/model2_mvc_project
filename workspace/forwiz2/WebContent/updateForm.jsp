<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 
<%-- <%
	String empNo = request.getParameter("empNo");
	MemberDAO dao = new MemberDAO();
	MemberVO vo = dao.selectEmployDetailList(empNo);
	MemberVO member = (MemberVO)session.getAttribute("member");
	if(session.getAttribute("member")==null){
		response.sendRedirect("loginForm.jsp");
	}
%> --%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<title>Insert title here</title>
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
margin-top: 100px;
}
</style>
</head>
<body>
<c:choose>
<c:when test="${memberSession.admin eq 'AUTH_ADMIN' || memberSession.empNo eq member.empNo}">
	<form name="update" method="post" action="update.do" onsubmit="return checkIt();" autocomplete="off">
	<h1  class="text_center">직원정보 수정</h1>
	<table align="center">
  			<tr>
				<td width="100"><p align="right">성명</td>
				<td width="400"><input type="text" name="name" value="${member.name }" maxlength="6"></td>
				<td width="100"><p align="right">생년월일</td>
				<td width="400"><p>
						<input type="date" name="birth" value="${member.birth }"></td>
			</tr>
			<tr>
				<td width="100"><p align="right">연락처</td>
				<td width="100"><p>
						<input type="text" name="phone" id="phone" maxlength="13" value="${member.phone }"></td>
				<td width="100"><p align="right">성별</td>
				<td width="400">
				<input type="radio" name="gen" value="GENDER_MALE" ${member.gen eq "남자" ?"checked":""} />남자
				<input type="radio" name="gen" value="GENDER_FEMALE" ${member.gen eq "여자" ?"checked":""}/>여자</td>
			</tr>
			<tr>
				<td width="100"><p align="right">사원번호</td>
				<td width="400"><input type="text" name="empNo" value="${member.empNo }" maxlength="6" readonly="readonly">
				<td width="100"><p align="right">입사일</td>
				<td width="400"><p>
						<input type="date" name="joinDate" value="${member.joinDate }" onclick = "${memberSession.admin eq 'AUTH_ADMIN'?'':'return false;'}"></td>
			</tr>
			<tr>
				<td width="100"><p align="right">비밀번호</td>
				<td width="400"><input type="password" name="pwd" maxlength="10"><br></td>
				<td width="100"><p align="right">내선번호</td>
				<td width="50"><p>
						<input type="text" name="tel" id ="tel" maxlength="12" value="${member.tel }"></td>
			</tr>
			<tr>
				<td width="100"><p align="right">권한</td>
				<td width="400"><p>
						<input type="checkbox" name="admin" value="AUTH_ADMIN" ${member.admin eq 'AUTH_ADMIN'?'checked':''}
						onclick = "${memberSession.admin eq 'AUTH_ADMIN'?'':'return false;'}"></td>
						
				<td width="100"><p align="right">직급</td>
				<td width="400"><select name="position" id="position" onclick = "${memberSession.admin eq 'AUTH_ADMIN'?'':'preVal = this.value;'}">
						<%--  onchange = "${memberSession.admin eq 'AUTH_ADMIN'?'':'alert('권한이 없습니다.'); this.value = preVal;'}" --%>
						<option value="P10" ${member.position eq '대표이사'?'selected':'' }>대표이사</option>
						<option value="P09" ${member.position eq '부사장'?'selected':'' }>부사장</option>
						<option value="P08" ${member.position eq '전무'?'selected':'' }>전무</option>
						<option value="P07" ${member.position eq '본부장'?'selected':'' }>본부장</option>
						<option value="P06" ${member.position eq '부장'?'selected':'' }>부장</option>
						<option value="P05" ${member.position eq '차장'?'selected':'' }>차장</option>
						<option value="P04" ${member.position eq '과장'?'selected':'' }>과장</option>
						<option value="P03" ${member.position eq '대리'?'selected':'' }>대리</option>
						<option value="P02" ${member.position eq '주임'?'selected':'' }>주임</option>
						<option value="P01" ${member.position eq '사원'?'selected':'' }>사원</option>
				</select></td>
			</tr>
			<tr>
				<td width="100"><p align="right">이메일</td>
				<td width="400"><input type="text" name="email" maxlength="10" value="${member.email }">
					@forwiz.com</td>
				<td width="100"><p align="right">부서</td>
				
				<td width="400"><p>
						<select name="dept" onclick = "${memberSession.admin eq 'AUTH_ADMIN'?'':'preVal = this.value;'}">
						<%-- onchange = "${memberSession.admin eq 'AUTH_ADMIN'?'':'alert('권한이 없습니다.'); this.value = preVal;'}" --%>
							<option value="D10" ${member.dept eq '대표이사'?'selected':'' }>대표이사</option>
							<option value="D09" ${member.dept eq '경영지원본부'?'selected':'' }>경영지원본부</option>
							<option value="D08" ${member.dept eq '전략사업본부'?'selected':'' }>전략사업본부</option>
							<option value="D07" ${member.dept eq 'SI사업본부'?'selected':'' }>SI사업본부</option>
							<option value="D06" ${member.dept eq 'SI사업4팀'?'selected':'' }>SI사업4팀</option>
							<option value="D05" ${member.dept eq 'SI사업3팀'?'selected':'' }>SI사업3팀</option>
							<option value="D04" ${member.dept eq 'SI사업2팀'?'selected':'' }>SI사업2팀</option>
							<option value="D03" ${member.dept eq 'SI사업1팀'?'selected':'' }>SI사업1팀</option>
							<option value="D02" ${member.dept eq '부설연구소'?'selected':'' }>부설연구소</option>
							<option value="D01" ${member.dept eq '경영지원팀'?'selected':'' }>경영지원팀</option>
						</select>
			</tr>
			<tr>
				<td width="100"><p align="right"/>주소</td>
				<td colspan="3"><input type="text" id="addr" name="addr"  maxlength="50" style="width: 500px;" value="${member.addr }">
				<!-- <td width="100"><p align="right"/>주소</td>
				<td colspan="3"><input type="text" id="zip" name="zip" style="width: 100px;" placeholder="우편번호">
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
				<input type="text" id="addr1" name="addr1" style="width: 200px;" placeholder="주소">
				<input type="text" id="addr2" name="addr2" style="width: 200px;" placeholder="상세주소"></td> -->
			</tr>
			</table>
			<div class="btn">
			<input type="submit" value="수  정">
			<input type="button" value="목록으로 이동" onclick="location.href='/forwiz2/list.do'">
			</div>
	</form>
<script>
   		function checkIt(){   
        var update=document.update;
        if(!update.pwd.value){
            alert("비밀번호를 입력하세요");
            update.pwd.focus();
            return false;
        }
        if(!update.name.value){
            alert("사용자 이름을 입력하세요");
            update.name.focus();
            return false;
        }
        if(!update.addr.value){
            alert("주소를 입력하세요");
            update.addr.focus();
            return false;
        }
        if(!update.birth.value){
            alert("생일을 입력하세요");
            update.birth.focus();
            return false;
        }
        if(!update.gen.value){
            alert("성별을 입력하세요");
            update.gen.focus();
            return false;
        }
        if(!update.joinDate.value){
            alert("입사일자를 입력하세요");
            update.joinDate.focus();
            return false;
        }
	 	if(document.getElementById("phone").value.length>13) {
			alert("연락처를 다시 입력해주세요")
			document.getElementById("phone").value="";
			update.phone.focus();
			return false;
		}
	 	if(document.getElementById("tel").value.length>12) {
			alert("내선번호를 다시 입력해주세요")
			document.getElementById("tel").value="";
			update.tel.focus();
			return false;
		}
         if(!update.phone.value){
            alert("연락처를 입력하세요");
            update.phone.focus();
            return false;
        }
        if(!update.tel.value){
            alert("내선번호를 입력하세요");
            update.tel.focus();
            return false;
        }
        if(!update.dept.value){
            alert("부서명을 입력하세요");
            update.dept.focus();
            return false;
        }
        if(!update.position.value){
            alert("직급명을 입력하세요");
            update.position.focus();
            return false;
        }
        if(!update.email.value){
            alert("이메일을 입력하세요");
            update.email.focus();
            return false;
        }
        return true;
    }
    
   	$(document).on("keyup", "#phone", function() { $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^[0-9][0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); }); 
   	$(document).on("keyup", "#tel", function() { $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^[0-9][0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); }); 

	/* $(document).on("keyup", "#phone", function() { 
		var regtel = /^[0-9]*$/;
		phone = $(this).val();
		if(!regtel.test(phone)){
			alert("숫자만 입력하세요");
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		}
		
	});
	$(document).on("keyup", "#tel", function() { 
		var regtel = /^[0-9]*$/;
		tel = $(this).val();
		if(!regtel.test(tel)){
			alert("숫자만 입력하세요");
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		}
		
	}); */
	
/*     function execDaumPostcode() {
        new daum.Postcode({
        	oncomplete : function(data) {
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
				if (data.userSelectedType === 'R') { 
					addr = data.roadAddress;
				} else {
					addr = data.jibunAddress;
				}
				if (data.userSelectedType === 'R') {
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}
				document.getElementById('zip').value = data.zonecode;
				document.getElementById("addr1").value = addr;
				document.getElementById("addr2").focus();
			}
		}).open();
    } */
</script>
</c:when>
<c:otherwise>
<%
out.println("<script>window.onload=alert('권한이 없습니다.')</script>");
out.println("<script>location.href='list.do';</script>");
%>
</c:otherwise>
</c:choose>
</body>
</html>