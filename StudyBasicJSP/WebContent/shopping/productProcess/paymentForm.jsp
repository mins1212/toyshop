<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table align="center">
			<tr>
				<td width="200" align="left">결제계좌</td>
				<td width="400" align="left">
					<select name="account">
						<%
							String accountList = "";
							for(int i=0;i<accountLists.size();i++) {
								accountList = accountLists.get(i);
						%>
						<option value="<%=accountList%>"><%=accountList%></option>
						<%} %>
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