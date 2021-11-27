<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session = "false" language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="./css/global.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-Fo3rlrZj/k7ujTnHg4CGR2D7kSs0v4LLanw2qksYuRlEzO+tcaEPQogQ0KaoGN26/zrn20ImR1DfuLWnOo7aBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
<script type="text/javascript">
	function toastShow(content, title) {
		
		toastr.info(content, title);
	};
	function Valid(e) {
		var sname = document.getElementById("newSname").value;
		
		if (sname.length > 7 || sname.indexOf(' ') >= 0) {
			document.getElementById("newSnameHelp").style.display = 'flex';
			document.getElementById("commitBtn").disabled = true;
		}
		else {
			document.getElementById("newSnameHelp").style.display = 'none';
			document.getElementById("commitBtn").disabled = false;
		}	
	}
	function ValidRating(e) {
		var rating = document.getElementById("floatingRating").value;
		var comments = document.getElementById("floatingComments").value;
		
		if (rating > 5 || rating < 0) {
			document.getElementById("ratingHelp").style.display = 'flex';
			document.getElementById("reviewBtn").disabled = true;
		}
		else {
			document.getElementById("ratingHelp").style.display = 'none';
		}
		if (comments.length > 75) {
			document.getElementById("commentsHelp").style.display = 'flex';
			document.getElementById("reviewBtn").disabled = true;
		}
		else {
			document.getElementById("commentsHelp").style.display = 'none';
		}
		if (document.getElementById("ratingHelp").style.display != 'flex' && document.getElementById("commentsHelp").style.display != 'flex')
			document.getElementById("reviewBtn").disabled = false;
	}
