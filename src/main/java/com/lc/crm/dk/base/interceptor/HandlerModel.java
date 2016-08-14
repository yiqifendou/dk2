package com.lc.crm.dk.base.interceptor;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * session拦截器处理实体对象
 * 
 * @author yiqifendou
 * 
 */
public class HandlerModel {
	// 处理类
	private String handleClass;
	// 处理方法
	private String handleMethod;
	// false时跳转的页面，最多可以传一个参数，多个参数要转义
	private String errorRequestMapping;
	// 需要过滤的方法
	private String requestMappingsReg;
	private Method dealMethod;

	public HandlerModel() {

	}
	
	public HandlerModel(String handleClass, String handleMethod, String errorRequestMapping, String requestMappingsReg) {
		this.handleClass = handleClass;
		this.handleMethod = handleMethod;
		this.errorRequestMapping = errorRequestMapping;
		this.requestMappingsReg = requestMappingsReg;
		try {
			dealMethod = Class.forName(handleClass).getMethod(handleMethod, HttpServletRequest.class,HttpServletResponse.class);
		} catch (NoSuchMethodException | SecurityException | ClassNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException(handleClass+"类中"+handleMethod+"必须要有request,response参数 ,exception detail"+e.getMessage());
		}
	}


	public String getHandleClass() {
		return handleClass;
	}

	public void setHandleClass(String handleClass) {
		this.handleClass = handleClass;
	}

	public String getHandleMethod() {
		return handleMethod;
	}

	public void setHandleMethod(String handleMethod) {
		this.handleMethod = handleMethod;
	}

	public String getErrorRequestMapping() {
		return errorRequestMapping;
	}

	public void setErrorRequestMapping(String errorRequestMapping) {
		this.errorRequestMapping = errorRequestMapping;
	}

	public String getRequestMappingsReg() {
		return requestMappingsReg;
	}

	public void setRequestMappingsReg(String requestMappingsReg) {
		this.requestMappingsReg = requestMappingsReg;
	}

	public Method getDealMethod() {
		return dealMethod;
	}

	public void setDealMethod(Method dealMethod) {
		this.dealMethod = dealMethod;
	}


}
