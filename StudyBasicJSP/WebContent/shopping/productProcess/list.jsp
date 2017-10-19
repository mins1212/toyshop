<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="toy.manager.ManagerDataBean"%>
<%@page import="toy.manager.ManagerDBBean"%>
<%@page import="toy.manager.ToyDataBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/default.css">
<style type="text/css">
	.list_container {
		float:left;
		width:79%;
		padding: 20px;
	}
	.list_table {
		width:100%;
		border-collapse: collapse;
	}
	
	.list_table a{
		color:black;
	}
	
	.list_table td {
		border-bottom: 1px solid #8C8C8C;
	}
</style>
</head>
<body>
<%@include file="../module/Top.jsp"%>
<%@include file="../module/Sidebar.jsp" %>
<div id="container">
<div class="list_container">
<%
	String toy_kind = request.getParameter("toy_kind");
%>
	<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	List<ToyDataBean> toyLists = null;
	ToyDataBean toyList = null;
	String toy_kindName="";
	
	ManagerDBBean dbBean = ManagerDBBean.getInstance();
	
	
	if(toy_kind == null) {
		toy_kindName = "전체";
		toyLists = dbBean.getToyList();
	}
	else {
		toyLists = dbBean.getToyList(toy_kind);
		toy_kindName = dbBean.getKindTitle(toy_kind);
	}
	
	%>
	
	<h3><b><%=toy_kindName%> 분류목록</b></h3>
	<hr color="black">
	<table class="list_table">
 	<%
	for(int i=0;i<toyLists.size();i++) {
		ToyDataBean toy_article;
		toy_article = (ToyDataBean)toyLists.get(i);
	%>
	<!-- 데이터 하나당 테이블 생성 -->
	
		<tr>
			<td>
				<a href="content.jsp?num=<%=toy_article.getNum()%>"><img src="http://localhost:8088/StudyBasicJSP/imageFile/<%=toy_article.getToy_image()%>" height="150"></a>
			</td>
			<td><a href="content.jsp?num=<%=toy_article.getNum()%>">
				<%=toy_article.getToy_title()%><br><br>
				<font style="font-size: 10px;">[<%=toy_article.getToy_maker()%>]</font></a>
			</td>
			<td>
				<s><%=NumberFormat.getInstance().format(toy_article.getToy_price())%></s><br>
				<font size="6px" color="#2F9D27">
				<%int buy_price = (int)(toy_article.getToy_price()*((double)(100-toy_article.getDiscount_rate())/100)); %>
				<%=NumberFormat.getInstance().format(buy_price)%></font>
			</td>
			<td>
				<%=sdf.format(toy_article.getReg_date())%>
			</td>
		</tr>
	<%} %>
	</table>
	</div>
	</div>
</html>