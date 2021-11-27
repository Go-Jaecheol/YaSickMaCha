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
		// 사용자 정보 UPDATE, session UPDATE
		HttpSession session = request.getSession();
		Object getdata = session.getAttribute("user_name");
		String user_name = (String)getdata;
		if (user_name == null) response.sendRedirect("./index.html");
		
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
		conn.setAutoCommit(false);
		
		String menu_id = request.getParameter("mid");
		int res = -1;
   		boolean isDuplicated = false;
   		String Sid = "";
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
				res = pstmt.executeUpdate();
		        conn.commit();
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		%>
		<script>
			var r = <%= res %>;
			var url = 'main.jsp';
			window.location.href = url;
		</script>
</body>
</html>