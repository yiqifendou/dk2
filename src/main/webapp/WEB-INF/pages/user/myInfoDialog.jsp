<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的信息</title>
</head>
<body>
	<div id="myInfoDialog" class="pageContent">
	<form method="post" id="myInfoDialogForm" action="${ctx}/user/updateMyInfo" class="pageForm" >
			<div class="pageFormContent" layoutH="58">
				<fieldset>
				<legend>基本信息</legend>
				<dl>
					<dt>账号：</dt>
					<dd><input class="required" name="account" readonly="readonly" type="text" /></dd>
				</dl>
				<dl>
					<dt>姓名：</dt>
					<dd><input class="required" name="name" readonly="readonly" type="text" /></dd>
				</dl>
				<dl>
					<dt>联系方式：</dt>
					<dd><input class="required" name="phone" type="text" /></dd>
				</dl>
				<dl>
					<dt>角色：</dt>
					<dd class="type"></dd>
				</dl>
				<dl>
					<dt>状态：</dt>
					<dd class="stus">
					</dd>
				</dl>
				<dl>
					<dt>入职时间：</dt>
					<dd class="entryTime">
					</dd>
				</dl>
			</fieldset>
			<fieldset>
				<legend>授课列表及备注</legend>
				<dl class="nowrap">
					<dt>授课列表：</dt>
					<dd>
						<c:forEach items="${courseList}" var="c">
							<label><input type="checkbox" name="courseArr" value="${c.id}" />${c.courseName}</label>
						</c:forEach>
					</dd>
				</dl>
				<dl class="nowrap">
					<dt>备注：</dt>
					<dd><textarea name="remark"  cols="80" rows="5"></textarea></dd>
				</dl>
			</fieldset>
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
		var ctx = com.lc.crm.dk.c.ctx;
		$.ajax({
			type : "POST",
			url : ctx+"/user/queryMyInfo",
			dataType : "json",
			success : function(rs) {
				if (rs.status==0) {
					$("#myInfoDialogForm input[name='account']").val(rs.data.account);
					$("#myInfoDialogForm input[name='name']").val(rs.data.name);
					$("#myInfoDialogForm input[name='phone']").val(rs.data.phone);
					$("#myInfoDialogForm .type").text(rs.data.type==0?"教师":"管理员");
					$("#myInfoDialogForm .stus").text(rs.data.stus==1?"正常":"冻结");
					$("#myInfoDialogForm .entryTime").text(rs.data.simpleEntryTime);
					var ca = (rs.data.courseArr||"").split(",");
					for(var i=0;i<ca.length;i++){
						$("#myInfoDialogForm input[name='courseArr'][value='"+ca[i]+"']").prop("checked",true);
					}
					$("#myInfoDialogForm textarea[name='remark']").val(rs.data.remark); 
				} else { 
					alertMsg.error(rs.msg);
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alertMsg.error("系统繁忙！")
			}
		});
		//最好不要将js掺杂在html中
		$("#myInfoDialogForm").on("submit",function(){
			return validateCallback(this, function(rs){
				if (rs.status==0) {
					alertMsg.correct("修改成功!")
					$.pdialog.closeCurrent();
				} else { 
					alertMsg.error(rs.msg);
				}
				navTab.reloadFlag("userList");
			},'确认修改吗?');
		});
		
		$("#myInfoDialogForm input[name='courseArr']").on("click",function(){
			return false;
		});
	});
</script>
	
</body>
</html>