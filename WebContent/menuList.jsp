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
	#controlBar {
		width: 90%;
    	margin: 5px auto;
	}
	
	#formDiv {
		float : left;
	}
	
	#buttonDiv {
		float : right;
	}
</style>
<title>YSMC</title>
</head>
<body>
	<%
		String aid = (String)session.getAttribute("aid");
		
		HttpSession httpsessionForMenu = request.getSession();
		httpsessionForMenu.setAttribute("aid", aid); //메뉴 관리시에 MANAGES 정보를 위함
		
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
		<div id="formDiv">
			<form action="menuList.jsp" method="post" accept-charset="utf-8">
		      	<input name="input" type="text" />
		      	<select name="section">
			        <option value="mname" selected>메뉴이름</option>
			        <option value="storeN">가게이름</option>
			        <option value="seasonId">시즌</option>
		     	</select>
		    	<button class="btn btn-primary" type="submit">검색</button>
	  		</form>
		</div>
	  	<div id="buttonDiv">
	  		<button class="btn btn-primary" onclick="location.href = 'addMenu.jsp'">메뉴추가</button>
	  	</div>
  	</div>
  
	<%
		query = "select * from menu";
	
		String section="";
		String input="";
		
		input = request.getParameter("input");
		section = request.getParameter("section");
		
		if(section == null){
			
		}
		else if(section.equals("mname")){
			query = query + " where mname LIKE '%" + input + "%'";
		}
		else if(section.equals("storeN")){
			query = query + " where storeN LIKE '%" + input + "%'";
		}
		else if(section.equals("seasonId")){
			query = query + " where seasonId LIKE '%" + input + "%'";
		}
		
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		out.println("<table class='table table-striped'>");
		out.println("<thead>");
		out.println("<th>메뉴id</th>");
		out.println("<th>메뉴이름</th>");
		out.println("<th>수량</th>");
		out.println("<th>학생회비납부자용메뉴여부</th>");
		out.println("<th>가게이름</th>");
		out.println("<th>시즌</th>");
		out.println("</thead>");
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td><a href = 'editMenu.jsp?mid=" +rs.getString(1)+ "'>"+ rs.getString(2) +"</a></td>");
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