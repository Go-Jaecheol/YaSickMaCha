<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
    function handleMenuInfo(element) {
    	var info = element.getElementsByTagName("span");
    	var mid = info[0].innerHTML;
    	
    	document.location.href = "menuInfo.jsp?mid=" + mid;
    }
</script>
<style type="text/css">
html {
	height: 100%;
}
body {
	margin: 0;
	height: 100%;
	text-align: center;
}
#searchBar {
	display: flex;
	margin-top: 50px;
	height: 10%;
	padding-bottom: 20px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
#menuList {
	display: flex;
	flex-wrap: wrap;
	overflow: auto;
	margin-top: 50px;
	height: 60%;
	padding-bottom: 20px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
#menuContent {
	height: 150px;
 	width: 150px;
	margin: 5px;
	border: 2px solid;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
</style>
<title>YSMC</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<div id="searchBar" class="container">
		<form action="main.jsp" method="POST">
			<select name="year">
				<option value=''></option>
				<%
					String serverIP = "localhost";
					String strSID = "orcl";
					String portNum = "1521";
					String user = "db11";
					String pass = "db11";
					String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
					String query;
					Connection conn=null;
					PreparedStatement pstmt;
					ResultSet rs;
					
					Class.forName("oracle.jdbc.driver.OracleDriver");
					conn=DriverManager.getConnection(url, user, pass);
					query = "SELECT DISTINCT SUBSTR(SeasonId, 1, 4) "
							+ "FROM SEASON";
					pstmt=conn.prepareStatement(query);
					rs=pstmt.executeQuery();
					while(rs.next()){
						String seasonId = rs.getString(1);
				%>
						<option value=<%= seasonId %>><%= seasonId %>년</option>
				<%
					}
					rs.close();
					pstmt.close();
				%>
			</select>
			<select name="semester">
				<option value='1'>1학기</option>
				<option value='2'>2학기</option>
			</select>
			<select name="exam">
				<option value='M'>중간</option>
				<option value='F'>기말</option>
			</select>
			<input type="submit" value="submit">
		</form>
	</div>
	<div id="menuList" class="container">
	<% 
		String year = request.getParameter("year");
		String semester = request.getParameter("semester");
		String exam = request.getParameter("exam");
		
		String seasonId = year+semester+exam;
		String Sid = "";
		try {
			query = "SELECT Mid, Mname, Quantity, IsMenuForMembership, StoreN, Membership, Sid "
					+ "FROM MENU, STUDENT " 
					+ "WHERE SeasonId = ? "
					+ "AND Sname = ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, seasonId);
			pstmt.setString(2, user_name);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				// Fill out your code
				String Mid = rs.getString(1);
				String Mname = rs.getString(2);
				int Quantity = rs.getInt(3);
				String IsMenuForMembership = rs.getString(4);
				String StoreN = rs.getString(5);
				String Membership = rs.getString(6);
				Sid = rs.getString(7);
				
				if(IsMenuForMembership.equals("Y") && Membership.equals("N")) {
	%>
					<div id="menuContent" class="container" data-bs-toggle="modal" data-bs-target="#notMembership">
						<span><%=Mid %></span>
						<span><%=Mname %></span>
						<span><%=Quantity %></span>
						<span><%=IsMenuForMembership %></span>
						<span><%=StoreN %></span>
					</div>
	<%
				} else {
	%>
					<div id="menuContent" class="container" onclick="handleMenuInfo(this)">
						
						<span><%=Mid %></span>
						<span><%=Mname %></span>
						<span><%=Quantity %></span>
						<span><%=IsMenuForMembership %></span>
						<span><%=StoreN %></span>
					</div>
	<%	
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		rs.close();
		pstmt.close();
	%>
	</div>
	
	<!-- Not Membership Alert -->
	<div class="modal fade" id="notMembership" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalLabel">Alert</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        학생회비 납부자가 아닙니다.
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>