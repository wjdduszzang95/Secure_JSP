<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
	UserDAO userDAO = new UserDAO();
	int result = userDAO.delete_ip((String) session.getAttribute("userID")); // 로그인 IP 삭제
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('IP 삭제 관련 데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	session.invalidate();
	%>
	<script type="text/javascript">
		location.href = 'login.jsp';
	</script>
</body>
</html>