<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>点课流水</title>
</head>
<body>
<div id="teacherWorkFlowlistPage">
<form id="pagerForm" method="post" action="${ctx}/user/teacherWorkFlowList?qType=${param.qType}">
	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
	<input type="hidden" name="courseId" value="${param.courseId}" />
	<c:if test="${param.qType=='all'}">
		<input type="hidden" name="teacherName" value="${param.teacherName}" />
	</c:if>
	<input type="hidden" name="startTime" value="${param.startTime}" />
	<input type="hidden" name="endTime" value="${param.endTime}" />
</form>


<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="${ctx}/user/teacherWorkFlowList?qType=${param.qType}" 
		method="post">
		<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td><select class="combox"  name="courseId" >
							<option <c:if test="${param.courseId == null || param.courseId==''}">selected</c:if> value="">所有课程</option>
							<c:forEach items="${courseList}" var="course">
								<option <c:if test="${param.courseId == course.id}">selected</c:if> value="${course.id}">${course.courseName}</option>
							</c:forEach>
					</select></td>
					<c:if test="${param.qType=='all'}">
						<td>&nbsp;&nbsp;
							教师名：<input type="text"  name="teacherName" value="${param.teacherName}"  />
						</td>
					</c:if>
					<td>&nbsp;&nbsp;
						从：
						<input type="text" name="startTime" maxDate="%y-%M-%d" value="${param.startTime}"  class="date" dateFmt="yyyy-MM-dd" readonly="true"/>
						<a class="inputDateButton"  href="javascript:;" style="float:right;">选择</a>
					</td>
					<td>&nbsp;&nbsp;
						至：
						<input type="text" name="endTime" maxDate="%y-%M-%d" value="${param.endTime}" class="date" dateFmt="yyyy-MM-dd" readonly="true"/>
						<a class="inputDateButton"  href="javascript:;" style="float:right;">选择</a>
					</td>
					
					<td><div class="buttonActive"><div class="buttonContent"><button style="width: 30px;height: 30px;" type="submit">查询</button></div></div></td>
					<td><div class="buttonActive"><div class="buttonContent"><button style="width: 30px;height: 30px;" class="reset" type="button">重置</button></div></div></td>
				</tr>
			</table>
		</div>
	</form>
</div>

<div class="pageContent">
	<table class="table" width="100%" layoutH="85">
		<thead>
			<tr>
				<th width="300" style="text-align: center;">流水号</th>
				<th width="150" style="text-align: center;">教师</th>
				<th width="100" style="text-align: center;">科目</th>
				<th width="100" style="text-align: center;">课时（节）</th>
				<th width="100" style="text-align: center;">实际扣课人数</th>
				<th width="300" style="text-align: center;">备注</th>
				<th width="300" style="text-align: center;">时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${p.dataList}" var="b" varStatus="s">
				<tr>
					<td style="text-align: center;">${b.id}</td>
					<td style="text-align: center;">${b.teacherName}</td>
					<td style="text-align: center;">${b.courseName}</td>
					<td style="text-align: center;">${b.courseCount}</td>
					<td style="text-align: center;">${b.stuCount}</td>
					<td style="text-align: center;">${b.remark}</td> 
					<td style="text-align: center;">
						<fmt:formatDate value="${b.createTime}" pattern="yyyy/MM/dd HH:mm:ss" />
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td style="text-align: center;color: #FF0097;" colspan="7">
					课时共计:${totalCourseCount}节（来源所有分页数据）
				</td>
			</tr>
		</tbody>
	</table>
	<%@include file="/static/include/pageFooter.jsp"%>
</div>
</div>
<script type="text/javascript">
	$(function(){
		$("#teacherWorkFlowlistPage .reset").on("click",function(){
			$("#teacherWorkFlowlistPage input[name='teacherName']").val("");
			$("#teacherWorkFlowlistPage input[name='startTime']").val("");
			$("#teacherWorkFlowlistPage input[name='endTime']").val("");
			$("#teacherWorkFlowlistPage select[name='courseId']").val("");
			$("#teacherWorkFlowlistPage a[name='courseId']").text("所有课程"); 
		});
	});
</script>
</body>
</html>
