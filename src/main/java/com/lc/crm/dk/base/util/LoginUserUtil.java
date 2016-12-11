package com.lc.crm.dk.base.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.util.codec.AESUtil;
import com.lc.crm.dk.base.util.codec.DecriptUtil;
import com.lc.crm.dk.base.util.cookie.CookieUtils;
import com.lc.crm.dk.business.dto.User;

public class LoginUserUtil {
	/**
	 * 保存登录用户
	 * @param resp
	 * @param loginUser
	 */
	public static void saveLoginUser(HttpServletResponse resp,User loginUser){
		//aes加密后的用户信息
		String securityUser = AESUtil.encrypt(JSON.toJSONString(loginUser), Constant.LOGINUSER_SECURITY_KEY);
		long timeStamp = System.currentTimeMillis();
		String randomStr = RandomStrUtil.generateStr(6);
		String sign = DecriptUtil.MD5(securityUser+""+timeStamp+""+randomStr+""+Constant.SIGN_SECURITY_KEY);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("securityUser", securityUser);
		jsonObj.put("timeStamp", timeStamp);
		jsonObj.put("randomStr", randomStr);
		jsonObj.put("sign", sign);
		Cookie cookie = new Cookie(Constant.LOGIN_USER_INFO, jsonObj.toJSONString()); 
		cookie.setPath("/");
		cookie.setMaxAge(86400); 
		resp.addCookie(cookie);
	}
	
	public static void delLoginUser(HttpServletResponse resp){
		Cookie cookie = new Cookie(Constant.LOGIN_USER_INFO, null);
		cookie.setPath("/");
		cookie.setMaxAge(0);
		resp.addCookie(cookie);
	}
	
	/**
	 * 获取登录的用户信息
	 * @return
	 */
	public static User getLoginUser(HttpServletRequest req,HttpServletResponse resp){
		String loginUserInfo = CookieUtils.getCookie(req, Constant.LOGIN_USER_INFO);
		//解密,非空性，合法性等判断统一在filter中判断哦
		JSONObject jsonObj = JSON.parseObject(loginUserInfo);
		User loginUser = JSON.parseObject(AESUtil.decrypt(jsonObj.getString("securityUser"), Constant.LOGINUSER_SECURITY_KEY), User.class);
		return loginUser;
	}
	
	
}
