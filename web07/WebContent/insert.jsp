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
		request.setCharacterEncoding("UTF-8");
		String param1 = request.getParameter("deptno");
		String param2 = request.getParameter("dname");
		String param3 = request.getParameter("loc");
		
		int deptno = Integer.parseInt(param1);
		String dname = param2.trim();
		String loc = param3.trim();
		
		String sql = "insert into dept values("
						+ deptno + ",'"
						+ dname + "','"
						+ loc + "'"
						+ ")";
		
		String driver = "com.mysql.cj.jdbc.Driver";
		String user = "user01";
		String pw = "1234";
		String url = "jdbc:mysql://localhost:3306/scott";
		
		Class.forName(driver);
		Connection conn = null;
		Statement stmt = null;
		try{
			conn = DriverManager.getConnection(url, user, pw);
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		}finally{
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
	}
%>
</body>
</html>