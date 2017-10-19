<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="toy.manager.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/default.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
	.m_container {
		padding:10px;
	}
	
	.m_listTable {
		text-align: center;
		width:95%;
		border-collapse: collapse;
	}
	
	.m_listTable td{
		border:1px dotted black;
	}
	
</style>
   <script type="text/javascript">
      $(document).ready(function () {
            $('.ssnb2').css('background', '#52c3ff');
      });
   </script>
</head>
<body>
	<%
	String managerId = "";
	
	try {
		managerId = (String)session.getAttribute("id");
		if(managerId == null || managerId.equals("")) {
			response.sendRedirect("../login/loginForm.jsp");
		} else {
	%>
	<div id="wrap">
	<%@include file="../module/Top_m.jsp"%>
	<%@include file="../module/Sidebar_m.jsp"%>
	<div id="container">
	<div class="m_container">
		<div class="m_insertTop">
		<h1>상품 수정/삭제</h1>
		</div>
		<div class="m_insertMain">
	<table class="m_listTable">
		<tr style="background-color: #52c3ff;">
			<td>글번호</td>
			<td>고유번호</td>
			<td>이미지</td>
			<td>분류</td>
			<td>가격</td>
			<td>제품명</td>
			<td>제조사</td>
			<td>수량</td>
			<td>글작성일</td>
			<td>수정/삭제</td>
		</tr>
	<%
		ManagerDBBean dbBean = ManagerDBBean.getInstance();
		List<ToyDataBean> toyList = dbBean.getToyList();
		for(int i = 0;i<toyList.size();i++) {
			ToyDataBean toyData = (ToyDataBean)toyList.get(i);
			int x = i+1;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String reg_date = sdf.format(toyData.getReg_date());
			String toy_kind = "";
			
			toy_kind = dbBean.getKindTitle(toyData.getToy_kind());
			
	%>
		<tr>
			<td><%=x%></td>
			<td><%=toyData.getNum() %></td>
			<td style="height:100px; width:100px;"><img src="http://localhost:8088/StudyBasicJSP/imageFile/<%=toyData.getToy_image()%>" width="100" height="100"></td>
			<td><%=toy_kind%></td>
			<td><%=NumberFormat.getInstance().format(toyData.getToy_price())%></td>
			<td><%=toyData.getToy_title()%></td>
			<td><%=toyData.getToy_maker()%></td>
			<td><%=toyData.getToy_count()%></td>
			<td><%=reg_date%></td>
			<td>
			<input type="button" onclick="javascript:window.location='toyUpdateForm.jsp?num=<%=toyData.getNum()%>&toy_kind=<%=toyData.getToy_kind()%>'" value="수정">
			<input type="button" onclick="javascript:window.location='toyDeleteForm.jsp?num=<%=toyData.getNum()%>'" value="삭제">
			</td>
		</tr>
	<%
		}
	%>
		
	</table>
	</div>
	<%
		}
	}catch(Exception e) {}
	%>
</div>
</div>
</div>
</body>
</html>