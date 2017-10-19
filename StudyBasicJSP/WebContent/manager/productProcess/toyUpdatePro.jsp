<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@page import="toy.manager.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%request.setCharacterEncoding("utf-8");%>

<%
String realFolder="";
String filename="";

MultipartRequest mrequest = null;

String saveFolder="/imageFile";
String encType="utf-8";
int maxSize = 2*1024*1024;

ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);

try {
	mrequest = new MultipartRequest(
			request,
			realFolder,//파일을 업로드 할 폴더 imageFile
			maxSize,
			encType,
			new DefaultFileRenamePolicy()
			);
	
	Enumeration <?> files = mrequest.getFileNames();
	
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		filename = mrequest.getFilesystemName(name);
	}
} catch(Exception e) {
	e.printStackTrace();
}
%>
<%
	

	Timestamp tmp = new Timestamp(System.currentTimeMillis());
	ToyDataBean article = new ToyDataBean();
	
	int toy_num = Integer.parseInt(mrequest.getParameter("num"));
	String toy_kind = mrequest.getParameter("toy_kind");
	int toy_price = Integer.parseInt(mrequest.getParameter("toy_price"));
	String toy_title = mrequest.getParameter("toy_title");
	String toy_maker = mrequest.getParameter("toy_maker");
	int toy_count = Integer.parseInt(mrequest.getParameter("toy_count"));
	String toy_content = mrequest.getParameter("toy_content");
	int discount_rate = Integer.parseInt(mrequest.getParameter("discount_rate"));
	
 	article.setNum(toy_num);
	article.setToy_kind(toy_kind);
	article.setToy_price(toy_price);
	article.setToy_title(toy_title);
	article.setToy_maker(toy_maker);
	article.setToy_count(toy_count);
	article.setToy_content(toy_content);
	article.setToy_image(filename);
	article.setDiscount_rate(discount_rate);
	
	ManagerDBBean dbbean = ManagerDBBean.getInstance();
	
	dbbean.updateToyArticle(article);
	
	response.sendRedirect("toyList.jsp");
%>
</body>
</html>