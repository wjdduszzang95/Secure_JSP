<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.net.URLEncoder"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty  name="user" property="userID" />
<jsp:setProperty  name="user" property="userPW"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취약한 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if((String)session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPW());
		if(result == 1){
			session.setAttribute("userID", user.getUserID()); // 세션에 userID 저장
			session.setAttribute("userIP", request.getRemoteAddr()); // 세션에 접속IP 저장
			
			Date nowTime = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
			
			String auth = null;
			if(user.getUserID() == "admin"){
				auth = "admin";
			}
			else{
				auth = user.getUserID();
			}
			String cookieName[] = {"auth","login_time"};
			String cookieValue[] = {auth,URLEncoder.encode(sf.format(nowTime),"UTF-8")};
			
			for(int i=0; i<cookieName.length; i++){
				Cookie cookie = new Cookie(cookieName[i],cookieValue[i]);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 성공했습니다.')");
			script.print("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>