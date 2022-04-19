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
				<h1>부서 추가</h1>
				<form action="insertDept.jsp">
					<table>
						<tr>
							<td>deptno : </td>
							<td><input type="text" name="deptno"></td>
						</tr>
						<tr>
							<td>dname : </td>
							<td><input type="text" name="dname"></td>
						</tr>
						<tr>
							<td>location : </td>
							<td>
								<select name="loc">
									<option value="1">서울</option>
									<option value="2">부산</option>
									<option value="3">대구</option>
									<option value="4">광주</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan = "2">
								<input type="submit" value="부서 등록">
							</td>
						</tr>
					</table>
				</form>
				
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