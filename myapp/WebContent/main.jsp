<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>안전한 웹사이트</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.select_ip((String) session.getAttribute("userID"),(String) session.getAttribute("userIP")); // 세션 재사용 방지
		if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('중복 로그인입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
		String userID = null;
		String userIP = null;
		String login_time = null;
		String auth = null;
		String exp_time = null;
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for (int i=0; i < cookies.length; i++){
				if(cookies[i].getName().equals("login_time")){
					login_time = cookies[i].getValue();
				}
				if(cookies[i].getName().equals("auth")){
					auth = cookies[i].getValue();
				}
				if(cookies[i].getName().equals("exp_time")){
					exp_time = cookies[i].getValue();
				}
			}
		}
		if ((String) session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			userIP = (String) session.getAttribute("userIP");
		}
		int auth_exp = sf.format(nowTime).compareTo( URLDecoder.decode(exp_time,"UTF-8")); // 불충분한 세션 만료 방지 2021-05-04
		if (auth_exp > 0) { // 불충분한 세션 만료 방지 2021-05-04
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('세션이 만료되었습니다.')");
			script.println("location.href='http://172.30.1.51/myapp/logoutAction.jsp'");
			script.println("</script>");
		} else {	    
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
			<a class="navbar-brand" href="main.jsp">안전한 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="borad.jsp">게시판</a></li>
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
		<div class="jumbotron">
			<div class="container"></div>
		<%
			if(auth.equals("admin")) {		
		%>
			<h1>관리자님 안녕하세요!!</h1>
			<h2>접속 정보</h2>
			<p> 로그인 ID : <%=userID %></p>
			<p> 로그인 IP : <%=request.getRemoteAddr() %></p>
			<p> 로그인 후 세션 ID : <%=session.getId() %></p>
			<p>	로그인 시간 : <%=URLDecoder.decode(login_time,"UTF-8") %> </p>
			<p>	현재 시간 : <%=sf.format(nowTime) %> </p>
			<p>	세션 만료 시간 : </p>
			<p>	쿠키 내 사용자 식별 값 : <%=auth %></p>
		<% 
			} else {
		%>
			<h1>접속 정보</h1>
			<p> 로그인 ID : <%=userID %></p>
			<p> 로그인 IP : <%=request.getRemoteAddr() %></p>
			<p> 로그인 후 세션 ID : <%=session.getId() %></p>
			<p>	로그인 시간 : <%=URLDecoder.decode(login_time,"UTF-8") %> </p>
			<p>	현재 시간 : <%=sf.format(nowTime) %> </p>
			<p>	세션 만료 시간 : <%=URLDecoder.decode(exp_time,"UTF-8") %></p>
			<p>	쿠키 내 사용자 식별 값 : <%=auth %></p>
		</div>
		<%}
		}
		%>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img alt="이미지1" src="images/1.jpg">
				</div>
				<div class="item">
					<img alt="이미지2" src="images/2.jpg">
				</div>
				<div class="item">
					<img alt="이미지3" src="images/3.jpg">
				</div>

			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>