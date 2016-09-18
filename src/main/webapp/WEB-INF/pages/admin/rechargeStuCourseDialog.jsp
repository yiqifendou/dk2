<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程充值</title>
</head>
<body>
	<div id="rechargeStuCourseDialog" class="pageContent">
	<form method="post" id="rechargeStuCourseDialogForm" action="${ctx}/student/rechargeCourse?studentId=${param.studentId}" class="pageForm" >
			<div class="pageFormContent" layoutH="58">
				<div class="unit">
					<label>学生姓名：</label>
					${student.name}
				</div>
				<div class="unit">
					<label>充值课程：</label>
					<select class="combox"  width="300" name="courseId" >
							<c:forEach items="${courseList}" var="c">
								 <option value="${c.id}">${c.courseName}</option>
							</c:forEach>
					</select>
				</div>
				<div class="unit">
					<label>充值类型：</label>
					<select class="combox"  width="300" name="type" >
						<option value="1">充值</option>
						<option value="2">赠送</option>
					</select>
				</div>
				
				<div class="unit">
					<label> 充值课时（节）：</label>
					<input type="text" name="courseCount"  size="50" class="digits required" min="0" />
				</div>
				
				<div class="unit">
					<label> 充值费用：</label>
					<input type="text" name="rechargeFee"  size="50" class="digits required" min="0" />
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
$("#rechargeStuCourseDialogForm").on("submit",function(){
	return validateCallback(this, function(rs){
		if (rs.status==0) {
			alertMsg.correct("充值成功!")
			$.pdialog.closeCurrent();
		} else { 
			alertMsg.error(rs.msg);
		}
		navTab.reloadFlag("studentList");
		navTab.reloadFlag("courseRemainList");
	},"确认充值吗?");
});
$("#rechargeStuCourseDialogForm select[name='type']").on("change",function(){
	var type = $(this).val();
	if(type==2){
		$("#rechargeStuCourseDialogForm input[name='rechargeFee']").val("0");
	}
});
</script>
	
</body>
</html>