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
	if(request.getMethod().equals("POST")){
		int deptno = Integer.parseInt(request.getParameter("deptno"));
		String dname = request.getParameter("dname");
		String loc = request.getParameter("loc");
		String sql = "update dept set dname='" + dname + "', loc='" + loc + "' where deptno=" + deptno;
		
		String url = "jdbc:mysql://localhost:3306/scott";
		String user = "user01";
		String pw = "1234";
		
		Connection conn = null;
		Statement stmt = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		try{
			conn = DriverManager.getConnection(url, user, pw);
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		}finally{
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
	}else{
		response.sendRedirect("./");
	}
	


%>
</body>
</html>