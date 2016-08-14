package com.lc.crm.dk.base.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.util.codec.AESUtil;
import com.lc.crm.dk.base.util.codec.DecriptUtil;
import com.lc.crm.dk.base.util.cookie.CookieUtils;
import com.lc.crm.dk.business.dto.User;

public class SessionHandler {
	/**
	 * 用户登录合法性校验
	 * @return
	 */
	public static boolean checkLogin(HttpServletRequest request,HttpServletResponse response){
		String loginUserInfo = CookieUtils.getCookie(request, Constant.LOGIN_USER_INFO);
		if(StringUtils.isEmpty(loginUserInfo)){
			return false;
		}
		JSONObject jsonObj = JSON.parseObject(loginUserInfo);
		//签名合法性和过期判断
		String securityUser = jsonObj.getString("securityUser");
		Long timeStamp = jsonObj.getLong("timeStamp");
		String randomStr = jsonObj.getString("randomStr");
		String sign = jsonObj.getString("sign");
		
		if(System.currentTimeMillis()-timeStamp>1800000){
			//30分钟过期判断
			return false;
		}
		//签名校验
		String realSign = DecriptUtil.MD5(securityUser+""+timeStamp+""+randomStr+""+Constant.SIGN_SECURITY_KEY);
		if(!realSign.equals(sign)){
			//签名不合法
			return false;
		}
		return true;
	}
	
	
	public static boolean checkAdmin(HttpServletRequest request,HttpServletResponse response){
		//和checkLoginEmp方法大部分相同，可以提出来公共的
		String loginUserInfo = CookieUtils.getCookie(request, Constant.LOGIN_USER_INFO);
		if(StringUtils.isEmpty(loginUserInfo)){
			return false;
		}
		JSONObject jsonObj = JSON.parseObject(loginUserInfo);
		//签名合法性和过期判断
		String securityUser = jsonObj.getString("securityUser");
		Long timeStamp = jsonObj.getLong("timeStamp");
		String randomStr = jsonObj.getString("randomStr");
		String sign = jsonObj.getString("sign");
		
		if(System.currentTimeMillis()-timeStamp>1800000){
			//30分钟过期判断
			return false;
		}
		//签名校验
		String realSign = DecriptUtil.MD5(securityUser+""+timeStamp+""+randomStr+""+Constant.SIGN_SECURITY_KEY);
		if(!realSign.equals(sign)){
			//签名不合法
			return false;
		}
		//是否是管理员
		User loginUser = JSON.parseObject(AESUtil.decrypt(securityUser, Constant.LOGINUSER_SECURITY_KEY), User.class);
		if(loginUser.getType()==1){
			return true;
		}
		return false;
	}
}
