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
<script type="text/javascript">
    $(document).ready(function() {
        $("#EditMenuModal").on("show.bs.modal", function(e) {
        	var mid = $(e.relatedTarget).data('mid');
        	var mname = $(e.relatedTarget).data('mname');
            var quan = $(e.relatedTarget).data('quan');
            var mem = $(e.relatedTarget).data('mem');
            var store = $(e.relatedTarget).data('store');
            var addr = $(e.relatedTarget).data('addr');
            var phone = $(e.relatedTarget).data('phone');
            var season = $(e.relatedTarget).data('season');
            
            $('input[name=mid]').attr('value',mid);
            $('input[name=mname]').attr('value',mname);
            $('input[name=quantity]').attr('value',quan);
            $('input[name=isMenuForMembership]').attr('value',mem);
            $('input[name=storeN]').attr('value',store);
            $('input[name=Address]').attr('value',addr);
            $('input[name=Phone]').attr('value',phone);
            $('input[name=seasonId]').attr('value',season);
        });
    });
</script>
<style type="text/css">
	#controlBar {
		width: 90%;
    	margin: 5px auto;
		display: flex;
		margin-top: 50px;
		height: 10%;
		border-radius: 10px;
		box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
		justify-content: space-around;
		align-items: center;
	}
	#adminMenuForm {
		display: flex;
	}
	#buttonDiv {
		float : right;
	}
	#commitBtn {
		display: block;
	}
	.input-group {
		margin: 0 10px 0 10px;
	}
