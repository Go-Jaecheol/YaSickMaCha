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
<meta charset="utf-8">
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
	
	#form {
		margin-top: 30px;
		padding-bottom: 20px;
		padding-top: 20px;
		border-radius: 10px;
		box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
	}
</style>
<title>YSMC</title>
</head>
<body>
	<%
		HttpSession session = request.getSession();
		String aid = (String)session.getAttribute("aid");
		session.setAttribute("aid", aid); //메뉴 관리시에 MANAGES 정보를 위함
		System.out.println(aid);
	%>
	<%@ include file="./adminNavbar.jsp" %>
	<div id="form" class="container">
		<form action="updateMenu.jsp" method="post" naccept-charset="utf-8">
	      	<h3>메뉴 추가</h3>
	      	<div class="form-floating mb-3">
	      		<input type="text" id="floatingMname" class="form-control" name="mname" placeholder="메뉴이름" required>
				<label for="floatingMname">메뉴이름</label>
	      	</div>
	      	<div class="form-floating mb-3">
	      		<input type="number" id="floatingQuantity" class="form-control" name="quantity" placeholder="수량" required>
				<label for="floatingQuantity">수량</label>
	      	</div>
	      	<div class="form-floating mb-3">
	      		<input type="text" id="floatingIsMenuForMembership" class="form-control" name="isMenuForMembership" placeholder="학생회비납부자용메뉴여부" required>
				<label for="floatingIsMenuForMembership">학생회비납부자용메뉴여부</label>
	      	</div>
	      	<hr>
	      	<div class="form-floating mb-3">
	      		<input type="text" id="floatingStoreName" class="form-control" name="storeN" placeholder="가게이름" required>
				<label for="floatingStoreName">가게이름</label>
	      	</div>
	      	<div class="form-floating mb-3">
	      		<input type="text" id="floatingStoreAddress" class="form-control" name="Address" placeholder="가게주소">
				<label for="floatingStoreAddress">가게주소</label>
	      	</div>
	      	<div class="form-floating mb-3">
	      		<input type="text" id="floatinStorePhone" class="form-control" name="Phone" placeholder="가게번호">
				<label for="floatinStorePhone">가게번호</label>
	      	</div>
	      	<hr>
	      	<div class="form-floating mb-3">
	      		<input type="text" id="floatinSeasonId" class="form-control" name="seasonId" placeholder="시즌">
				<label for="floatinSeasonId">시즌</label>
	      	</div>
	    	<button class="btn btn-primary" type="submit">확인</button>
	  	</form>
  	</div>
</body>
</html>