<%@page import="toy.shopping.MemberDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dataBean" class="toy.shopping.MemberDataBean">
	<jsp:setProperty name="dataBean" property="*"/>
</jsp:useBean>
<%
	Timestamp tmp = new Timestamp(System.currentTimeMillis());
	dataBean.setReg_date(tmp);
	
	MemberDBBean dbBean = MemberDBBean.getInstance();
	
	int x = dbBean.confirmId(dataBean.getId());
	
	if (x == 1) {
%>
	<script type="text/javascript">
		alert('아이디가 중복됩니다.');
		history.go(-1);
	</script>
<%
	} else {
	dbBean.insertMember(dataBean);
%>
	<script>
		alert('회원가입을 축하합니다.');
		window.location="../shopMain.jsp";
	</script>
<%
	}
%>
</body>
</html>