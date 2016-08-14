<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程报警</title>
</head>
<body>
<div id="courseRemainlistPage">
<form id="pagerForm" method="post" action="${ctx}/student/courseRemainList">
	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
	<input type="hidden" name="courseId" value="${param.courseId}" />
</form>



<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="${ctx}/student/courseRemainList" 
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
				<th width="100" style="text-align: center;">序号</th>
				<th width="200" style="text-align: center;">学生</th>
				<th width="260" style="text-align: center;">电话</th>
				<th width="200" style="text-align: center;">联系人（家长）</th>
				<th width="200" style="text-align: center;">课程名称</th>
				<th width="200" style="text-align: center;">剩余课时（节）</th>
				<th width="200" style="text-align: center;">已学课时（节）</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${p.dataList}" var="b" varStatus="s">
				<tr>
					<td style="text-align: center;">${b.id}</td>
					<td style="text-align: center;">${b.student.name}</td>
					<td style="text-align: center;">${b.student.phone}</td>
					<td style="text-align: center;">${b.student.contactName}</td>
					<td style="text-align: center;">${b.course.courseName}</td>
					<td style="text-align: center;">
						<c:if test="${b.remain<=2}">
							<font color="red">${b.remain}</font>
						</c:if>
						<c:if test="${b.remain>2}">
							${b.remain}
						</c:if>
					</td>
					<td style="text-align: center;">${b.alreadyStudy}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%@include file="/static/include/pageFooter.jsp"%>
</div>
</div>
<script type="text/javascript">
	$(function(){
		$("#courseRemainlistPage .reset").on("click",function(){
			$("#courseRemainlistPage select[name='courseId']").val("");
			$("#courseRemainlistPage a[name='courseId']").text("所有课程"); 
		});
	});
</script>
</body>
</html>
