<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="800" align="center" cellspacing="0">
		<tr>
			<td colspan="5">
				<img alt="" src="images/logo.jpg">
			</td>
		</tr>
		<tr>
			<td bgcolor="gray"></td>
			<td bgcolor="gray" width="100" align="center"><a href=index.jsp>[HOME]</a></td>
			<td bgcolor="gray" width="100" align="center"><a href=list.jsp>[DEPT]</a></td>
			<td bgcolor="gray" width="100" align="center"><a href=list2.jsp>[DEPT2]</a></td>
			<td bgcolor="gray"></td>
		</tr>
		<tr>
			<td colspan="5">
				<!-- content start -->
				<h1>Mysql List Page</h1>
				<table border="1" width="80%" align="center">
					<%
					String by = request.getParameter("by");
					String search = request.getParameter("search");
					if(by == null) by = "deptno";
					if(search == null) search = "";
					%>
					<p align="center">
						<form action="" >
							<input type="text" name="search" value="<%=search%>">
							<input type="submit" value="검색">
						</form>
					</p>
					<tr>
						<td width="100"><a href="list2.jsp?by=deptno&search=<%=search%>">deptno</a></td>
						<td width="50%"><a href="list2.jsp?by=dname&search=<%=search%>"">dname</a></td>
						<td><a href="list2.jsp?by=loc&search=<%=search%>"">loc</a></td>
					</tr>
					<%
					Class.forName("com.mysql.cj.jdbc.Driver");
					
					String url = "jdbc:mysql://192.168.128.133:3306/scott";
					String user = "user01";
					String pwd = "1234";
					String sql = "select deptno, dname, loc from dept2 where dname like '%"+ search +"%' order by " + by;
					
					Connection conn = null;
					Statement statement = null;
					ResultSet rs = null;
					try{
						conn = DriverManager.getConnection(url, user, pwd);
						statement = conn.createStatement();
						rs = statement.executeQuery(sql);
						while(rs.next()){
							%>
							<tr>
								<td><a href="dept.jsp?deptno=<%=rs.getInt(1) %>"><%=rs.getInt(1) %> </a></td>
								<td><a href="dept.jsp?deptno=<%=rs.getString(2) %>"><%=rs.getString(2) %></a></td>
								<td><a href="dept.jsp?deptno=<%=rs.getString(3) %>"><%=rs.getString(3) %></a></td>
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
				<p align="center">
					<a href="add.jsp">[입 력]</a>
				</p>
				<!-- content end -->
			</td>
		</tr>
		<tr>
			<td colspan="5" align="center" bgcolor="gray">
			Copyright by bitacademy co.ltd. All rights reserved.
			</td>
		</tr>
	
	
	</table>
</body>
</html>