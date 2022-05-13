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
		margin: 0px;
		padding: 0px;
	}
	nav{
		background-color: gray;
		overflow: hidden;
	}
	nav>ul{
		list-style: none;
		padding: 0px;
		margin: 0px;
	}
	nav>ul>li{
		display: inline-block;
		width: 100px;
	}
	nav>ul>li>a{
		display: block;
		height: 40px;
		color: white;
		text-decoration: none;
		text-align: center;
		line-height: 40px;
	}
	
	.row img{
		width: 100%;
	}
	.btn{
		width: 30px;
		height: 30px;
		border: 1px solid white;
		border-radius: 4px;
		overflow: hidden;
		float: right;
		background-color: darkgray;
	}
	
	.table,.table tr>th,.table tr>td{
		border: 1px solid gray;
		border-collapse: collapse;
	}
	.table{
		width: 80%;
		margin: 100px auto;
	}
	.table tr>th,.table tr>td{
		height: 50px;
	}
	.table tr>td>a{
		display: block;
		height: 50px;
	}
	.table tr>td:first-child>a{
		text-align: center;
	}
	.table tr>td:last-child>a{
		text-align: right;
	}
	.button{
		display: block;
		width: 80%;
		margin: 50px auto;
		height: 40px;
		text-decoration: none;
		background-color: blue;
		border-radius: 5px;
		color:white;
		text-align: center;
		line-height: 40px;
	}
</style>
<script type="text/javascript">
	$(function(){
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
				<img alt="" src="resource/logo.jpg">
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