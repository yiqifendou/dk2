package com.lc.crm.dk.base.interceptor;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

@SuppressWarnings("all")
public class SessionInterceptorContext {
	static final List<HandlerModel> handlerModelList = new ArrayList<HandlerModel>();
	static {
		InputStream is = SessionInterceptorContext.class.getResourceAsStream("/conf/intercept/sessionIntercept.xml"); 
		try {
			SAXReader saxReader = new SAXReader();
			Document doc = saxReader.read(is);
			Element sessionIntercepts = doc.getRootElement();
			List<Element> sessionInterceptList = sessionIntercepts.elements("sessionIntercept");
			for (Element siEle : sessionInterceptList) {
				String requestMappingsReg = "";
				String[] requestMappingsArray = siEle.elementText("requestMappings").split(",");
				for(String rm:requestMappingsArray){
					requestMappingsReg += "|(" + rm.trim().replaceAll("\\.", "\\\\.").replaceAll("\\*", ".\\*") + ")";
				}
				requestMappingsReg = "".equals(requestMappingsReg) ? "" : requestMappingsReg.substring(1);
				HandlerModel hm = new HandlerModel(siEle.attributeValue("handleClass"), siEle.attributeValue("handleMethod"), 
						siEle.attributeValue("errorRequestMapping"), requestMappingsReg);
				handlerModelList.add(hm);
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
