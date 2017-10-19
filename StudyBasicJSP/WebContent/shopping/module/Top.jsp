<%@page import="toy.shopping.MemberDataBean"%>
<%@page import="toy.shopping.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/default.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
MemberDBBean dbBeans = MemberDBBean.getInstance();
MemberDataBean dataBean = dbBeans.getMember(id);
%>
	<div id="wrap">
		<header id="header">
			<div id="top_nav">
				<ul class="tnv">
					<li><a href="#"><img src="http://localhost:8088/StudyBasicJSP/shopping/images/header/star.png" alt="즐겨찾기 추가" class="header_img">즐겨찾기 추가</a></li>
					<li><a href="http://localhost:8088/StudyBasicJSP/shopping/shopMain.jsp">Home</a></li>
					<%if(id==null) { %>
					<li><a href="http://localhost:8088/StudyBasicJSP/shopping/login/loginForm.jsp">로그인</a></li>
					<li><a href="http://localhost:8088/StudyBasicJSP/shopping/login/signUpForm.jsp">회원가입</a></li>
					<%} else { %>
					<li><a><font style="font-weight: bold"><%=dataBean.getName()%>님</font> 안녕하세요</a></li>
					<li><a href="http://localhost:8088/StudyBasicJSP/shopping/productProcess/cartList.jsp">장바구니</a></li>
					<li><a href="http://localhost:8088/StudyBasicJSP/shopping/login/logout.jsp">로그아웃</a></li>
					<%} %>
				</ul>
			</div>
			<div class="logo">
				<a href="http://localhost:8088/StudyBasicJSP/shopping/shopMain.jsp" alt="logo">
					<img src="http://localhost:8088/StudyBasicJSP/shopping/images/header/logo.png" class="logoImg">
				</a>
				<div class="top_search">
					<form>
						<input type="text" name="#" id="tSch" required="" onfocus="" class="t_sch" placeholder="검색">
						<input type="image" src ="http://localhost:8088/StudyBasicJSP/shopping/images/header/ts_button.png" class="btn_search">
					</form>
				</div>
			</div>
			<nav id="main_nav">
				<ul class="nav">
					<li><a href="#" target="_self">메뉴테그1</a></li>
					<li><a href="#" target="_self">메뉴테그2</a></li>
					<li><a href="#" target="_self">메뉴테그3</a></li>
					<li><a href="#" target="_self">메뉴테그4</a></li>
					<li><a href="#" target="_self">메뉴테그5</a></li>
					<li><a href="#" target="_self">메뉴테그6</a></li>
				</ul>
			</nav>
		</header>
	</div>
</body>
</html>