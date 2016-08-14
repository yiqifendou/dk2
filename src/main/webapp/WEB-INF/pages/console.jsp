<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>点课系统-用户中心</title>
<link rel="icon" href="${ctx}/favicon.ico" />
<script src="${ctx}/static/script/m.c.js" type="text/javascript"></script>
<script src="${ctx}/static/script/m.jui.c.js" type="text/javascript"></script>
<script src="${ctx}/static/script/m.console.js" type="text/javascript"></script>
<style type="text/css">
#header .logo {
    background: url(${ctx}/static/images/logo.png) no-repeat;
}
</style>
</head>

<body>
	<div id="layout">
		<div id="header">
			<div class="headerNav">
				<a class="logo" href="javascript:;">LOGO</a>
				<ul class="nav">
					<li><a href="${ctx}/user/toUpdateMyInfoDialog" target="dialog" width="820" height="400" mask="true" 
								>我的信息</a></li>
					<li><a href="${ctx}/user/toUpdatePwdDialog" target="dialog" width="550" height="200" mask="true" 
								>修改密码</a></li>
					<li><a href="${ctx}/user/logout.do">退出</a></li>
				</ul>
				<ul class="themeList" id="themeList">
					<li theme="azure"><div >天蓝</div></li>
					<li theme="purple"><div>紫色</div></li>
					<li theme="default"><div>蓝色</div></li>
					<li theme="green"><div>绿色</div></li>
					<li theme="silver"><div>银色</div></li>
					<!-- <li theme="red"><div>红色</div></li> -->
				</ul>
			</div>
			<!-- navMenu -->
		</div>

		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse">
						<div></div>
					</div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse">
					<h2>主菜单</h2>
					<div>收缩</div>
				</div>

				<div class="accordion" id="funMenuBar" fillSpace="sidebar">
				
					<div class="accordionHeader">
						<h2>
							<span>Folder</span>用户专区
						</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree treeFolder">
							<li><a href="${ctx}/user/teacherMain"  target="navTab" rel="teacherMain" fresh="true" external="false">教师点课</a></li>
							<li><a href="${ctx}/user/teacherWorkFlowList" target="navTab" rel="teacherWorkFlowList" fresh="true" external="false" >点课流水</a></li>
							<li><a href="${ctx}/user/toUpdateMyInfoDialog" width="820" height="400" target="dialog" rel="myInfoDialog" mask="true" >我的信息</a></li>
							<li><a href="${ctx}/user/toUpdatePwdDialog" width="550" height="200" target="dialog" rel="updatePwdDialog" mask="true" >修改密码</a></li>
							<li><a href="${ctx}/teacherTip.jsp" target="navTab" rel="teacherTip" fresh="true" external="false" >教师必读</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>


		<div id="container">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent">
						<!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
							<li tabid="main" class="main"><a href="javascript:;"><span><span
										class="home_icon">我的主页</span></span></a></li>
						</ul>
					</div>
					<div class="tabsLeft">left</div>
					<!-- 禁用只需要添加一个样式 class="tabsLeft tabsLeftDisabled" -->
					<div class="tabsRight">right</div>
					<!-- 禁用只需要添加一个样式 class="tabsRight tabsRightDisabled" -->
					<div class="tabsMore">more</div>
				</div>

				<ul class="tabsMoreList">
					<li><a href="javascript:;">我的主页</a></li>
				</ul>
				<div class="navTab-panel tabsPageContent layoutBox">
					<div class="page unitBox">
						<div class="pageFormContent" layoutH="0" style="padding:0px;">
						<!-- 
							<iframe width="100%" height="100%" class="share_self"
								frameborder="0" scrolling="yes" src="${ctx}/view/welcome.do"></iframe> -->
							
							<div class="accountInfo"  style="height: 30px;" >
								<div class="alertInfo" style="width:8%;">
									<p style="color:#15428B;"  class="lastBook">
										你好，${loginUser.name}
									</p>
								</div>
								<p style="color:#FF0097;width: 80%;"  class="publicTip">点课系统全新上线啦，涉及班级分配、学员分配、账号添加及课程分配等操作请联系管理员...</p>
							</div>
							<div class="pageFormContent" style="padding: 0px 5px;" layoutH="35" >
								<iframe width="100%" height="100%" class="share_self"
								frameborder="0" style="border: none;" scrolling="no" src="${ctx}/static/compoment/calendar/calendar.html"></iframe>
							</div>
							
						</div>
					</div>
				</div>

			</div>
		</div>

	</div>
	<div id="footer">
		Copyright &copy; 2016 <a href="mailto:zhongbao.wang@lc.crm.com">1508707775@qq.com</a>
	</div>
</body>
</html>