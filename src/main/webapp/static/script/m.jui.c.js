!function(){
	//为了简写
	var c = com.lc.crm.dk.c;
	var juiBasePath = c.juiBasePath;
	
	var loveTheme = c.getCookie("dk_love_theme")||"purple";
	document.write("<link id=\"dkLoveTheme\" href=\""+juiBasePath+"/themes/"+loveTheme+"/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>");
	document.write("<link href=\""+juiBasePath+"/themes/css/core.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>");
	document.write("<link href=\""+juiBasePath+"/themes/css/print.css\" rel=\"stylesheet\" type=\"text/css\" media=\"print\"/>");
	document.write("<link href=\""+juiBasePath+"/uploadify/css/uploadify.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>");
	document.write("<link href=\""+juiBasePath+"/themes/css/ieHack.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"/>");
	document.write("<script src=\""+juiBasePath+"/js/speedup.js\" type=\"text/javascript\"></script>");
	document.write("<script src=\""+juiBasePath+"/js/jquery.cookie.js\" type=\"text/javascript\"></script>");
	document.write("<script src=\""+juiBasePath+"/js/jquery.validate.js\" type=\"text/javascript\"></script>");
	document.write("<script src=\""+juiBasePath+"/js/jquery.bgiframe.js\" type=\"text/javascript\"></script>");
	document.write("<script src=\""+juiBasePath+"/bin/dwz.min.js\" type=\"text/javascript\"></script>");
	document.write("<script src=\""+juiBasePath+"/js/dwz.regional.zh.js\" type=\"text/javascript\"></script>");
	
	
}();

$(function(){
	var c = com.lc.crm.dk.c;
	var juiBasePath = c.juiBasePath;
	DWZ.init(juiBasePath+"/dwz.frag.xml", {
		//loginUrl : juiBasePath+"login_dialog.html",
		//loginTitle : "登录", // 弹出登录对话框
		//		loginUrl:"login.html",	// 跳到登录页面
		loginUrl:com.lc.crm.dk.c.loginUrl,	// 跳到登录页面
		statusCode : {
			ok : 200,
			error : -1,
			timeout : 301
		}, //【可选】
		pageInfo : {
			pageNum : "pageNum",
			numPerPage : "numPerPage",
			orderField : "orderField",
			orderDirection : "orderDirection"
		}, //【可选】
		keys : {
			statusCode : "errorCode",
			message : "msg"
		}, //【可选】
		ui : {
			hideMode : 'offsets'
		}, //【可选】hideMode:navTab组件切换的隐藏方式，支持的值有’display’，’offsets’负数偏移位置的值，默认值为’display’
		debug : false, // 调试模式 【true|false】
		callback : function() {
			initEnv();
			$("#themeList").theme({
				themeBase : juiBasePath+"/themes"
			}); // themeBase 相对于index页面的主题base路径
			//navTab.openTab("indexNavTab2", "http://www.lc.crm.com", { title:"首页", fresh:false, data:{} });
		}
	});
	
	//jui主题切换
	$(".themeList li").on("click",function(){ 
		var c = com.lc.crm.dk.c;
		var juiBasePath = c.juiBasePath;
		var dkLoveTheme = $(this).attr("theme");
		
		var iframes=document.getElementsByTagName("iframe"); 
		for(var i=0;i<iframes.length;i++){
			try {
				if(iframes[i].contentDocument.getElementById('dkLoveTheme').href){
					iframes[i].contentDocument.getElementById('dkLoveTheme').href = juiBasePath+"/themes/"+dkLoveTheme+"/style.css";
				}
			} catch (e) {
			}
		}
		
		c.addCookie("dk_love_theme",dkLoveTheme);
	});
	var loveTheme = c.getCookie("dk_love_theme")||"purple";
	$(".themeList li div").removeClass("selected");
	$(".themeList li[theme="+loveTheme+"] div").addClass("selected");
	
});
$.ajaxSetup({
	beforeSend:function(){
		$("#background,#progressBar").show();
	},
	complete:function(){
		$("#background,#progressBar").hide();
	}
});

