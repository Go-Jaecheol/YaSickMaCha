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
		String Aid = (String)session.getAttribute("Aid");
		if (Aid == null) response.sendRedirect("./index.html");
		
		HttpSession httpsession = request.getSession();
		httpsession.setAttribute("aid", Aid); //메뉴 관리시에 MANAGES 정보를 위함
    %>
	<nav class="navbar navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="./adminPage.jsp">컴학 야식마차! - 관리자용</a>
			<ul class="nav nav-tabs justify-content-end">
				<li class="nav-item">
					<a class="nav-link" href="./studentList.jsp">전체 학생리스트</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="./menuList.jsp">메뉴관리</a>
				</li>
				<li class="nav-item">	
					<a class="nav-link" href="./signout.jsp">SIGN OUT</a>
				</li>
			</ul>
		</div>
	</nav>
</body>
</html>