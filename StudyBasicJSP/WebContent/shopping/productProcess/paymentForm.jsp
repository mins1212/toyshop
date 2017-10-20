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

	String buyer = (String)session.getAttribute("id");	
	if(buyer==null) {
		%>

	<script type="text/javascript">
				alert("회원님만 이용 가능합니다.");
				window.location='../login/loginForm.jsp';
		</script>

	<%
	
	} else {

	String deliveryName = request.getParameter("deliveryName");
	String deliveryTel = request.getParameter("deliveryTel");
	String deliveryAddress = request.getParameter("deliveryAddress");
	String deliveryText = request.getParameter("deliveryText");
	
	BankDBBean dbBean = BankDBBean.getInstance();
	List<BankDataBean> accountList = dbBean.getAccount(buyer);
%>
	<table align="center">
			<tr>
				<td width="200" align="left">결제계좌</td>
				<td width="400" align="left">
					<select name="account">
					<%
						if (accountList.size() != 0) {
						String accountLists = "";
						for(int i=0;i<accountList.size();i++) {
							accountLists = accountList.get(i).getAccount();
							accountLists += accountList.get(i).getBank();
					%>
					<option value="<%=accountList%>"><%=accountList.get(i).getBank()%> <%=accountList.get(i).getAccount()%></option>
					<%}
						} else {
					%>
					<option>계좌를 등록 하여 주세요</option>
					<%
					}
					%>
			</select>
			</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="계좌추가" onclick="javascript:window.location='insertAccount.jsp'">&nbsp;
				<input type="button" value="계좌수정" onclick="javascript:window.location='updateAccount.jsp'">&nbsp;
				<input type="button" value="계좌삭제" onclick="window.open('', '_bank', 'width=400, height=400, resizable=no')">&nbsp;
			</tr>
		</table>
		<%} %>
</body>
</html>