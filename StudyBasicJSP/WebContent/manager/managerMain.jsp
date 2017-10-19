<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/default.css">
</head>
<body>
<%
	String managerId = "";
	try {
	managerId = (String)session.getAttribute("id");
	if(managerId == null||managerId.equals("")) {
		response.sendRedirect("login/loginForm.jsp");
	} else {
%>
	<div id="wrap">
		<%@include file="module/Top_m.jsp"%>
		<%@include file="module/Sidebar_m.jsp"%>
		<div id="container">
			<div class="m_container">
				<div class="m_main"></div>
				<div class="m_name">
					<h1><span class="m_accent"><%=managerId%></span>님 안녕하세요.</h1>
				</div>
				<div class="m_bt">
					<div class="m_bt1"><a href="http://localhost:8088/StudyBasicJSP/manager/productProcess/toyInsertForm.jsp">물품 등록</a></div>
					<div class="m_bt2"><a href="http://localhost:8088/StudyBasicJSP/manager/productProcess/toyList.jsp">물품 수정/삭제</a></div>
					<div class="m_bt3"><a href="#">전체 판매 목록 보기</a></div>
				</div>
				<%}
	}catch(Exception e) {
		e.printStackTrace();
	}
	%>
			</div>
		</div>
	</div>
</body>
</html>