</script>  
<style type="text/css">
body {
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
#commitBtn {
	width: 150px;
}
#reviewBtn {
	width: 150px;
}
#chBtn {
	float: right;
}
</style>
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
	  			String strSID = "orcl"; //ORCLCDB
	  			String portNum = "1521";
	  			String user = "db11"; //lucifer
	  			String pass = "db11";	//1234
	  			String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
	  			String query, sname=user_name;
	  			String sid="", phone="", mem="", depart="", season="", storen="", mname="", mid="", isget="", comm="";
	  			String[] attr = {"#", "야식마차", "가게 이름", "메뉴 이름", "수령 여부", "REVIEW"};
	  			int cnt=1, rating=0;
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
					alert("당신은 누구십니까.");
					document.location.href="signout.jsp";
				</script>
  				<% }
	  			else {
	  				String rtn = request.getParameter("isUp");
	  				if (rtn != null && Integer.parseInt(rtn) >= 0)%> <script></script>
	  				<% sid = rs.getString(1);
	  				phone = rs.getString(2);
	  				mem = (rs.getString(3).equals("N") ? "X" : "O");
	  				int d = rs.getInt(4);
	  				depart = (d == 1 ? "심컴" : "글솦");
	  				out.println("<dl class=\"row\">");
	  				out.println("<dt class=\"col-sm-6 text-center\">학번</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + sid + "</dd><br/>");
	  				out.println("<dt class=\"col-sm-6 text-center\">이름</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + sname + "</dd>");
	  				out.println("<dt class=\"col-sm-6 text-center\">휴대폰 번호</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + phone + "</dd>");
	  				out.println("<dt class=\"col-sm-6 text-center\">학생회비 납부 여부</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + mem + "</dd>");
	  				out.println("<dt class=\"col-sm-6 text-center\">학과</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + depart + "</dd>");
	  				out.println("</dl>");
					out.println("<button type=\"button\" class=\"btn btn-outline-primary\" id=\"chBtn\" data-bs-toggle=\"modal\" data-bs-target=\"#MypageUpdateModal\">수정  <i class=\"fas fa-user-edit\"></i></button>");
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
							isget = (rs.getString(4).equals("N") ? "X" : "O");
							out.println("<td class=\"text-center\">" + season + "</td>");
							out.println("<td class=\"text-center\">" + storen + "</td>");
							out.println("<td class=\"text-center\">" + mname + "</td>");
							out.println("<td class=\"text-center\">" + isget + "</td>");
							if (isget.equals("X"))
								out.println("<td class=\"text-center\" style=\"color: red\">작성 불가</td>");
							else
								out.println("<td class=\"text-center\"><button type=\"button\" style=\"padding: 0;\" class=\"btn btn-primay\" data-bs-toggle=\"modal\" data-bs-target=\"#ReviewModal\">Go!</button></td>");
							out.println("</tr>");
							cnt += 1;
						} while(rs.next());
						out.println("</table");
					}
				%>
			</div>
		</div>
		<div class="modal fade" id="MypageUpdateModal" tabindex="-1" aria-labelledby="MypageUpdateModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
		  		<div class="modal-content">
		      		<div class="modal-header">
		        		<h5 class="modal-title" id="MypageUpdateModalLabel">회원 정보 수정</h5>
		        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      		</div>
					<div class="modal-body">
	        		<%
						// 수정할 수 없는 거는 readonly로
						out.println("<form action=\"mypageUpdate.jsp\" method=\"POST\">");
						out.println("<h3>" + sname + "님의 회원 정보 수정</h3>");
	        			out.println("<div class=\"input-group mb-3\">");
	        			out.println("<span class=\"input-group-text\" id=\"sidLabel\">학번</span>");
	        			out.println("<input class=\"form-control\" type=\"text\" value=\"" + sid + "\" aria-describedby=\"sidLabel\" readonly>");
	        			out.println("</div>");
	        			out.println("<div class=\"input-group mb-3\">");
	        			out.println("<span class=\"input-group-text\" id=\"snameLabel\">이름(7글자 이내)</span>");
	        			out.println("<input class=\"form-control\" id=\"newSname\" name=\"sname\" type=\"text\" value=\"" + sname + "\" aria-describedby=\"snameLabel\" oninput=\"Valid(this)\" required>");
	        			out.println("<div id=\"newSnameHelp\" class=\"invalid-feedback\">7자 이내로 입력해주세요.</div>");
	        			out.println("</div>");
	        			out.println("<div class=\"input-group mb-3\">");
	        			out.println("<span class=\"input-group-text\" id=\"phoneLabel\">휴대폰 번호</span>");
	        			out.println("<input class=\"form-control\" type=\"text\" value=\"" + phone + "\" aria-describedby=\"phoneLabel\" readonly>");
	        			out.println("</div>");
	        			out.println("<div class=\"input-group mb-3\">");
	        			out.println("<span class=\"input-group-text\" id=\"memLabel\">학생회비 납부 여부</span>");
	        			out.println("<input class=\"form-control\" type=\"text\" value=\"" + mem + "\" aria-describedby=\"memLabel\" readonly>");
	        			out.println("</div>");
	        			out.println("<div class=\"input-group mb-3\" style=\"justify-content: center;\">");
	        			out.println("<div class=\"form-check form-check-inline\">");
	        			out.println("<input class=\"form-check-input\" type=\"radio\" name=\"depart\" id=\"depart1\" value=\"심컴\" checked>");
	        			out.println("<label class=\"form-check-label\" for=\"depart1\">심컴</label>");
	        			out.println("</div>");
	        			out.println("<div class=\"form-check form-check-inline\">");
   	        			out.println("<input class=\"form-check-input\" type=\"radio\" name=\"depart\" id=\"depart2\" value=\"글솦\">");
   	        			out.println("<label class=\"form-check-label\" for=\"depart2\">글솦</label>");
   	        			out.println("</div>");
	        			out.println("</div>");
						out.println("<button class=\"btn btn-outline-primary form-control\" id=\"commitBtn\" type=\"submit\">수정 완료</button>");
						out.println("</form>");
		  			%>
	      			</div>
	    		</div>
		  	</div>
		</div>
		
		<div class="modal fade" id="ReviewModal" tabindex="-1" aria-labelledby="ReviewModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
		  		<div class="modal-content">
		      		<div class="modal-header">
		        		<h5 class="modal-title" id="ReviewModalLabel">Review</h5>
		        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      		</div>
					<div class="modal-body">
	        		<%
		        		query = "SELECT m.Mid, r.Rating, r.Comments "
								+ "FROM SMENU_LIST s, MENU m, Rating r " 
								+ "WHERE s.Sid = ? AND m.Mid = r.MenuId AND s.Mid = m.Mid AND s.Sid = r.StudentId AND s.IsGet = 'Y'";
						pstmt=conn.prepareStatement(query);
						pstmt.setString(1, sid);
						rs = pstmt.executeQuery();
						// 남긴 후기가 있는 경우, 그 후기를 보여주고 그렇지 않은 경우 후기 작성 form
						if (!rs.next()) {
							out.println("<form action=\"ratingInsert.jsp\" method=\"POST\">");
							out.println("<h3>리뷰 작성하기</h3>");
							out.println("<div class=\"form-floating mb-3\">");
							out.println("<input type=\"text\" id=\"floatingMname\" class=\"form-control\" name=\"mname\" value=\"" + mname + "\" readonly>");
							out.println("<label for=\"floatingMname\">메뉴 이름</label>");
							out.println("</div>");
							out.println("<div class=\"form-floating mb-3\">");
							out.println("<input type=\"number\" id=\"floatingRating\" class=\"form-control\" name=\"rating\" value=5 max=5 min=0 oninput=\"ValidRating(this)\" required>");
							out.println("<label for=\"floatingRating\">별점</label>");
							out.println("<div id=\"ratingHelp\" class=\"invalid-feedback\">0 ~ 5 사이의 1점 단위로 작성해주세요.</div>");
							out.println("</div>");
							out.println("<div class=\"form-floating mb-3\">");
							out.println("<textarea id=\"floatingComments\" class=\"form-control\" name=\"comments\" oninput=\"ValidRating(this)\" style=\"height: 100px\"></textarea>");
							out.println("<label for=\"floatingComments\">후기</label>");
							out.println("<div id=\"commentsHelp\" class=\"invalid-feedback\">75자 이내로 작성해주세요.</div>");
							out.println("</div>");
							out.println("<button class=\"btn btn-outline-primary form-control\" id=\"reviewBtn\" type=\"submit\">작성 완료</button>");
							out.println("</form>");
							out.println("</div>");
		      			}
						else {
							out.println("<h3>" + mname + "에 대한 리뷰</h3>");
							mid = rs.getString(1);
							rating = rs.getInt(2);
							comm = rs.getString(3);
							out.println("<h4>별점</h4>");
							String innerHtml="";
							for(int i=0; i<5; i++) {  
							  if(i < rating) innerHtml += "★";
							  else innerHtml += "☆";
							} 
							out.println(innerHtml);
							out.println("<h4>남긴 후기</h4>");
							out.println(comm);
							out.println("</div>");
							out.println("<div class=\"modal-footer\">");
							out.println("<button type=\"button\" class=\"btn btn-danger\" onclick=\"location.href='ratingDelete.jsp?mid=" + mid + "'\">삭제하기</button>");
							out.println("</div>");
						}
		  				rs.close();
		  				pstmt.close();
		  				conn.close();
		  			%>
    				</div>
		  		</div>
			</div>
		</div>
	</div>
</body>
</html>