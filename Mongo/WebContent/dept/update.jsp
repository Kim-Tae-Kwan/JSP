<%@page import="com.mongodb.client.model.Updates"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="com.mongodb.client.*"%>
<%@page import="org.bson.conversions.Bson"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.MongoClient"%>
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
String param1 = request.getParameter("deptno");
String param2 = request.getParameter("dname");
String param3 = request.getParameter("loc");

int deptno = Integer.parseInt(param1);
String dname = param2.trim();
String loc = param3.trim();

if(request.getMethod().equals("GET")){
	response.sendRedirect("edit.jsp?deptno=" + deptno);
	return;
}

MongoClient client = null;
try{
	client = new MongoClient();
	MongoDatabase db = client.getDatabase("testDB");
	MongoCollection<Document> coll = db.getCollection("dept02");
	
	Bson filter = Filters.eq("_id", deptno);
 	Bson updates = Updates.combine(
             Updates.set("dname", dname),
             Updates.set("loc", loc)
             );
	coll.updateOne(filter, updates);
}finally{
	client.close();
}

response.sendRedirect("list.jsp");
%>
</body>
</html>