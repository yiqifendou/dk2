<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
</head>
<body>
	<div id="updateUserDialog" class="pageContent">
	<form method="post" id="updateUserDialogForm" action="${ctx}/user/updateUserByAdmin?id=${param.id}" class="pageForm" >
			<div class="pageFormContent" layoutH="58">
				<fieldset>
				<legend>基本信息</legend>
				<dl>
					<dt>账号：</dt>
					<dd><input class="required" name="account" readonly="readonly" type="text" /></dd>
				</dl>
				<dl>
					<dt>姓名：</dt>
					<dd><input class="required" name="name" type="text" /></dd>
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
					<dd>
						<select class="combox"  width="300" name="stus" >
								<option  value="1">正常</option>
								<option  value="0">冻结</option>
						</select>
					</dd>
				</dl>
				<dl>
					<dt>入职时间：</dt>
					<dd>
						<input type="text" name="entryTime" maxDate="%y-%M-%d"  class="date" dateFmt="yyyy-MM-dd" readonly="true"/>
						<a class="inputDateButton"  href="javascript:;">选择</a>
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
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >保存</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
<script type="text/javascript">
$(function(){
	var c = com.lc.crm.dk.c;
	$.ajax({
		type : "POST",
		url : c.ctx+"/user/queryUserInfoByAdmin",
		data:{id:"${param.id}"},
		dataType : "json",
		success : function(rs) {
			if (rs.status==0) {
				$("#updateUserDialogForm input[name='account']").val(rs.data.account);
				$("#updateUserDialogForm input[name='name']").val(rs.data.name);
				$("#updateUserDialogForm input[name='phone']").val(rs.data.phone);
				$("#updateUserDialogForm .type").text(rs.data.type==0?"教师":"管理员");
				$("#updateUserDialogForm select[name='stus']").val(rs.data.stus);
				$("#updateUserDialogForm a[name='stus']").text(rs.data.stus==1?"正常":"冻结"); 
				$("#updateUserDialogForm input[name='entryTime']").val(rs.data.simpleEntryTime);
				var ca = (rs.data.courseArr||"").split(",");
				for(var i=0;i<ca.length;i++){
					$("#updateUserDialogForm input[name='courseArr'][value='"+ca[i]+"']").prop("checked",true);
				}
				$("#updateUserDialogForm textarea[name='remark']").val(rs.data.remark); 
			} else { 
				alertMsg.error(rs.msg);
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alertMsg.error("系统繁忙！");
		}
	});
	
	
	//最好不要将js掺杂在html中
	$("#updateUserDialogForm").on("submit",function(){
		return validateCallback(this, function(rs){
			if (rs.status==0) {
				alertMsg.correct("修改成功!")
				$.pdialog.closeCurrent();
			} else { 
				alertMsg.error(rs.msg)
			}
			navTab.reloadFlag("userList");
		},'确认修改吗?');
		
	});
});
</script>

	
</body>
</html>