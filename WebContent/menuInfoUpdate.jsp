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
		if (user_name == null) response.sendRedirect("index.jsp");
		
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
		int res = -1;
   		int menu_quan = 0;
   		String Sid = "";
   		String year = "";
   		String semester = "";
   		String exam = "";
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
			query = "SELECT Quantity, SUBSTR(SeasonId, 1, 4), SUBSTR(SeasonId, 5, 1), SUBSTR(SeasonId, 6, 1) "
					+ "FROM MENU " 
					+ "WHERE Mid = ? "
					+ "FOR UPDATE";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, menu_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				menu_quan = rs.getInt(1);
				year = rs.getString(2);
				semester = rs.getString(3);
				exam = rs.getString(4);
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
					var y = <%= year %>;
					var s = <%= semester %>;
					var e =	"<%out.print(exam);%>";
					var url = 'main.jsp?year=' + encodeURI(y) + '&semester=' + encodeURI(s) + '&exam=' + encodeURI(e);
					window.location = url;
				</script>
				<%
			} else {
				conn.rollback();
				rs.close();
				pstmt.close();
				%>
				<script>
					alert("남은 수량이 없습니다!");
					var y = <%= year %>;
					var s = <%= semester %>;
					var e = "<%out.print(exam);%>";
					var url = 'main.jsp?year=' + encodeURI(y) + '&semester=' + encodeURI(s) + '&exam=' + encodeURI(e);
					window.location = url;
				</script>
				<%
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		%>
</body>
</html>