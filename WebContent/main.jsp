<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
#menuContainer {
	display: flex;
	margin-top: 50px;
	height: 60%;
	padding-bottom: 20px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
</style>
<title>YSMC</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<div id="searchBar" class="container">
		<select id="year">
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
				conn.close();
			%>
		</select>
		<select id="semester">
			<option value='1'>1학기</option>
			<option value='2'>2학기</option>
		</select>
		<select id="exam">
			<option value='M'>중간</option>
			<option value='F'>기말</option>
		</select>
		<input type="submit" value="submit">
	</div>
	<div id="menuContainer" class="container">
		
	</div>
</body>
</html>