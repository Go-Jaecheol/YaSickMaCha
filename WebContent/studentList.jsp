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
	
	<nav class="navbar navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="./main.jsp">컴학 야식마차! - 학생관리</a>
			<ul class="nav nav-tabs justify-content-end">
				<li class="nav-item">
					<a class="nav-link" href="./mypage.jsp">마이페이지</a>
				</li>
				<li class="nav-item">	
					<a class="nav-link" href="./signout.jsp">SIGN OUT</a>
				</li>
			</ul>
		</div>
	</nav>
	
	<form action="adminPage.jsp" method="post" accept-charset="utf-8">
      	<input name="input" type="text" />
      	<select name="section">
	        <option value="sid" selected>학번</option>
	        <option value="sname">이름</option>
	        <option value="phone">핸드폰</option>
     	</select>
    	<button class="btn btn-primary" type="submit">검색</button>
  	</form>
  
	<%
		query = "select sid as 학번, pwd as 비밀번호, Sname as 이름, phone as 휴대전화, Membership as 학생회비납부여부, dname as 전공 "
				+ "from student, DEPARTMENT "
				+ "where dnumber=dno";
	
		String section="";
		String input="";
		
		input = request.getParameter("input");
		section = request.getParameter("section");
		
		if(section == null){
			
		}
		else if(section.equals("sid")){
			query = query + " and sid LIKE '%" + input + "%'";
		}
		else if(section.equals("sname")){
			query = query + " and sname LIKE '%" + input + "%'";
		}
		else if(section.equals("phone")){
			query = query + " and phone LIKE '%" + input + "%'";
		}
			
		System.out.println(query);
		
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		out.println("<table class='table table-striped'>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		out.println("<thead>");
		for(int i=1; i<=cnt; i++){
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</thead>");
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getString(4)+"</td>");
			out.println("<td>"+rs.getString(5)+"</td>");
			out.println("<td>"+rs.getString(6)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
</body>
</html>