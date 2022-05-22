<%@page import="java.util.List"%>
<%@page import="com.bit.model.EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../template/head.jspf" %>
<%
  		EmpDto bean = (EmpDto) request.getAttribute("bean");
  		List<String> items = bean.getItem();
%>
<script type="text/javascript">
var ele = $(`
		<div class="form-group">
	    <label for="ename" class="col-sm-2 control-label">ename</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" name="item" id="ename" placeholder="ename">
	    </div>
	  </div>
	  `);
var cnt = <%=items != null ? items.size() : 0%>;
$(function(){
	$('button').click(function(e){
		if(e.target.innerHTML == '입력 추가'){
			cnt++;
			var obj = ele.clone();
			obj.find('label').attr('for', 'item' + cnt).text('item' + cnt);
			obj.find('input')
				//.attr('name', 'item' + cnt)
				.attr('id', 'item' + cnt)
				.attr('placeholder', 'item' + cnt)
				
			$(e.target).parent().parent().before(obj);
		}
	});
	$('#item-add').hide();
	$('button[type="reset"]').hide();
	$('form').one('submit', function(e){
		$(e.target).find('input').removeProp('readonly');
		$('.page-header>h1').html('<h1>수정 페이지 <small>Update List</small></h1>');
		$('#item-add').show();
		$('button[type="reset"]').show();
		$('.btn.btn-danger').hide();
		return false;
	});
	$('.btn.btn-danger').click(function(e){
		$.ajax({
			url : 'detail.html',
			type: 'delete',
			data: '{_id:ObjectId("<%=bean.getId()%>")}',
			success:function(data){
				location.href='list.html';		
			}
		});
	});
	
});
</script>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<div class="page-header">
  <h1>상세 페이지 <small>Detail List</small></h1>
</div>
<form class="form-horizontal" method="post">
  <div class="form-group">
    <label for="empno" class="col-sm-2 control-label">empno</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="empno" id="empno" value="<%=bean.getEmpno() %>" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="ename" class="col-sm-2 control-label">ename</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="ename" id="ename" value="<%=bean.getEname() %>" readonly>
    </div>
  </div>
  
  <%
  if(items !=null){
  	for(int i = 0; i < items.size(); i++){
  %>
  <div class="form-group">
    <label for="item<%=i+1 %>" class="col-sm-2 control-label">item<%=i+1 %></label>
    <div class="col-sm-10">
      <input type="text" class="form-control" name="item" id="item<%=i+1 %>" value="<%=items.get(i) %>" readonly>
    </div>
  </div>
  <%}} %>
  
  <div id="item-add" class="form-group">
  	<div class="col-sm-offset-2 col-sm-10">
  		<button type="button" class="btn btn-default btn-block">입력 추가</button>
  	</div>
  </div>
  
  <input type="hidden" name="_id" value="<%=bean.getId()%>">
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
    	<div class="btn-group" role="group" aria-label="...">
	      <button type="submit" class="btn btn-primary">수정</button>
	      <button type="reset" class="btn btn-default">취소</button>
	      <button type="button" class="btn btn-danger">삭제</button>
	      <button type="button" onclick="history.back();" class="btn btn-default">뒤로</button>
      	</div>
    </div>
  </div>
</form>

<%@ include file="../template/footer.jspf" %>
</body>
</html>