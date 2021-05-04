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
<title>안전한 웹사이트</title>
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
		int IP_result = userDAO.select_ip(user.getUserID(),request.getRemoteAddr()); // 세션 재사용 방지 2021-05-04
		if(IP_result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('중복 로그인입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{  // 중복 로그인 아닐 시 로그인 프로세스 진행 2021-05-04
			int result = userDAO.login(user.getUserID(), user.getUserPW());
			if(result == 1){
				session.invalidate(); // 세션 고정 방지 2021-05-04
				HttpSession new_session = request.getSession(true); // 세션 고정 방지 2021-05-04
				new_session.setAttribute("userID", user.getUserID()); // 세션에 userID 저장
				new_session.setAttribute("userIP", request.getRemoteAddr()); // 세션에 접속IP 저장
				new_session.setAttribute("test", "test"); // git test 용				
				
				int IP_result2 = userDAO.insert_ip(user.getUserID(), request.getRemoteAddr()); // 세션 재사용 방지 2021-05-04
				if(IP_result2 == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('IP 추가 관련 데이터베이스 오류가 발생했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
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
		}
	%>
</body>
</html>