package com.lc.crm.dk.base.handler;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

/**
 * 拓展spring的异常处理器，让freemarker可以显示异常堆栈信息
 * @author Administrator
 *
 */
public class ExpandSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver{
	@Override
	protected ModelAndView getModelAndView(String viewName, Exception ex) {
		ModelAndView mv = super.getModelAndView(viewName, ex);
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		PrintStream ps = new PrintStream(bos);
		try {
			ex.printStackTrace(ps);
			String stackTraceStr = new String(bos.toByteArray(), "UTF-8");
			mv.addObject("stackTrace", stackTraceStr);
		}catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}finally{
			try {
				ps.close();
				bos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return mv;
	}
}
