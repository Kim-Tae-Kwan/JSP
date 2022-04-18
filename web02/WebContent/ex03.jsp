<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>내장 객체</h1>
	<%
	//내장 객체(참조 변수)
	String addr = request.getRemoteAddr();
	String host = request.getRemoteHost();
	int port = request.getRemotePort();
	String uri = request.getRequestURI();
	StringBuffer url = request.getRequestURL();
	out.println(addr);
	out.println("<br>");
	out.println(host);
	out.println("<br>");
	out.println(port);
	out.println("<br>");
	out.println(uri);
	out.println("<br>");
	out.println(url);
	out.println("<br>");
	%>
</body>
</html>