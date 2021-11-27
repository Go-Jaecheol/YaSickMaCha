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
   		int menu_quan = 0;
   		String Sid = "";
		try {
			query = "SELECT Sid "
					+ "FROM STUDENT " 
					+ "WHERE Sname = ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, user_name);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Sid = rs.getString(1);
			}
			query = "SELECT Quantity "
					+ "FROM MENU " 
					+ "WHERE Mid = ? "
					+ "FOR UPDATE";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, menu_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				menu_quan = rs.getInt(1);
			}
			if (menu_quan > 0) {
				query = "UPDATE MENU "
						+ "SET Quantity = NVL(Quantity, 0)-1 " 
						+ "WHERE Mid = ?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, menu_id);
				res = pstmt.executeUpdate();
			    conn.commit();
				query = "INSERT "
						+ "INTO SMENU_LIST " 
						+ "VALUES(?, ?, ?)";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, Sid);
				pstmt.setString(2, "N");
				pstmt.setString(3, menu_id);
				res = pstmt.executeUpdate();
			    conn.commit();
			    rs.close();
				pstmt.close();
			    %>
			    <script>
					alert("신청이 완료되었습니다!");
					window.location = 'main.jsp';
				</script>
				<%
			} else {
				conn.rollback();
				rs.close();
				pstmt.close();
				%>
				<script>
					alert("남은 수량이 없습니다!");
					window.location = 'main.jsp';
				</script>
				<%
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		%>
</body>
</html>