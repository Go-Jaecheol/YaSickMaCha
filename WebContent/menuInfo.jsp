<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ include file="./navbar.jsp" %>
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
#menuInfo {
	display: flex;
	flex-wrap: wrap;
	flex-direction: column;
	overflow: auto;
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
	<div id="menuInfo" class="container">
	<% 
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		String query;
		Connection conn=null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		
		String menu_id = request.getParameter("mid");
		String modal_name = "#completeModal";
		String Sid = "";
		int menu_quan = 0;
		query = "SELECT Mname, Quantity, IsMenuForMembership, StoreN "
				+ "FROM MENU "
				+ "WHERE Mid = ?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, menu_id);
		rs=pstmt.executeQuery();
		while(rs.next()){
			String Mname = rs.getString(1);
			int Quantity = rs.getInt(2);
			String IsMenuForMembership = rs.getString(3);
			String StoreN = rs.getString(4);
			menu_quan = Quantity;
	%>
			<h2><%=Mname %></h2>
			<p id="menuInfoStore"><%=Quantity %></p>
	        <p id="menuInfoQuantity"><%=IsMenuForMembership %></p>
	        <p id="menuInfoMembership"><%=StoreN %></p>
	<% 
		}
		query = "SELECT Mid, STUDENT.Sid "
				+ "FROM SMENU_LIST, STUDENT " 
				+ "WHERE Sname = ? "
				+ "AND SMENU_LIST.Sid = STUDENT.Sid";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, user_name);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			String rsMid = rs.getString(1);
			Sid = rs.getString(2);
			if(rsMid.equals(menu_id)) {
				modal_name = "#duplicatedModal";
				break;
			}
		}
	%>
		<div class="modal-footer">
	      	<button class="btn btn-info" data-bs-target=<%=modal_name %> data-bs-toggle="modal">신청</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	    </div>
	<%
		rs.close();
		pstmt.close();
	%>
	</div>
	<!-- Complete Alert -->
	<div class="modal fade" id="completeModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalLabel">Complete</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<p id="modalMessage"></p>
	      	<form action="menuInfoUpdate.jsp" method="POST">
	      		<button type="submit" name="mid" value=<%=menu_id %> class="btn btn-info">신청</button>
	      	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Duplicated Alert -->
	<div class="modal fade" id="duplicatedModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalLabel">Alert</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<p id="modalMessage">이미 신청한 메뉴입니다.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>