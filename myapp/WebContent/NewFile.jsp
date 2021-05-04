<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String user = "system";
	String pass = "1234";
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	stmt = conn.createStatement();
	// pstmt = conn.prepareStatement("select * from member");
	String userID = "test";
	String query = "SELECT * FROM MEMBER WHERE USERID = '" + userID + "'";
	// rs = pstmt.executeQuery();
	rs = stmt.executeQuery(query);
	
	out.println("<table border=\"1\">");
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString("userID")+"</td>");
		out.println("<td>"+rs.getString("userPW")+"</td>");
		out.println("<td>"+rs.getString("userName")+"</td>");		
	}
	out.println("</table>");
	
	conn.close();
%>
</body>
</html>