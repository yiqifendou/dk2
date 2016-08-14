<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改课程信息</title>
</head>
<body>
	<div id="updateCourseDialog" class="pageContent">
	<form method="post" id="updateCourseDialogForm" action="${ctx}/course/updateCourse.do?courseId=${param.courseId}" class="pageForm" >
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
$(function(){
	var c = com.lc.crm.dk.c;
	$.ajax({
		type : "POST",
		url : c.ctx+"/course/queryByCourseId",
		data:{courseId:"${param.courseId}"},
		dataType : "json",
		success : function(rs) {
			if (rs.status==0) {
				$("#updateCourseDialog input[name='courseName']").val(rs.data.courseName);
				$("#updateCourseDialog select[name='courseType']").val(rs.data.courseType); 
				$("#updateCourseDialog a[name='courseType']").text(rs.data.courseType==1?"集体课":"小课"); 
				$("#updateCourseDialog textarea[name='remark']").val(rs.data.remark);
			} else { 
				alertMsg.error(rs.msg)
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			alertMsg.error("系统繁忙！")
		}
	});
	
	
	//最好不要将js掺杂在html中
	$("#updateCourseDialogForm").on("submit",function(){
		return validateCallback(this, function(rs){
			if (rs.status==0) {
				alertMsg.correct("修改成功!")
				$.pdialog.closeCurrent();
			} else { 
				alertMsg.error(rs.msg);
			}
			navTab.reloadFlag("courseList");
		},'确认修改吗?');
	});
});
</script>

	
</body>
</html>