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
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}

		int ID = 0;
		if (request.getParameter("ID") != null) {
			ID = Integer.parseInt(request.getParameter("ID"));
		}
		if (ID == 0) {
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
		}
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

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form action="updateAction.jsp?ID=<%=ID%>" method="post">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd;">
					<tr>
						<td colspan="2"
							style="background-color: #eeeeee; text-align: center">게시판
							글수정 양식</td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							placeholder="글 제목" name="Title" maxlength="50"
							value="<%=borad.getTITLE()%>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용"
								name="Content" maxlength="2048" style="height: 350px;"><%=borad.getCONTENT()%></textarea></td>
					</tr>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>