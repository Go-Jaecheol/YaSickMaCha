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
<link rel="stylesheet" href="./css/global.css?after">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
<script type="text/javascript">
	function ValidIn(e) {
		var sid = document.getElementById("floatingSid").value;
		var pwd = document.getElementById("floatingPwd").value;
		
		if (sid.length > 10 || sid.indexOf(' ') >= 0) {
			document.getElementById("sidHelp").style.display = 'flex';
			document.getElementById("InBtn").disabled = true;
		}
		else {
			document.getElementById("sidHelp").style.display = 'none';	
		}
		if (pwd.length > 5 || pwd.indexOf(' ') >= 0) {
			document.getElementById("pwdHelp").style.display = 'flex';
			document.getElementById("InBtn").disabled = true;	
		}
		else {
			document.getElementById("pwdHelp").style.display = 'none';		
		}
		if (document.getElementById("sidHelp").style.display != 'flex' && document.getElementById("pwdHelp").style.display != 'flex')
			document.getElementById("InBtn").disabled = false;	
	}
	function ValidUp(e) {
		var sid = document.getElementById("floatingUpSid").value;
		var pwd = document.getElementById("floatingUpPwd").value;
		var sname = document.getElementById("floatingUpSname").value;
		var phone = document.getElementById("floatingUpPhone").value;
		var dept = document.getElementById("floatingUpDept").value;
		
		if (sid.length > 10 || sid.indexOf(' ') >= 0) {
			document.getElementById("sidUpHelp").style.display = 'flex';
			document.getElementById("UpBtn").disabled = true;
		}	
		else document.getElementById("sidUpHelp").style.display = 'none';
		if(pwd.length > 5 || pwd.indexOf(' ') >= 0) {
			document.getElementById("pwdUpHelp").style.display = 'flex';
			document.getElementById("UpBtn").disabled = true;	
		}
		else document.getElementById("pwdUpHelp").style.display = 'none';
		if(sname.length > 7 || sname.indexOf(' ') >= 0) {
			document.getElementById("snameUpHelp").style.display = 'flex';
			document.getElementById("UpBtn").disabled = true;	
		}
		else document.getElementById("snameUpHelp").style.display = 'none';
		if(phone.length > 11 || phone.indexOf(' ') >= 0 || phone.indexOf("010") == -1) {
			document.getElementById("phoneUpHelp").style.display = 'flex';
			document.getElementById("UpBtn").disabled = true;	
		}
		else document.getElementById("phoneUpHelp").style.display = 'none';
		if(dept.length > 2 || dept.indexOf(' ') >= 0 || (dept != "심컴" && dept != "글솦")) {
			document.getElementById("dnoUpHelp").style.display = 'flex';
			document.getElementById("UpBtn").disabled = true;	
		}
		else document.getElementById("dnoUpHelp").style.display = 'none';
		if (document.getElementById("sidUpHelp").style.display != 'flex' && document.getElementById("pwdUpHelp").style.display != 'flex' && document.getElementById("snameUpHelp").style.display != 'flex' && document.getElementById("phoneUpHelp").style.display != 'flex' && document.getElementById("dnoUpHelp").style.display != 'flex') {
			document.getElementById("UpBtn").disabled = false;	
		}
	}
    function toggle() {
    	this.state = !this.state;
    	this.innerHTML = this.state ? '이미 계정이 있어요' : '계정이 없어요';
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
	box-shadow: 9px 9px 16px rgba(163, 177, 198, 0.6),
      -9px -9px 16px rgba(255, 255, 255, 0.5),
       inset 3px 3px 7px rgba(136, 165, 191, 0.48), 
      inset -3px -3px 7px #FFFFFF;
    background: linear-gradient(318.32deg, rgba(163, 177, 198, 0.1) 0%, rgba(163, 177, 198, 0.1) 55%, rgba(163, 177, 198, 0.25) 100%);
}
h1 {
	position: relative;
	padding: 20px;
	font-weight: 600;
}
#signUp {
	display: none;
}
#SwitchBtn {
	text-decoration: none;
	color: green;
}
#SwitchBtn:hover {
	text-decoration: underline;
}
</style>
<title>YSMC</title>
</head>
<body>
	<img src="./image/main.png" height="30%">
	<div id="signForm" class="container">
		<div id="signIn" class="fadein">
			<form action="signIn.jsp" method="POST">
				<h1><i class="fas fa-user-check"></i></h1>
				<div class="form-floating mb-3">
					<input type="text" id="floatingSid" class="form-control" name="sid" placeholder="학번" oninput="ValidIn(this)" required autofocus>
					<label for="floatingSid">학번</label>
					<div id="sidHelp" class="invalid-feedback">10자 이내로 입력해주세요.</div>
				</div>
				<div class="form-floating">
					<input type="password" id="floatingPwd" class="form-control" name="pwd" placeholder="비밀번호" oninput="ValidIn(this)" required>
					<label for="floatingPwd">비밀번호</label>
					<div id="pwdHelp" class="invalid-feedback">5자 이내로 입력해주세요.</div>
				</div>
				<br/>
				<button class="btn-lg form-control formSubmitBtns" id="InBtn" type="submit">SIGN IN</button>
			</form>
		</div>
		<div id="signUp">
			<form action="signUp.jsp" method="POST">
				<h1><i class="fas fa-user-edit"></i></h1>
				<div class="form-floating mb-3">
					<input type="text" id="floatingUpSid" class="form-control" name="sid" placeholder="학번" oninput="ValidUp(this)" required autofocus>
					<label for="floatingUpSid">학번</label>
					<div id="sidUpHelp" class="invalid-feedback">10자 이내로 입력해주세요.</div>
				</div>
				<div class="form-floating mb-3">
					<input type="password" id="floatingUpPwd" class="form-control" name="pwd" placeholder="비밀번호" oninput="ValidUp(this)" required>
					<label for="floatingUpPwd">비밀번호</label>
					<div id="pwdUpHelp" class="invalid-feedback">5자 이내로 입력해주세요.</div>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="floatingUpSname" class="form-control" name="sname" placeholder="이름" oninput="ValidUp(this)" required>
					<label for="floatingUpSname">이름</label>
					<div id="snameUpHelp" class="invalid-feedback">7자 이내로 입력해주세요.</div>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="floatingUpPhone" class="form-control" name="phone" placeholder="휴대폰 번호(ex: 010xxxxxxxx)" oninput="ValidUp(this)" required>
					<label for="floatingUpPhone">휴대폰 번호(ex: 010xxxxxxxx)</label>
					<div id="phoneUpHelp" class="invalid-feedback">형식에 맞게 입력해주세요.</div>
				</div>
				<div class="form-floating">
					<input type="text" id="floatingUpDept" class="form-control" name="dno" placeholder="전공(ex: 심컴, 글솦)" oninput="ValidUp(this)" required>
					<label for="floatingUpDept">전공(ex: 심컴, 글솦)</label>
					<div id="dnoUpHelp" class="invalid-feedback">형식에 맞게 입력해주세요.</div>
				</div>
				<br/>
                <button class="btn btn-lg form-control formSubmitBtns" id="UpBtn" type="submit">SIGN UP</button>
			</form>
		</div>
		<br/>
		<a href="#" data-bs-toggle="button" id="SwitchBtn" onclick="toggle.call(this)">계정이 없어요</a>
	</div>
</body>
</html>