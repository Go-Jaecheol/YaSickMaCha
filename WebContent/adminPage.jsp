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
<link rel="stylesheet" href="./style/global.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<style type="text/css">
	.transpose { width: 100%; }
	.transpose tr { display: block; float: left; }
	.transpose th { display: block; }
	.transpose td { display: block; }
	#adminMainForm {
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
		String finalQuery="";
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn=DriverManager.getConnection(url, user, pass);
	%>
	
	<%
		query = "SELECT * from season order by seasonid";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		String seasonId = "";
		
		while(rs.next()){
			seasonId = rs.getString(1);
			System.out.println(seasonId);
		}
		
		seasonId = seasonId.substring(0,5);
		System.out.println(seasonId);
		
		query = "select * from season where seasonid like '"+seasonId+"%'";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		
		int count = 0;
		
		while(rs.next()){
			count++;
			if(count == 1)
				seasonId = rs.getString(1);
			else
				seasonId = seasonId.substring(0,5)+'F';
		}
	
		finalQuery = "select s.sid as 학번, s.sname as 이름, s.phone as 휴대전화, m.mid as 메뉴번호, m.mname as 메뉴, l.isget as 수령여부, m.IsMenuForMembership as 멤버십 "
				+ "from student s, menu m, SMENU_LIST l "
				+ "where s.sid = l.sid and l.mid = m.mid and m.SeasonId = '"+seasonId+"'";
	
		String section="";
		String input="";
		String mid="";
		
		input = request.getParameter("input");
		section = request.getParameter("section");
		mid = request.getParameter("mid");
		
		System.out.println(input);
		System.out.println(section);
		System.out.println(mid);
		
		if(section == null){
			
		}
		else if(section.equals("sid")){
			finalQuery = finalQuery + " and s.sid LIKE '%" + input + "%'";
		}
		else if(section.equals("sname")){
			finalQuery = finalQuery + " and s.sname LIKE '%" + input + "%'";
		}
		else if(section.equals("phone")){
			finalQuery = finalQuery + " and s.phone LIKE '%" + input + "%'";
		}
		
		if(mid != null){
			finalQuery = finalQuery + " and l.mid ='" + mid + "'";
		}
		
		System.out.println(finalQuery);
	%>
	
	<%@ include file="./adminNavbar.jsp" %>

	<div id ="controlBar" class="container">
		<form action="adminPage.jsp" method="post" accept-charset="utf-8" id="adminMainForm">
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
	      	
	<%	
		query = "select mid, mname from menu where seasonid = '"+seasonId+"'";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		out.println("<div class=\"input-group\">");
		out.println("<label class=\"input-group-text\" for=\"inputGroupSelect03\">메뉴 이름</label>");
		out.println("<select class=\"form-select\" id=\"inputGroupSelect03\" name='mid'>");
		while(rs.next()){
			if(rs.getString(1).equals(mid)){
				out.println("<option value='"+rs.getString(1)+"' selected>"+rs.getString(2)+"</option>");
			}
			else
				out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(2)+"</option>");
		}
		out.println("</select>");
		out.println("</div>");
		out.println("<button class='btn formSubmitBtns' id=\"adminSearchBtn\" type='submit'><i class=\"fas fa-search\"></i></button>");
		out.println("</form>");
	%>
	</div>
	<div id="menuList" class="container">
	<%
		pstmt=conn.prepareStatement(finalQuery);	
		rs=pstmt.executeQuery();
		out.println("<table class='table table-striped'>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		out.println("<thead>");
		for(int i=1; i<cnt; i++){
			out.println("<th class=\"text-center\">"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</thead>");
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<td class=\"text-center\">"+rs.getString(1)+"</td>");		
			out.println("<td class=\"text-center\"><a href = 'studentDetail.jsp?sid=" +rs.getString(1)+ "'>"+ rs.getString(2) +"</a></td>");
			out.println("<td class=\"text-center\">"+rs.getString(3)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(4)+"</td>");
			out.println("<td class=\"text-center\">"+rs.getString(5)+"</td>");
			out.println("<td class=\"text-center\"><button class=\"adminBtns\" onclick=\"location.href = 'updateIsGet.jsp?sid="+rs.getString(1)+"&mid="+rs.getString(4)+"&isGet="+rs.getString(6)+"&membership="+rs.getString(7)+"'"+"\""+">"+rs.getString(6)+"</button></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		
		rsmd.close();
		rs.close();
		pstmt.close();
		conn.close();
	%>
	</div>
</body>
</html>