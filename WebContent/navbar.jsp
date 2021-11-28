<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false" import="javax.servlet.http.HttpSession" %>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="./style/global.css?after">
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
</style>
<title>YSMC</title>
</head>
<body>
	<%
		HttpSession session = request.getSession();
		Object getdata = session.getAttribute("user_id");
		String user_id = (String)getdata;
		if (user_id == null) response.sendRedirect("index.jsp");
		
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		String query, sid=user_id, sname="", phone="", mem="", depart="";

		Connection conn=null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		
		query = "SELECT Sname, Phone, Membership, Dno "
				+ "FROM STUDENT " 
				+ "WHERE Sid = ?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, sid);
		rs=pstmt.executeQuery();
		if (rs.next()) {
			sname=rs.getString(1);
			phone=rs.getString(2);
			mem = (rs.getString(3).equals("N") ? "X" : "O");
			depart = (rs.getInt(4) == 1 ? "심컴" : "글솦");
		}
    %>
	<nav class="navbar navbar-light bg-light" id="main_nav">
		<div class="container-fluid">
			<a class="navbar-brand" style="display: contents;" href="./main.jsp"><img src="./image/logo.png" class="img-fluid" width="9%"></a>
			<ul class="nav nav-pills nav-fill" id="navTabs">
				<li class="nav-item">
					<a class="nav-link linkBtns" data-toggle="tab" href="./mypage.jsp"><%=sname %>의 <i class="fas fa-user"></i></a>
				</li>
				<li class="nav-item">	
					<button class="nav-link linkBtns" data-toggle="tab" data-bs-toggle="modal" data-bs-target="#realSignoutModal">SIGN OUT  <i class="fas fa-sign-out-alt"></i></button>
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
				<div class="modal-body text-center">
	       			<h3>정말 <button type="button" class="btn btn-danger modalBtns" onclick="location.href='signout.jsp'">SIGN OUT</button> 하시겠습니까?</h3>
	   			</div>
	   		</div>
	  	</div>
	</div>
</body>
</html>