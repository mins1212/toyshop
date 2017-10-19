<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "toy.shopping.CartDBBean" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartList</title>
</head>
<body bgcolor="<%=bodyback_c%>">

<%
String list = request.getParameter("list");
String form_name = request.getParameter("form_name");
String buyer = (String)session.getAttribute("id");
%>

<%
if(session.getAttribute("id")==null) {
	response.sendRedirect("shopMain.jsp");
} else {
	CartDBBean bookProcess = CartDBBean.getInstance();
	
	if(list.equals("all"))
		bookProcess.deleteAll(buyer);
	else
		bookProcess.deleteList(Integer.parseInt(list));
	
	response.sendRedirect(form_name + ".jsp");
%>

</body>
</html>
<%}%>