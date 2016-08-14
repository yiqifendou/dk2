package com.lc.crm.dk.base.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.alibaba.druid.pool.DruidDataSource;
/**
 * @author Wzb
 * @version 2014-9-9
 * @description application监听器,spring容器其实就是ServletContext
 */
public class ApplicationListener implements ServletContextListener{
	Log log = LogFactory.getLog(this.getClass());
	//项目绝对路径
	private static String projectRealPath = "";
	//上下文路径
	private static String contextPath = "";
	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		log.warn("servletContext destory...");
	}

	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		log.info("servletContext initialized");
		//项目绝对路径和上下文路径
		projectRealPath = servletContextEvent.getServletContext().getRealPath("/");
		contextPath = servletContextEvent.getServletContext().getContextPath();
		log.info("contextPath:"+contextPath+" projectRealPath:"+projectRealPath);
		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
		StringBuffer sbf = new StringBuffer();
		for(String n:ctx.getBeanDefinitionNames()){
			Object bean = ctx.getBean(n);
			if(bean instanceof DruidDataSource){
				sbf.append("beanName:"+n+" beanType:"+bean.getClass().getName()+" toString:druid dataSource\n");
			}else{
				sbf.append("beanName:"+n+" beanType:"+bean.getClass().getName()+" toString:"+bean.toString()+"\n");
			}
		}
		log.info("bean count: "+ctx.getBeanDefinitionCount()+"\n***bean detai start***\n"+sbf.toString()+"***bean detail end***");
	}

	public static String getProjectRealPath() {
		return projectRealPath;
	}

	public static String getContextPath() {
		return contextPath;
	}
	

}
