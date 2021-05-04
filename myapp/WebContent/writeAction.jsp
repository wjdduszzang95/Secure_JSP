<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="borad.BoradDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="borad" class="borad.Borad" scope="page" />
<jsp:setProperty name="borad" property="TITLE" />
<jsp:setProperty name="borad" property="CONTENT" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if ((String) session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			if (borad.getTITLE() == null || borad.getCONTENT() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {

				BoradDAO boradDAO = new BoradDAO();
				int result = boradDAO.write(borad.getTITLE(), userID, borad.getCONTENT());

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.print("location.href = 'borad.jsp'");
					script.println("</script>");
				}
			}

		}
	%>
</body>
</html>