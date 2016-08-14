<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加班级</title>
<style type="text/css">
	#addGrpTab .selectedStusTable th{
		border-bottom: 1px solid #CACACA;
		border-right:1px solid #CACACA;
		background-color: #F5F3FF;
		text-align: center;
	}
	#addGrpTab .selectedStusTable td{
		border-bottom: solid 1px #ededed;
		border-right:solid 1px #ededed;
		text-align: center;
	}
	#addGrpTab .selectedStusTable tr{
		height: 25px;
	}
	#addGrpTab .selectedStusTable tr:hover{
		background-color: #f6f6f6;
	}
</style>
</head>
<body>
	<div id="addGrpTab" class="pageContent">
		<div class="pageFormContent" style="padding: 0px;" layoutH="40">
			<!-- 以下是班级基本信息 -->
			<div style="background-color: #F1F1F1;padding-top: 7px;">
				<div style="display: inline-block;float:left;height: 30px;">
					<font style=" margin-left: 30px;float: left;margin-top: 5px;margin-right: 20px;">课程&教师：</font>
					<select  class="combox"   name="courseId" ref="addGrp_combox_teacherId" refUrl="${ctx}/user/queryTeacherByCourseId?courseId={value}">
						<c:forEach items="${courseList}" var="c">
							<option  value="${c.id}">${c.courseName}</option>
						</c:forEach>
					</select>
					<select  class="combox"  id="addGrp_combox_teacherId" name="teacherId" >
						<c:forEach items="${firstTeacherList}" var="t">
							<option  value="${t.id}">${t.name}</option>
						</c:forEach>
					</select>
				</div>
				<div style="display:inline-block;height: 30px;margin-left: 50px;">
					<font style="margin-right: 20px;">名称：</font>
					<input class="required" name="grpName" style="float:none;width:200px;" type="text" />
					<font style="margin-left: 50px;margin-right: 20px;">备注:</font>
					<input name="remark" style="float:none;width:400px;" type="text" />
				</div>
			</div>
			
			<!-- 以下是学员操作 -->
			<div class="panelBar">
				<ul class="toolBar">
					<li>
						<a class="add addStusToGrpBtn"><span>添加学员</span></a>
					</li>
				</ul>
			</div>
			
			
			<table class="selectedStusTable" style="width: 100%;">
				<thead>
					<tr>
						<th width="100">
							<div class="gridCol" title="序号">序号</div>
						</th>
						<th width="300">姓名</th>
						<th width="300">手机号</th>
						<th width="300">联系人(家长)</th>
						<th width="300">剩余课程（节）</th>
						<th width="300">操作</th>
					</tr>
				</thead>
				<tbody class="addGrpStusList">
				</tbody>
			</table>
			
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" class="saveGrpBtn" >保存班级</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消保存</button></div></div></li>
			</ul>
		</div>
</div>

<script id="addGrpStusListTempContent" type="text/html">
	{{each list as r i}}						    
		<tr data-stuid="{{r.studentId}}">
			<td>{{r.studentId}}</td>
			<td>{{r.name}}</td>
			<td>{{r.phone}}</td>
			<td>{{r.contactName}}</td>
			<td>{{r.remain}}</td>
			<td><a style="margin-left:45%;" class="removecur btnDel">取消选择</a></td>
		</tr>
	{{/each}}
</script>

<script type="text/javascript" src="${ctx}/static/compoment/artTemplate/template.js"></script>
<script type="text/javascript">
$(function(){
	var c = com.lc.crm.dk.c;
	
	$("#addGrpTab .addStusToGrpBtn").on("click",function(){
		var cId = $("#addGrpTab select[name='courseId']").val();
		var tId = $("#addGrpTab select[name='teacherId']").val();
		if(tId && cId){
			$.pdialog.open("${ctx}/grp/joinGrpStuList?type=1&courseId="+cId+"&teacherId="+tId, "joinStusDialog", "添加学员", {"mask":true,"width":800,"height":400});
		}else{
			alertMsg.error("请选择课程和教师");
		}
	});
	
	$("#addGrpTab").on("change","select[name='courseId']",function(){
		$("#addGrpTab .addGrpStusList").html("");
	});
	
	$("#addGrpTab").on("change","select[name='teacherId']",function(){
		$("#addGrpTab .addGrpStusList").html("");
	});
	
	$("#addGrpTab").on("click","tbody tr .removecur",function(){
		$(this).parent().parent().remove();
	});
	
	
	$("#addGrpTab .saveGrpBtn").on("click",function(){
		var courseId = $("#addGrpTab select[name='courseId']").val();
		var teacherId = $("#addGrpTab select[name='teacherId']").val();
		var grpName = $("#addGrpTab input[name='grpName']").val();
		var remark = $("#addGrpTab input[name='remark']").val();
		if(!courseId){
			alertMsg.error("请选择课程！");
			return;
		}
		if(!teacherId){
			alertMsg.error("请选择教师！");	
			return;
		}
		if(!grpName){
			alertMsg.error("请填写班级名称！");
			return;
		}
		var confirmStuArr = [];
		//所有选中的班级人员
		$("#addGrpTab").find("[data-stuid]").each(function(){
			confirmStuArr.push($(this).attr("data-stuid"));
		});
		
		alertMsg.confirm("确认添加吗？（课程剩余0的学员将无法添加到该班级）", {
			okCall: function(){
				$.ajax({
					url:c.ctx+"/grp/addGrp",
					type:"post",
					dataType:"json",
					data:{courseId:courseId,teacherId:teacherId,grpName:grpName,remark:remark,cStuIds:confirmStuArr.join(",")},
					success:function(rs){
						if (rs.status==0) {
							alertMsg.correct("班级添加成功!");
							navTab.closeCurrentTab();
						} else {
							alertMsg.error(rs.msg);
						}
						navTab.reloadFlag("grpList");
					},
					error:function(){
						alertMsg.error("系统繁忙，请稍后再试！")
					}
				});
			}
		});
		
	});
});

</script>
</body>
</html>