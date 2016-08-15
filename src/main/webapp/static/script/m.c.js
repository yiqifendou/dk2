/**
 * 包作用域，减少域污染
 */
typeof(com)=="undefined"&&(function(){com={};})();
!com.lc&&(function(){com.lc={};})();
!com.lc.crm&&(function(){com.lc.crm={};})();
!com.lc.crm.dk&&(function(){com.lc.crm.dk={};})();
com.lc.crm.dk.c = {
		//可以和ctx关联
		ctx:"/dk",
		juiBasePath:"/dk/static/compoment/jui",
		loginUrl:"/dk",
		getCookie:function(name){
			if (document.cookie.length > 0) {
				start = document.cookie.indexOf(name + "=");
				if (start != -1) {
					start = start + name.length + 1;
					end = document.cookie.indexOf(";", start);
					if (end == -1)
						end = document.cookie.length;
					return unescape(document.cookie.substring(start, end));
				}
			}
			return "";
		},
		addCookie:function(name,value)
		{
			var Days = 36500;
			var exp = new Date();
			exp.setTime(exp.getTime() + Days*24*60*60*1000);
			document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString()+";path=/";
		},
		delCookie:function(name) 
		{ 
			var exp = new Date(); 
			exp.setTime(exp.getTime() - 1); 
			var cval=this.getCookie(name); 
			if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString()+";path=/";
		},
		getDateStr:function(d,dsp,tsp){
			dsp = dsp||"/";
			tsp = tsp||":";
			var monStr = (d.getMonth()+1);
			monStr<10&&(monStr="0"+monStr);
			var dateStr = d.getDate();
			dateStr<10&&(dateStr="0"+dateStr);
			var hourStr = d.getHours();
			hourStr<10&&(hourStr="0"+hourStr);
			var minStr = d.getMinutes();
			minStr<10&&(minStr="0"+minStr);
			var secStr = d.getSeconds();
			secStr<10&&(secStr="0"+secStr);
			return d.getFullYear()+dsp+monStr+dsp+dateStr+" "+hourStr+tsp+minStr+tsp+secStr;
		},		
		getQueryString:function(name) {
	        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	        var r = window.location.search.substr(1).match(reg);
	        if (r != null) return unescape(r[2]);
	        return null;
	    }

}

!function(){
	//局部作用域
	var juiBasePath = com.lc.crm.dk.c.juiBasePath;
	document.write("<script src=\""+juiBasePath+"/js/jquery-1.11.3.min.js\" type=\"text/javascript\"></script>");
}();







