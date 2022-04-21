<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.mongodb.*"%>
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
				<h1>List Page</h1>
				
				<table border="1" width="80%" align="center">
					<%
					String sortField = request.getParameter("sort");
					String search = request.getParameter("search");
					if(sortField == null) sortField = "_id";
					if(search == null) search = "";
					%>
					<p align="center">
						<form action="" >
							<input type="text" name="search" value="<%=search%>">
							<input type="submit" value="검색">
						</form>
					</p>
					<tr>
						<td width="100"><a href="list.jsp?sort=_id&search=<%=search%>">deptno</a></td>
						<td width="50%"><a href="list.jsp?sort=dname&search=<%=search%>"">dname</a></td>
						<td><a href="list.jsp?sort=loc&search=<%=search%>"">loc</a></td>
					</tr>
					<%
					String ip = "127.0.0.1";
					int port = 27017;
					
					MongoClient client = new MongoClient(new ServerAddress(ip, port));
					DB db = client.getDB("testDB");
					DBCollection coll = db.getCollection("dept02");
					
					DBCursor cursor = coll.find(new BasicDBObject("dname", new BasicDBObject("$regex",search))).sort(new BasicDBObject(sortField, 1));
					
					while(cursor.hasNext()){
						DBObject obj = cursor.next();
						out.println("<tr>");
						out.print("<td><a href=\"dept.jsp?deptno=" + obj.get("_id") + "\">" + obj.get("_id") + "</a></td>");
						out.print("<td><a href=\"dept.jsp?deptno=" + obj.get("_id") + "\">" + obj.get("dname") + "</a></td>");
						out.println("<td><a href=\"dept.jsp?deptno=" + obj.get("_id") + "\">" + obj.get("loc") + "</a></td>");
						out.println("</tr>");
					}
					client.close();
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