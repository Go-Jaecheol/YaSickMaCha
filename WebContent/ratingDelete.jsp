<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YSMC</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		String query;
		Connection conn=null;
		PreparedStatement pstmt;
		int res;

		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		try {
			query = "DELETE FROM RATING "
					+ "WHERE MenuId = ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, request.getParameter("mid"));
			res = pstmt.executeUpdate();	
			
			conn.commit();
			pstmt.close();
			conn.close();
			response.sendRedirect("mypage.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>