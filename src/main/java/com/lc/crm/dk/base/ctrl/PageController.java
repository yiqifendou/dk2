package com.lc.crm.dk.base.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面跳转controller
 * @author yiqilvyou
 *
 */
@Controller
@RequestMapping("/pages")
public class PageController {
	
	@RequestMapping("/errorPages/{pageName}")
	public String toErrorPage(@PathVariable String pageName){
		return "errorPages/"+pageName;
	}
	
}
