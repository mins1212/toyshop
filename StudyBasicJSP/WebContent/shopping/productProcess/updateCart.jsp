<%@page import="toy.shopping.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart수량 update Pro</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8"); %>
	<%
		byte buy_count = Byte.parseByte(request.getParameter("buy_count"));
		int cart_id = Integer.parseInt(request.getParameter("cart_id"));
		String form_name = request.getParameter("form_name");
		
		CartDBBean dbBean = CartDBBean.getInstance();
		dbBean.updateCount(cart_id, buy_count);
		
		response.sendRedirect(form_name + ".jsp");
	%>
</body>
</html>