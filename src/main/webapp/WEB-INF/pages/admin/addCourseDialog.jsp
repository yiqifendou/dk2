<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加课程</title>
</head>
<body>
	<div id="addCourseDialog" class="pageContent">
	<form method="post" id="addCourseDialogForm" action="${ctx}/course/addCourse" class="pageForm" >
			<div class="pageFormContent" layoutH="58">
				<div class="unit">
					<label>课程名称：</label>
					<input type="text" name="courseName"  size="50" class="required" />
				</div>
				<div class="unit">
					<label>课程类型：</label>
					<select class="combox"  width="300" name="courseType" >
							<option  value="1">集体课</option>
							<option  value="0">小课</option>
					</select>
				</div>
				<div class="unit">
					<label>备注 ：</label>
					<textarea name="remark" cols="52" rows="4"></textarea>
				</div>
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
$("#addCourseDialogForm").on("submit",function(){
	return validateCallback(this, function(rs){
		if (rs.status==0) {
			alertMsg.correct("添加成功!")
			$.pdialog.closeCurrent();
		} else { 
			alertMsg.error(rs.msg);
		}
		navTab.reloadFlag("courseList");
	},"确认添加吗?");
});
</script>
	
</body>
</html>