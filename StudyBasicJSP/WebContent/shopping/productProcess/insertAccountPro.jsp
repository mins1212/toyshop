<%@page import="toy.shopping.BankDBBean"%>
<%@page import="toy.shopping.BankDataBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8"); %>
	<%
	String bank = request.getParameter("bank");
	String account = request.getParameter("account");
	String buyer = (String)session.getAttribute("id");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	
	BankDataBean dataBean = new BankDataBean();
	
	dataBean.setId(buyer);
	dataBean.setBank(bank);
	dataBean.setAccount(account);
	dataBean.setReg_date(reg_date);
	
	BankDBBean dbBean = BankDBBean.getInstance();
	
	dbBean.insertBank(dataBean);
	
	response.sendRedirect("paymentForm.jsp");
	%>
</body>
</html>