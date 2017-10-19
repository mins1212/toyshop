<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="toy.manager.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>index</title>
	<link rel="stylesheet" href="./css/default.css">
	<style type="text/css">
		.mainImg {
			width:100%;
			margin-bottom: 20px;
			margin-top:20px;
		}
		
		.main_line {
			width:100%;
			height:3px;
			background-color: #008100;
			margin-top: 10px;
		}
		
		.list_title {
			color:#008100;
		}
		
		.list_more {
			float:right;
			font-size: 13px;
			color:black;
			margin-top: 20px;
		}
		
		.content {
			width:30%;
			height:300px;
			text-align: center;
			position: relative;
		}
		
		.content_intro {
			width:100%;
			height:300px;
			position: absolute;
			top:0;right: 0;
			color:rgba(0,0,0,0);
			z-index: 2;
		}
		
		.content_intro:hover {
			background: rgba(0,0,0,0.4);
			position: absolute;
			top:0;right: 0;
			z-index: 2;
			text-align: center;
			color:white;
			font-size: 20px;
			line-height: 300%;
		}
		
		.content_img {
		 width:300px;
		 height:300px;
		 position: absolute;
		 top:0;right: 0;
		}
	</style>
</head>
<body>
	<%@include file="module/Top.jsp"%>
	<div id="container">
	<img class="mainImg" alt="main1" src="http://localhost:8088/StudyBasicJSP/shopping/images/shop/m_background.png">
	<%	
		ManagerDBBean dbBean = ManagerDBBean.getInstance();
		List<ToyKindDataBean>List = new ArrayList<ToyKindDataBean>();
		List<ToyDataBean>kindList = new ArrayList<ToyDataBean>();
		List = dbBean.getToyKind();
	%>
	<%
	for(int i = 0;i<List.size();i++) {
		String toy_kind = List.get(i).getToy_kind();
		kindList = dbBean.getToyList(toy_kind, 3);
	%>
	<h2 class="list_title"><%=List.get(i).getKind_title()%>의 top3 장난감<a class="list_more" href="./productProcess/list.jsp?toy_kind=<%=List.get(i).getToy_kind()%>"><%=List.get(i).getKind_title()%> 더보기 ▶</a></h2>
	<div class="main_line"></div>
	<table style="width:100%;margin-bottom: 30px;">
		<tr>
		<%for(int j = 0; j<kindList.size();j++) { %>
			<%if(kindList.get(j)!=null) {%>
			<td class="content">
				<a href="productProcess/content.jsp?num=<%=kindList.get(j).getNum()%>"><div class="content_intro"><%=kindList.get(j).getToy_title() %><br><%=kindList.get(j).getToy_price() %></div><img src="http://localhost:8088/StudyBasicJSP/imageFile/<%=kindList.get(j).getToy_image()%>" class="content_img">
				</a>
			</td>
			<%} else {%>
			<td class="content_img">
				<h4>준비 중</h4>
			</td>
			<%} 
			}%>
		</tr>
	</table>
	<%}%>
<%@include file="module/Footer.jsp" %>
</div>
</body>
</html>