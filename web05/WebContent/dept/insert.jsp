<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.WriteResult"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.MongoClient"%>
<%@page import="com.mongodb.Mongo"%>
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
//GET 경우 add.jsp로 다시 리다이렉트
if(request.getMethod().equals("GET")){
	response.sendRedirect("add.jsp");
	return;
}
request.setCharacterEncoding("utf-8");
String param1 = request.getParameter("deptno");
String param2 = request.getParameter("dname");
String param3 = request.getParameter("loc");

int deptno = Integer.parseInt(param1.trim());
String dname = param2.trim();
String loc = param3.trim();
////
/* Mongo client = null;
try{
	client = new MongoClient();
	DBCollection coll = client.getDB("testDB").getCollection("dept02");
	BasicDBObject doc = new BasicDBObject("_id", deptno);
	doc.append("dname", dname);
	doc.append("loc", loc);
	WriteResult result = coll.insert(doc);
	
}finally{
	client.close();
} */
////
////
MongoClient client = null;
try{
	client = new MongoClient("localhost", 20000);
	MongoDatabase db = client.getDatabase("test01");
	MongoCollection<Document> coll = db.getCollection("dept02");
	Document document = new Document("_id", deptno);
	document.append("dname", dname);
	document.append("loc", loc);
	coll.insertOne(document);
}finally{
	client.close();
}
////
response.sendRedirect("list.jsp");
%>
</body>
</html>