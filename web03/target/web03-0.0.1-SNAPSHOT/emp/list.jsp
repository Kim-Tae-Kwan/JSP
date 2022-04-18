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
				<h1>사원 목록</h1>
				<table width ="600" border = "1" align ="center" cellspacing="0">
					<tr>
						<td width ="100">empno</td>
						<td width ="200">ename</td>
						<td width ="200">dname</td>
						<td width ="100">location</td>
					</tr>
					<%
					String url = "jdbc:mysql://192.168.128.133:3306/scott";
					//String sql = "select empno, ename, dname, loc from emp A, dept B where A.deptno=B.deptno";
					String sql = "select A.empno, A.ename, B.dname, B.loc from emp A inner join dept B on A.deptno=B.deptno order by A.empno";
					
					Map<String, String> map = System.getenv();
					String user = map.get("MYSQL_USER");
					String password = map.get("MYSQL_PASSWORD");
					
					Properties props = new Properties();
					props.setProperty("user", user);
					props.setProperty("password", password);
					
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn = null;
					Statement stmt = null;
					ResultSet rs = null;
					try{
						conn = DriverManager.getConnection(url, props);
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql);
						while(rs.next()){
					%>
					<tr>
						<td><%=rs.getInt(1) %></td>
						<td><%=rs.getString(2) %></td>
						<td><%=rs.getString(3) %></td>
						<td><%=rs.getString(4) %></td>
					</tr>
					<%
						}
					}finally{
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();
						if(conn!=null) conn.close();
					}
					%>
					
				</table>
				<p>
					<a href="addEmp.jsp">[사원추가]</a>
					<a href="addDept.jsp">[부서추가]</a>
				</p>
				
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