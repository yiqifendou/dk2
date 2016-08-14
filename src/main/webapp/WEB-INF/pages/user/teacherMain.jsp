<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>教师点课</title>
</head>
<body>
<div id="teacherMainPage" style="height:100%;">
	<div class="tabs" currentIndex="${selectedTabIndex}" eventType="click" >
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<c:forEach items="${gsrList}" var="gsr">
						<li><a href="javascript:;"><span>${gsr.grp.grpName}</span></a></li> 
					</c:forEach>
				</ul>
			</div>
		</div>
		
		<div class="tabsContent" >
			<c:forEach items="${gsrList}" var="gsr">
				<div class="gsrTabContent">
					<div class="pageContent">
						<div class="pageHeader">
								<div class="searchBar">
									<table class="searchContent">
										<tr>
											<td style="background: #0CDDFF;width: 15%;">
												班级：${gsr.grp.grpName}
											</td>
											<td  style="background: #0CDDFF;width: 15%;">
												课程：${gsr.grp.courseName}
											</td>
											<td  style="background: #0CDDFF;width: 15%;">
												授课教师：${teacher.name}
											</td>
											<td  style="background: #0CDDFF;width: 55%;">
												学生姓名：<input class="condition" type="text"  name="stuName"  />
											</td>
										</tr>
									</table>
								</div>
						</div>
						<table class="table" width="100%" layoutH="112">
							<thead>
								<tr>
									<th width="100" align="center">序号</th>
									<th width="150" align="center">学生姓名</th>
									<th width="200" align="center">电话</th>
									<th width="100" align="center">剩余课时（节）</th>
									<th width="100" align="center">已学课时（节）</th>
									<th width="100" align="center">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${gsr.stuCourseRemainList}" var="scr" varStatus="i">
									<tr data-sid="${scr.student.id}" data-sname="${scr.student.name}">
										<td align="center">${scr.student.id}</td>
										<td align="center">${scr.student.name}</td>
										<td align="center">${scr.student.phone}</td>
										<td align="center">${scr.remain}</td>
										<td align="center">${scr.alreadyStudy}</td>
										<td align="center" style="background-color:#0CDDFF;">
											<c:if test="${gsr.grp.courseType==0}">
												<a style="color:white;margin-right: 20px;"	width="600" height="300" target="dialog" rel="studyCourseDialog" mask="true"
												 href="${ctx}/student/toStudyCourseDialog?operateType=single&grpId=${gsr.grp.id}&studentId=${scr.student.id}" >点课</a>
											</c:if>
											<a style="color:white;"	target="navTab" rel="courseFlowList" title="课程流水" fresh="true" external="false"
											 href="${ctx}/student/courseFlowList?studentId=${scr.student.id}&courseId=${gsr.grp.courseId}" >流水</a>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${gsr.canStudyAll==1}">
									<tr class="studyCourse" style="background-color:#0CDDFF;">
											<td align="center" colspan="6">
												<a style="color:white;font-weight: bold;" width="600" height="300" target="dialog" rel="studyCourseDialog" mask="true"
												 href="${ctx}/student/toStudyCourseDialog?operateType=all&grpId=${gsr.grp.id}" >点课(all)</a>
											</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

</div>
<style type="text/css">
	.strongStu{
		color: #FF00A5;
		font-weight: bold;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("#teacherMainPage .condition").on("keyup",function(){
			var that = this;
			var stuName = $(that).val();
			var nameReg = eval("/"+stuName.trim()+"/");
			
			var gsrTabContentNode = $(that).closest(".gsrTabContent");
			gsrTabContentNode.find("tbody tr[data-sname]").each(function(){
				if(!stuName){
					$(this).removeClass("strongStu");
				}else{
					if(nameReg.test($(this).attr("data-sname"))){
						$(this).addClass("strongStu");
					}else{
						$(this).removeClass("strongStu");
					}
				}
			});
		});
	});
</script>
</body>
</html>
