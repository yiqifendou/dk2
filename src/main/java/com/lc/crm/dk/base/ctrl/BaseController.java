package com.lc.crm.dk.base.ctrl;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSON;
import com.lc.crm.dk.business.dto.ResponseVo;

public class BaseController {
	protected Log log = LogFactory.getLog(this.getClass());
	
	
	/**
	 * 将数据相应到客户端
	 * 
	 * @param data
	 */
	protected void responseToBrowser(HttpServletResponse response,String data) {
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write(data);
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 将数据相应到客户端
	 * 
	 * @param data
	 */
	protected void responseToBrowser(HttpServletResponse response,ResponseVo vo) {
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write(JSON.toJSONString(vo));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	/**
	 * 输出带有status和msg的json
	 * @param status
	 * @param msg
	 */
	public void responseBrowser(HttpServletResponse response,int status,String msg){
		String json = "{\"status\":"+status+",\"msg\":\""+msg+"\"}";
		responseToBrowser(response,json);
	}
	
}
