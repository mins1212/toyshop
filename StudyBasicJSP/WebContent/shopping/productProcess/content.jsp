<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="toy.manager.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.content_top {
		width:100%;
		height:50px;
		padding-top: 20px;
		padding-bottom: 20px;
		padding-left:10px;
	}
	
	.content_img {
		width:49.8%;
		height:400px;
		border-right:1px solid #8C8C8C;
		float:left;
	}
	
	.content_center {
		height:400px;
		border-top:2px #8C8C8C solid;
		border-bottom: 2px #8C8C8C solid;
	}
	.content_main{
		width:50%;
		height:400px;
		border-collapse: collapse;
	}
	
	.content_main td {
		padding-left: 20px;
	}
	
	.content_image {
		width:100%;
	}
	.content_point {
		background-color: #CEFBC9;
	}
	
	.content_point {
	border:1px #CEFBC9 solid;
	border-top:1px #8C8C8C solid;
	}
	
	.content {
		width:100%;
	}
	
	.bg {
		width:100%;
		height:40px;
		border-bottom:black solid 1px;
		padding-top:50px;
		padding-left:10px;
		margin:20px 0;
	}
	
	.content_a {
		font-weight: bold;
	}
	
	
</style>
<link rel="stylesheet" href="../css/default.css">
</head>
<body>
	<%@include file="../module/Top.jsp"%>
	<div id="container">
	<div style="clear:both">
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		ManagerDBBean dbBean = ManagerDBBean.getInstance();
		
		ToyDataBean article = dbBean.getToyArticle(num);
		
	%>

	
	<div class="content_top">
		<h2><font color="#22741C"><%=article.getToy_title()%></font></h2>
		<p><%=article.getToy_content() %></p>
	</div>
	<div class="content_center">
	<div class="content_img" style="text-align: center;"><img src="http://localhost:8088/StudyBasicJSP/imageFile/<%=article.getToy_image()%>" style="height:100%;"></div>
	<form method="post" action="cartInsert.jsp">
	<table class="content_main">
		<tr>
			<td width="30" class="content_a">상품코드</td>
			<td width="30"><%=article.getNum()%></td>
			
		</tr>
		<tr>
			<td class="content_a">제조사</td>
			<td><%=article.getToy_maker()%></td>
		</tr>
		<tr>
			<td class="content_a">총수량</td>
			<td><%=article.getToy_count() %></td>
		</tr>
		<tr>
			<td class="content_a"><s>원가</s></td>
			<td><s><%=NumberFormat.getInstance().format(article.getToy_price()) %></s></td>
		</tr>
		<tr>
			<td class="content_a">판매가</td>
			<td><font size="10px" color="#2F9D27">
			<%int buy_price = (int)(article.getToy_price()*((double)(100-article.getDiscount_rate())/100)); %>
			<%=NumberFormat.getInstance().format(buy_price)%></font>
			</td>
		</tr>
		<tr class="content_point">
			<td class="content_a" >구매수량</td>
			<td>
				<input type="number" maxlength="100" name="buy_count" value="1" style="width:40px;">
			</td>
		</tr>
		<tr class="content_point">
			<td class="content_a">예약배송일정</td>
			<td>2~3일 배송일 소요
				<input type="hidden" value="<%=article.getToy_kind()%>" name="toy_kind">
				<input type="hidden" value="<%=article.getNum()%>" name="toy_id" >
				<input type="hidden" value="<%=article.getToy_title()%>" name="toy_title">
				<input type="hidden" value="<%=article.getToy_image()%>" name="toy_image">
				<input type="hidden" value="<%=buy_price%>" name="toy_price">
			</td>
		</tr>
		<tr class="content_point" style="text-align: center;">
			<td colspan="2">
				<input type="submit" value="장바구니">
				<input type="button" value="바로 구매">
			</td>
		</tr>
	</table>
	</form>
	<div class="bg"><h4>상품상세정보▼</h4></div>
		<img src="http://localhost:8088/StudyBasicJSP/shopping/images/shop/content_1.png" alt="" class="content_image">
		<img src="../images/shop/imsi.jpg" class="content">
	</div>
	</div>
	</div>
</body>
</html>

