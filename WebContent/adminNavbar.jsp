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
		/* String Aid = (String)session.getAttribute("Aid");
		if (Aid == null) response.sendRedirect("./index.html"); */
		
		/* HttpSession httpsession = request.getSession();
		httpsession.setAttribute("aid", Aid); //메뉴 관리시에 MANAGES 정보를 위함 */
		
		HttpSession httpsession = request.getSession();
		String Aid = (String)httpsession.getAttribute("Aid");
		httpsession.setAttribute("aid", Aid); //메뉴 관리시에 MANAGES 정보를 위함
		if (Aid == null) response.sendRedirect("index.jsp");
    %>
	
	<nav class="navbar navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" style="display: contents;" href="./adminPage.jsp"><img src="./image/logo.png" class="img-fluid" width="9%"></a>
			<ul class="nav nav-pills nav-fill justify-content-end" id="navTabs">
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="./studentList.jsp">전체 학생리스트</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="./menuList.jsp">메뉴관리</a>
				</li>
				<li class="nav-item">	
					<button class="nav-link" data-toggle="tab" data-bs-toggle="modal" data-bs-target="#realSignoutModal">SIGN OUT</button>
				</li>
			</ul>
		</div>
	</nav>
	
	<div class="modal fade" id="realSignoutModal" tabindex="-1" aria-labelledby="realSignoutModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
	  		<div class="modal-content">
	      		<div class="modal-header">
	        		<h5 class="modal-title" id="realSignoutModalLabel">알림</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      		</div>
				<div class="modal-body">
	       			<p>정말 SIGN OUT하시겠습니까?<N/p>
	   			</div>	
	   			<div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			        <button type="button" class="btn btn-primary" onclick="location.href='signout.jsp'">SIGN OUT</button>
		    	</div>
	   		</div>
	  	</div>
	</div>
</body>
</html>