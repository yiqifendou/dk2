<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="format-detection" content="address=no">
<meta name="format-detection" content="email=no">
<link rel="stylesheet" href="${ctx}/static/compoment/wap/css/bind.min.css">
<script src="${ctx}/static/script/m.c.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/compoment/layer/layer.js"></script>
<title>教师账号绑定</title>
</head>
<body>
	<header>
		<div class="header">
			教师账号绑定
		</div>
	</header>

	<div class="form-section">
		<div class="form-group">
			<label>账号</label>
			<input type="text" id="account" placeholder="账号" class="js-input" maxlength="20">
			<i class="vl-clear js-vl-clear"></i>
		</div>
		<div class="form-group">
			<label>密码</label>
			<input type="password" id="password" placeholder="密码" class="js-input" maxlength="20">
			<i class="vl-clear js-vl-clear"></i>
		</div>
	</div>
	<div class="btn-box" style="padding: 0;">
		<div class="btn" id="bindBtn">立即绑定</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$("#bindBtn").on("click",function(){
				var account = $("#account").val();
				if(!account){
					layer.msg("请输入账号");
					return;
				}
                var password = $("#password").val();
                if(!password){
                    layer.msg("请输入密码");
                    return;
                }
				$.ajax({
					type:"post",
					url:"${ctx}/weixin/bindTeacher",
					dataType:"json",
					data:{account:account,password:password},
					success:function(rs){
						if(rs.status==0){
							alert("绑定成功！");
							location.href = "${ctx}/weixin/toTeacherMain";
						}else{
							layer.msg(rs.msg);
						}
					},
					error:function(){
						layer.msg("系统繁忙！");
					}
				});
			});
		});
	</script>
</body>
</html>