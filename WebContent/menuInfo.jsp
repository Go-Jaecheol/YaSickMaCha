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
	
	
	<!-- Menu Info Modal -->
	<div class="modal" id="menuModal" tabindex="-1" aria-labelledby="menuInfoName" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="menuInfoName"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p id="menuInfoStore"></p>
	        <p id="menuInfoQuantity"></p>
	        <p id="menuInfoMembership"></p>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-info" data-bs-target="#completeModal" data-bs-toggle="modal" data-bs-dismiss="modal">신청</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
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
	   		boolean isDuplicated = false;
	   		String Sid = "";
	   		String menu_id = request.getParameter("mid");
			try {
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
		%>
						<p>이미 신청한 메뉴입니다.</p>
		<%
						isDuplicated = true;
						break;
					}
				}
				if (!isDuplicated) {
					query = "INSERT "
							+ "INTO SMENU_LIST " 
							+ "VALUES(?, ?, ?)";
					pstmt=conn.prepareStatement(query);
					pstmt.setString(1, Sid);
					pstmt.setString(2, "N");
					pstmt.setString(3, menu_id);
					int res = pstmt.executeUpdate();
			        conn.commit();
		%>
					<p>신청이 완료되었습니다.</p>
		<%
				}
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>