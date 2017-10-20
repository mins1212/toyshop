<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%

	String buyer = (String)session.getAttribute("id");	
	if(buyer==null) {
		%>

	<script type="text/javascript">
				alert("회원님만 이용 가능합니다.");
				window.location='../login/loginForm.jsp';
		</script>

	<%
	
	} else {%>
	<h3>수정할 계좌를 선택하여 주세요</h3>
	<form action="insertAccountPro.jsp" method="post">
		은행 <input type="text" name="bank"> 계좌<input type="text"
			name="account"> <input type="submit" value="계좌 등록">
	</form>
	<%} %>
</body>
</html>