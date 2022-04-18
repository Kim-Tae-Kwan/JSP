<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table align="center" width="800">
		<tr>
			<td colspan="6">
				<img alt="logo" src="../images/logo.jpg">
			</td>
		</tr>
		<tr>
			<td bgcolor="gray"></td>
			<td bgcolor="gray" width="100" align="center"><a href="../index.jsp"><font color="white">[홈으로]</font></a></td>
			<td bgcolor="gray" width="100" align="center"><a href="../intro.jsp"><font color="white">[인트로]</font></a></td>
			<td bgcolor="gray" width="100" align="center"><a href="list.jsp"><font color="white">[사원정보]</font></a></td>
			<td bgcolor="gray" width="100" align="center"><a href=""><font color="white">[로그인]</font></a></td>
			<td bgcolor="gray"></td>
		</tr>
		<tr>
			<td colspan="6">
				<h1>사원 정보</h1>
				<table width="600" align="center" cellspacing="0" border="1">
				<%
				int empno = Integer.parseInt(request.getParameter("empno"));
				//String sql = "select empno, ename, job, mgr, dname, loc, sal, comm, hiredate from emp inner join dept using(deptno) where empno=" + empno;
				String sql = "select empno, ename, job, (select ename from emp C where A.mgr = C.empno), dname, loc, sal, comm, hiredate from emp A inner join dept B using(deptno) where empno=" + empno;
				String url = "jdbc:mysql://192.168.128.133:3306/scott";
				String driver = "com.mysql.cj.jdbc.Driver";
				
				Connection conn = null;
				Statement statement = null;
				ResultSet rs = null;
				try{
					Class.forName(driver);
					conn = DriverManager.getConnection(url, System.getenv("MYSQL_USER"), System.getenv("MYSQL_PASSWORD"));
					statement = conn.createStatement();
					rs = statement.executeQuery(sql);
					if(rs.next()){
				%>
					<tr>
						<td>empno</td>
						<td><%=rs.getInt(1)%></td>
						<td>ename</td>
						<td><%=rs.getString(2)%></td>
					</tr>
					<tr>
						<td>job</td>
						<td><%=rs.getString(3)%></td>
						<td>mgr</td>
						<td>
						<% 
	                    String msg = rs.getString(4);
	                    if (msg == null) out.print("-");
	                    else out.println(msg);
	                    %>
	                  </td>
					</tr>
					<tr>
						<td>dname</td>
						<td><%=rs.getString(5)%></td>
						<td>loc</td>
						<td><%=rs.getString(6)%></td>
					</tr>
					<tr>
						<td>comm</td>
						<td><%=rs.getString(7)%></td>
						<td>hiredate</td>
						<td><%=rs.getInt(8)%></td>
					</tr>
				<%
					}
				}finally{
					if(rs != null) rs.close();
					if(statement != null) statement.close();
					if(conn != null) conn.close();
				}
				%>
				
				</table>
				
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="4">Copyright by bitacademy co.ltd. All rights reserved.</td>
			<td></td>
		</tr>
	</table>
</body>
</html>