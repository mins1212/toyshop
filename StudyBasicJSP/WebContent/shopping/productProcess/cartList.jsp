<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "toy.shopping.CartDataBean" %>
<%@ page import = "toy.shopping.CartDBBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.NumberFormat" %>

<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartList</title>
<link rel="stylesheet" href="../css/default.css">
<style type="text/css">
	.cart_title {
		margin-top: 70px;
		margin-bottom: 30px;
	}
	
	.cart_table {
		width:100%;
		border-collapse:collapse;
		text-align: center;
	}
	
	.cart_table td{
		border-bottom: solid #D5D5D5 1px;
	}
</style>
</head>
<body>
<%@include file="../module/Top.jsp"%>
<div id="container">
<%
String toy_kind = request.getParameter("toy_kind");
String buyer = (String)session.getAttribute("id");

if(buyer==null) {%>
<script type="text/javascript">
		alert("회원님만 이용 가능합니다.");
		window.location='../login/loginForm.jsp';
</script>
<%
}
List <CartDataBean>cartLists = null;
CartDataBean cartList = null;
int count = 0;
int number = 0;
int total = 0;

if(buyer==null) {
%>

<script type="text/javascript">
		alert("회원님만 이용 가능합니다.");
		window.location='../login/loginForm.jsp';
</script>

<%
} else {
	CartDBBean bookProcess = CartDBBean.getInstance();
	count = bookProcess.getListCount(buyer);
	if(count==0) {
%>
	<h3 class="cart_title"><b>Shopping cart</b></h3>
	
	<table align="center" class="cart_table">
		<tr height="100"><td>장바구니에 담긴 물품이 없습니다.</td></tr>
	</table>
	
	<input type="button" value="쇼핑계속" onclick ="javascript:window.location='list.jsp?book_kind=<%=toy_kind%>'">
	
	<%
	} else {
		cartLists = bookProcess.getCart(buyer);
	%>
		<h3 class="cart_title"><b>Shopping cart</b></h3>
		<hr>
			<table align="center" class="cart_table">
				<tr>
					<td colspan="6" height="30" style="background-color: #D5D5D5;">장바구니 상품</td>
				</tr>
				<tr style="background-color: #CEFBC9;" height="50">
					<td width="50">번호</td>
					<td width="50">이미지</td>
					<td width="250">책이름</td>
					<td width="100">판매가격</td>
					<td width="150">수량</td>
					<td width="150">금액</td>

				</tr>

				<%
					for(int i=0;i<cartLists.size();i++) {
						cartList = (CartDataBean)cartLists.get(i);
				%>
				
				<tr height="150">
					
					<td width="50"><%=++number %></td>
					<td width="150">
						<img src="../../imageFile/<%=cartList.getToy_image()%>"
						 border="0" height="150" aling="middle">
					</td>
					<td width="150" align="left">
						<%=cartList.getToy_title()%>
					</td>
					
					<td width="100"><%=NumberFormat.getInstance().format(cartList.getToy_price())%></td>
					
					<td width="150">
						<form name="inform" method="post" action="updateCart.jsp">
						<input type="text" name="buy_count" size="5" value="<%=cartList.getBuy_count()%>">
						<input type="hidden" name="cart_id" value="<%=cartList.getCart_id() %>">
						<input type="hidden" name="form_name" value="cartList">
						<input type="submit" value="수정">
						</form>
					</td>
					
					<td align="center" width="150">
						<%total += cartList.getBuy_count()*cartList.getToy_price();%>
						
						<%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getToy_price()) %>
						
						<input type="button" value="삭제" onclick="javascript:window.location='cartListDel.jsp?list=<%=cartList.getCart_id()%>&toy_kind=<%=toy_kind%>&form_name=cartList'">
					</td>
					
				</tr >
					<%}%>
				<tr height="50">
					<td colspan="6" align="right" style="padding-right:30px;color:blue;font-size:2;background-color: #CEFBC9"><b>총금액 : <%=NumberFormat.getInstance().format(total)%></b></td>
				</tr>
				<tr height="50">
					<td colspan="6">
					<input type="button" value="구매하기" onclick="javascript:window.location='buyForm.jsp'">
					<input type="button" value="쇼핑계속" onclick="javascript:window.location='list.jsp?toy_kind=<%=toy_kind%>'">
					<input type="button" value="장바구니 비우기" onclick="javascript:window.location='cartListDel.jsp?list=all&toy_kind=<%=toy_kind%>'">
					</td>
				</tr>
			</table>
	<%
		}
	}
%>
</div>
</body>
</html>