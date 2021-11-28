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
			// user_id == null�̸� ���ǿ� ���� ���� ���� �α����ϴ� �����
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
						alert("���̵� ��й�ȣ�� Ʋ�Ƚ��ϴ�.");
						document.location.href = "index.jsp";
						// response.sendRedirect("index.jsp");
					</script>
				<% }
				else {
					session.setAttribute("user_id", rs.getString(1)); //sname�� ���ǿ� �Է�
					rs.close();
					pstmt.close();
					conn.close();
					response.sendRedirect("main.jsp");
				}	
			}
			else {
				// �̹� �α����� ������ε� â�� �ݾҴ��� �ƴ��� �𸣴ϱ�
				// �����ϴ� ���� �����Ű�� ���� ���� �߰�
				String new_user_id = user_id;
				session.invalidate();
				session = request.getSession();
				session.setAttribute("user_id", new_user_id); //sname�� ���ǿ� �Է�
				rs.close();
				pstmt.close();
				conn.close();
				response.sendRedirect("main.jsp");
			}
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("Aid", rs.getString(1)); //Aid�� ���ǿ� �Է�
			rs.close();
			pstmt.close();
			conn.close();
			response.sendRedirect("adminPage.jsp");
		} %>
</body>
</html>