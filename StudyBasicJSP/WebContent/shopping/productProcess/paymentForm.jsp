<%@page import="toy.shopping.BankDBBean"%>
<%@page import="java.util.List"%>
<%@page import="toy.shopping.BankDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String deliveryName = request.getParameter("deliveryName");
	String deliveryTel = request.getParameter("deliveryTel");
	String deliveryAddress = request.getParameter("deliveryAddress");
	String deliveryText = request.getParameter("deliveryText");
	String buyer = (String)session.getAttribute("id");	
	
	BankDBBean dbBean = BankDBBean.getInstance();
	List<BankDataBean> accountList = dbBean.getAccount(buyer);
%>
	<table align="center">
			<tr>
				<td width="200" align="left">결제계좌</td>
				<td width="400" align="left">
					<select name="account">
						<%
							if (accountList != null) {
							String accountList = "";
							for(int i=0;i<accountLists.size();i++) {
								accountList = accountLists.get(i);
						%>
						<option value="<%=accountList%>"><%=accountList%></option>
							<%}
						} else {%>
						<option>계좌를 등록 하여 주세요</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="결제계좌" onclick="javascript:window.location=''">&nbsp;
				<input type="button" value="계좌수정" onclick="javascript:window.location=''">&nbsp;
				<input type="button" value="계좌삭제" onclick="javascript:window.location=''">&nbsp;
			</tr>
		</table>
</body>
</html>