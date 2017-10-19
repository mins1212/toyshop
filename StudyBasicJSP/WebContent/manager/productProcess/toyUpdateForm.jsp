<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="toy.manager.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Timestamp"%>
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
<title>Upload</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
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
	if(managerId == null||managerId.equals("")) {
		response.sendRedirect("../managerMain.jsp");
	} else {
		int num = Integer.parseInt(request.getParameter("num"));
		String toy_kind = request.getParameter("toy_kind");
%>
<div id="wrap">
<%@include file="../module/Top_m.jsp" %>
<%@include file="../module/Sidebar_m.jsp" %>
<div id="container">
<div class="m_container">
	<form method="post" name ="insertForm" action="toyUpdatePro.jsp" enctype="multipart/form-data">
	<%
		ManagerDBBean dbBean = ManagerDBBean.getInstance();
		
		ToyDataBean dataBean = new ToyDataBean();
		dataBean = dbBean.getToyArticle(num);
		List<ToyKindDataBean>kindList = new ArrayList<ToyKindDataBean>();
		kindList = dbBean.getToyKind();
	%>
	<input type="hidden" value="<%=num%>" name="num">
	<table>
		<tr>
			<td>상품 카테고리</td>
			<td colspan="3">
				<select name="toy_kind">
				<%for(int i = 0; i < kindList.size();i++) {%>
						<option value="<%=kindList.get(i).getToy_kind()%>" <%if(kindList.get(i).getToy_kind().equals(kindList.get(i).getKind_title())){%>selected="selected"<%}%>><%=kindList.get(i).getKind_title()%></option>
				<%}%>
				</select>
			</td>
		</tr>
		<tr>
			<td>판매 가격</td>
			<td>
				<input type="text" size="10" maxlength="9" name="toy_price" value="<%=dataBean.getToy_price()%>">
			</td>
			<td>할인율</td>
			<td>
				<input type="text" size="10" maxlength="9" name="discount_rate" value="<%=dataBean.getDiscount_rate()%>">
			</td>
		</tr>
		<tr>
			<td>상품코드</td>
			<td>(상품코드 자동입력)</td>
			<td>등록일자</td>
			<%
				SimpleDateFormat smf = new SimpleDateFormat("yyyy-MM-dd");
				String today = smf.format(dataBean.getReg_date());
			%>
			<td><input type="text" value="<%=today%>" readonly="readonly" style="background:rgba(189,189,189,0.5);">
			</td>
		</tr>
		<tr>
			<td>상품명</td>
			<td colspan="3">
				<input type="text" name="toy_title" value="<%=dataBean.getToy_title()%>">
			</td>
		</tr>
		<tr>
			<td >제조사</td>
			<td colspan="3"> 
				<input type="text" name="toy_maker" value="<%=dataBean.getToy_maker()%>">
			</td>
		</tr>
		<tr>
			<td>총 수량</td>
			<td colspan="3">
				<input type="number" name="toy_count" maxlength="30" value="<%=dataBean.getToy_count()%>">
			</td>
		</tr>
		<tr>
			<td>상품설명</td>
			<td colspan="3"><textarea rows="15" cols="50" name="toy_content"><%=dataBean.getToy_content()%></textarea></td>
		</tr>
		<tr>
			<td>상품 이미지</td>
			<td colspan="3">
				<input type="file" name="toy_image"><%=dataBean.getToy_image()%>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<input type="submit" value="수정">
				<input type="button" value="취소" onclick="">
			</td>
		</tr>
	</table>
	</form>
	<%		}
		} catch(Exception e) {}%>
</div>
</div>
</div>
</body>
</html>