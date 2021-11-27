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
		String sid="", mname=request.getParameter("mname"), mid="", comments="";
		int res, rating=0, count=0;
		Connection conn=null;
		PreparedStatement pstmt;
		ResultSet rs;
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		
		try {
			// 해당 학생의 학번 정보 가져오기
			query = "SELECT Sid "
					+ "FROM STUDENT "
					+ "WHERE Sname = ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, user_name);
			rs=pstmt.executeQuery();
			
			if (!rs.next()) { // 해당 학생이 없는 경우 %>
				<script>
					alert("당신은 누구십니까.");
					document.location.href="index.jsp";
				</script>
			<% }
			else {
				// 후기 작성하려는 메뉴 정보를 불러와야 함
				sid = rs.getString(1);
				query = "SELECT Mid "
						+ "FROM MENU "
						+ "WHERE Mname = ?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, mname);
				rs=pstmt.executeQuery();
				
				if (rs.next()) {
					mid=rs.getString(1);
					// 준비 끝 transaction 시작
					query = "SELECT * "
							+ "FROM RATING "
							+ "WHERE StudentId = ? AND MenuId = ? FOR UPDATE";
					pstmt=conn.prepareStatement(query);
					pstmt.setString(1, sid);
					pstmt.setString(2, mid);
					rs=pstmt.executeQuery();
					
					if (!rs.next()) { // 작성한 후기가 없다는 의미
						rating=Integer.parseInt(request.getParameter("rating"));
						comments=request.getParameter("comments");
						query = "SELECT COUNT(*) "
								+ "FROM RATING";
						pstmt=conn.prepareStatement(query);
						rs=pstmt.executeQuery();
						if (rs.next())
							count=rs.getInt(1)+1;
						query = "INSERT "
				                + "INTO RATING "
				                + "VALUES(?, ?, ?, ?, ?)";
				        pstmt=conn.prepareStatement(query);
				        pstmt.setString(1, sid);
				        pstmt.setString(2, mid);
				        pstmt.setString(3, Integer.toString(count));
				        pstmt.setInt(4, rating);
				        pstmt.setString(5, comments);
				        res=pstmt.executeUpdate();
						conn.commit();
					}
					else { // 작성한 게 있다는 의미
						conn.rollback(); %>
						<script>
							alert("이미 작성했습니다.");
						</script>
					<%}
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
			response.sendRedirect("mypage.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</body>
</html>