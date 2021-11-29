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
<link rel="stylesheet" href="./style/global.css?after">
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
	$(document).ready(function() {
        $("#ReviewModal").on("show.bs.modal", function(e) {
        	var mname = $(e.relatedTarget).data('mname');
        	var mid = $(e.relatedTarget).data('mid');
            $('input[name=mname]').attr('value',mname);
            $('input[name=mid]').attr('value',mid);
        });
    });
	$(document).ready(function() {
        $("#ShowReviewModal").on("show.bs.modal", function(e) {
        	var mname = $(e.relatedTarget).data('mname');
        	var rating = $(e.relatedTarget).data('rating');
        	var comm = $(e.relatedTarget).data('comm');
        	var mid = $(e.relatedTarget).data('mid');
        	
        	console.log(mid);
        	document.getElementById("ModalMessage").innerHTML = mname;
        	var innerHtml="";
			for(var i=0; i<5; i++) {  
				if(i < rating) innerHtml += "★";
				else innerHtml += "☆";
			} 
			document.getElementById("ModalRating").innerHTML = innerHtml;
			document.getElementById("ModalComment").innerHTML = comm;
			$('input[name=mid]').attr('value',mid);
        });
    });
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
	display: block;
}
#reviewBtn {
	width: 150px;
	display: block;
}
.btn-toolbar {
	float: right;
}
.updateInfoBtn {
	margin-right: 10px;
}
.deleteBtn {
	margin-left: 10px;
}
</style>
<title>YSMC</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<div id="mypagePaper" class="container">
		<h3 class="formTitle">MY PAGE</h3>
		<nav>
			<div class="nav nav-tabs" id="nav-tab" role="tablist">
			    <button class="nav-link active" id="nav-info-tab" data-bs-toggle="tab" data-bs-target="#nav-info" type="button" role="tab" aria-controls="nav-home" aria-selected="true"><strong>회원 정보</strong></button>
		    	<button class="nav-link" id="nav-menu-tab" data-bs-toggle="tab" data-bs-target="#nav-menu" type="button" role="tab" aria-controls="nav-profile" aria-selected="false"><strong>신청 메뉴</strong></button>
			</div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
  			<div class="tab-pane fade show active" id="nav-info" role="tabpanel" aria-labelledby="nav-info-tab">
  			<%
	  			String season="", storen="", mname="", mid="", isget="", comm="";
	  			String[] attr = {"#", "야식마차", "가게 이름", "메뉴 이름", "수령 여부", "REVIEW"};
	  			int cnt=1, rating=0;
	  			
	  			query = "SELECT Phone, Membership, Dno "
	  					+ "FROM STUDENT " 
	  					+ "WHERE Sid = ?";
	  			pstmt=conn.prepareStatement(query);
	  			pstmt.setString(1, sid);
	  			rs=pstmt.executeQuery();
	  			if (!rs.next()) { %>
				<script>
					alert("당신은 누구십니까.");
					document.location.href="signout.jsp";
				</script>
  				<% }
	  			else {
	  				out.println("<dl class=\"row\">");
	  				out.println("<dt class=\"col-sm-6 text-center\">학번</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + sid + "</dd><br/>");
	  				out.println("<dt class=\"col-sm-6 text-center\">이름</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + sname + "</dd>");
	  				out.println("<dt class=\"col-sm-6 text-center\">휴대폰 번호</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + phone + "</dd>");
	  				out.println("<dt class=\"col-sm-6 text-center\">학생회비 납부 여부</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + mem + "</dd>");
	  				out.println("<dt class=\"col-sm-6 text-center\">전공</dt>");
	  				out.println("<dd class=\"col-sm-6 text-center\">" + depart + "</dd>");
	  				out.println("</dl>");
	  				out.println("<div class=\"btn-toolbar\">");
	  				out.println("<button type=\"button\" class=\"btn updateInfoBtn\" id=\"chBtn\" data-bs-toggle=\"modal\" data-bs-target=\"#MypageUpdateModal\">수정  <i class=\"fas fa-user-edit\"></i></button>");
	  				out.println("<button type=\"button\" class=\"btn deleteBtn\" id=\"delBtn\" data-bs-toggle=\"modal\" data-bs-target=\"#DeleteModal\">탈퇴  <i class=\"fas fa-user-slash\"></i></button>");
	  				out.println("</div>");
				} %>
  			</div>
			<div class="tab-pane fade" id="nav-menu" role="tabpanel" aria-labelledby="nav-menu-tab">
				<% 
					query = "SELECT m.SeasonId, m.StoreN, m.Mname, m.Mid, s.IsGet "
							+ "FROM SMENU_LIST s, MENU m " 
							+ "WHERE s.Sid = ? AND s.Mid = m.Mid ORDER BY s.IsGet";
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
							mid = rs.getString(4);
							isget = (rs.getString(5).equals("N") ? "X" : "O");
							out.println("<td class=\"text-center\">" + season + "</td>");
							out.println("<td class=\"text-center\">" + storen + "</td>");
							out.println("<td class=\"text-center\">" + mname + "</td>");
							out.println("<td class=\"text-center\">" + isget + "</td>");
							if (isget.equals("X"))
								out.println("<td class=\"text-center\" style=\"color: red\">작성 불가</td>");
							else {
								query = "SELECT m.Mname, m.Mid, r.Rating, r.Comments "
										+ "FROM SMENU_LIST s, MENU m, Rating r " 
										+ "WHERE s.Sid = ? AND m.Mid = r.MenuId AND s.Mid = m.Mid AND s.Sid = r.StudentId AND s.IsGet = 'Y'";
								pstmt=conn.prepareStatement(query);
								pstmt.setString(1, sid);
								ResultSet rs_temp = pstmt.executeQuery();
								boolean isDuplicated = false;
								
								if (!rs_temp.next())
									out.println("<td class=\"text-center\"><button type=\"button\" style=\"padding: 0;\" class=\"btn\" data-bs-toggle=\"modal\" data-bs-target=\"#ReviewModal\" data-mname=\""+mname+"\" data-mid=\""+mid+"\"><i class=\"fas fa-share\"></i></button></td>");
								else {
									do {
										String rs_mname = rs_temp.getString(1);
										String rs_mid = rs_temp.getString(2);
										int rs_rating = rs_temp.getInt(3);
										String rs_comm = rs_temp.getString(4);
										if (rs_mid.equals(mid)) {
											isDuplicated = true;
											out.println("<td class=\"text-center\"><button type=\"button\" style=\"padding: 0;\" class=\"btn\" data-bs-toggle=\"modal\" data-bs-target=\"#ShowReviewModal\" data-mname=\""+rs_mname+"\" data-rating=\""+rs_rating+"\" data-comm=\""+rs_comm+"\" data-mid=\""+rs_mid+"\"><i class=\"fas fa-share\"></i></button></td>");
											break;
										}
									}while(rs_temp.next());
									if (!isDuplicated)
										out.println("<td class=\"text-center\"><button type=\"button\" style=\"padding: 0;\" class=\"btn\" data-bs-toggle=\"modal\" data-bs-target=\"#ReviewModal\" data-mname=\""+mname+"\" data-mid=\""+mid+"\"><i class=\"fas fa-share\"></i></button></td>");
								}
								rs_temp.close();
							}
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
						out.println("<button class=\"btn form-control modalBtns\" id=\"commitBtn\" type=\"submit\">수정 완료</button>");
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
		        		out.println("<form action=\"ratingInsert.jsp\" method=\"POST\">");
						out.println("<h3 class=\"formTitle\">리뷰 작성하기</h3>");
						out.println("<div class=\"form-floating mb-3\">");
					%>
						<input type="hidden" id="floatingMname" class="form-control" name="mid" value="" readonly>
						<input type="text" id="floatingMname" class="form-control" name="mname" value="" readonly>
					<% 
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
						out.println("<button class=\"btn form-control modalBtns\" id=\"reviewBtn\" type=\"submit\">작성 완료</button>");
						out.println("</form>");
						out.println("</div>");
		  			%>
    				</div>
		  		</div>
			</div>
		</div>
		
		<div class="modal fade" id="ShowReviewModal" tabindex="-1" aria-labelledby="ShowReviewModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
		  		<div class="modal-content">
		      		<div class="modal-header">
		        		<h5 class="modal-title" id="ShowReviewModalLabel">Review</h5>
		        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      		</div>
					<div class="modal-body text-center">
						<h3 id="ModalMessage"></h3>
						<h4>별점</h4>
						<p id="ModalRating"></p>
						<h4>남긴 후기</h4>
						<p id="ModalComment"></p>
					</div>
						<div class="modal-footer">
							<form action="ratingDelete.jsp" method="POST">
								<input type="hidden" id="floatingMname" class="form-control" name="mid" value="" readonly>
								<button type="submit" class="btn form-control btn-danger" id="deleteBtn"><i class="fas fa-trash-alt"></i></button>
							</form>
						</div>
   					</div>
	  		  </div>
			</div>
		
		<div class="modal fade" id="DeleteModal" tabindex="-1" aria-labelledby="DeleteModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
		  		<div class="modal-content">
		      		<div class="modal-header">
		        		<h5 class="modal-title" id="DeleteModalLabel">알림</h5>
		        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      		</div>
					<div class="modal-body text-center">
						<h3>정말 <button type="button" class="btn btn-danger modalBtns" onclick="location.href='deleteStudent.jsp'">탈퇴</button> 하시겠습니까?</h3>
					</div>
		  		</div>
			</div>
		</div>
	</div>
</body>
</html>