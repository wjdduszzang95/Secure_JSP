<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="borad.BoradDAO"%>
<%@ page import="borad.Borad"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>취약한 웹사이트</title>
<style type="text/css">
	a, a:hover{
		color: :#000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if ((String) session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber")!= null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		String searchWord = null;
		if(request.getParameter("searchWord")!= null){
			searchWord = (String)request.getParameter("searchWord");
			System.out.println(searchWord);
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
					<th style="background-color: #eeeeee; text-align: center">번호</th>
					<th style="background-color: #eeeeee; text-align: center">제목</th>
					<th style="background-color: #eeeeee; text-align: center">작성자</th>
				</tr>
					<%
						BoradDAO boradDAO = new BoradDAO();
						ArrayList<Borad> list = boradDAO.getSearchedList(pageNumber, searchWord);
						for(int i=0; i < list.size(); i++){
					%>
						<tr>
							<td><%= list.get(i).getID() %></td>
							<td><a href="view.jsp?ID=<%= list.get(i).getID() %>"><%= list.get(i).getTITLE()%></td>
							<td><%= list.get(i).getNAME()%></td>
						</tr>
				<tr>
					<h1 style="background-color: #eeeeee; text-align: center">완성된 쿼리 : <%= list.get(i).getQuery() %></h1>
				</tr>
					<%		
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
			<a href="searchedBorad.jsp?pageNumber=<%= pageNumber-1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(boradDAO.nextPage(pageNumber+1)){
			%>
			<a href="searchedBorad.jsp?pageNumber=<%= pageNumber+1 %>" class="btn btn-success btn-arrow-right">다음</a>
			<%		
				}
			%>
			<form method="get" action="searchedBorad.jsp">
			<div class="col-lg-4">
				<input type="text" class="form-control pull-right" placeholder="Search" name="searchWord" />
			</div>
				<button class="btn btn-primary" type="submit">
				<span class="glyphicon glyphicon-search">
				</span>
				</button>
			</form>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>