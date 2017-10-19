<%@page import="java.sql.Timestamp"%>
<%@page import="toy.shopping.BuyDBBean"%>
<%@page import="toy.shopping.CartDataBean"%>
<%@page import="toy.shopping.BuyDataBean"%>
<%@page import="toy.shopping.CartDBBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>buyPro.jsp</title>
</head>
<body>
	<%
		String deliveryName = request.getParameter("deliveryName");
		String deliveryTel = request.getParameter("deliveryTel");
		String deliveryAddress = request.getParameter("deliveryAddress");
		String deliveryText = request.getParameter("deliveryText");
		String buyer = (String)session.getAttribute("id");
		
		CartDBBean cart = CartDBBean.getInstance();
		List<CartDataBean> cartList = cart.getCart(buyer);
		
		BuyDataBean dataBean = new BuyDataBean();
		dataBean.setBuyer(buyer);
		dataBean.setCartList(cartList);
		dataBean.setDeliveryName(deliveryName);
		dataBean.setDeliveryTel(deliveryTel);
		dataBean.setDeliveryAddress(deliveryAddress);
 		dataBean.setBuyer_account("aaa");
		dataBean.setDeliveryText(deliveryText);
		dataBean.setBuy_date(new Timestamp(System.currentTimeMillis()));
		BuyDBBean dbBean = BuyDBBean.getInstance();
		
		dbBean.insertBuy(dataBean);
		
	%>
	
</body>
</html>