<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="./css/global.css">
<script type="text/javascript">
    function toggle() {
    	this.state = !this.state;
    	this.innerHTML = this.state ? 'SIGN IN' : 'SIGN UP';
    	if (this.state) {
    		document.getElementById("signIn").style.display = 'none';
    		document.getElementById("signUp").style.display = 'block';
    	}
    	else {
    		document.getElementById("signIn").style.display = 'block';
    		document.getElementById("signUp").style.display = 'none';
    	}
    }
</script>

<style type="text/css">
body {
	text-align: center;
}
img {
	padding: 30px;
}
#signForm {
	width: 550px;
	margin-top: 30px;
	padding: 0 30px 20px 30px;
	border-radius: 10px;
	box-shadow: 0 8px 20px 0 rgba(0,0,0,0.15);
}
h3 {
	position: relative;
	padding: 20px;
}
#signUp {
	display: none;
}
</style>
<title>YSMC</title>
</head>
<body>
	<img src="./image/main.png" width="40%">
	<div id="signForm" class="container">
		<div id="signIn">
			<form action="signIn.jsp" method="POST">
				<h3>SIGN IN</h3>
				<div class="form-floating mb-3">
					<input type="text" id="floatingSid" class="form-control" name="sid" placeholder="학번" required>
					<label for="floatingSid">학번</label>
				</div>
				<div class="form-floating">
					<input type="password" id="floatingPwd" class="form-control" name="pwd" placeholder="비밀번호" required>
					<label for="floatingPwd">비밀번호</label>
				</div>
				<br/>
				<button class="btn btn-outline-primary btn-lg form-control" type="submit">Sign in</button>
			</form>
		</div>
		<div id="signUp">
			<form action="signUp.jsp" method="POST">
				<h3>SIGN UP</h3>
				<div class="form-floating mb-3">
					<input type="text" id="floatingUpSid" class="form-control" name="sid" placeholder="학번" required>
					<label for="floatingUpSid">학번</label>
				</div>
				<div class="form-floating mb-3">
					<input type="password" id="floatingUpPwd" class="form-control" name="pwd" placeholder="비밀번호" required>
					<label for="floatingUpPwd">비밀번호</label>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="floatingName" class="form-control" name="sname" placeholder="이름" required>
					<label for="floatingName">이름</label>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="floatingPhone" class="form-control" name="phone" placeholder="휴대폰 번호(ex: 010xxxxxxxx)" required>
					<label for="floatingPhone">휴대폰 번호(ex: 010xxxxxxxx)</label>
				</div>
				<div class="form-floating">
					<input type="text" id="floatingDept" class="form-control" name="dno" placeholder="전공(ex: 심컴, 글솦)" required>
					<label for="floatingDept">전공(ex: 심컴, 글솦)</label>
				</div>
				<br/>
                <button class="btn btn-outline-primary btn-lg form-control" type="submit">Sign up</button>
			</form>
		</div>
		<br/>
		<button type="button" class="btn btn-primary" data-bs-toggle="button" id="SwitchBtn" onclick="toggle.call(this)">SIGN UP</button>
	</div>
</body>
</html>