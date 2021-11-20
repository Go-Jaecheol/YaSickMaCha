<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style type="text/css">
html {
	height: 100%;
}
body {
	margin: 0;
	height: 100%;
}
</style>
<title>YSMC</title>
</head>
<body>
	<%
		String user_name = (String)session.getAttribute("user_name");
		if (user_name == null) response.sendRedirect("./index.html");
    %>
	<nav class="navbar navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="./main.jsp">컴학 야식마차!</a>
			<ul class="nav nav-tabs justify-content-end">
				<li class="nav-item">
					<a class="nav-link" href="./mypage.jsp"><%=user_name %>의 마이페이지</a>
				</li>
				<li class="nav-item">	
					<a class="nav-link" href="./signout.jsp">SIGN OUT</a>
				</li>
			</ul>
		</div>
	</nav>
</body>
</html>