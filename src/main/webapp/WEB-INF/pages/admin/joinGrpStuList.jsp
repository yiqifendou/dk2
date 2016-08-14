<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择学生</title>
<style type="text/css">
	#joinGrpStulistPage .stusTable th{
		border-bottom: 1px solid #CACACA;
		border-right:1px solid #CACACA;
		background-color: #F5F3FF;
		text-align: center;
	}
	#joinGrpStulistPage .stusTable td{
		border-bottom: solid 1px #ededed;
		border-right:solid 1px #ededed;
		text-align: center;
	}
	#joinGrpStulistPage .stusTable tr{
		height: 25px;
	}
	#joinGrpStulistPage .stusTable tr:hover{
		background-color: #f6f6f6;
	}
</style>
</head>
<body>
<div id="joinGrpStulistPage">
<div class="pageHeader">
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>&nbsp;&nbsp;
					姓名：<input type="text"  class="condition" name="name"  />
				</td>
				<td>&nbsp;&nbsp;
					手机号：<input type="text" class="condition" name="phone"  />
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="pageContent">
	<table class="stusTable" width="100%" layoutH="70">
		<thead>
			<tr>
				<th width="100"></th>
				<th width="300">姓名</th>
				<th width="300">手机号</th>
				<th width="300">联系人（家长）</th>
				<th width="300">剩余课程（节）</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${canJoinStuList}" var="s">
				<tr data-sid="${s.studentId}" data-sname="${s.student.name}" data-sphone="${s.student.phone}">
					<td><input type="checkbox" name="stuData"  data-stu="{studentId:'${s.studentId}', name:'${s.student.name}',phone:'${s.student.phone}',contactName:'${s.student.contactName}', remain:${s.remain}}"/></td>
					<td>${s.student.name}</td>
					<td>${s.student.phone}</td>
					<td>${s.student.contactName}</td>
					<td>${s.remain}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="formBar">
	<ul>
		<li><div class="buttonActive"><div class="buttonContent"><button type="button" class="cinfirmGrpStusBtn" >确认选择</button></div></div></li>
		<li><div class="button"><div class="buttonContent"><button type="button" class="close">取消选择</button></div></div></li>
	</ul>
</div>
</div>
<script type="text/javascript">
	$(function(){
		$("#joinGrpStulistPage .cinfirmGrpStusBtn").on("click",function(){
			var selectedStuArr =[]; 
			$("#joinGrpStulistPage input[name='stuData']:checked").not(":hidden").each(function(){
				selectedStuArr.push(eval("("+$(this).attr("data-stu")+")"));
			});
			var type = parseInt("${param.type}");
			if(type==1){
				selectedJoinStusCallback(selectedStuArr);
			}else if(type==2){
				selectedJoinStusInUpdateGrpCallback(selectedStuArr);
			}
			
			$.pdialog.closeCurrent();
		});
		
		function selectedJoinStusCallback(stuArr){
			var alreadyStuIdsRegStr = "";
			$("#addGrpTab").find("[data-stuid]").each(function(){
				alreadyStuIdsRegStr+=("|(^"+$(this).attr("data-stuid")+"$)");
			});
			var resultArr = stuArr;
			if(alreadyStuIdsRegStr){
				var resultJoinStuArr = [];
				var alreadyStuIdsReg = eval("(/"+alreadyStuIdsRegStr.substr(1)+"/)");
				for(var i=0;i<stuArr.length;i++){
					if(!alreadyStuIdsReg.test(stuArr[i].studentId)){
						resultJoinStuArr.push(stuArr[i]);
					}
				}
				resultArr = resultJoinStuArr;
			}
			console.dir(resultArr);
			var html = template("addGrpStusListTempContent", {list:resultArr});
			$("#addGrpTab .addGrpStusList").prepend(html);
		}
		
		function selectedJoinStusInUpdateGrpCallback(stuArr){
			var alreadyStuIdsRegStr = "";
			$("#updateGrpTab").find("[data-stuid]").each(function(){
				alreadyStuIdsRegStr+=("|(^"+$(this).attr("data-stuid")+"$)");
			});
			var resultArr = stuArr;
			if(alreadyStuIdsRegStr){
				var resultJoinStuArr = [];
				var alreadyStuIdsReg = eval("(/"+alreadyStuIdsRegStr.substr(1)+"/)");
				for(var i=0;i<stuArr.length;i++){
					if(!alreadyStuIdsReg.test(stuArr[i].studentId)){
						resultJoinStuArr.push(stuArr[i]);
					}
				}
				resultArr = resultJoinStuArr;
			}
			console.dir(resultArr);
			var html = template("updateGrpStusListTempContent", {list:resultArr});
			$("#updateGrpTab .updateGrpStusList").prepend(html);
		}
		
		$("#joinGrpStulistPage .condition").on("keyup",function(){
			showStus();
		});
		
		var allResultArr = [];
		$("#joinGrpStulistPage tbody tr[data-sid]").each(function(){
			var sid = $(this).attr("data-sid");
			var sname = $(this).attr("data-sname");
			var sphone = $(this).attr("data-sphone");
			allResultArr.push({id:sid,name:sname,phone:sphone});
		});
		
		function showStus(){
			var name = $("#joinGrpStulistPage input[name='name']").val();
			var nameReg = eval("/"+name.trim()+"/");
			var phone = $("#joinGrpStulistPage input[name='phone']").val();
			var phoneReg = eval("/"+phone.trim()+"/");
			
			var showResultArr = [];
			var hideResultArr = [];
			for(var i=0;i<allResultArr.length;i++){
				var curStu = allResultArr[i];
				if(name&&(name.trim())){
					if(!nameReg.test(curStu.name)){
						hideResultArr.push(curStu);
						continue;
					}
				}
				if(phone&&(phone.trim())){
					if(!phoneReg.test(curStu.phone)){
						hideResultArr.push(curStu);
						continue;
					}
				}
				showResultArr.push(curStu);
			}
			for(var i=0;i<hideResultArr.length;i++){
				$("#joinGrpStulistPage tbody tr[data-sid='"+hideResultArr[i].id+"']").hide();
			}
			for(var i=0;i<showResultArr.length;i++){
				$("#joinGrpStulistPage tbody tr[data-sid='"+showResultArr[i].id+"']").show();
			}
			
		}
	});
</script>
</body>
</html>
