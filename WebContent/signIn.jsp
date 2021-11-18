<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
				document.location.href="./index.html";
			</script>
		<% }
		else {
			HttpSession session = request.getSession();
			session.setAttribute("user_name", rs.getString(3)); //sname을 세션에 입력
			rs.close();
			pstmt.close();
			conn.close(); %>
			<script>
				document.location.href="./main.jsp";
			</script>
		<% } %>
</body>
</html>