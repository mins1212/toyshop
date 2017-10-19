<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="toy.manager.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/default.css">
<script type="text/javascript" src="../js/managerJs.js"></script>
<style type="text/css">
	.m_container {
		padding:10px;
	}
</style>
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
   <script type="text/javascript">
      $(document).ready(function () {
            $('.ssnb1').css('background', '#52c3ff');
      });
   </script>
</head>
<body>

<%
String managerId = "";
try {
	managerId = (String)session.getAttribute("id");
	if(managerId == null||managerId.equals("")) {
		response.sendRedirect("../managerMain.jsp");
	} else {
%>
<div id="wrap">
<%@include file="../module/Top_m.jsp" %>
<%@include file="../module/Sidebar_m.jsp" %>
<div id="container">
<div class="m_container">
<div class="m_insertTop">
	<h1>상품 추가</h1>
</div>
<div class="m_insertMain">
<form method="post" name ="insertForm" action="toyInsertPro.jsp" enctype="multipart/form-data">
<%

ManagerDBBean dbBean = ManagerDBBean.getInstance();
List<ToyKindDataBean>kindList = new ArrayList<ToyKindDataBean>();
kindList = dbBean.getToyKind();

Timestamp tmp = new Timestamp(System.currentTimeMillis());
SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
String today = smf.format(tmp);

%>
<table>
	<tr>
		<td>상품 카테고리</td>
		<td colspan="3">
			<select name="toy_kind">
			<%for(int i = 0; i < kindList.size();i++) {%>
					<option value="<%=kindList.get(i).getToy_kind()%>"><%=kindList.get(i).getKind_title()%></option>
			<%}%>
			</select>
		</td>
	</tr>
	<tr>
		<td>판매 가격</td>
		<td>
			<input type="text" size="10" maxlength="9" name="toy_price">
		</td>
		<td>할인율</td>
		<td>
			<input type="text" size="10" maxlength="9" name="discount_rate">
		</td>
	</tr>
	<tr>
		<td>상품코드</td>
		<td>(상품코드 자동입력)</td>
		<td>등록일자</td>
		<td><input type="text" value="<%=today%>" readonly="readonly" style="background:rgba(189,189,189,0.5);"></td>
	</tr>
	<tr>
		<td>상품명</td>
		<td colspan="3">
			<input type="text" name="toy_title">
		</td>
	</tr>
	<tr>
		<td >제조사</td>
		<td colspan="3">
			<input type="text" name="toy_maker">
		</td>
	</tr>
	<tr>
		<td>총 수량</td>
		<td colspan="3">
			<input type="number" name="toy_count" maxlength="30">
		</td>
	</tr>
	<tr>
		<td>상품설명</td>
		<td colspan="3"><textarea rows="15" cols="50" name="toy_content"></textarea></td>
	</tr>
	<tr>
		<td>상품 이미지</td>
		<td colspan="3">
			<input type="file" name="toy_image">
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="">
		</td>
	</tr>
</table>
</form>
</div>
<%		}
	} catch(Exception e) {}
%>
</div>
</div>
</div>
</body>
</html>