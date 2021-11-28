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
<link rel="stylesheet" href="css/global.css?after">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style type="text/css">
	.transpose { width: 100%; }
	.transpose tr { display: block; float: left; }
	.transpose th { display: block; }
	.transpose td { display: block; }
	#stdDetailBar {
		width: 90%;
		margin: 5px auto;
	}
</style>
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
		
		String sid = "";
		String mid = "";
		String isGet = "";
		
		String query="";
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
	%>
	
	<%@ include file="./adminNavbar.jsp" %>
  		<div id="stdDetailBar" class="container">
	<%
		sid = request.getParameter("sid");
		System.out.println(sid);
		
		query = "select sid as 학번, pwd as 비밀번호, Sname as 이름, phone as 휴대전화, Membership as 학생회비납부여부, dname as 전공 "
				+ "from student, DEPARTMENT "
				+ "where dnumber=dno and sid ='"+sid+"'";
	
		System.out.println(query);
		
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		out.println("<table class='table table-striped'>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		out.println("<thead>");
		for(int i=1; i<=cnt; i++){
			out.println("<th class=\"text-center\">"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</thead>");
		while(rs.next()){
			out.println("<tr>");
			out.println("<td class=\"text-center\">"+rs.getString(1)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(2)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(3)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(4)+"</td>");
			out.println("<td class=\"text-center\"><button class=\"adminBtns\" onclick=\"location.href = 'updateMembership.jsp?sid="+sid+"&membership="+rs.getString(5)+"'"+"\""+">"+rs.getString(5)+"</button></td>");
			out.println("<td class=\"text-center\">"+rs.getString(6)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
	
	<%
		
		query = "select mname, seasonid, isget, sm.mid, m.IsMenuForMembership "
				+ "from SMENU_LIST sm, menu m "
				+ "where sm.mid = m.mid and sm.sid = '"+sid+"'";
	
		System.out.println(query);
		
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		out.println("<table class='table table-striped'>");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		out.println("<thead>");
		
		out.println("<th class=\"text-center\">메뉴</th>");
		out.println("<th class=\"text-center\">시즌</th>");
		out.println("<th class=\"text-center\">수령여부</th>");
		
		out.println("</thead>");
		while(rs.next()){
			out.println("<tr>");
			out.println("<td class=\"text-center\">"+rs.getString(1)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(2)+"</td>");
			out.println("<td class=\"text-center\"><button class=\"adminBtns\" onclick=\"location.href = 'updateIsGet.jsp?sid="+sid+"&mid="+rs.getString(4)+"&isGet="+rs.getString(3)+"&membership="+rs.getString(5)+"'"+"\""+">"+rs.getString(3)+"</button></td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
	
	<%
		
		query = "select m.mname, r.rating, r.Comments from Rating r, menu m "
				+ "where m.mid = r.menuid and r.StudentId='"+sid+"'";
	
		System.out.println(query);
		
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		out.println("<table class='table table-striped'>");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		out.println("<thead>");
		for(int i=1; i<=cnt; i++){
			out.println("<th class=\"text-center\">"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</thead>");
		while(rs.next()){
			out.println("<tr>");
			out.println("<td class=\"text-center\">"+rs.getString(1)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(2)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(3)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
  		</div>
</body>
</html>