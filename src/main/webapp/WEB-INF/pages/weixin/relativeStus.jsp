<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=no,minimum-scale=1" />
<link rel="apple-touch-icon" href="http://icon.zol-img.com.cn/m/images/apple-touch-icons/default.png" />
<link rel="stylesheet" href="${ctx}/static/compoment/wap/css/list.css">
<script src="${ctx}/static/script/m.c.js" type="text/javascript"></script>
<script type="text/javascript">
if(!com.lc.crm.dk.c.getCookie("bindPhone")){
	location.href = "${ctx}/weixin/toBindPhone";
}
</script>
<style type="text/css">
	.btn{
		width: 100%;
	    height: 2.5rem;
	    line-height: 2.5rem;
	    border-radius: .3125rem;
	    background: #1389FE;
	    font-size: 1rem;
	    color: #fff;
	    text-align: center;
	}
</style>
<title>学员列表</title>
</head>
<body>
	<header>
		<div class="header" data-bindPhone="${bindPhone}"  style="height: 3rem;line-height: 3rem;background: #1389FE;font-size: 1rem;color: #fff;text-align: center;">
		</div>
	</header>
 
	<div class="account-menu menu" role="menu">
		<c:forEach items="${stuCourseRemainList}" var="r">
			<a role="menuitem" class="menuitem" href="${ctx}/weixin/queryStuStudyRecord?studentId=${r.studentId}&courseId=${r.courseId}&remain=${r.remain}&alreadyStudy=${r.alreadyStudy}">
				<i>详情</i>
				<em class="fav">${r.student.name}&nbsp;&nbsp;${r.course.courseName}&nbsp;&nbsp;剩${r.remain}节&nbsp;&nbsp;学${r.alreadyStudy}节</em>
			</a>
		</c:forEach>
	</div>
	
	<div class="btn-box" style="margin-top: 10px;">
		<div class="btn" id="calcelBindBtn" >取消绑定</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	var bindPhone = new String("${bindPhone}");
	$(".header").html("手机号："+bindPhone.split("").join("&nbsp;"));
	
	$("#calcelBindBtn").on("click",function(){
		 if(confirm("确定取消绑定吗？")){
			com.lc.crm.dk.c.delCookie("bindPhone");
			location.href="${ctx}/weixin/toBindPhone";
		 }
	});
});
</script>
</html>