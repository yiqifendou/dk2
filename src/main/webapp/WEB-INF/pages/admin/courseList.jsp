<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>课程列表</title>
</head>
<body>
<div id="courselistPage">

<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="${ctx}/course/toAddCourseDialog.do" width="550" title="添加课程" height="260" mask="true" target="dialog"><span>添加课程</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="${ctx}/course/toUpdateCourseDialog.do?courseId={courseId}" width="550" title="修改课程" height="260" mask="true" warn="请选择课程" target="dialog"><span>修改课程</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="112">
		<thead>
			<tr>
				<th width="150" align="center">序号</th>
				<th width="300" style="text-align: center;">课程名称</th>
				<th width="100">课程类型</th>
				<th width="500" style="text-align: center;">备注</th>
				<th width="300">创建时间</th>
				<th width="300">更新时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dataList}" var="b" varStatus="s">
				<tr target="courseId" rel="${b.id}">
					<td>${b.id}</td>
					<td style="text-align: center;">${b.courseName}</td>
					<td>
						<c:if test="${b.courseType==0}">
							小课
						</c:if>
						<c:if test="${b.courseType==1}">
							集体课
						</c:if>
					</td>
					<td style="text-align: center;">
						<c:if test="${b.remark==null}">
							暂无
						</c:if>
						<c:if test="${b.remark!=null}">
							${b.remark}
						</c:if>
					</td>
					<td>
						<fmt:formatDate value="${b.createTime}" pattern="yyyy/MM/dd HH:mm:ss" />
					</td>
					<td>
						<c:if test="${b.updateTime==null}">
							<fmt:formatDate value="${b.createTime}" pattern="yyyy/MM/dd HH:mm:ss" />
						</c:if>
						<c:if test="${b.updateTime!=null}">
							<fmt:formatDate value="${b.updateTime}" pattern="yyyy/MM/dd HH:mm:ss" />
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
</div>
</div>
</body>
</html>
