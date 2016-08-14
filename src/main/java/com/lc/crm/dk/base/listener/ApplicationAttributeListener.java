package com.lc.crm.dk.base.listener;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Wzb
 * @version 2014-9-9
 * @description spring容器属性监听器,spring容器其实就是ServletContext
 */
public class ApplicationAttributeListener implements ServletContextAttributeListener{
	Log log = LogFactory.getLog(this.getClass());

	@Override
	public void attributeAdded(ServletContextAttributeEvent servletContextAttributeEvent) {
		log.info("servletContext addAttribute: key:"+servletContextAttributeEvent.getName()+" val:"+servletContextAttributeEvent.getValue());
	}

	@Override
	public void attributeRemoved(ServletContextAttributeEvent servletContextAttributeEvent) {
		log.info("servletContext removedAttribute: key"+servletContextAttributeEvent.getName()+" val:"+servletContextAttributeEvent.getValue());
	}
 
	@Override
	public void attributeReplaced(ServletContextAttributeEvent servletContextAttributeEvent) {
		log.info("servletContext replacedAttribute:"+servletContextAttributeEvent.getName()+" val:"+servletContextAttributeEvent.getValue());
	}


}
