<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.bit.module01.mysql.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="template/head.jspf" %>
<style type="text/css">
	body{
		margin : 0px;
		padding: 0px;
	}
	nav{
		background-color: gray;
		overflow: hidden;
	}
	nav ul{
		list-style: none;
		padding: 0px;
		margin:0px;
	}
	nav ul li{
		display: inline-block;
		width : 100px;
	}
	nav ul li a{
		display: block;
		text-decoration: none;
		color : white;
		height: 40px;
		text-align: center;
		line-height: 40px;
	}
	.row img{
		width: 100%;
	}
	.btn{
		width: 30px;
		height: 30px;
		border : 1px solid white;
		border-radius : 4px;
		overflow : hidden;
		float: right;
		background-color: darkgray;
	}
	.btn span{
		display: block;
		border: 1px solid white;
		margin : 10px 5px 0px 5px;
		
	}
	form div{
		display: flex;
		flex-direction: column;
	}
	form div button,
	form div input{
		margin-top : 10px;
	}
	.error{
		background: red;
		height: 50px;
		text-align: center;
		color : white;
	}
</style>
<script type="text/javascript">
	$(function(){
		$(document).on('click', 'form button:eq(2)',function(){
			history.back();
		});
		$('<div class="btn"/>')
			.append('<span></span>')
			.append('<span></span>')
			.append('<span></span>')
			.appendTo('nav')
			.click(function(){
				$('nav ul li').toggle();
			})
			;
		$(window).on('resize', function(){
			if($('nav').width() < 600){
				$('.btn').show();
				$('nav ul li').css('display','block').hide();
				
			}else{
				$('.btn').hide();
				$('nav ul li').css('display','inline-block');
			}
		});
	});
	$(function(){
		if($('nav').width() < 600){
			$('.btn').show();
			$('nav ul li').css('display','block').hide();
			
		}else{
			$('.btn').hide();
			$('nav ul li').css('display','inline-block');
		}
	});

</script>
</head>
<body>
<%
	String[] params = {
			request.getParameter("empno"),
			request.getParameter("ename"),
			request.getParameter("sal")
	};
	try{
		if(request.getMethod().equals("POST")){
			int empno = Integer.parseInt(params[0].trim());
			String ename = params[1].trim();
			int sal = Integer.parseInt(params[2].trim());
			
			BitEmp emp = new BitEmp();
			Boolean result = emp.insertOne(empno, ename, sal);
			
			if(result) response.sendRedirect("list.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
		out.print("<div class=\"error\">오류발생<br/>"+ e.getMessage() +"</div>");
	}
%>
<nav>
	<ul>
	  <li><a href="index.jsp">HOME</a></li>
	  <li><a href="list.jsp">EMP</a></li>
	  <li><a href="">DEPT</a></li>
	  <li><a href="#">ETC</a></li>
	</ul>
</nav>
	<div class="container">
		<div class="row">
			<div class="grid12">
				<h2>입력 페이지</h2>
				<form action="" method="post">
					<div>
						<label for="empno">empno</label>
						<input type="text" name="empno" id="empno" value="<%=params[0]==null?"":params[0]%>">
					</div>
					<div>
						<label for="ename">ename</label>
						<input type="text" name="ename" id="ename" value="<%=params[1]==null?"":params[1]%>">
					</div>
					<div>
						<label for="sal">sal</label>
						<input type="text" name="sal" id="sal" value="<%=params[2]==null?"":params[2]%>">
					</div>
					<div>
						<button class="button">입력</button>
						<button class="button" type="reset">취소</button>
						<button class="button" type="button">뒤로</button>
					</div>
				</form>
			</div>
		</div>
		<div class="row" id="footer">
			<div class="grid12">
			&copy; by bitacademy co.ltd. All rights reserved
			</div>
		</div>
	</div>
</body>
</html>