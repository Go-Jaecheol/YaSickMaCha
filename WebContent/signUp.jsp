<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>YSMC</title>
</head>
<body>
	<%
    	request.setCharacterEncoding("utf-8");
		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "db11";
		String pass = "db11";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		String query;
		int res, dno = 0;
		Connection conn=null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		query = "SELECT Sname, Phone, Membership, Dno "
				+ "FROM STUDENT " 
				+ "WHERE Sid = ? AND Pwd = ? AND Phone = ?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, request.getParameter("sid"));
		pstmt.setString(2, request.getParameter("pwd"));
		pstmt.setString(3, request.getParameter("phone"));
		rs=pstmt.executeQuery();
		if (!rs.next()) {
			// sign up된 사용자가 아닌 경우 등록
			query = "INSERT "
					+ "INTO STUDENT(Sid, Pwd, Sname, Phone, Membership, Dno) " 
					+ "VALUES(?, ?, ?, ?, ?, ?)";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, request.getParameter("sid"));
			pstmt.setString(2, request.getParameter("pwd"));
			pstmt.setString(3, request.getParameter("sname"));
			pstmt.setString(4, request.getParameter("phone"));
			pstmt.setString(5, "N");
			if (request.getParameter("dno").equals("심컴")) dno = 1;
			else if (request.getParameter("dno").equals("글솦")) dno = 2;
			pstmt.setInt(6, dno);
			res=pstmt.executeUpdate();
			response.sendRedirect("main.jsp");
		}
		else { %>
			<!-- 이미 가입된 학번, 비밀번호가 있는 경우
			<div id="alreadyAlert"></div>
			<script>
				$('#alreadyAlert').click(function () {
					var wrapper = document.createElement('div')
					wrapper.innerHTML = '<div class="alert alert-danger alert-dismissible" role="alert">이미 등록된 학생입니다. Sign In 해주시기 바랍니다.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
		
		     		alreadyAlert.append(wrapper)
				})
				document.location.href="./index.html";
			</script>
			-->
		<% } 
		%>
</body>
</html>
