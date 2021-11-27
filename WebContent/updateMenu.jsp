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
	<h1>test</h1>
	<%
		String mid = request.getParameter("mid");
		System.out.println(mid);
		String mname = request.getParameter("mname");
		System.out.println(mname);
		String quantity = request.getParameter("quantity");
		System.out.println(quantity);
		String isMenuForMembership = request.getParameter("isMenuForMembership");
		System.out.println(isMenuForMembership);
		String storeN = request.getParameter("storeN");
		System.out.println(storeN);
		String address = request.getParameter("Address");
		System.out.println(address);
		String phone = request.getParameter("Phone");
		System.out.println(phone);
		String seasonId = request.getParameter("seasonId");
		System.out.println(seasonId);
		
		String serverIP = "localhost";
		String strSID = "orcl"; //ORCLCDB
		String portNum = "1521";
		String user = "db11"; //lucifer
		String pass = "db11";	//1234
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		
		
		String query="";
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		int cnt=0;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
		conn.setAutoCommit(false);
		
		//deal with STORE table 
		query = "select * from store where storeName = '"+storeN+"'";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		if (!rs.next()) {	//not exist
			try {
				query = "INSERT INTO STORE VALUES('"
						+storeN+"', '"+address+"', '"+phone+"')";
				pstmt=conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				conn.commit();
				System.out.println("insert into store success");
			} catch(Exception e){
				System.out.println("insert into store failed");
				e.printStackTrace();
				conn.rollback(); // if faild, rollback
			}
		}
		else {	//exist
			
			try {
				query = "update STORE set StoreName = '"+storeN
						+"', Address ='"+address+"', phone = '"+phone
						+"' where StoreName = '"+storeN+"'";
				pstmt=conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				conn.commit();
				System.out.println("update store success");
			} catch(Exception e){
				e.printStackTrace();
				conn.rollback(); // if faild, rollback
				System.out.println("update store failed");
			}
		}
		
		//deal with SEASON table 
		query = "select * from season where seasonId = '"+seasonId+"'";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
				
		if (!rs.next()) {	//not exist
			try {
				query = "INSERT INTO SEASON VALUES('"+seasonId+"')";
				pstmt=conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				conn.commit();
				System.out.println("insert into season success");
			} catch(Exception e){
				e.printStackTrace();
				conn.rollback(); // if faild, rollback
				System.out.println("insert into season failed");
			}
			
		}
		
		//deal with SEASON table
		try{
			query = "update MENU set Mname = '"+mname
					+"', Quantity ="+quantity+", IsMenuForMembership = '"
					+isMenuForMembership+"', StoreN = '"+storeN
					+"', SeasonId = '"+seasonId+"' where mid = '"+mid+"'";
			pstmt=conn.prepareStatement(query);
			cnt = pstmt.executeUpdate();
			conn.commit();
			System.out.println("update menu success");
		} catch(Exception e){
			e.printStackTrace();
			conn.rollback(); // if faild, rollback
			System.out.println("update menu failed");
		}
		
	%>
	
	<% if(cnt == 0){ %>
		<script>
			alert ("수정 실패");
			history.back();
		</script>
	
	<% } else { %>
		<script>
			alert("수정성공");
			location.href = 'menuList.jsp';
		</script>
	<% } %>
</body>
</html>