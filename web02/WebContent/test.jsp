<%@page import="java.util.Arrays"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>데이터베이스 접속 테스트</h1>
	<% 
	Connection conn = null;
	String url = "jdbc:mysql://192.168.128.133:33066/";
	String user = "root";
	String pw = "1234";
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, pw);
		if(conn != null) {
	%><h2> connection : true </h2>
	<%}else{%>
	 <h2> connection : false </h2>
	<%} 
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if (conn != null) conn.close();
	}
	
	%>
</body>
</html>