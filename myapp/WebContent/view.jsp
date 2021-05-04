<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="borad.BoradDAO"%>
<%@ page import="borad.Borad"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if ((String) session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int ID = 0;
		if (request.getParameter("ID") != null) {
			ID = Integer.parseInt(request.getParameter("ID"));
		}
		if (ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		Borad borad = new BoradDAO().getBorad(ID);
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<!-- 게시판 아이콘 작대기(-) 하나를 의미 -->
				<span class="icon-bar"></span>
				<!-- 게시판 아이콘 작대기(-) 하나를 의미 -->
				<span class="icon-bar"></span>
				<!-- 게시판 아이콘 작대기(-) 하나를 의미 -->
			</button>
			<a class="navbar-brand" href="main.jsp">취약한 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="borad.jsp">게시판</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>

		</div>
	</nav>
	<div class="container">
		<div class="row">

			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<tr>
					<th colspan="3"
						style="background-color: #eeeeee; text-align: center">게시판 글보기


					
					</td>
				</tr>
				<%-- .replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")
				 --%>
				<tr>
					<td style="width: 20%;">글 제목</td>
					<td colspan="2"><%= borad.getTITLE()%></td>
				</tr>
				<tr>
					<td style="width: 20%;">작성자</td>
					<td colspan="2"><%=borad.getNAME() %></td>
				</tr>
				<%-- .replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")  --%>
				<tr>
					<td style="width: 20%;">내용</td>
					<td colspan="2" style="min-height: 200px; text-align: left;">
					<%=
					borad.getCONTENT()
					%></td>
				</tr>
			</table>
			<a href="borad.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(borad.getNAME())){
			%>
				<a href="update.jsp?ID=<%= borad.getID() %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')"  href="deleteAction.jsp?ID=<%= borad.getID() %>" class="btn btn-primary">삭제</a>
			
			<%
				}
			%>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>