<%@page import="com.mongodb.client.model.Sorts"%>
<%@page import="com.mongodb.*"%>
<%@page import="org.bson.conversions.Bson"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="com.mongodb.client.*"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.MongoClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dummy Date List</title>
</head>
<body>
<%
String myPath = ".";
%>
<h1 align="center">Dummy Date List</h1>
<table width="500" align="center" border="1">
	<%
	//변수 선언.
	String sortField = request.getParameter("sort");
	String search = request.getParameter("search");
	String fieldName = request.getParameter("field");
	
	if(sortField == null) sortField = "_id";
	if(search == null) search = "";
	if(fieldName == null) fieldName = "title";
	
	int pageNum = 1;
	long pageMax = 0;
	long next = 0;
	int prev = 0;
	%>
	<p align="center">
		
		<form action="" >
			<select name="field">
				<option value="title">제목</option>
				<option value="body">내용</option>
			</select>
			<input type="text" name="search" value="<%=search%>">
			<input type="submit" value="검색">
		</form>
	</p>
	<tr>
		<th width="50"><a href="index.jsp?p=1&sort=_id&search=<%=search %>&field=<%=fieldName%>">번호</a></th>
		<th><a href="index.jsp?p=1&sort=title&search=<%=search %>&field=<%=fieldName%>">제목</a></th>
		<th width="100"><a href="index.jsp?p=1&sort=user_id&search=<%=search %>&field=<%=fieldName%>">작성자</a></th>
	</tr>
	<%
	MongoClient client = null;
	try{
		//서버 정보
		String ip = "127.0.0.1";
		int port = 27017;
		
		//MongoDB 연결
		client = new MongoClient(new ServerAddress(ip, port));
		MongoDatabase db = client.getDatabase("testDB");
		MongoCollection<Document> coll = db.getCollection("test01");
		Bson filter = Filters.regex(fieldName, search);
		
		//페이징 변수 설정.
		pageMax = (long)Math.ceil(coll.countDocuments(filter) / 10.0);
		String param = request.getParameter("p");
		if(param != null) pageNum = Integer.parseInt(param);
		
		if(pageNum >= pageMax){
			next = pageMax;
		}else next = pageNum + 1; 
		
		if(pageNum <= 1){
			prev = 1;
		}else prev = pageNum - 1;
		//페이징, 서치, 정렬을 사용하여 검색.
		FindIterable<Document> ite = coll.find(filter)
										.sort(new Document(sortField, 1))
										.skip(10 * (pageNum - 1))
										.limit(10);
		
		MongoCursor<Document> cursor = ite.iterator();
		while(cursor.hasNext()){
			Document obj = cursor.next();
	%>
		<tr>
			<td align="center"><%=obj.getInteger("_id", 0) %></td>
			<td align="center"><%=obj.getString("title") %></td>
			<td align="center"><%=obj.getInteger("user_id") %></td>
		</tr>
	<%
		}
	}finally{
		if(client != null) client.close();
	}
	%>
</table>
<p align="center">
	<a href="index.jsp?p=<%=prev %>&sort=<%=sortField %>&search=<%=search %>&field=<%=fieldName%>">[이전]</a>
	<a href="index.jsp?p=<%=next %>&sort=<%=sortField %>&search=<%=search %>&field=<%=fieldName%>">[다음]</a>
</p>
</body>
</html>