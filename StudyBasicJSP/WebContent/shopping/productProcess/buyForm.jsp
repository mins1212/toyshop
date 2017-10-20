<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="toy.shopping.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	<!--test-->
	.buy_wrap {
	width:80%;
	margin:0 auto;
	}
	
	.buy_wrap table {
		margin-bottom: 50px;
	}
	
	.buy_container {
	width:100%;
	margin:0 auto;
	}
	
	.buy_logo {
	float:left;
	width:100px;
	}
	
	.buy_title {
	float:left;
	color:#1DDB16;
	margin-left: 10px;
	margin-top:30px;
	}
	
	.buy_table {
		width:100%;
		border-bottom: 1px solid black;
		border-top:1px solid black;
		text-align: center;
	}
	
	.buy_table_point {
		background-color: #D5D5D5;
	}
	.div_bottom {
	text-align: center;
	width:100%;
	margin-bottom: 30px;
	}
	.buy_bottom {
		width:30%;
		height:30px;
		background: #006F00;
		color:white;
	}
	
</style>
</head>
<body bgcolor="#E6FFFF">
<div class="buy_wrap">
	<img src="../images/header/logo.png" class="buy_logo"><h1 class="buy_title">주문/결제</h1>
	
	<div id="buy_container" style="clear:both;">
	<%
	
	
	String toy_kind = request.getParameter("toy_kind");
	String buyer = (String)session.getAttribute("id");
	
	
	
	if(buyer==null) {
	%>
	
	<script type="text/javascript">
			alert("회원님만 이용 가능합니다.");
			window.location='../login/loginForm.jsp';
	</script>
	
	<%
	
	} else {
		List <CartDataBean>cartLists = null;
		CartDataBean cartList = null;
		int count = 0;
		int number = 0;
		int total = 0;
		CartDBBean bookProcess = CartDBBean.getInstance();
		count = bookProcess.getListCount(buyer);
		
		MemberDBBean memberDB = MemberDBBean.getInstance();
		MemberDataBean member = memberDB.getMember(buyer);
		
		if(count==0) {
	%>
		<h3 class="cart_title"><b>Shopping cart</b></h3>
		
		<table align="center" class="buy_table">
			<tr height="100"><td>장바구니에 담긴 물품이 없습니다.</td></tr>
		</table>
		
		<input type="button" value="쇼핑계속" onclick ="javascript:window.location='list.jsp?book_kind=<%=toy_kind%>'">
		
		<%
		} else {
			cartLists = bookProcess.getCart(buyer);
		%>
			<h3 class="cart_title"><b>Shopping cart</b></h3>
			<hr>
			<h4>주문 목록</h4>
				<table align="center" class="buy_table">
					<tr class="buy_table_point" height="50">
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
							<input type="hidden" name="form_name" value="buyForm">
							<input type="submit" value="수정">
							</form>
						</td>
						
						<td align="center" width="150">
							<%total += cartList.getBuy_count()*cartList.getToy_price();%>
							
							<%=NumberFormat.getInstance().format(cartList.getBuy_count()*cartList.getToy_price()) %>
							
							<input type="button" value="삭제" onclick="javascript:window.location='cartListDel.jsp?list=<%=cartList.getCart_id()%>&toy_kind=<%=toy_kind%>&form_name=buyForm'">
						</td>
						
					</tr >
						<%}%>
				</table>
				
				<form action="paymentForm.jsp" method="post">
				<h4>구매자 정보</h4>
				<table class="buy_table">
					<tr>
						<td class="buy_table_point">이름</td>
						<td style="text-align: left;" ><input type="text" value="<%=member.getName()%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="buy_table_point">휴대폰</td>
						<td style="text-align: left;"><input type="tel" style="width:50%;" value="<%=member.getTel()%>" readonly="readonly"></td>
					</tr>
					<tr>
						<td class="buy_table_point">주소</td>
						<td style="text-align: left;"> <input type="text" style="width:80%;" value="<%=member.getAddress()%>" readonly="readonly"></td>
					</tr>
				</table>
				
				<h4>받는 사람 정보</h4>
				<table class="buy_table">
					<tr>
						<td class="buy_table_point">이름</td>
						<td style="text-align: left;" ><input type="text" name="deliveryName"></td>
					</tr>
					<tr>
						<td class="buy_table_point">휴대폰</td>
						<td style="text-align: left;"><input type="tel" style="width:50%;" name="deliveryTel"></td>
					</tr>
					<tr>
						<td class="buy_table_point">주소</td>
						<td style="text-align: left;"> <input type="text" style="width:80%;" name="deliveryAddress"></td>
					</tr>
					<tr>
						<td class="buy_table_point">배송메세지</td>
						<td style="text-align: left;"><input type="text" style="width:80%;" name="deliveryText" placeholder="배송 메세지 입력"></td>
					</tr>
				</table>
				<h4>결제정보</h4>
				<table class="buy_table">
				<tr class="buy_table_point">
					<td>주문금액</td>
					<td>배송비</td>
					<td>총 금액</td>
				</tr>
				<tr>
				<tr>
					<td><%=NumberFormat.getInstance().format(total)%></td>
					<td>0</td>
					<td><%=NumberFormat.getInstance().format(total)%></td>
				</tr>
				</table>
			<div class="div_bottom">
			<input type="submit" value="결제하기" class="buy_bottom">
			</div>
			</form>
		<%
			}
		}
	%>
</div>
</div>

</body>
</html>