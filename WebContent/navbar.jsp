<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="./css/global.css">
<style type="text/css">
.nav-link {
	transition: background-color .5s;
}
.nav-link:hover {
	background-color: #0d6efd;
	color: white;
}
</style>
<title>YSMC</title>
</head>
<body>
	<%
		HttpSession session = request.getSession();
		Object getdata = session.getAttribute("user_name");
		String user_name = (String)getdata;
		if (user_name == null) response.sendRedirect("./index.html");
    %>
	<nav class="navbar navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" style="display: contents;" href="./main.jsp"><img src="./image/logo.png" width="9%"></a>
			<ul class="nav nav-pills nav-fill justify-content-end" id="navTabs">
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="./mypage.jsp"><%=user_name %>의 마이페이지</a>
				</li>
				<li class="nav-item">	
					<a class="nav-link" data-toggle="tab" href="./signout.jsp">SIGN OUT</a>
				</li>
			</ul>
		</div>
	</nav>
</body>
</html>