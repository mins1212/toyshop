<%@page import="toy.shopping.BankDataBean"%>
<%@page import="java.util.List"%>
<%@page import="toy.shopping.BankDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function accountVal(val) {
		document.getElementById("sal").value = "dd";	
	}
</script>
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
	
	if(accountList.size() == 0) {
	%>
		<script type="text/javascript">
			alret('수정할 수 있는 계좌가 없습니다. 계좌를 등록하여 주세요');
			history.go(-1);
		</script>
	<%
	}
	%>
	<table align="center">
		<tr>
			<td width="200" align="left">결제계좌</td>
			<td width="400" align="left">
			<select name="account" onchange='accountVal(a)'>
					<%
					
					String accountLists = "";
					for(int i=0;i<accountList.size();i++) {
						accountLists = accountList.get(i).getAccount();
						accountLists += accountList.get(i).getBank();
				%>
					<option value="<%=accountList.get(i).getAccount()%>"><%=accountList.get(i).getBank()%> <%=accountList.get(i).getAccount()%></option>
					<%}
				%>
			</select></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<input type="button" value="계좌수정" onclick="javascript:window.location=''">
			</td>
		</tr>
	</table>
	<h3>계좌를 추가합니다.</h3>
	<form action="insertAccountPro.jsp" method="post">
		은행 <input type="text" name="bank" id="sal"> 
		계좌<input type="text"name="account"> 
		<input type="submit" value="계좌 등록">
	</form>
	<%} %>
</body>
</html>