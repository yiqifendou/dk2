package com.lc.crm.dk.base.interceptor;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lc.crm.dk.base.constant.Constant;


@SuppressWarnings("all")
public class SessionInterceptor implements HandlerInterceptor {

	private static final Log log = LogFactory.getLog(HandlerInterceptor.class);
	private static final List<HandlerModel> handlerModelList = SessionInterceptorContext.handlerModelList;

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("interceptor url:"+request.getRequestURL());
		//session校验不通过转发页面
		String errorRequestMapping = "";
		// 决定是否放行
		boolean flag = true;
		String requestURI = request.getRequestURI().replace(Constant.CONTEXTPATH, "");
		
		for (HandlerModel hm : handlerModelList) {
			if (requestURI.matches(hm.getRequestMappingsReg())) {
				// 是需要拦截requestMapping
				try {
					flag = (Boolean) hm.getDealMethod().invoke(null, request,response);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
					//ingore
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
					//ingore
				} catch (InvocationTargetException e) {
					e.printStackTrace();
					//ingore
				}
				if(!flag){
					errorRequestMapping = hm.getErrorRequestMapping();
					break;
				}
			}
		}
		if(flag){
			return true;
		}
		//session校验不通过
		if(request.getHeader("x-requested-with")==null && request.getHeader("X-Requested-With")==null){
			//同步请求
			response.sendRedirect(Constant.CONTEXTPATH+errorRequestMapping);
		}else{
			//异步请求，直接返回无操作权限，当然你可以在xml中配，得你自己拓展了
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			JSONObject resultJson = new JSONObject();
			resultJson.put("success", false);		
			resultJson.put("errorCode", Constant.Code.STATUS_NOAUTH);
			resultJson.put("msg", "权限不足或需要登录之后才能访问！");
			response.getWriter().write(resultJson.toString());
			response.getWriter().flush();
		}
		return false;
	}

	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
