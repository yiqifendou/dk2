package com.lc.crm.dk.business.util;

import com.lc.crm.dk.base.util.codec.DecriptUtil;

public class PwdUtil {
	private static String key = "LCCRM_";
	public static String encoding(String realPwd){
		return DecriptUtil.MD5(key+realPwd);
	}
}
