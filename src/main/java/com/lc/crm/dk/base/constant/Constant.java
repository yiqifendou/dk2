package com.lc.crm.dk.base.constant;

import com.lc.crm.dk.base.listener.ApplicationListener;
import com.lc.crm.dk.base.util.RandomStrUtil;
import com.lc.crm.dk.base.util.codec.AESUtil;

/**
 * 常量
 * @author Administrator
 *
 */
public interface Constant {
	
	String CONTEXTPATH = ApplicationListener.getContextPath();
	
	String LOGIN_USER_INFO = "loginUserInfo";
	//用户信息加密key
	String LOGINUSER_SECURITY_KEY = AESUtil.generateKey();
    //其他信息加密key
    String OTHER_INFO_SECURITY_KEY = AESUtil.generateKey();
	//md5签名key
	String SIGN_SECURITY_KEY = RandomStrUtil.generateStr(10);
	//默认登录密码
	String DEFAULT_LOGIN_PWD = "lc365";
	//系统异常错误信息
	String SYSTEM_BUSY = "系统繁忙！";
	
	public static interface Code{
		//成功
		int STATUS_OK = 0;
		//服务器出错
		int STATUS_EXCEPTION = -1;
		//权限不足
		int STATUS_NOAUTH = -2;
		//用户已经存在
		int ACCOUNT_EXIST = 1001;
		//账号已被冻结，请联系管理员
		int USER_INVALID = 1002;
		//登录失败，用户名或密码错误
		int PWD_ERROR = 1003;
		//用户不存在
		int USER_NOTEXIST = 1004;
		//原密码错误
		int OLDPWD_ERROR = 1005;
		//2次输入的密码不匹配
		int NEWPWD_NOT_MATCH = 1006;
		//该号码不存在
		int PHONE_NOT_EXIST = 1007;
        //该号码不存在
        int REPEAT_BIND_WEIXIN = 1008;
	}
	
	public interface Page{
		public static final Integer DEFAULT_PAGESIZE = 20;
		public static final Long DEFAULT_SHOWPAGES = 10L;
	}
	
	public interface Weixin{
		public static final String ORGIN_ID = "gh_0a5d51535520";
		public static final String APP_ID = "wxf164e9705090cf0e";
		public static final String APP_SECRET = "c135130c76e09949b4c5d6cb28c203aa";
		public static final String TOKEN = "111";
	}
	
	
}
