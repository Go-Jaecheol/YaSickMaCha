<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style type="text/css">
html {
	height: 100%;
}
body {
	margin: 0;
	height: 100%;
	text-align: center;
}
#mypagePaper {
	margin-top: 50px;
	padding-bottom: 20px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
h3 {
	position: relative;
	padding: 20px;
	text-align: center;
}
.nav {
	justify-content: center;
}
#nav-tabContent {
	padding: 40px;
}
</style>
<script type="text/javascript">
</script>
<title>YSMC</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<div id="mypagePaper" class="container">
		<h3>MY PAGE</h3>
		<nav>
			<div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-info" type="button" role="tab" aria-controls="nav-home" aria-selected="true">회원 정보</button>
		    	<button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-menu" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">신청 메뉴</button>
			</div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
  			<div class="tab-pane fade show active" id="nav-info" role="tabpanel" aria-labelledby="nav-home-tab">
  			<%
	  			String serverIP = "localhost";
	  			String strSID = "orcl";
	  			String portNum = "1521";
	  			String user = "db11";
	  			String pass = "db11";
	  			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	  			String query, sname=user_name;
	  			String sid="", phone="", mem="", depart="", season="", storen="", mname="", isget="";
	  			String[] attr = {"#", "야식마차", "가게 이름", "메뉴 이름", "수령 여부", "후기"};
	  			int cnt=1;
	  			Connection conn=null;
	  			PreparedStatement pstmt;
	  			ResultSet rs;
	  			
	  			Class.forName("oracle.jdbc.driver.OracleDriver");
	  			conn=DriverManager.getConnection(url, user, pass);
	  			query = "SELECT Sid, Phone, Membership, Dno "
	  					+ "FROM STUDENT " 
	  					+ "WHERE Sname = ?";
	  			pstmt=conn.prepareStatement(query);
	  			pstmt.setString(1, sname);
	  			rs=pstmt.executeQuery();
	  			if (!rs.next()) { %>
				<script>
					alert("아이디나 비밀번호가 틀렸습니다.");
					document.location.href="./index.html";
				</script>
  				<% }
	  			else {
	  				sid = rs.getString(1);
	  				phone = rs.getString(2);
	  				mem = rs.getString(3);
	  				int d = rs.getInt(4);
	  				depart = (d == 1 ? "심컴" : "글솦");
	  				out.println("<dl class=\"row\">");
	  				out.println("<dt class=\"col-sm-4 text-center\">학번</dt>");
	  				out.println("<dd class=\"col-sm-8 text-center\">" + sid + "</dd>");
	  				out.println("<dt class=\"col-sm-4 text-center\">이름</dt>");
	  				out.println("<dd class=\"col-sm-8 text-center\">" + sname + "</dd>");
	  				out.println("<dt class=\"col-sm-4 text-center\">휴대폰 번호</dt>");
	  				out.println("<dd class=\"col-sm-8 text-center\">" + phone + "</dd>");
	  				out.println("<dt class=\"col-sm-4 text-center\">학생회비 제출 여부</dt>");
	  				out.println("<dd class=\"col-sm-8 text-center\">" + mem + "</dd>");
	  				out.println("<dt class=\"col-sm-4 text-center\">학과</dt>");
	  				out.println("<dd class=\"col-sm-8 text-center\">" + depart + "</dd>");
	  				out.println("</dl>");
					out.println("<button type=\"button\">수정하기</button>");
				} %>
  			</div>
			<div class="tab-pane fade" id="nav-menu" role="tabpanel" aria-labelledby="nav-profile-tab">
				<% 
					query = "SELECT m.SeasonId, m.StoreN, m.Mname, s.IsGet "
							+ "FROM SMENU_LIST s, MENU m " 
							+ "WHERE s.Sid = ? AND s.Mid = m.Mid";
					pstmt=conn.prepareStatement(query);
					pstmt.setString(1, sid);
					rs = pstmt.executeQuery();
					out.println("<table class=" + "table table-primary table-hover" + ">");
					out.println("<thead>");
					out.println("<tr>");
					for (String obj : attr) {
						out.println("<th scope=\"col\" class=\"text-center\">" + obj +"</th>");
					}
					out.println("</tr>");
					out.println("</thead>");
					if (!rs.next()) {
						out.println("</table");
					}
					else {
						do {
							out.println("<tr class=\"table-active\">");
							out.println("<th scope=\"row\" class=\"text-center\">" + cnt + "</th>");
							season = rs.getString(1);
							storen = rs.getString(2);
							mname = rs.getString(3);
							isget = rs.getString(4);
							out.println("<td class=\"text-center\">" + season + "</td>");
							out.println("<td class=\"text-center\">" + storen + "</td>");
							out.println("<td class=\"text-center\">" + mname + "</td>");
							out.println("<td class=\"text-center\">" + isget + "</td>");
							out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn btn-primay\" data-bs-toggle=\"modal\" data-bs-target=\"#ReviewModal\">Go!</button></td>");
							out.println("</tr>");
							cnt += 1;
						} while(rs.next());
						out.println("</table");
					}
	  				rs.close();
	  				pstmt.close();
	  				conn.close();
				%>
			</div>
		</div>
		<div class="modal fade" id="ReviewModal" tabindex="-1" aria-labelledby="ReviewModalLabel" aria-hidden="true">
			<div class="modal-dialog">
		  		<div class="modal-content">
		      		<div class="modal-header">
		        		<h5 class="modal-title" id="ReviewModalLabel">후기</h5>
		        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      		</div>
		      		<div class="modal-body">
		        		<!-- 남긴 후기가 있는 경우, 그 후기를 보여주고 그렇지 않은 경우 후기 작성 form -->
		        		
		      		</div>
		      		<div class="modal-footer">
		        		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        		<button type="button" class="btn btn-primary">Save changes</button>
		      		</div>
	    		</div>
		  	</div>
		</div>
	</div>
</body>
</html>