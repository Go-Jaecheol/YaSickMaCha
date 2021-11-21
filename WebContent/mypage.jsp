<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
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
	text-align: center;
}
#mypagePaper {
	margin-top: 50px;
	padding-bottom: 20px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
h3 {
	position: relative;
	padding: 20px;
	text-align: center;
}
.nav {
	justify-content: center;
}
</style>
<title>YSMC</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<div id="mypagePaper" class="container">
		<h3>MY PAGE</h3>
		<nav>
			<div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-info" type="button" role="tab" aria-controls="nav-home" aria-selected="true">회원 정보</button>
		    	<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-menu" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">신청 메뉴</button>
			</div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
  			<div class="tab-pane fade show active" id="nav-info" role="tabpanel" aria-labelledby="nav-home-tab">
  			<%
	  			String serverIP = "localhost";
	  			String strSID = "orcl";
	  			String portNum = "1521";
	  			String user = "db11";
	  			String pass = "db11";
	  			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	  			String query;
	  			String sname = user_name;
	  			String sid="", phone="", mem="", dno="";
	  			Connection conn=null;
	  			PreparedStatement pstmt;
	  			ResultSet rs;
	  			
	  			Class.forName("oracle.jdbc.driver.OracleDriver");
	  			conn=DriverManager.getConnection(url, user, pass);
	  			query = "SELECT Sid, Phone, Membership, Dno "
	  					+ "FROM STUDENT " 
	  					+ "WHERE Sname = ?";
	  			pstmt=conn.prepareStatement(query);
	  			pstmt.setString(1, sname);
	  			rs=pstmt.executeQuery();
	  			if (!rs.next()) { %>
				<script>
					alert("아이디나 비밀번호가 틀렸습니다.");
					document.location.href="./index.html";
				</script>
  				<% }
	  			else {
	  				sid = rs.getString(1);
	  				phone = rs.getString(2);
	  				mem = rs.getString(3);
	  				int d = rs.getInt(4);
	  				dno = (d == 1 ? "심컴" : "글솦");
	  				ResultSetMetaData rsmd = rs.getMetaData();
					out.println("<h4>"+sid+"</h4>");
					out.println("<h4>"+sname+"</h4>");
					out.println("<h4>"+phone+"</h4>");
					out.println("<h4>"+mem+"</h4>");
					out.println("<h4>"+dno+"</h4>");
				} %>
  			</div>
			<div class="tab-pane fade" id="nav-menu" role="tabpanel" aria-labelledby="nav-profile-tab">
				<% 
					query = "SELECT s.IsGet, m.Mname "
							+ "FROM SMENU_LIST s, MENU m " 
							+ "WHERE s.Sid = ? AND s.Mid = m.Mid";
					pstmt=conn.prepareStatement(query);
					pstmt.setString(1, sid);
					rs = pstmt.executeQuery();
					if (!rs.next()) out.println("No menu!");
					else {
						do {
							String isget = rs.getString(1);
							String mname = rs.getString(2);
							out.println(isget + " | " + mname);
						} while(rs.next());
					}
					
	  				rs.close();
	  				pstmt.close();
	  				conn.close();
				%>
			</div>
		</div>
	</div>
</body>
</html>