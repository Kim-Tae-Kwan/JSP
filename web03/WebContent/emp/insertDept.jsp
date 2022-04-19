<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//deptno=1234&dname=test&loc=1
int deptno = Integer.parseInt(request.getParameter("deptno"));
String dname = request.getParameter("dname");
String loc = request.getParameter("loc");

if(loc.equals("1")) loc = "서울";
else if(loc.equals("2")) loc = "부산";
else if(loc.equals("3")) loc = "대구";
else if(loc.equals("4")) loc = "광주";


String sql = "insert into dept values(" + deptno + ",'" + dname + "','" + loc + "');";
String url = "jdbc:mysql://192.168.128.133:3306/scott";

Connection conn = null;
Statement statement = null;

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, System.getenv("MYSQL_USER"), System.getenv("MYSQL_PASSWORD"));
	statement = conn.createStatement();
	statement.executeUpdate(sql);
}finally{
	if(statement != null) statement.close();
	if(conn != null) conn.close();
}
response.sendRedirect("list.jsp");
%>
</body>
</html>