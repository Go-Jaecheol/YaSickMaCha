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
		String mid = request.getParameter("mid");
		String membership = request.getParameter("membership");
		char isGet = request.getParameter("isGet").charAt(0);
		
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		
		
		String query1=""; //SMENU_LIST 업데이트 쿼리 
		String query2=""; //RECEIVES 삽입 또는 삭제 쿼리
		Connection conn = null;
		PreparedStatement pstmt;
		int rs=0;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		
		if(isGet == 'N'){
			query1 = "update SMENU_LIST set isget = 'Y' where sid = '"+sid+"'"+ " and mid = '"+mid+"'";
        	query2 = "INSERT INTO RECEIVES VALUES('"+sid+"', '"+mid+"', '"+membership+"')";
		}
		else if(isGet == 'Y'){
			query1 = "update SMENU_LIST set isget = 'N' where sid = '"+sid+"'"+ " and mid = '"+mid+"'";
        	query2 = "DELETE from RECEIVES where StudentId='"+sid+"' and MenuId ='"+mid+"'";
		}
		
		try{
			pstmt=conn.prepareStatement(query1);
			rs = pstmt.executeUpdate();
			
			pstmt=conn.prepareStatement(query2);
			rs = pstmt.executeUpdate();
			
			conn.commit();
			
			pstmt.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.rollback(); // 실패시 롤백
			
			pstmt.close();
			conn.close();
		}
		
	%>
	
	<% if(rs == 0){ %>
		<script>
			alert ("수정 실패");
			history.back();
		</script>
	
	<% } else { %>
		<script>
			var preUrl = document.referrer;
			alert("수정 성공");
			if (preUrl.includes("studentDetail"))
				location.href = 'studentDetail.jsp?sid=<%=sid%>';
			else
				location.href = 'adminPage.jsp';
		</script>
	<% } %>
</body>
</html>