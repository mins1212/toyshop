<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="toy.manager.ToyKindDataBean"%>
<%@page import="toy.manager.ManagerDBBean"%>
<%@page import="org.apache.tomcat.util.modeler.ManagedBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/default.css">
<title>Insert title here</title>
</head>
<body>
<%
	ManagerDBBean dbBeanb = ManagerDBBean.getInstance();
	List<ToyKindDataBean>kindList = new ArrayList<ToyKindDataBean>();
	kindList = dbBeanb.getToyKind();
	%>
<div id="container">
	<div id="snb">
		<h2 id="rMenu">
			<img src = "images/header/rMenu.png" >
		</h2>
		<ul class="snb">
			<li><a href="http://localhost:8088/StudyBasicJSP/shopping/productProcess/list.jsp">전체보기</a></li>
			<%for(int i = 0; i < kindList.size();i++) {%>
				<li><a href="http://localhost:8088/StudyBasicJSP/shopping/productProcess/list.jsp?toy_kind=<%=kindList.get(i).getToy_kind()%>"><%=kindList.get(i).getKind_title()%></a></li>
			<%}%>
		</ul>
	</div>
</div>
</body>
</html>