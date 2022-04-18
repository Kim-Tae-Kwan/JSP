<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="0;url=dept.jsp"> 
<title>Insert title here</title>
</head>
<body>
<%

String deptno = request.getParameter("deptno");
String sql = "delete from dept where deptno=" + deptno;

String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://192.168.128.133:3306/scott";
String user = "user01";
String pw = "1234";
Properties info = new Properties();

System.setProperty("mysql.user", user);
System.setProperty("mysql.password", pw);

Connection conn = null;
Statement stmt = null;
int result = 0;
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, System.getProperty("mysql.user"), System.getProperty("mysql.password"));
	stmt = conn.createStatement();
    result = stmt.executeUpdate(sql);
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	if (conn != null) conn.close();
	if (stmt != null) stmt.close();
}
%>

</body>
</html>