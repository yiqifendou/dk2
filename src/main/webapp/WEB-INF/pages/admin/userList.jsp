<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<script type="text/javascript" src="${ctx}/static/script/m.userList.js"></script>
</head>
<body>
<div id="userlistPage">
<form id="pagerForm" method="post" action="${ctx}/user/userList">
	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
	
	<input type="hidden" name="account" value="${param.account}" />
	<input type="hidden" name="name" value="${param.name}" />
	<input type="hidden" name="phone" value="${param.phone}" />
	<input type="hidden" name="stus" value="${param.stus}" />
</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="${ctx}/user/userList" 
		method="post">
		<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>&nbsp;&nbsp;
						账号：<input type="text"  name="account" value="${param.account}"  />
					</td>
					<td>&nbsp;&nbsp;
						姓名：<input type="text"  name="name" value="${param.name}"  />
					</td>
					<td>&nbsp;&nbsp;
						手机号：<input type="text"  name="phone" value="${param.phone}"  />
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
			<li><a class="add" href="${ctx}/user/toAddUserDialog" width="820" height="400" title="添加用户"  mask="true" target="dialog"><span>添加用户</span></a></li>
			<li class="line">line</li>
			<li><a class="edit" href="${ctx}/user/toUpdateUserDialog?id={id}" width="820" height="400" title="修改用户" mask="true" warn="请选择用户" target="dialog"><span>修改用户</span></a></li>
			<li class="line">line</li>
			<li><a class="edit resetLoginPwd"><span>重置密码</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="112">
		<thead>
			<tr>
				<th width="100" align="center">序号</th>
				<th width="150">账号</th>
				<th width="150">姓名</th>
				<th width="150">手机号</th>
				<th width="120" style="text-align: center;">角色</th>
				<th width="350" style="text-align: center;">授课列表</th>
				<th width="80">状态</th>
				<th width="350" style="text-align: center;">备注</th>
				<th width="130">入职时间</th>
				<th width="200">创建时间</th>
				<th width="200">更新时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${p.dataList}" var="b" varStatus="s">
				<tr data-id="${b.id}" target="id" rel="${b.id}">
					<td>${b.id}</td>
					<td>${b.account}</td>
					<td>${b.name}</td>
					<td>${b.phone}</td>
					<td style="text-align: center;">
						<c:if test="${b.type==1}">
							<font style="color:rgb(222, 54, 224);">管理员</font>
						</c:if>
						<c:if test="${b.type!=1}">
							教师
						</c:if>
					</td>
					<td style="text-align: center;">
						<c:forEach  items="${b.courseList}" var="c" varStatus="index">
							<c:if test="${index.index==0}">
								${c.courseName}
							</c:if>
							<c:if test="${index.index!=0}">
								、${c.courseName}
							</c:if>
						</c:forEach>
					</td>
					<td>
						<c:if test="${b.stus==1}">
							<font color="green">正常</font>
						</c:if>
						<c:if test="${b.stus!=1}">
							<font color="red">冻结</font>
						</c:if>
					</td>
					<td style="text-align: center;">
						${b.remark}
					</td>
					<td>
						<fmt:formatDate value="${b.entryTime}" pattern="yyyy/MM/dd" />
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
	<%@include file="/static/include/pageFooter.jsp"%>
</div>
</div>
</body>
</html>
