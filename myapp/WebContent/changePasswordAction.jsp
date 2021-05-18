<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty  name="user" property="userPW"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취약한 웹 사이트</title>
</head>
<body>
	<%
			String userID = null;
			String New_userPW = request.getParameter("New_userPW"); 
			if((String)session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			}
			if(New_userPW == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 입력하세요.')");
				script.println("history.back()");
				script.println("</script>");	
			} else {
				UserDAO userDAO = new UserDAO();
				int result = userDAO.change_Password(userID, New_userPW);
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호 변경 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('비밀번호 변경 성공했습니다')");
					script.print("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}
	%>
</body>
</html>