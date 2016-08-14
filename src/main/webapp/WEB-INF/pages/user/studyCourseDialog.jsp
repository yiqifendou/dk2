<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>点课</title>
</head>
<body>
	<div id="studyCourseDialog" class="pageContent">
	<form method="post" id="studyCourseDialogForm" 
	<c:if test="${not empty student}">
		action="${ctx}/student/studyCourseInPrivete?grpId=${param.grpId}&studentId=${param.studentId}" 
	</c:if>
	<c:if test="${empty student}">
		action="${ctx}/student/studyCourseInPublic?grpId=${param.grpId}" 
	</c:if>
	class="pageForm" >
			<div class="pageFormContent" layoutH="58">
				<div class="unit">
					<label>班级：</label>
					${grp.grpName}
				</div>
				<div class="unit">
					<label>课程：</label>
					${grp.courseName}
				</div>
				<c:if test="${not empty student}">
					<div class="unit">
						<label>学生姓名：</label>
						${student.name}
					</div>
				</c:if>
				<div class="unit">
					<label>课时：</label>
					<select class="combox"  width="300" name="courseCount" >
						<option value="1">1节</option>
						<option value="2">2节</option>
						<option value="3">3节</option>
						<option value="4">4节</option>
					</select>
				</div>				
				<div class="unit">
					<label>备注 ：</label>
					<textarea name="remark" cols="52" placeholder="具体上课时间段等..." class="required" rows="4"></textarea>
				</div>
			</div>
			<div class="formBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit" >确定</button></div></div></li>
					<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div></li>
				</ul>
			</div>
	</form>
</div>
<script type="text/javascript">
$("#studyCourseDialogForm").on("submit",function(){
	return validateCallback(this, function(rs){
		if (rs.status==0) {
			alertMsg.correct("点课成功!")
			$.pdialog.closeCurrent();
			
			var c = com.lc.crm.dk.c;
			var selectedTabIndex = $("#teacherMainPage .tabsHeaderContent li.selected").parent().children("li").index($("#teacherMainPage .tabsHeaderContent li.selected"));
			c.addCookie("selectedTabIndex",selectedTabIndex);
			navTab.reloadFlag("teacherMain");
			navTab.reloadFlag("teacherWorkFlowList");
		} else { 
			alertMsg.error(rs.msg);
		}
	},"确认点课吗?");
});
</script>
</body>
</html>