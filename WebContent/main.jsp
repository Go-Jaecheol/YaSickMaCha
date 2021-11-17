<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="./navbar.jsp" %>
	<%
		String test = (String)session.getAttribute("user_id");
		if (test == null)
	   		response.sendRedirect("./index.html"); 
		out.println("session: " + test);
    %>
</body>
</html>