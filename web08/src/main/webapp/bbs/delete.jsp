<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
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
		String empno = request.getParameter("empno");
		
		String sql = "delete from emp where empno=" + empno;
		String url = "jdbc:mysql://localhost:3306/scott";
		String user = "user01";
		String pw = "1234";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		try{
			conn = DriverManager.getConnection(url, user, pw);
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		}finally{
			if(stmt !=null) stmt.close();
			if(conn !=null) conn.close();
		}	
	}else response.sendRedirect("../");
	
%>
</body>
</html>