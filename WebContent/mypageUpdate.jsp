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
		Object getdata = session.getAttribute("user_id");
		String user_id = (String)getdata;
		if (user_id == null) response.sendRedirect("index.jsp");
		
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		String query, nSname;
		int res = -1, dno;
		Connection conn=null;
		PreparedStatement pstmt;
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		
		query = "UPDATE STUDENT "
				+ "SET Sname = ?, Dno = ? " 
				+ "WHERE Sid = ?";
		pstmt=conn.prepareStatement(query);
		nSname=request.getParameter("sname");
		dno=request.getParameter("depart").equals("심컴") ? 1 : 2;
		pstmt.setString(1, nSname);
		pstmt.setInt(2, dno);
		pstmt.setString(3, user_id);
		res=pstmt.executeUpdate();
		
		// session 정보 변경
		session.setAttribute("user_id", user_id);
		
		pstmt.close();
		conn.close();
		%>
		
		<script>
			alert("수정 완료!");
			document.location.href = "mypage.jsp";
			//response.sendRedirect("mypage.jsp");
		</script>
		<%
	%>
</body>
</html>