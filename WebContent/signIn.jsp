<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		query = "SELECT Aid, Pwd, Aname "
				+ "FROM ADMIN " 
				+ "WHERE Aid = ? AND Pwd = ?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, request.getParameter("sid"));
		pstmt.setString(2, request.getParameter("pwd"));
		rs=pstmt.executeQuery();
		if (!rs.next()) {
			HttpSession session = request.getSession();
			Object getdata = session.getAttribute("user_id");
			String user_id = (String)getdata;
			// user_id == null이면 세션에 없는 경우로 새로 로그인하는 사용자
			if (user_id == null) {
				query = "SELECT Sid, Pwd, Sname, Phone, Membership, Dno "
						+ "FROM STUDENT "
						+ "WHERE Sid = ? AND Pwd = ?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, request.getParameter("sid"));
				pstmt.setString(2, request.getParameter("pwd"));
				rs=pstmt.executeQuery();
				if (!rs.next()) { %>
					<script>
						alert("아이디나 비밀번호가 틀렸습니다.");
						document.location.href = "index.jsp";
						// response.sendRedirect("index.jsp");
					</script>
				<% }
				else {
					session.setAttribute("user_id", rs.getString(1)); //sname을 세션에 입력
					rs.close();
					pstmt.close();
					conn.close();
					response.sendRedirect("main.jsp");
				}	
			}
			else {
				// 이미 로그인한 사용자인데 창을 닫았는지 아닌지 모르니까
				// 존재하는 세션 종료시키고 새로 세션 추가
				String new_user_id = user_id;
				session.invalidate();
				session = request.getSession();
				session.setAttribute("user_id", new_user_id); //sname을 세션에 입력
				rs.close();
				pstmt.close();
				conn.close();
				response.sendRedirect("main.jsp");
			}
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("Aid", rs.getString(1)); //Aid를 세션에 입력
			rs.close();
			pstmt.close();
			conn.close();
			response.sendRedirect("adminPage.jsp");
		} %>
</body>
</html>