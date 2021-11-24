<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YSMC</title>
</head>
<body>
<%
    // session을 재시작해서 저장된 정보를 날린다
    session.invalidate();
    // 그리고 다시 index.html로 돌아가게 한다
    response.sendRedirect("./index.html"); 
%>
</body>
</html>
