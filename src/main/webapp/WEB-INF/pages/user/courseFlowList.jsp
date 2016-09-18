<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程流水</title>
<script type="text/javascript" src="${ctx}/static/script/m.userList.js"></script>
</head>
<body>
<div id="userlistPage">
<form id="pagerForm" method="post" action="${ctx}/student/courseFlowList?studentId=${param.studentId}&courseId=${param.courseId}">
	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
</form>
<div class="pageContent">
	<table class="table" width="100%" layoutH="48">
		<thead>
			<tr>
				<th width="100" style="text-align: center;">序号</th>
				<th width="150" style="text-align: center;">学生</th>
				<th width="200" style="text-align: center;">电话</th>
				<th width="100" style="text-align: center;">科目</th>
				<th width="100" style="text-align: center;">类型</th>
				<th width="100" style="text-align: center;">课时（节）</th>
				<th width="150" style="text-align: center;">授课教师/操作人</th>
				<th width="100">充值额（元）</th>
				<th width="200">备注</th>
				<th width="300" style="text-align: center;">时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${p.dataList}" var="b" varStatus="s">
				<tr>
					<td style="text-align: center;">${b.id}</td>
					<td style="text-align: center;">${student.name}</td>
					<td style="text-align: center;">${student.phone}</td>
					<td style="text-align: center;">${b.course.courseName}</td>
					<td style="text-align: center;">
						<c:if test="${b.type==0}">
							<font color="red">消费</font>
						</c:if>
						<c:if test="${b.type==1}">
							<font color="#19D062">充值</font>
						</c:if>
						<c:if test="${b.type==2}">
							<font color="blue">赠送</font>
						</c:if>
					</td>
					<td style="text-align: center;">${b.courseCount}</td>
					<td style="text-align: center;">${b.operator.name}</td>
					<td>${b.rechargeFee}</td> 
					<td>${b.remark}</td> 
					<td style="text-align: center;">
						<fmt:formatDate value="${b.createTime}" pattern="yyyy/MM/dd HH:mm:ss" />
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td style="text-align: center;color: #FF0097;" colspan="10">
					课程剩余情况:
					${courseRemains}
					<c:forEach items="${scrList}" var="scr" >
						${scr.course.courseName} 剩${scr.remain}节，学${scr.alreadyStudy}节；
					</c:forEach>
					（来源所有分页数据）
				</td>
			</tr>
		</tbody>
	</table>
	<%@include file="/static/include/pageFooter.jsp"%>
</div>
</div>
</body>
</html>
