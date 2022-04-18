<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="0; url=list.jsp">
<title>Insert title here</title>
</head>
<body>
	<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	String ename = request.getParameter("ename");
	String job = request.getParameter("job");
	int mgr = Integer.parseInt(request.getParameter("mgr"));
	int deptno = Integer.parseInt(request.getParameter("deptno"));
	String sql = "insert into emp values (" + empno + ",'" + ename + "','" + job + "'," + mgr + ",now(),0,null," +  deptno + ");";
	System.out.println(sql);
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://192.168.128.133:3306/scott";
	
	Class.forName(driver);
	Connection conn = null;
	Statement statement = null;
	try{
		conn = DriverManager.getConnection(url, System.getenv("MYSQL_USER"), System.getenv("MYSQL_PASSWORD"));
		statement = conn.createStatement();
		statement.executeUpdate(sql);
	}finally{
		if(statement!=null) statement.close();
		if(conn!=null) conn.close();
	}
	response.sendRedirect("list.jsp");
	%>
</body>
</html>