</style>
<title>YSMC</title>
</head>
<body>
	<%
		HttpSession session = request.getSession();
		String aid = (String)session.getAttribute("aid");
		session.setAttribute("aid", aid); //메뉴 관리시에 MANAGES 정보를 위함
		
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
	<div id="controlBar" class="container">
		<div id="formDiv">
			<form action="menuList.jsp" method="post" accept-charset="utf-8" id="adminMenuForm">
		      	<div class="input-group form-floating">
	      			<input id="inputGroupSelect01" class="form-control" name="input" placeholder="학번" type="text">
	      			<label for="inputGroupSelect01">검색</label>
				</div>
				<div class="input-group">
			  		<label class="input-group-text" for="inputGroupSelect02">검색 기준</label>
			  		<select class="form-select" id="inputGroupSelect02" name="section">
			    		<option value="mname" selected>메뉴 이름</option>
						<option value="storeN">가게 이름</option>
						<option value="seasonId">시즌</option>
			  		</select>
				</div>
		    	<button class="btn formSubmitBtns" id="adminSearchBtn" type="submit"><i class="fas fa-search"></i></button>
	  		</form>
		</div>
	  	<div id="buttonDiv">
	  		<button type="button" class="btn adminBtns" data-bs-toggle="modal" data-bs-target="#AddMenuModal">메뉴 추가  <i class="fa-solid fa-plus"></i></button>
	  	</div>
  	</div>
  	<div id="menuList" class="container">
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
		
		query += " order by seasonId";
		pstmt=conn.prepareStatement(query);	
		rs=pstmt.executeQuery();
		out.println("<table class='table table-striped'>");
		out.println("<thead>");
		out.println("<th class=\"text-center\">메뉴 이름</th>");
		out.println("<th class=\"text-center\">수량</th>");
		out.println("<th class=\"text-center\">학생회비 납부자용 메뉴 여부</th>");
		out.println("<th class=\"text-center\">가게 이름</th>");
		out.println("<th class=\"text-center\">시즌</th>");
		out.println("<th class=\"text-center\">수정</th>");
		out.println("</thead>");
		while(rs.next()){
			String mid = rs.getString(1);
			query = "select m.mname, m.Quantity, m.IsMenuForMembership, m.StoreN, s.Address, s.Phone, m.seasonid "
					+ "from menu m , store s, season se "
					+ "where StoreN = StoreName and m.SeasonId = se.SeasonId and mid = '"+mid+"'";
			System.out.println(query);
			pstmt=conn.prepareStatement(query);	
			ResultSet rs_temp=pstmt.executeQuery();
			rs_temp.next();
			
			String mname = rs_temp.getString(1);
			int quan = rs_temp.getInt(2);
			String membership = rs_temp.getString(3);
			String storeN = rs_temp.getString(4);
			String addr = rs_temp.getString(5);
			String phone = rs_temp.getString(6);
			String seasonId = rs_temp.getString(7);
			
			out.println("<tr>");
			out.println("<th class=\"text-center\">"+ mname +"</th>");
			out.println("<td class=\"text-center\">"+quan+"</td>");
			out.println("<td class=\"text-center\">"+(membership.equals("N") ? "X" : "O")+"</td>");
			out.println("<td class=\"text-center\">"+storeN+"</td>");
			out.println("<td class=\"text-center\">"+seasonId+"</td>");
			out.println("<td class=\"text-center\"><button type=\"button\" class=\"btn updateInfoBtn\" data-bs-toggle=\"modal\" data-bs-target=\"#EditMenuModal\" data-mid=\""+mid+"\" data-mname=\""+mname+"\" data-quan=\""+quan+"\" data-mem=\""+membership+"\" data-store=\""+storeN+"\" data-season=\""+seasonId+"\" data-addr=\""+addr+"\" data-phone=\""+phone+"\"><i class=\"fas fa-share\"></i></button></td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
  	</div>
  	<div class="modal fade" id="AddMenuModal" tabindex="-1" aria-labelledby="AddMenuModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
	  		<div class="modal-content">
	      		<div class="modal-header">
	        		<h5 class="modal-title" id="AddMenuModalLabel">메뉴 추가</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      		</div>
				<div class="modal-body">
        		<%
					// 수정할 수 없는 거는 readonly로
					out.println("<form action=\"addMenu.jsp\" method=\"POST\" accept-charset=\"utf-8\">");
					out.println("<h5>메뉴 정보</h5>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"text\" id=\"floatingMname\" class=\"form-control\" name=\"add_mname\" placeholder=\"메뉴 이름\" required>");
        			out.println("<label for=\"floatingMname\">메뉴 이름</label>");
        			out.println("</div>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"number\" id=\"floatingQuantity\" class=\"form-control\" name=\"add_quantity\" placeholder=\"수량\" required>");
        			out.println("<label for=\"floatingQuantity\">수량</label>");
        			out.println("</div>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"text\" id=\"floatingIsMenuForMembership\" class=\"form-control\" name=\"add_isMenuForMembership\" placeholder=\"학생회비 납부자용 메뉴 여부\" required>");
        			out.println("<label for=\"floatingIsMenuForMembership\">학생회비 납부자용 메뉴 여부</label>");
        			out.println("</div>");
        			out.println("<hr>");
        			out.println("<h5>가게 정보</h5>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"text\" id=\"floatingStoreName\" class=\"form-control\" name=\"add_storeN\" placeholder=\"가게 이름\" required>");
        			out.println("<label for=\"floatingStoreName\">가게 이름</label>");
        			out.println("</div>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"text\" id=\"floatingStoreAddress\" class=\"form-control\" name=\"add_Address\" placeholder=\"가게 주소\">");
        			out.println("<label for=\"floatingStoreAddress\">가게 주소</label>");
        			out.println("</div>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"text\" id=\"floatinStorePhone\" class=\"form-control\" name=\"add_Phone\" placeholder=\"가게 전화번호\">");
        			out.println("<label for=\"floatinStorePhone\">가게 전화번호</label>");
        			out.println("</div>");
        			out.println("<hr>");
        			out.println("<h5>야식마차 정보</h5>");
        			out.println("<div class=\"form-floating mb-3\">");
        			out.println("<input type=\"text\" id=\"floatinSeasonId\" class=\"form-control\" name=\"add_seasonId\" placeholder=\"시즌\">");
        			out.println("<label for=\"floatinSeasonId\">시즌</label>");
        			out.println("</div>");
					out.println("<button class=\"btn form-control formSubmitBtns\" id=\"commitBtn\" type=\"submit\">추가</button>");
					out.println("</form>");

					rs.close();
					pstmt.close();
					conn.close();
	  			%>
      			</div>
    		</div>
	  	</div>
	</div>
	<!-- Menu Request Modal -->
	<div class="modal fade" id="EditMenuModal" tabindex="-1" aria-labelledby="EditMenuModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
	  		<div class="modal-content">
	      		<div class="modal-header">
	        		<h5 class="modal-title" id="EditMenuModalLabel">메뉴 수정</h5>
	        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      		</div>
				<div class="modal-body text-center">
					<form action="updateMenu.jsp" method="POST" accept-charset="utf-8">
						<input type="hidden" id="floatingMid" class="form-control" name="mid" value="">
				      	<div class="form-floating mb-3">
				      		<input type="text" id="floatingMname" class="form-control" name="mname" placeholder="메뉴이름"	 value="" required>
							<label for="floatingMname">메뉴이름</label>
				      	</div>
				      	<div class="form-floating mb-3">
				      		<input type="number" id="floatingQuantity" class="form-control" name="quantity" placeholder="수량" value="" required>
							<label for="floatingQuantity">수량</label>
				      	</div>
				      	<div class="form-floating mb-3">
				      		<input type="text" id="floatingIsMenuForMembership" class="form-control" name="isMenuForMembership" placeholder="학생회비납부자용메뉴여부" value="" required>
							<label for="floatingIsMenuForMembership">학생회비납부자용메뉴여부</label>
				      	</div>
				      	<hr>
				      	<div class="form-floating mb-3">
				      		<input type="text" id="floatingStoreName" class="form-control" name="storeN" placeholder="가게이름" value="" required>
							<label for="floatingStoreName">가게이름</label>
				      	</div>
				      	<div class="form-floating mb-3">
				      		<input type="text" id="floatingStoreAddress" class="form-control" name="Address" value="" placeholder="가게주소">
							<label for="floatingStoreAddress">가게주소</label>
				      	</div>
				      	<div class="form-floating mb-3">
				      		<input type="text" id="floatinStorePhone" class="form-control" name="Phone" value="" placeholder="가게번호">
							<label for="floatinStorePhone">가게번호</label>
				      	</div>
				      	<hr>
				      	<div class="form-floating mb-3">
				      		<input type="text" id="floatinSeasonId" class="form-control" name="seasonId" value="" placeholder="시즌">
							<label for="floatinSeasonId">시즌</label>
				      	</div>
				    	<button class="btn form-control formSubmitBtns" type="submit">확인</button>
				  	</form>
				</div>
			</div>
  		</div>
	</div>
</body>
</html>