<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.conversions.Bson"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.client.*"%>
<%@page import="com.mongodb.*"%>
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
	request.setCharacterEncoding("utf-8");
	int id = Integer.parseInt(request.getParameter("id"));
	String title = null;
	String body = null;
	
	MongoClient client = null;
	try{
		String ip = "127.0.0.1";
		int port = 27017;
		
		client = new MongoClient(new ServerAddress(ip, port));
		MongoDatabase db = client.getDatabase("testDB");
		MongoCollection<Document> coll = db.getCollection("test01");
		
		//Template 패턴.
		Bson filter = Filters.eq("_id", id);
		MongoCursor<Document> cursor = coll.find(filter).iterator();
		if(cursor.hasNext()){
			Document doc = cursor.next();
			title = doc.getString("title");
			body = doc.getString("body");
		}
	}finally{
		client.close();
	}
	%>
	<h1>Dummy Detail Page</h1>
	<form action="edit.jsp">
		<table align="center">
			<tr>
				<td width="100" bgcolor="#cccccc" align="center">번호</td>
				<td><input type="text" name="deptno" value="<%=id%>" readonly> </td>
			</tr>
			<tr>
				<td bgcolor="#cccccc" align="center">제목</td>
				<td><input type="text" name="dname" value="<%=title%>" readonly></td>
			</tr>
			<tr>
				<td bgcolor="#cccccc" align="center">내용</td>
				<td><input type="text" name="loc" value="<%=body%>" readonly></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수 정">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>