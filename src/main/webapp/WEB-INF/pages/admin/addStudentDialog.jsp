<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加学生</title>
</head>
<body>
	<div id="addStudentDialog" class="pageContent">
	<form method="post" id="addStudentDialogForm" action="${ctx}/student/addStudent" class="pageForm" >
		<div class="pageFormContent" layoutH="58">
			<fieldset>
				<legend>基本信息</legend>
				<dl>
					<dt>姓名：</dt>
					<dd><input class="required" name="name" type="text" /></dd>
				</dl>
				<dl>
					<dt>联系方式：</dt>
					<dd><input class="required" name="phone" type="text" /></dd>
				</dl>
				<dl>
					<dt>联系人（家长）：</dt>
					<dd><input class="required" name="contactName" type="text" /></dd>
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
					<dt>生日：</dt>
					<dd>
						<input type="text" name="birthday" maxDate="%y-%M-%d"  class="date" dateFmt="yyyy-MM-dd" readonly="true"/>
						<a class="inputDateButton"  href="javascript:;">选择</a>
					</dd>
				</dl>
				<dl>
					<dt>所属学校：</dt>
					<dd>
						<dd><input class="required" name="school" type="text" /></dd>
					</dd>
				</dl>
			</fieldset>
			<fieldset>
				<legend>备注</legend>
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
$("#addStudentDialogForm").on("submit",function(){
	return validateCallback(this, function(rs){
		if (rs.status==0) {
			alertMsg.correct("添加成功!")
			$.pdialog.closeCurrent();
		} else { 
			alertMsg.error(rs.msg);
		}
		navTab.reloadFlag("studentList");
	},"确认添加吗?");
});
</script>
	
</body>
</html>