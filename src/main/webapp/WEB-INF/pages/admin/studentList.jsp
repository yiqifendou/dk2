<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生列表</title>
</head>
<body>
<div id="studentlistPage">
<form id="pagerForm" method="post" action="${ctx}/student/studentList">
	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
	
	<input type="hidden" name="name" value="${param.name}" />
	<input type="hidden" name="phone" value="${param.phone}" />
	<input type="hidden" name="contactName" value="${param.contactName}" />
	<input type="hidden" name="stus" value="${param.stus}" />
</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="${ctx}/student/studentList" 
		method="post">
		<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>&nbsp;&nbsp;
						姓名：<input type="text"  name="name" value="${param.name}"  />
					</td>
					<td>&nbsp;&nbsp;
						手机号：<input type="text"  name="phone" value="${param.phone}"  />
					</td>
					<td>&nbsp;&nbsp;
						联系人：<input type="text"  name="contactName" value="${param.contactName}"  />
					</td>
					<td><select class="combox"  name="stus" >
							<option <c:if test="${param.stus == null || param.stus==''}">selected</c:if>	value="">所有状态</option>
							<option <c:if test="${param.stus == '1'}">selected</c:if> value="1">正常</option>
							<option <c:if test="${param.stus == '0'}">selected</c:if> value="0">冻结</option>
					</select></td>
					
					<td><div class="buttonActive"><div class="buttonContent"><button style="width: 30px;height: 30px;" type="submit">查询</button></div></div></td>
					<td><div class="buttonActive"><div class="buttonContent"><button style="width: 30px;height: 30px;" class="reset" type="button">重置</button></div></div></td>
				</tr>
			</table>
		</div>
	</form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="${ctx}/student/toAddStudentDialog" width="820" height="350" title="添加学生"  mask="true" target="dialog"><span>添加学生</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="${ctx}/student/toUpdateStudentDialog?id={id}" width="820" height="350" title="修改学生" mask="true" warn="请选择学生" target="dialog"><span>修改学生</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="${ctx}/student/toRechargeStuCourseDialog?studentId={id}" width="600" height="320" title="课程充值" mask="true" warn="请选择学生" target="dialog"><span>课程充值</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="112">
		<thead>
			<tr>
				<th width="100" align="center">序号</th>
				<th width="150">姓名</th>
				<th width="150">手机号</th>
				<th width="150">联系人（家长）</th>
				<th width="100">充值总费用（元）</th>
				<th width="80">状态</th>
				<th width="130">生日</th>
				<th width="150" style="text-align: center;">所属学校</th>
				<th width="350" style="text-align: center;">备注</th>
				<th width="200">创建时间</th>
				<th width="200">更新时间</th>
				<th width="200" style="text-align: center;">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${p.dataList}" var="b" varStatus="s">
				<tr data-id="${b.id}" target="id" rel="${b.id}">
					<td>${b.id}</td>
					<td>${b.name}</td>
					<td>${b.phone}</td>
					<td>${b.contactName}</td>
					<td>${b.totalFee}</td>
					<td>
						<c:if test="${b.stus==1}">
							<font color="green">正常</font>
						</c:if>
						<c:if test="${b.stus==0}">
							<font color="red">冻结</font>
						</c:if>
					</td>
					<td>
						<fmt:formatDate value="${b.birthday}" pattern="yyyy/MM/dd" />
					</td>
					<td style="text-align: center;">
						${b.school}
					</td>
					<td style="text-align: center;">
						${b.remark}
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
					<td style="text-align: center;">
						<a style="color:blue;" href="${ctx}/student/courseFlowList?studentId=${b.id}" target="navTab" rel="courseFlowList" title="课程流水" fresh="true" external="false">课程流水</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%@include file="/static/include/pageFooter.jsp"%>
</div>
</div>
<script type="text/javascript">
	$(function(){
		$("#studentlistPage .reset").on("click",function(){
			$("#studentlistPage input[name='name']").val("");
			$("#studentlistPage input[name='phone']").val("");
			$("#studentlistPage input[name='contactName']").val("");
			$("#studentlistPage select[name='stus']").val("");
			$("#studentlistPage a[name='stus']").text("所有状态"); 
		});
	});
</script>
</body>
</html>
