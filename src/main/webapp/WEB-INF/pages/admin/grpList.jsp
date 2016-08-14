<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>班级列表</title>
</head>
<body>
<div id="grplistPage">
<form id="pagerForm" method="post" action="${ctx}/grp/grpList">
	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
	
	<input type="hidden" name="grpName" value="${param.grpName}" />
</form>

<div class="pageHeader">
	<form onsubmit="return navTabSearch(this);" action="${ctx}/grp/grpList" 
		method="post">
		<input type="hidden" name="numPerPage" value="${p.numPerPage}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>&nbsp;&nbsp;
						班级名称：<input type="text"  name="grpName" value="${param.grpName}"  />
					</td>
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
			<li><a class="add" href="${ctx}/grp/toAddGrp" target="navTab" rel="toAddGrp" title="添加班级" fresh="true" external="false"><span>添加班级</span></a></li>
			<li class="line">line</li>
			<li><a class="edit editGrp"><span>修改班级</span></a></li>
			<li class="line">line</li>
			<li><a class="delete deleteGrp"><span>删除班级</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="112">
		<thead>
			<tr>
				<th width="100" align="center">序号</th>
				<th width="150">班级名称</th>
				<th width="150">教师</th>
				<th width="150">课程</th>
				<th width="350" style="text-align: center;">备注</th>
				<th width="200">创建时间</th>
				<th width="200">更新时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${p.dataList}" var="b" varStatus="s">
				<tr data-id="${b.id}" target="id" rel="${b.id}">
					<td>${b.id}</td>
					<td>${b.grpName}</td>
					<td>${b.teacherName}</td>
					<td>${b.courseName}</td>
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
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%@include file="/static/include/pageFooter.jsp"%>
</div>
</div>
<script type="text/javascript">
	$(function(){
		$("#grplistPage .reset").on("click",function(){
			$("#grplistPage input[name='grpName']").val("");
		});
		
		$("#grplistPage .editGrp").on("click",function(){
			var c = com.lc.crm.dk.c;
			var selectedSize = $("#grplistPage tr.selected").length;
			if(selectedSize<1){
				alertMsg.error("请选择班级");
			}else{
				var id = $("#grplistPage tr.selected").attr("data-id");
				navTab.openTab("toUpdateGrp",c.ctx+"/grp/toUpdateGrp?id="+id,{title:"修改班级",fresh:true,external:false});
			}
		});
		
		$("#grplistPage .deleteGrp").on("click",function(){
			var c = com.lc.crm.dk.c;
			var selectedSize = $("#grplistPage tr.selected").length;
			if(selectedSize<1){
				alertMsg.error("请选择班级");
			}else{
				alertMsg.confirm("确定要删除吗？", {
					okCall: function(){
						var id = $("#grplistPage tr.selected").attr("data-id");
						$.ajax({
							url:c.ctx+"/grp/deleteGrp?id="+id,
							type:"post",
							dataType:"json",
							success:function(rs){
								if (rs.status==0) {
									alertMsg.correct("删除成功！");
								} else {
									alertMsg.error(rs.msg);
								}
								navTab.reloadFlag("grpList");
							},
							error:function(){
								alertMsg.error("系统繁忙，请稍后再试！")
								navTab.reloadFlag("grpList");
							}
						});
					}
				});
			}
		});
		
	});
</script>
</body>
</html>
