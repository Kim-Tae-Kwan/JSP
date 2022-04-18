<%@page import="java.util.Arrays"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="1;url=dept.jsp">
<title>Insert title here</title>
</head>
<body>
	<%
	// get 방식 한글처리
	// server.xml 수정
	// <Connector URIEncoding = "UTF-8" 추가.
	String deptno = request.getParameter("deptno");
	String dname = request.getParameter("dname");
	dname = new String(dname.getBytes("iso-8859-1"));
	String loc = request.getParameter("loc");
	if(loc.equals("1")) loc = "서울";
	else if(loc.equals("2")) loc = "대전";
	else if(loc.equals("3")) loc = "대구";
	else if(loc.equals("4")) loc = "부산";
	else if(loc.equals("5")) loc = "광주";
	
	String sql = "insert into dept values (" + deptno + ",'" + dname + "','" + loc + "')";
	System.out.println(sql);
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://192.168.128.133:3306/scott";
	String user = "user01";
	String pw = "1234";
	
	Connection conn = null;
	Statement stmt = null;
	int result = 0;
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, user, pw);
		stmt = conn.createStatement();
	    result = stmt.executeUpdate(sql);
		
		
	}catch(Exception e){
		
	}finally{
		if (conn != null) conn.close();
		if (stmt != null) stmt.close();
	}
	
	if(result>0){
	%>
	<h1>등록성공</h1>
	<%}else { %>
	<h1>등록실패</h1>
	<%}%>
</body>
</html>
