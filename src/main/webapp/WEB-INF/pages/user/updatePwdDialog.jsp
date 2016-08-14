<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
</head>
<body>
	<div id="udpatePwdDialog" class="pageContent">
	<form method="post" id="updatePwdDialogForm" action="${ctx}/user/updatePwd" class="pageForm" >
			<div class="pageFormContent" layoutH="58">
				<div class="unit">
					<label>原密码：</label>
					<input type="password" name="oldPwd" size="50" class="required"/>
				</div>
				<div class="unit">
					<label>新密码：</label>
					<input type="password" name="newPwd" size="50" class="required"/>
				</div>
				<div class="unit">
					<label>确认新密码：</label>
					<input type="password" name="confirmNewPwd" size="50" class="required"/>
				</div>
			</div>
			<div class="formBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >修改</button></div></div></li>
					<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
				</ul>
			</div>
	</form>
</div>
<script type="text/javascript">
	$(function(){
		$("#updatePwdDialogForm").on("submit",function(){
			return validateCallback(this, function(rs){
				if (rs.status==0) {
					alertMsg.correct("修改成功!")
					$.pdialog.closeCurrent();
				} else { 
					alertMsg.error(rs.msg)
				}
			},'确认修改吗?');
		});
	});
</script>
	
</body>
</html>