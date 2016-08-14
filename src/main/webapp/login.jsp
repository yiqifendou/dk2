<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<html>
<head>
<title>点课系统-用户登录</title>
<link rel="icon" href="${ctx}/favicon.ico" />
<link rel="stylesheet" href="${ctx}/static/compoment/login/reset.css">
<link rel="stylesheet" href="${ctx}/static/compoment/login/common.css">
<script type="text/javascript" src="${ctx}/static/script/m.c.js"></script>
<script type="text/javascript" src="${ctx}/static/compoment/login/common.js"></script>
<script type="text/javascript" src="${ctx}/static/compoment/layer/layer.js"></script>


<script>
	$(document).on("ready", function() {
		
		var lastAccount = localStorage.getItem("lastAccount"); 
		if(lastAccount){
			$("input[name='account']").val(lastAccount); 
			$("input[name='password']").focus();
		}else{
			$("input[name='account']").focus();
		}
		
		$(document).on("keydown",function(e){
			if (e.keyCode == 13) {
				check();
			}
		});
		
		$("button").on("click", function() {
			check();
		});

		function check() {
			var account = $("input[name='account']").val();
			if (!account) {
				layer.msg('请输入账号');
				return;
			}
			
			var password = $("input[name='password']").val();
			if (!password) {
				layer.msg('请输入密码');
				return;
			}
			$("button").text("登录中...");
			$.ajax({
				type : "POST",
				url : "${ctx}/user/login.do",
				data : {
					'account' : account,
					'password' : password
				},
				dataType : "json",
				success : function(rs) {
					if (rs.status==0) { 
						localStorage.setItem("lastAccount", account);
						location.href = "${ctx}/user/console";
					} else {
						$("button").text("登录");
						layer.msg(rs.msg);
					} 
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("button").text("登录");
					layer.msg("系统繁忙！");
				}
			});
		}
		
		//防止页面嵌套
		if(!(window==window.parent)){
			window.parent.location.href = t.loginPage;
		}
	});
</script>
</head>
<body>
	
	<div class="wrap login_wrap">
			<div class="content">
				
				<div class="logo"></div>
				
				<div class="login_box">	
					
					<div class="login_form">
						<div class="login_title">
							点课系统登录
						</div>
							<div class="form_text_ipt" style="box-shadow: none;">
								<input name="account" type="text" placeholder="账号">
							</div>
							<div class="ececk_warning"><span>账号不能为空</span></div>
							<div class="form_text_ipt" style="box-shadow: none;">
								<input name="password" type="password" placeholder="密码">
							</div>
							<div class="ececk_warning"><span>密码不能为空</span></div>
							<div class="form_btn">
								<button type="button">登录</button>
							</div>
							
					</div>
				</div>
			</div>
		</div>
</body>
</html>
