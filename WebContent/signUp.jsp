<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" import="java.text.*, java.sql.*"%>
<%
    // 인코딩
    request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
		int res, dno = 0;
		Connection conn=null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		query = "SELECT Sname, Phone, Membership, Dno "
				+ "FROM STUDENT " 
				+ "WHERE Sid = ? AND Pwd = ?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, request.getParameter("sid"));
		pstmt.setString(2, request.getParameter("pwd"));
		rs=pstmt.executeQuery();
		if (!rs.next()) {
			query = "INSERT "
					+ "INTO STUDENT(Sid, Pwd, Sname, Phone, Membership, Dno) " 
					+ "VALUES(?, ?, ?, ?, ?, ?)";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, request.getParameter("sid"));
			pstmt.setString(2, request.getParameter("pwd"));
			pstmt.setString(3, request.getParameter("sname"));
			pstmt.setString(4, request.getParameter("phone"));
			pstmt.setString(5, "N");
			System.out.println(request.getParameter("dno"));
			if (request.getParameter("dno").equals("심컴")) dno = 1;
			else if (request.getParameter("dno").equals("글솦")) dno = 2;
			pstmt.setInt(6, dno);
			System.out.println(dno);
			res=pstmt.executeUpdate();
		}
		else {
			out.println("이미 등록된 학생입니다. Sign In 해주시기 바랍니다.");
		}
	%>
</body>
</html>