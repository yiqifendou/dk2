package com.lc.crm.dk.base.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author Wzb
 * @version 2014-9-9
 * @description 
 */
public class SessionListener implements HttpSessionListener{
	Log log = LogFactory.getLog(this.getClass());
	
	@Override
	public void sessionCreated(HttpSessionEvent httpSessionEvent) {
		log.info("create httpsession id："+httpSessionEvent.getSession().getId());
	}
	@Override
	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
		log.info("destory httpsession id:"+httpSessionEvent.getSession().getId());
	}

}
