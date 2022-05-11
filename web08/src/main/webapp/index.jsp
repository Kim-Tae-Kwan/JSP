<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="css/mygrid.css">
		<style rel="stylesheet" type="text/css">
			#header{
   
		   }
		   #header h1{
		      height:42px;
		      background-image: url("resource/logo.jpg");
		      background-repeat: no-repeat;
		      text-indent: -9999px;
		   }
		   #menu{
		      text-align: center;
		      background-color: gray;
		   }
		   #menu a{
		      color: white;
		      text-decoration: none;
		      display: block;
		      height:35px;
		      line-height: 30px;
		   }
		   #menu a:hover{
		      border-bottom: 5px solid black;
		      border-top: 5px solid black;
		      box-sizing: border-box;
		   }
		   #bx{
		      width:800px;
		      margin: 10px auto;
		      position: relative;
		   }
		   #bx img{
		      width:800px;
		   }
		   #bx a{
		      display:inline-block;
			position: absolute;
			top: 17px;
			height: 220px;
			width:100px;
			background-color: black;
			opacity: 0.4;
			color: white;
			line-height: 200px;
			text-decoration: none;
			font-weight: bold;
			font-size: 100px;
			text-align: center;
		   }
		   #bx a:last-child{
		      left:700px;
		   }
		   #footer{
		   		padding-top : 100px;
		   		padding-left : 200px;
		   }
		   #list-group{
		   		width : 80%;
		   		margin : 0px auto;
		   		border-radius : 10px;
		   		border : 1px solid gray;
		   }
		   #list-group>*{
		   		
		   		padding : 20px;
		   }
		   #list-group>*:not(:last-child){
		   		border : 1px solid gray;
		   }
		   #list-group>*:first-child{
		   		background-color : aqua;
		   		border-radius : 10px 10px 0px 0px;
		   }
		   #list-group>*:last-child{
		   		border-radius : 0px 0px 10px 10px;
		   }
		   
		   #popup{
		   	position: absolute;
		   	left: 0px;
		   	top : 0px;
		   	width: 100%;
		   	height: 100%;
		   	background-color: rgba(0,0,0,0.5);
		   }
		   #popup>div{
		   	background-color: white;
		   	width: 400px;
		   	height: 400px;
		   	margin: 100px auto;
		   	padding : 50px;
		   	box-sizing: border-box;
		   	border-radius: 20px;
		   }
		   #popup>div>form{}
		   #popup>div>form>div{
		   	margin-bottom: 10px;
		   	text-align: center;
		   }
		   #popup>div>form>div>label{
		   	display: inline-block;
		   	width: 40%;
		   	background-color: darkgray;
		   	
		   }
		   #popup>div>form>div>input{
		   	width: 50%;
		   }
		   #popup>div>form>div>button{}
		   #popup>div>.error{
		   	background-color: red;
		   	color: white;
		   	text-align: center;
		   	font-style: italic; 
		   }
		</style>
		<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="js/jquery.bxslider.min.js"></script>
		<script type="text/javascript">
			$(function(){
				// 이벤트 callback -----------------------------------------------------------------
				var addEvent = function(e){
					var param = $(e.target).serialize();
					addList(param);
					return false;
				}
				var editEvent = function(e){
					var param = $(e.target).serialize();
					editOne(param);
					return false;
				}
				var detailEvent = function(e){
					$(e.target).prev().text('수정 페이지');
					$(e.target).find('input').each(function(idx, ele){
						if(idx != 0) $(ele).removeProp('readonly');
					});
					$(e.target).off('submit', detailEvent).on('submit', editEvent);
					return false;
				}
				var delEvent = function(e){
					e.preventDefault();
					delOne($(e.target).parent().parent().find('input[type=number]').val());
				}
				
				
				// ---------------------------------------------------------------------------------
				
				// 페이지 초기화 -------------------------------------------------------------------
				$('#popup').hide();
				$('#bx>ul').bxSlider({
					slideWidth : 800,
					minSlides:1,
					maxSlides:1,
					moveSlides:1,
					auto : true,
					pager : false,
					nextText:'>',
		            prevText:'<'
				});
				
				var menu1Click = function(){
					$('#content>.row').hide().eq(0).show();
					return false;
				};
				
				var menu2Click = function(){
					$('#content>.row').hide().eq(1).show();
					return false;
				};
				
				var menu3Click = function(){
					$('#content>.row').hide().eq(2).show();
					getList();
					return false;
				};
				
				$('#menu a')
					.first()
					.click(menu1Click)
					.end().eq(1)
					.click(menu2Click)
					.end().eq(2)
					.click(menu3Click);
				
				$('#popup>div').click(function(e){
					e.stopPropagation();
				});
				
				$('#popup').add('#popup form button:eq(2)').click(function(){
					$('#popup form input').val('');
					$('#popup .error').remove();
					$('#popup').find('h2').text('입력페이지');
					$('#popup').find('button').first().text('입력');
					$('#popup').find('input').removeProp('readonly');
					$('#popup form').off('submit', detailEvent);
					$('#popup form').on('submit', addEvent);
					$('#popup').hide();
				});
				
				$('#p3>a').click(function(){
					$('#popup').show();
					return false;
				});
				

				$('#popup form').on('submit',addEvent);
				
				
				
				// ---------------------------------------------------------------------------------
				
				// 통신 ----------------------------------------------------------------------------
				var editOne = function(param){
						$.ajax({
							type : 'post',
							url : 'bbs/update.jsp',
							data : param,
							success : function(data){
								$('#menu a').eq(2).click();
								$('#popup').click();
							},
							error : function(a,b,c){
								console.log(b,c);
							}
						});
				};
				
				var getOne= function (empno) {
					$('#popup').find('h2').text('상세페이지');
					$('#popup').find('button').first().text('수정')
						.next().text('삭제').on('click', delEvent);
					$('#popup').find('input').prop('readonly', true);
					$.getJSON('bbs/detail.jsp', 'empno=' + empno, function(data){
						$('#popup').find('input').eq(0).val(data.root[0].empno);
						$('#popup').find('input').eq(1).val(data.root[0].ename);
						$('#popup').find('input').eq(2).val(data.root[0].sal);
					});
					$('#popup form').off('submit',addEvent);
					$('#popup form').off('submit',editEvent);
					$('#popup form').on('submit',detailEvent);
					$('#popup').show();
				};
				
				var getList = function(){
					$('#list-group').html('<div><span>ename</span></div>');
					$.getJSON('bbs/list.jsp', function(data){
						data.root.forEach(function(ele, idx){
							var alink = $('<a/>').text(ele.ename).attr('href','#')
							alink.click(function(){
								getOne(ele.empno);
								return false;
							});
							$('<div/>')
								.append(alink)
								.appendTo('#list-group');
						});
					});	
				};
				
				var addList = function(param){
					/* $.post('bbs/insert.jsp', param, function(){
						$('#menu a').eq(2).click();
						$('#popup').click();
					}); */
					$.ajax({
						type : 'post',
						url : 'bbs/insert.jsp',
						data : param,
						success : function(){
							$('#menu a').eq(2).click();
							$('#popup').click();
						},
						error : function(xhr, status, errmsg){
							$('#popup .error').remove();
							$('#popup h2').before('<div class="error">에러발생'+ errmsg +'</div>')
						}
					});
				};
				
				var delOne = function(param){
					$.post('bbs/delete.jsp','empno=' + param, function(){
						$('#menu a').eq(2).click();
						$('#popup').click();
					});
				};
				// ---------------------------------------------------------------------------------
				//$('#menu a').first().click();
				$('#menu a').eq(2).click();
			});
			
		
		</script>
	</head>
	<body>
		<div class="container">
			<div id="header" class="row">
				<div class="grid12">
					<h1>비트교육센터</h1>
				</div>
			</div>
			<div id="menu" class="row">
				<div class="grid2">&nbsp;</div>
				<div class="grid2"><a href="#">HOME</a></div>
				<div class="grid2"><a href="#">INTRO</a></div>
				<div class="grid2"><a href="#">BBS</a></div>
				<div class="grid2"><a href="#">LOGIN</a></div>
				<div class="grid2">&nbsp;</div>
			</div>
			<div id="content">
				<div id="p1" class="row">
					<div id="bx">
						<ul>
							<li><img src="https://www.bitacademy.com/img/main_bn_0414_1.png"/></li>
	               			<li><img src="https://www.bitacademy.com/img/main_bn_0414_3.png"/></li>
	               			<li><img src="https://www.bitacademy.com/img/main_bn_0503.png"/></li>
	               			<li><img src="https://www.bitacademy.com/img/main_bn_0414_2.png"/></li>
						</ul>
					</div>
				</div>
				<div id="p2" class="row">
					<dl>
						<dt>국무총리는 국회의 동</dt>
						<dd>모든 국민은 그 보호하는 자녀에게 적어도 초등교육과 법률이 정하는 교육을 받게 할 의무를 진다. 모든 국민의 재산권은 보장된다. 그 내용과 한계는 법률로 정한다.</dd>
						<dt>학교교육 및 평생교육</dt>
						<dd>대한민국의 영토는 한반도와 그 부속도서로 한다. 비상계엄하의 군사재판은 군인·군무원의 범죄나 군사에 관한 간첩죄의 경우와 초병·초소·유독음식물공급·포로에 관한 죄중 법률이 정한 경우에 한하여 단심으로 할 수 있다. 다만, 사형을 선고한 경우에는 그러하지 아니하다.</dd>
						<dt>감사위원은 원장의 제</dt>
						<dd>모든 국민은 헌법과 법률이 정한 법관에 의하여 법률에 의한 재판을 받을 권리를 가진다. 모든 국민은 신체의 자유를 가진다. 누구든지 법률에 의하지 아니하고는 체포·구속·압수·수색 또는 심문을 받지 아니하며, 법률과 적법한 절차에 의하지 아니하고는 처벌·보안처분 또는 강제노역을 받지 아니한다.</dd>
						<dt>모든 국민은 양심의 </dt>
						<dd>대법원장과 대법관이 아닌 법관의 임기는 10년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다. 중앙선거관리위원회는 법령의 범위안에서 선거관리·국민투표관리 또는 정당사무에 관한 규칙을 제정할 수 있으며, 법률에 저촉되지 아니하는 범위안에서 내부규율에 관한 규칙을 제정할 수 있다.</dd>
					</dl>
				</div>
				<div id="p3" class="row">
					<h2>리스트</h2>
					<a href="#">입력</a>
					<div id="list-group">
						<div><span>ename</span></div>
					</div>
				</div>
			</div>
			<div id="footer" class="row">
				<address>
					부산광역시 동구 범일동 범내남로 38
				</address>
				&copy; bitacademy co.ltd. All rights reserved.
			</div>
		</div>
		
		<div id="popup">
			<div>
				<h2>입력 페이지</h2>
				<form action="#" method="post">
					<div>
						<label for="empno">empno</label>
						<input type="number" name="empno" id="empno">
					</div>
					<div>
						<label for="ename">ename</label>
						<input type="text" name="ename" id="ename">
					</div>
					<div>
						<label for="sal">sal</label>
						<input type="text" name="sal" id="sal">
					</div>
					<div>
						<button>입력</button>
						<button type="reset">취소</button>
						<button type="button">뒤로</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
