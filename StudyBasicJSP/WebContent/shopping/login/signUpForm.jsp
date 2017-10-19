<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/default.css">
<style type="text/css">
	.signUp_main {
		width:400px;
		margin:0 auto;
		text-align: center;
	}
	
	.signUp_table {
		border-collapse: collapse;
	}
	
	.signUp_table td {
		border: 1px solid #747474;
		background-color:white;
		width:400px;
		height:40px;
	}

	.signUp_gonback {
		height:30px;
	}
	
	.signUp_table td input{
		width:400px;
		height:40px;
		background: transparent;
		border:none;
		padding:3px;
	}
	
	.signUp_logo {
		width:200px;
		margin-top:50px;
		margin-bottom: 50px;
	}
</style>
</head>
<body bgcolor="#CEFBC9">
<div id="container">
<div class="signUp_main">
<img src="../images/header/logo.png" class="signUp_logo">
<form method="post" action="signUpPro.jsp">
<table class="signUp_table">
	<tr>
		<td>
		<input type="text" name="id" placeholder="아이디">
		</td>
	</tr>
	<tr>
		<td>
		<input type="password" id="passwd" name="passwd" maxlength="20"  placeholder="비밀번호"> 
		</td>
	</tr>
	<tr>
		<td>
		<input type="password" id="passwdOk" maxlength="20" placeholder="비밀번호 재확인">
		</td>
	</tr>
</table>
<div class="signUp_gonback"></div>
<table class="signUp_table">
	<tr>
		<td>
		<input type="text" name="name" maxlength="20" placeholder="이름">
		</td>
	</tr>
	<tr>
		<td>
		<input type="text" name="address" maxlength="20"  placeholder="주소"> 
		</td>
	</tr>
	<tr>
		<td>
		<input type="tel" name="tel" maxlength="11" placeholder="전화번호">
		</td>
	</tr>
	<tr>
		<td style="background-color:#1DDB16;">
			<input type="submit" value="가입" class="signUp" style="color:white;font-size: 17px;">
		</td>
	</tr>
</table>
</form>
</div>
</div>
</body>
</html>


