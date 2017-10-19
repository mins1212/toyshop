<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니저 로그인 창</title>
<link rel="stylesheet" href="../../shopping/css/default.css">
<link rel="stylesheet" href="../css/default.css">
<style type="text/css">
 #header {
 	height:50px;
 }
 
 #top_nav {
    border-bottom: 0px;
}
</style>
</head>
<body>
<div id="wrap">
<%@include file="../module/Top_m.jsp"%>

<div class="shopping_login">
	<h2>▶ 관리자 로그인</h2><br>
	<hr>
	<div class="shopping_top">
		<h1>관리자 페이지 로그인 입니다.</h1>
		환영합니다 사원님 좋은 하루 되십시오.
	</div>
	<div class="shopping_center">
		▼ 관리자 로그인
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
		관리자가 아니세요? ▶ <input type="button" value="회원 로그인" onclick="javascript:window.location='../../shopping/login/loginForm.jsp'">
		</div>
	</div>
</div>
</div>
</body>
</html>