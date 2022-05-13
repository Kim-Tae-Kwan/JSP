<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="../template/head.jsp">
		<jsp:param value=".." name="root"/>
	</jsp:include>
	<script type="text/javascript">
				
	</script>
	</head>
	<%@ page import="java.sql.*,com.bit.util.*,java.util.*" %>
	<%!
	Connection conn;
	Statement stmt;
	
	public void insertOne(EmpDto bean) throws SQLException{
		String sql = "insert into emp (empno, ename, sal, hiredate) values ("
						+ bean.getEmpno() + "," 
						+ bean.getEname() + ","
						+ bean.getSal() + ",now())";
		try{
			conn = DBServer.getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		}finally{
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}
	}
	%>
 	<jsp:useBean id="bean" class="com.bit.util.EmpDto"></jsp:useBean>
	<jsp:setProperty property="empno" name="bean"></jsp:setProperty>
	<jsp:setProperty property="ename" name="bean"></jsp:setProperty>
	<jsp:setProperty property="sal" name="bean"></jsp:setProperty>
	<%
	request.setCharacterEncoding("utf-8");
	
	if(request.getMethod().equals("POST")){
		System.out.println(bean.getEname());
	   	insertOne(bean);
	   	response.sendRedirect("./");
	}
	
	%>
	<body>
		<nav>
			<h1><a href="../">비트교육센터</a></h1>
			<jsp:useBean id="login" class="com.bit.util.EmpDto" scope="session"></jsp:useBean>
			<ul>
				<li><a href="../">HOME</a></li>
				<li><a href="../intro.jsp">INTRO</a></li>
				<li><a href="/">LIST</a></li>
				<%if(login.isResult()){%>
					<li><a href="../login/logout.jsp">LOGOUT</a></li>
				<%}else{ %>
					<li><a href="../login/form.jsp">LOGIN</a></li>
				<%} %>
			</ul>
			
			<%if(login.isResult()){%>
			<span><jsp:getProperty property="ename" name="login"/>님 로그인중...</span>
			<%} %>
		</nav>
		<div class="container">
			<div class="row">
				<div class="grid12">
				<!-- content start -->
				<h2>입력 페이지</h2>
				<form class="form-control" method="post">
					<div class="form-group">
						<label for="empno">empno</label>
						<input type="number" name="empno" id="empno" placeholder="사번">
					</div>
					<div class="form-group">
						<label for="ename">ename</label>
						<input type="text" name="ename" id="ename" placeholder="이름">
					</div>
					<div class="form-group">
						<label for="sal">sal</label>
						<input type="number" name="sal" id="sal" placeholder="연봉">
					</div>
					<div class="form-group">
						<button class="btn btn-primary">입력</button>
						<button class="btn">취소</button>
						<button class="btn">뒤로</button>
					</div>
				</form>
				<!-- content end -->
				</div>			
			</div>
			<div class="row">
				<div id="footer" class="grid12">
				&copy; by bitacademy co.ltd. All rights reserved. http://www.bitacademy.com
				</div>			
			</div>
		</div>
		
	</body>
</html>