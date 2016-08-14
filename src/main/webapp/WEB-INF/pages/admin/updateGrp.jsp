<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更新班级</title>
<style type="text/css">
	#updateGrpTab .selectedStusTable th{
		border-bottom: 1px solid #CACACA;
		border-right:1px solid #CACACA;
		background-color: #F5F3FF;
		text-align: center;
	}
	#updateGrpTab .selectedStusTable td{
		border-bottom: solid 1px #ededed;
		border-right:solid 1px #ededed;
		text-align: center;
	}
	#updateGrpTab .selectedStusTable tr{
		height: 25px;
	}
	#updateGrpTab .selectedStusTable tr:hover{
		background-color: #f6f6f6;
	}
</style>
</head>
<body>
	<div id="updateGrpTab" class="pageContent">
		<div class="pageFormContent" style="padding: 0px;" layoutH="40">
			<!-- 以下是班级基本信息 -->
			<div style="background-color: #F1F1F1;padding-top: 7px;">
				<div style="display: inline-block;float:left;height: 30px;">
					<font style=" margin-left: 30px;float: left;margin-top: 5px;margin-right: 20px;">课程&教师：</font>
					<select name="courseId"  class="combox">
						<option  value="${grp.courseId}">${grp.courseName}</option>
					</select>
					<select name="teacherId"  class="combox">
						<option  value="${grp.teacherId}">${grp.teacherName}</option>
					</select>
				</div>
				<div style="display:inline-block;height: 30px;margin-left: 50px;">
					<font style="margin-right: 20px;">名称：</font>
					<input class="required" readonly="readonly" name="grpName" value="${grp.grpName}" style="float:none;width:200px;" type="text" />
					<font style="margin-left: 50px;margin-right: 20px;">备注:</font>
					<input name="remark" style="float:none;width:400px;" value="${grp.remark}" type="text" />
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
				<tbody class="updateGrpStusList">
				</tbody>
			</table>
			
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="button" class="updateGrpBtn" >保存修改</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消修改</button></div></div></li>
			</ul>
		</div>
</div>

<script id="existStusListTempContent" type="text/html">
	{{each list as r i}}						    
		<tr data-stuid="{{r.studentId}}">
			<td>{{r.studentId}}</td>
			<td>{{r.student.name}}</td>
			<td>{{r.student.phone}}</td>
			<td>{{r.student.contactName}}</td>
			<td>{{r.remain}}</td>
			<td><a style="margin-left:45%;" class="removecur btnDel">取消选择</a></td>
		</tr>
	{{/each}}
</script>

<script id="updateGrpStusListTempContent" type="text/html">
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
	var nowExistStus = ${stuCourseRemainList};
	var html = template("existStusListTempContent", {list:nowExistStus});
	$("#updateGrpTab .updateGrpStusList").prepend(html);
	
	
	$("#updateGrpTab .addStusToGrpBtn").on("click",function(){
		var cId = $("#updateGrpTab select[name='courseId']").val();
		var tId = $("#updateGrpTab select[name='teacherId']").val();
		if(tId && cId){
			$.pdialog.open("${ctx}/grp/joinGrpStuList?type=2&courseId="+cId+"&teacherId="+tId, "joinStusDialog", "添加学员", {"mask":true,"width":800,"height":400});
		}else{
			alertMsg.error("请选择课程和教师");
		}
	});
	
	
	$("#updateGrpTab").on("click","tbody tr .removecur",function(){
		$(this).parent().parent().remove();
	});
	
	
	$("#updateGrpTab .updateGrpBtn").on("click",function(){
		var remark = $("#updateGrpTab input[name='remark']").val();
		var confirmStuArr = [];
		//所有选中的班级人员
		$("#updateGrpTab").find("[data-stuid]").each(function(){
			confirmStuArr.push($(this).attr("data-stuid"));
		});
		
		alertMsg.confirm("确认修改吗？（课程剩余0的学员将无法添加到该班级）", {
			okCall: function(){
				$.ajax({
					url:c.ctx+"/grp/updateGrp?grpId=${grp.id}",
					type:"post",
					dataType:"json",
					data:{remark:remark,cStuIds:confirmStuArr.join(",")},
					success:function(rs){
						if (rs.status==0) {
							alertMsg.correct("班级修改成功!");
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