$(function() {
	var c = com.lc.crm.dk.c;
	var ctx = c.ctx;
	
	if(c.getCookie("adminMenu")){
		var adminMenuHtml = 
		"<div class=\"accordionHeader\">"+
			"<h2> "+
				"<span>Folder</span>管理员专区"+
			"</h2>"+
		"</div>"+
		"<div class=\"accordionContent\">"+
			"<ul class=\"tree treeFolder\">"+
				"<li><a href=\""+ctx+"/course/courseList\" target=\"navTab\" rel=\"courseList\" fresh=\"true\" external=\"false\" >课程列表</a></li>"+
				"<li><a href=\""+ctx+"/user/userList\" target=\"navTab\" rel=\"userList\" fresh=\"true\" external=\"false\" >教师列表</a></li>"+
				"<li><a href=\""+ctx+"/student/studentList\" target=\"navTab\" rel=\"studentList\" fresh=\"true\" external=\"false\" >学生列表</a></li>"+
				"<li><a href=\""+ctx+"/grp/grpList\" target=\"navTab\" rel=\"grpList\" fresh=\"true\" external=\"false\" >班级列表</a></li>"+
				"<li><a href=\""+ctx+"/student/courseRemainList\" target=\"navTab\" rel=\"courseRemainList\" fresh=\"true\" external=\"false\" >课时报警</a></li>"+
				"<li><a href=\""+ctx+"/user/teacherWorkFlowList?qType=all\" target=\"navTab\" rel=\"teacherWorkFlowList\" fresh=\"true\" external=\"false\" >教学流水</a></li>"+
				"<li><a href=\""+ctx+"/adminTip.jsp\" target=\"navTab\" rel=\"adminTip\" fresh=\"true\" external=\"false\" >管理必读</a></li>"+
			"</ul>"+
		"</div>";
		$("#funMenuBar").prepend(adminMenuHtml);
	}
	
});