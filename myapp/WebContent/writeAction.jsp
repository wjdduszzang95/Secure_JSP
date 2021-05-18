<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="borad.BoradDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="borad" class="borad.Borad" scope="page" />
<%-- <jsp:setProperty name="borad" property="TITLE" />
<jsp:setProperty name="borad" property="CONTENT" /> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취약한 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
			
		int sizeLimit = 10 * 1024 * 1024; // 10메가
		String savePath = request.getRealPath("/upload");
		
		MultipartRequest multi = null;
		
		try{
		multi = new MultipartRequest(request, savePath, sizeLimit, 
				"UTF-8", new DefaultFileRenamePolicy());
		} catch(Exception e) {
			e.printStackTrace();
		}
		String TITLE = multi.getParameter("TITLE");
		String CONTENT = multi.getParameter("CONTENT");
		
		String filename = multi.getFilesystemName("FILE");
		String Origin_filename = multi.getOriginalFileName("FILE");
		
		System.out.println("원본 파일명 : " + Origin_filename);
		System.out.println("서버에 업로드 된 파일명 : " + filename);
		
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
 			if (multi.getParameter("TITLE") == null || multi.getParameter("CONTENT") == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {					
					BoradDAO boradDAO = new BoradDAO(); 
					int result = boradDAO.write(TITLE, userID, CONTENT, filename, Origin_filename);
			
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