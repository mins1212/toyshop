<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="toy.shopping.MemberDBBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("utf-8"); %>
	<%
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		MemberDBBean dbBean = MemberDBBean.getInstance();
		
		int x = dbBean.loginCheck(id, passwd);
		
		if(x==0) {
			session.setAttribute("id", id);
	%>
		<script type="text/javascript">
			alert("환영합니다 회원님");
			window.location='../shopMain.jsp';
		</script>
	<%	} else if(x == 1) {%>	
		<script type="text/javascript">
			alert("패스워드 오류 입니다.");
			history.go(-1);
		</script>
	<%	} else {%>
		<script type="text/javascript">
			alert("아이디 오류 입니다.");
			history.go(-1);
		</script>
		<%} %>
</body>
</html>