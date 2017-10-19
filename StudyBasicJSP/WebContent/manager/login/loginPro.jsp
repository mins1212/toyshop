<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session"%>
<%@ page import="toy.manager.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginPro 창</title>
</head>
<body>
	
	<% request.setCharacterEncoding("utf-8");
	%>
	
<%-- 	<jsp:useBean id="data" class="toy.manager.ManagerDataBean" >
		<jsp:setProperty name="data" property="*"/>
	</jsp:useBean> --%>
	
	<%	
		ManagerDataBean data = new ManagerDataBean();
		data.setId(request.getParameter("id"));
		data.setPasswd(request.getParameter("passwd"));
		ManagerDBBean article = ManagerDBBean.getInstance();
		int x = article.managerLoginCheck(data);
		
		if(x==0) {
			session.setAttribute("id", data.getId());
	%>
		<script type="text/javascript">
			alert("환영합니다 사원님");
			window.location='../managerMain.jsp';
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