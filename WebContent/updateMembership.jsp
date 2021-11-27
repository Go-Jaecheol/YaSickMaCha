<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YSMC</title>
</head>
<body>
	<%
		String sid = request.getParameter("sid");
		char membership = request.getParameter("membership").charAt(0);
		
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		
		
		String query="";
		Connection conn = null;
		PreparedStatement pstmt;
		int rs=0;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		
		if(membership == 'Y'){
			query = "update STUDENT set Membership = 'N' where sid = '"+sid+"'";
		}
				
		else{
			query = "update STUDENT set Membership = 'Y' where sid = '"+sid+"'";
		}
				
		try{
			pstmt=conn.prepareStatement(query);
			rs = pstmt.executeUpdate();
			
			conn.commit();
		} catch(Exception e){
			e.printStackTrace();
			conn.rollback(); // 실패시 롤백
		}
		
	%>
	
	<% if(rs == 0){ %>
		<script>
			alert ("수정 실패");
			history.back();
		</script>
	
	<% } else { %>
		<script>
			alert("수정성공");
			location.href = 'studentDetail.jsp?sid=<%=sid%>';
		</script>
	<% } %>
</body>
</html>