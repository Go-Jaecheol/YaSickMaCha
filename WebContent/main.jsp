<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="./style/global.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script type="text/javascript">
    $(document).ready(function() {
        $("#MenuRequestModal").on("show.bs.modal", function(e) {
        	var mname = $(e.relatedTarget).data('mname');
            var mid = $(e.relatedTarget).data('mid');
            document.getElementById("MenuRequestModalLabel").innerHTML = mname;
            $('input[name=mid]').attr('value',mid);
        });
    });
</script>
<style type="text/css">
body {
	text-align: center;
}
#mainForm {
	display: flex;
}
h1 {
	position: relative;
	padding: 20px;
	width: 100%;
	text-align: center;
	color: gray;
}
#searchBar {
	display: flex;
	margin-top: 50px;
	height: 10%;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
	align-items: center;
	justify-content: center;
}
.input-group {
	margin: 0 10px 0 10px;
}
#mainSearchBtn {
	margin: 0 0 0 10px;
}
#menuList {
	display: flex;
	flex-wrap: wrap;
	overflow: auto;
	margin-top: 50px;
	height: auto;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
	align-items: center;
}
#menuContent {
	height: 150px;
 	width: 150px;
	margin: 5px;
	border: 2px solid;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
#reviewBtn {
	display: block;
}
#modalMessage {
	font-weight: 600;
}
</style>
<title>YSMC</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<div id="searchBar" class="container">
		<form action="main.jsp" method="GET" id="mainForm">
			<div class="input-group">
			  	<label class="input-group-text" for="inputGroupSelect01">연도</label>
			  	<select class="form-select" id="inputGroupSelect01" name="year">
			    	<option selected>연도 선택</option>
			    	<%
						String serverIP = "localhost";
						String strSID = "orcl"; //ORCLCDB
						String portNum = "1521";
						String user = "db11"; //lucifer
						String pass = "db11";	//1234
						String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
						String query;
						Connection conn=null;
						PreparedStatement pstmt;
						ResultSet rs;
						
						Class.forName("oracle.jdbc.driver.OracleDriver");
						conn=DriverManager.getConnection(url, user, pass);
						conn.setAutoCommit(false);
						query = "SELECT DISTINCT SUBSTR(SeasonId, 1, 4) "
								+ "FROM SEASON";
						pstmt=conn.prepareStatement(query);
						rs=pstmt.executeQuery();
						while(rs.next()){
							String seasonId = rs.getString(1);
					%>
				    	<option value=<%= seasonId %>><%= seasonId %>년</option>
			    	<%
						}
						rs.close();
						pstmt.close();
					%>
			  	</select>
			</div>
			<div class="input-group">
			  	<label class="input-group-text" for="inputGroupSelect02">학기</label>
			  	<select class="form-select" id="inputGroupSelect02" name="semester">
			    	<option selected>학기 선택</option>
					<option value='1'>1학기</option>
					<option value='2'>2학기</option>
			  	</select>
			</div>
			<div class="input-group">
			  	<label class="input-group-text" for="inputGroupSelect03">시험</label>
			  	<select class="form-select" id="inputGroupSelect03" name="exam">
			    	<option selected>시험 선택</option>
					<option value='M'>중간</option>
					<option value='F'>기말</option>
			  	</select>
			</div>
			<button id="mainSearchBtn" class="formSubmitBtns" type="submit"><i class="fas fa-search"></i></button>
		</form>
	</div>
	<div id="menuList" class="container">
	<% 
		String year = request.getParameter("year");
		String semester = request.getParameter("semester");
		String exam = request.getParameter("exam");
		
		String seasonId = year+semester+exam;
		String Sid = "", Mid = "", Mname = "", IsMenuForMembership = "", StoreN = "", Membership = "";
		int Quantity = 0;
		String[] attr = {"#", "가게 이름", "메뉴 이름", "수량", "학생회비 필요여부", "조회"};
		try {
			query = "SELECT Mid, Mname, Quantity, IsMenuForMembership, StoreN, Membership, Sid "
					+ "FROM MENU, STUDENT " 
					+ "WHERE SeasonId = ? "
					+ "AND Sname = ?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, seasonId);
			pstmt.setString(2, user_name);
			rs = pstmt.executeQuery();
			out.println("<table class=" + "table table-primary table-hover" + ">");
			if (!rs.next()) {
				out.println("<h1 style=\"font-weight: 600; margin: 0;\">불러올 정보가 없습니다.</h1>");
				out.println("</table");
			} else {
				out.println("<h1>"+ year + "년 " + semester + "학기 " + (exam.equals("M") ? "중간" : "기말") + " 야식마차 메뉴" + "</h1>");
				out.println("<thead>");
				out.println("<tr>");
				for (String obj : attr) {
					out.println("<th scope=\"col\" class=\"text-center\">" + obj +"</th>");
				}
				out.println("</tr>");
				out.println("</thead>");
				do {
					// Fill out your code
					Mid = rs.getString(1);
					Mname = rs.getString(2);
					Quantity = rs.getInt(3);
					IsMenuForMembership = rs.getString(4);
					StoreN = rs.getString(5);
					Membership = rs.getString(6);
					Sid = rs.getString(7);
					
					out.println("<tr class=\"table-active\">");
					out.println("<td class=\"text-center\">" + Mid + "</td>");
					out.println("<td class=\"text-center\">" + StoreN + "</td>");
					out.println("<td class=\"text-center\">" + Mname + "</td>");
					out.println("<td class=\"text-center\">" + Quantity + "</td>");
					out.println("<td class=\"text-center\">" + IsMenuForMembership + "</td>");
					
					boolean isDuplicated = false;
					query = "SELECT Mid, STUDENT.Sid "
							+ "FROM SMENU_LIST, STUDENT " 
							+ "WHERE Sname = ? "
							+ "AND SMENU_LIST.Sid = STUDENT.Sid";
					pstmt=conn.prepareStatement(query);
					pstmt.setString(1, user_name);
					ResultSet rs_temp = pstmt.executeQuery();
					if(!rs_temp.next()) {
						if(IsMenuForMembership.equals("Y") && Membership.equals("N"))
							out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn btn-info\" data-bs-toggle=\"modal\" data-bs-target=\"#notMembership\">Go!</button></td>");
						else {
							out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn btn-info\" data-bs-toggle=\"modal\" data-bs-target=\"#MenuRequestModal\" data-mname=\""+Mname+"\" data-mid=\""+Mid+"\">Go!</button></td>");
						}
					} else {
						do {
							String rsMid = rs_temp.getString(1);
							Sid = rs_temp.getString(2);
							if(rsMid.equals(Mid)) {
								out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn btn-secondary\" data-bs-toggle=\"modal\" data-bs-target=\"#duplicatedModal\">신청 완료</button></td>");
								isDuplicated = true;
								break;
							}
						}while(rs_temp.next());
						if (!isDuplicated) {
							if(IsMenuForMembership.equals("Y") && Membership.equals("N"))
								out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn btn-info\" data-bs-toggle=\"modal\" data-bs-target=\"#notMembership\">Go!</button></td>");
							else {
								out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn btn-info\" data-bs-toggle=\"modal\" data-bs-target=\"#MenuRequestModal\" data-mname=\""+Mname+"\" data-mid=\""+Mid+"\">Go!</button></td>");
							}
						}
					}
					out.println("</tr>");
					rs_temp.close();
				} while(rs.next());
				out.println("</table");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		rs.close();
		pstmt.close();
	%>
	
	<!-- Duplicated Alert -->
	<div class="modal fade" id="duplicatedModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalLabel">알림</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	      	<p id="modalMessage">이미 신청한 메뉴입니다.</p>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Not Membership Alert -->
	<div class="modal fade" id="notMembership" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="modalLabel">알림</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	        <p id="modalMessage">학생회비 납부자가 아닙니다.</p>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Menu Request Modal -->
	<div class="modal fade" id="MenuRequestModal" tabindex="-1" aria-labelledby="MenuRequestModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
	  		<div class="modal-content">
	      		<div class="modal-header">
	        		<h5 class="modal-title" id="MenuRequestModalLabel">메뉴 신청</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      		</div>
				<div class="modal-body text-center">
					<form action="menuInfoUpdate.jsp" method="POST">
						<h5 id="ModalMessage">해당 메뉴를 신청하시겠습니까?</h5>
						<input type="hidden" id="floatingMid" class="form-control" name="mid" value="">
						<button class="btn form-control formSubmitBtns" id="reviewBtn" type="submit">신청</button>
					</form>
				</div>
			</div>
  		</div>
	</div>
</div>
</div>
</body>
</html>