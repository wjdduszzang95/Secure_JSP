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
		System.out.println("test");
	
		System.out.println("세션 token 값 : " + session.getAttribute("CSRF_Token"));
		System.out.println("request token 값 : " + request.getParameter("token"));
		System.out.println("세션 token type : " + session.getAttribute("CSRF_Token").getClass().getName());
		System.out.println("request token type : " + request.getParameter("token").getClass().getName());
	
		if(session.getAttribute("CSRF_Token") != request.getParameter("token")){ // 세션에 있는 토큰값과 요청에 있는 토큰값이 불일치 시
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('토큰 값이 일치하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");	
		}else{
			String userID = null;
			if((String)session.getAttribute("userID") != null){
				userID = (String)session.getAttribute("userID");
			}
			if(user.getUserPW() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 입력하세요.')");
				script.println("history.back()");
				script.println("</script>");	
			} else {
				
				UserDAO userDAO = new UserDAO();
				int result = userDAO.change_Password(userID, user.getUserPW());
				
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
		}

	%>
</body>
</html>