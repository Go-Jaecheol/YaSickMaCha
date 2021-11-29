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
<link rel="stylesheet" href="./style/global.css?after">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script src="js/bootstrap.js"></script>
<style type="text/css">
	#adminStdListForm {
		display: flex;
	}
	#controlBar {
		width: 90%;
    	margin: 5px auto;
		display: flex;
		margin-top: 50px;
		height: 10%;
		border-radius: 10px;
		box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
		justify-content: center;
		align-items: center;
	}
	.input-group {
		margin: 0 10px 0 10px;
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
		
		String query="";
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
	%>
	
	<%@ include file="./adminNavbar.jsp" %>
	<div id="controlBar">
		<form action="studentList.jsp" method="post" accept-charset="utf-8" id="adminStdListForm">
	      	<div class="input-group form-floating">
	      		<input id="inputGroupSelect01" class="form-control" name="input" placeholder="학번" type="text">
	      		<label for="inputGroupSelect01">검색</label>
			</div>
			<div class="input-group">
			  	<label class="input-group-text" for="inputGroupSelect02">검색 기준</label>
			  	<select class="form-select" id="inputGroupSelect02" name="section">
			    	<option value="sid" selected>학번</option>
					<option value="sname">이름</option>
					<option value="phone">휴대폰</option>
			  	</select>
			</div>
	    	<button class="btn formSubmitBtns" id="adminSearchBtn" type="submit"><i class="fas fa-search"></i></button>
	  	</form>
  	</div>
  	<div id="studentList" class="container">
 		<%
		query = "select sid as 학번, pwd as 비밀번호, Sname as 이름, phone as 휴대폰, Membership as 학생회비납부여부, dname as 전공 "
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
			out.println("<th class=\"text-center\">"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</thead>");
		while(rs.next()){
			out.println("<tr>");
			out.println("<td class=\"text-center\">"+rs.getString(1)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(2)+"</td>");
			out.println("<td class=\"text-center\"><a href = 'studentDetail.jsp?sid=" +rs.getString(1)+ "'>"+ rs.getString(3) +"</a></td>");
			out.println("<td class=\"text-center\">"+rs.getString(4)+"</td>");
			out.println("<td class=\"text-center\">"+(rs.getString(5).equals("N") ? "X" : "O")+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(6)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		rs.close();
		pstmt.close();
		conn.close();
	%>
  	</div>
</body>
</html>