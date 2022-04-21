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
			<%
			int deptno = Integer.parseInt(request.getParameter("deptno"));
			String dname = "";
			String loc = "";
			
			String ip = "127.0.0.1";
			int port = 27017;
			MongoClient client = null;
			try{
				client = new MongoClient(new ServerAddress(ip, port));
				DB db = client.getDB("testDB");			
				DBCollection collection = db.getCollection("dept02");
				
				BasicDBObject document = new BasicDBObject();
				document.append("_id", deptno);
				
				DBCursor cursor = collection.find(document);
				if(cursor.hasNext()){
					DBObject result = cursor.next();
					dname = result.get("dname").toString();
					loc = result.get("loc").toString();
				}	
			}finally{
				client.close();
			}
			
			%>
			<h1>Detail Page</h1>
			<table align="center" width="80%">
				<tr>
					<td align="center" bgcolor="gray" width="100">deptno</td>
					<td><%=deptno %></td>
				</tr>
				<tr>
					<td align="center" bgcolor="gray" width="100">dname</td>
					<td><%=dname %></td>
				</tr>
				<tr>
					<td align="center" bgcolor="gray" width="100">loc</td>
					<td><%=loc %></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<a href="edit.jsp?deptno=<%=deptno%>">[수 정]</a>
						<a href="delete.jsp?deptno=<%=deptno%>">[삭 제]</a>
					</td>
				</tr>
			</table>			
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