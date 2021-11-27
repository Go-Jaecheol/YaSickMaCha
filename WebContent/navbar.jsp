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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="./css/global.css">
<style type="text/css">
#main_nav {
	background-color: #efeeee;
  	box-shadow: 10px 10px 12px 0 rgba(0,0,0,.07);
  	border-radius: 0 0 10px 10px;
  	display: flex;
  	justify-content: flex-end;
  	align-items: center;
  	padding: 0;
  	list-style-type: none;
}
#main_nav .nav-item {
	padding: 10px;
}
#mypageLink, #signoutLink {
	padding: .5em 1em;
  	background: #efefef;
  	border: none;
  	border-radius: .5rem;
  	color: #444;
  	font-size: 1rem;
  	font-weight: 700;
  	letter-spacing: .2rem;
  	outline: none;
  	transition: .2s ease-in-out;
 	box-shadow: -6px -6px 14px rgba(255, 255, 255, .7),
    	         -6px -6px 10px rgba(255, 255, 255, .5),
        	      6px 6px 8px rgba(255, 255, 255, .075),
            	  6px 6px 10px rgba(0, 0, 0, .15);
}
#mypageLink:hover, #signoutLink:hover {
	box-shadow: -2px -2px 6px rgba(255, 255, 255, .6),
 	            -2px -2px 4px rgba(255, 255, 255, .4),
    	         2px 2px 2px rgba(255, 255, 255, .05),
        	     2px 2px 4px rgba(0, 0, 0, .1);
}
</style>
<title>YSMC</title>
</head>
<body>
	<%
		HttpSession session = request.getSession();
		Object getdata = session.getAttribute("user_name");
		String user_name = (String)getdata;
		if (user_name == null) response.sendRedirect("index.jsp");
    %>
	<nav class="navbar navbar-light bg-light" id="main_nav">
		<div class="container-fluid">
			<a class="navbar-brand" style="display: contents;" href="./main.jsp"><img src="./image/logo.png" class="img-fluid" width="9%"></a>
			<ul class="nav nav-pills nav-fill" id="navTabs">
				<li class="nav-item">
					<a id="mypageLink" class="nav-link" data-toggle="tab" href="./mypage.jsp"><%=user_name %>의 <i class="fas fa-user"></i></a>
				</li>
				<li class="nav-item">	
					<button id="signoutLink" class="nav-link" data-toggle="tab" data-bs-toggle="modal" data-bs-target="#realSignoutModal">SIGN OUT  <i class="fas fa-sign-out-alt"></i></button>
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
	       			<p>정말 SIGN OUT하시겠습니까?</p>
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