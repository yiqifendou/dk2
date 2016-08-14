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
<title>绑定手机</title>
<script type="text/javascript">
if(com.lc.crm.dk.c.getCookie("bindPhone")){
	location.href = "${ctx}/weixin/queryRelativeStus";
}
</script>
</head>
<body>
	<header>
		<div class="header">
			绑定手机
		</div>
	</header>

	<div class="form-section">
		<div class="form-group">
			<label for="userName">手机</label>
			<input type="number" pattern="[0-9]*" id="phone" placeholder="请输入学生报名时登记的手机号" class="js-input" maxlength="20">
			<i class="vl-clear js-vl-clear"></i>
		</div>
	</div>
	<div class="btn-box" style="padding: 0;">
		<div class="btn" id="loginBtn">确认</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$("#loginBtn").on("click",function(){
				var phone = $("#phone").val();
				if(!phone){
					layer.msg("请输入手机号");
					return;
				}
				$.ajax({
					type:"post",
					url:"${ctx}/weixin/bindPhone",
					dataType:"json",
					data:{phone:phone},
					success:function(rs){
						if(rs.status==0){
							alert("绑定成功！");
							location.href = "${ctx}/weixin/queryRelativeStus";
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