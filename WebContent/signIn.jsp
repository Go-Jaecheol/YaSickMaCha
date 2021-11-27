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
		query = "SELECT Aid, Pwd, Aname "
				+ "FROM ADMIN " 
				+ "WHERE Aid = ? AND Pwd = ?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, request.getParameter("sid"));
		pstmt.setString(2, request.getParameter("pwd"));
		rs=pstmt.executeQuery();
		if (!rs.next()) {
			HttpSession session = request.getSession();
			Object getdata = session.getAttribute("user_name");
			String user_name = (String)getdata;
			// user_name == null�̸� ���ǿ� ���� ���� ���� �α����ϴ� �����
			if (user_name == null) {
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
						response.sendRedirect("main.jsp");
					</script>
				<% }
				else {
					session.setAttribute("user_name", rs.getString(3)); //sname�� ���ǿ� �Է�
					//rs.close();
					//pstmt.close();
					//conn.close();
					response.sendRedirect("main.jsp");
				}	
			}
			else {
				// �̹� �α����� ������ε� â�� �ݾҴ��� �ƴ��� �𸣴ϱ�
				// �����ϴ� ���� �����Ű�� ���� ���� �߰�
				String nuser_name = user_name;
				session.invalidate();
				session = request.getSession();
				session.setAttribute("user_name", nuser_name); //sname�� ���ǿ� �Է�
				rs.close();
				pstmt.close();
				conn.close();
				response.sendRedirect("main.jsp");
			}
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("user_name", rs.getString(1)); //aid�� ���ǿ� �Է�
			rs.close();
			pstmt.close();
			conn.close();
			response.sendRedirect("adminPage.jsp");
		} %>
</body>
</html>