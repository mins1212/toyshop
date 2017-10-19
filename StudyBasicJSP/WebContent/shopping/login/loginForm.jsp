<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
</style>
<link rel="stylesheet" href="../css/default.css">
</head>
<body>
	<%@include file="../module/Top.jsp"%>
	<%@include file="../module/Sidebar.jsp" %>
<div class="login_container">
<div class="shopping_login">
	<h3>▶ 로그인</h3><br>
	<hr>
	<div class="shopping_top">
		<h1>로그인이 필요한 페이지 입니다</h1>
		로그인을 하시면 각종 정보를 받아 보실 수 있습니다.
	</div>
	<div class="shopping_center">
		▼ 회원 로그인
		<form method="post" action="loginPro.jsp">
			<div class="shopping_id">
				<table>
				<tr>
					<td>
						아이디 <br><br>
						비밀번호 
					</td>
					<td>
						<input type="text" name="id"><br><br>
						<input type="password" name="passwd">
					</td>
					<td>
						<input type= "submit" value="로그인" style="height:65px;">
					</td>
				<tr>
				</table>
			</div>
		</form>
		<div class="shopping_bottom">
		아직 회원이 아니세요? ▶ <input type="button" value="회원가입">
		</div>
		<div class="shopping_bottom">
		관리자 로그인 ▶ <input type="button" value="관리자 로그인" onclick="javascript:window.location='../../manager/managerMain.jsp'">
		</div>
	</div>
</div>
</div>
</body>
</html>