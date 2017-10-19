<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="toy.manager.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		ManagerDBBean dbBean = ManagerDBBean.getInstance();
		dbBean.deleteToyArticle(num);
		
		response.sendRedirect("toyList.jsp");
	%>
</body>
</html>