<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		String strSID = "orcl";
		String portNum = "1521";
		String user = "db11";
		String pass = "db11";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		String query;
		String nSname="";
		int res = -1, dno;
		Connection conn=null;
		PreparedStatement pstmt;
		ResultSet rs;
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		
		query = "SELECT Sid "
				+ "FROM STUDENT "
				+ "WHERE Sname=?";
		pstmt=conn.prepareStatement(query);
		pstmt.setString(1, user_name);
		rs=pstmt.executeQuery();
		
		if (!rs.next()) {
			
		}
		query = "INSERT "
                + "INTO RATING " 
                + "VALUES(?, ?, ?, ?, ?)";
        pstmt=conn.prepareStatement(query);
        pstmt.setString(1, studentId);
        pstmt.setString(2, menuId);
        pstmt.setString(3, count);
        pstmt.setInt(4, rating);
        pstmt.setString(5, comments);
        res=pstmt.executeUpdate();
        
        nSname=request.getParameter("sname");
		dno=request.getParameter("depart").equals("심컴") ? 1 : 2;
		pstmt.setString(1, nSname);
		pstmt.setInt(2, dno);
		pstmt.setString(3, user_name);
		res=pstmt.executeUpdate();
		
		rs.close();
		pstmt.close();
		conn.close();
		response.sendRedirect("mypage.jsp");
	%>
</body>
</html>