<%@page import="toy.shopping.CartDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartInsert</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>

<%
String toy_kind = request.getParameter("toy_kind");
String buy_count = request.getParameter("buy_count");
String toy_id = request.getParameter("toy_id");
String toy_title = request.getParameter("toy_title");
String toy_image = request.getParameter("toy_image");
String toy_price = request.getParameter("toy_price");
String buyer = (String)session.getAttribute("id");
%>

<jsp:useBean id="cart" scope="page" class="toy.shopping.CartDataBean">
</jsp:useBean>

<%
cart.setToy_id(Integer.parseInt(toy_id));
cart.setToy_image(toy_image);
cart.setToy_title(toy_title);
cart.setBuy_count(Byte.parseByte(buy_count));
cart.setToy_price(Integer.parseInt(toy_price));
cart.setBuyer(buyer);

CartDBBean bookProcess = CartDBBean.getInstance();
bookProcess.insertCart(cart);
response.sendRedirect("cartList.jsp?toy_kind="+toy_kind);
%>

</body>
</html>