<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%
    // 인코딩
    request.setCharacterEncoding("utf-8");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YSMC</title>
</head>
<body>
	<%
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
		
		int check = 0;
		String mid = request.getParameter("mid");
		if (mid == null){
			while(true){
				mid = Integer.toString((int)(Math.random() * 100000));
				System.out.println(mid);
				query = "select mid from menu";
				pstmt=conn.prepareStatement(query);	
				rs=pstmt.executeQuery();
				while(rs.next()){
					if(rs.getString(1).equals(mid)){
						check = 1;
					}
				}
				if(check == 1)
					continue;
				else
					break;
			}	
		}
		
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
		
		String aid = (String)session.getAttribute("aid");
		System.out.println(aid);
		
		//deal with STORE table 
		query = "select * from store where storeName = '"+storeN+"'";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		if (!rs.next()) {	//not exist
			try {
				query = "INSERT INTO STORE VALUES('"
						+storeN+"', '"+address+"', '"+phone+"')";
				System.out.println(query);
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
				System.out.println(query);
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
		
		//deal with MENU table
		query = "select * from menu where mid = "+mid;
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		if (!rs.next()) {	//not exist
			try {
				query = "INSERT INTO MENU VALUES("+mid+", '"+mname+"', "+quantity+", '"
						+isMenuForMembership+"', '"+storeN+"', '"+seasonId+"')";
				pstmt=conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				System.out.println(query);
				conn.commit();
				System.out.println("insert menu success");
			} catch(Exception e){
				e.printStackTrace();
				conn.rollback(); // if faild, rollback
				System.out.println(query);
				System.out.println("insert menu failed");
			}
			//insert MANAGES record
			try {
				query = "INSERT INTO MANAGES VALUES('"+aid+"', '"+mid+"')";
				pstmt=conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				System.out.println(query);
				conn.commit();
				System.out.println("insert manages success");
			} catch(Exception e){
				e.printStackTrace();
				conn.rollback(); // if faild, rollback
				System.out.println(query);
				System.out.println("insert manages failed");
			}
		}
		else {
			try{
				query = "update MENU set Mname = '"+mname
						+"', Quantity ="+quantity+", IsMenuForMembership = '"
						+isMenuForMembership+"', StoreN = '"+storeN
						+"', SeasonId = '"+seasonId+"' where mid = "+mid+"";
				pstmt=conn.prepareStatement(query);
				cnt = pstmt.executeUpdate();
				System.out.println(query);
				conn.commit();
				System.out.println("update menu success");
			} catch(Exception e){
				e.printStackTrace();
				conn.rollback(); // if faild, rollback
				System.out.println(query);
				System.out.println("update menu failed");
			}
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