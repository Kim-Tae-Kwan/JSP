<%@page import="com.mongodb.MongoClient"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.*"%>
<%@page import="com.mongodb.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#dddddd">
<%
String myPath = "..";
%>
<%@ include file="../template/header.jspf" %>
<h1>Dept List</h1>
<table width="500" align="center" border="1">
	<tr>
		<th>deptno</th>
		<th>dname</th>
		<th>loc</th>
	</tr>
	<%
	// default connection.
	// Mongo 라이브러리 버전 업
	MongoClient client = null;
	try{
		int p = 0;
		String param = request.getParameter("p");
		if(param != null){
			try{
				p = Integer.parseInt(param);	
			}catch(NumberFormatException e){
				
			}
		}
		
		client = new MongoClient();
		MongoDatabase db = client.getDatabase("testDB");
		MongoCollection<Document> coll = db.getCollection("dept02");
		FindIterable<Document> ite = coll.find().skip(5 * (p - 1)).limit(5);
		MongoCursor<Document> cursor = ite.iterator();
		while(cursor.hasNext()){
			Document obj = cursor.next();
	%>
		<tr>
			<td><a href="detail.jsp?deptno=<%=obj.getInteger("_id", 0)%>"><%=obj.getInteger("_id", 0) %></a></td>
			<td><a href="detail.jsp?deptno=<%=obj.getInteger("_id", 0) %>"><%=obj.getString("dname") %></a></td>
			<td><a href="detail.jsp?deptno=<%=obj.getInteger("_id", 0) %>"><%=obj.getString("loc") %></a></td>
		</tr>
	<%
		}
	}finally{
		if(client != null) client.close();
	}
	%>
</table>
<p align="center"><a href="add.jsp">[입 력]</a></p>
<%@ include file="../template/footer.jspf" %>			
</body>
</html>