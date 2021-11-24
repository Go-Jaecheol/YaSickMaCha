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
		String nSname="";
		int res, dno;
		Connection conn=null;
		PreparedStatement pstmt;
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		
		query = "UPDATE STUDENT "
				+ "SET Sname = ?, Dno = ? " 
				+ "WHERE Sname = ?";
		pstmt=conn.prepareStatement(query);
		nSname=request.getParameter("sname");
		dno=request.getParameter("depart").equals("심컴") ? 1 : 2;
		pstmt.setString(1, nSname);
		pstmt.setInt(2, dno);
		pstmt.setString(3, user_name);
		res=pstmt.executeUpdate();
		
		// session 정보 변경
		session.setAttribute("user_name", nSname);
		
		pstmt.close();
		conn.close();
		response.sendRedirect("mypage.jsp");
	%>
</body>
</html>