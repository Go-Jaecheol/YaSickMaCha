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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style type="text/css">
	.transpose { width: 100%; }
	.transpose tr { display: block; float: left; }
	.transpose th { display: block; }
	.transpose td { display: block; }
	
	#controlBar {
		width: 90%;
    	margin: 5px auto;
	}
</style>
<title>YSMC</title>
</head>
<body>

	<%
		String serverIP = "localhost";
		String strSID = "ORCLCDB";
		String portNum = "1521";
		String user = "lucifer";
		String pass = "1234";
		String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
		
		
		String query="";
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
	%>
	
	<%@ include file="./adminNavbar.jsp" %>

	<div id ="controlBar">
		<form action="adminPage.jsp" method="post" naccept-charset="utf-8">
	      	<input name="input" type="text" />
	      	<select name="section">
		        <option value="sid" selected>학번</option>
		        <option value="sname">이름</option>
		        <option value="phone">핸드폰</option>
	     	</select>
	    	<button class="btn btn-primary" type="submit">검색</button>
	  	</form>
  
	<%
		query = "select * from season";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		rs.next();
		System.out.println(rs.getString(1));
		String seasonId = rs.getString(1);
		
		query = "select mname, quantity from menu where seasonid = '"+seasonId+"'";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		out.println("<table class='table transpose'>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for(int i=1; i<=cnt; i++){
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<th>"+rs.getString(1)+"</th>");		
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
	</div>
	<%
		query = "select s.sid as 학번, s.sname as 이름, s.phone as 휴대전화, m.mid as 메뉴번호, m.mname as 메뉴, l.isget as 수령여부, m.IsMenuForMembership as 멤버십 "
				+ "from student s, menu m, SMENU_LIST l "
				+ "where s.sid = l.sid and l.mid = m.mid and m.SeasonId = '"+seasonId+"'";
	
		String section="";
		String input="";
		
		input = request.getParameter("input");
		section = request.getParameter("section");
		
		if(section == null){		
		}
		else if(section.equals("sid")){
			query = query + " and s.sid LIKE '%" + input + "%'";
		}
		else if(section.equals("sname")){
			query = query + " and s.sname LIKE '%" + input + "%'";
		}
		else if(section.equals("phone")){
			query = query + " and s.phone LIKE '%" + input + "%'";
		}
			
		System.out.println(query);
		
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		out.println("<table class='table table-striped'>");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		out.println("<thead>");
		for(int i=1; i<cnt; i++){
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</thead>");
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");		
			out.println("<td><a href = 'studentDetail.jsp?sid=" +rs.getString(1)+ "'>"+ rs.getString(2) +"</a></td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getString(4)+"</td>");
			out.println("<td>"+rs.getString(5)+"</td>");
			out.println("<td><button onclick=\"location.href = 'updateIsGet.jsp?sid="+rs.getString(1)+"&mid="+rs.getString(4)+"&isGet="+rs.getString(6)+"&membership="+rs.getString(7)+"'"+"\""+">"+rs.getString(6)+"</button></td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
</body>
</html>