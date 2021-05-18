<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="borad.BoradDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="borad.Borad"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취약한 웹사이트</title>
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
		}
		String ID = null;
		if (request.getParameter("ID") != null) {
		ID = request.getParameter("ID");
		}
		if (ID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='borad.jsp'");
			script.println("</script>");
		}
		Borad borad = new BoradDAO().getBorad(ID);
		if (!userID.equals(borad.getNAME())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='borad.jsp'");
			script.println("</script>");
		} else {

			BoradDAO boradDAO = new BoradDAO();
			int result = boradDAO.delete(ID);

			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제 성공했습니다.')");
				script.print("location.href = 'borad.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>