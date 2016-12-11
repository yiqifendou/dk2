package com.lc.crm.dk.base.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.util.codec.AESUtil;
import com.lc.crm.dk.base.util.codec.DecriptUtil;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import java.io.UnsupportedEncodingException;
import static com.alibaba.fastjson.JSON.parseObject;

/**
 * Created by yiqifendou on 2016/12/10.
 */
public class EncryptionUtil {

    /**
     * 信息aes加密+签名
     * @param obj
     * @return
     */
    public static String encrypt(Object obj){
        //aes加密后的用户信息
        String securityInfo = AESUtil.encrypt(JSON.toJSONString(obj), Constant.OTHER_INFO_SECURITY_KEY);
        long timeStamp = System.currentTimeMillis();
        String randomStr = RandomStrUtil.generateStr(6);
        String sign = DecriptUtil.MD5(securityInfo+""+timeStamp+""+randomStr+""+Constant.SIGN_SECURITY_KEY);
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("securityInfo", securityInfo);
        jsonObj.put("timeStamp", timeStamp);
        jsonObj.put("randomStr", randomStr);
        jsonObj.put("sign", sign);
        return encodeBase64(jsonObj.toJSONString());
    }

    /**
     * 信息aes解密，并校验签名
     * @param encryInfo
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> DecryptResult<T> decrypt(String encryInfo,Class<T> clazz){
        boolean rightSign = false;
        T t = null;
        if(StringUtils.isNotBlank(encryInfo)){
            String tempInfo = decodeBase64(encryInfo);
            JSONObject jsonObj = parseObject(tempInfo);
            //判断签名是否合法
            String securityInfo = jsonObj.getString("securityInfo");
            String timeStamp = jsonObj.getString("timeStamp");
            String randomStr = jsonObj.getString("randomStr");
            String sign = jsonObj.getString("sign");
            rightSign = checkSign(sign,securityInfo,timeStamp,randomStr);
            if(rightSign){
                t = JSON.parseObject(AESUtil.decrypt(securityInfo, Constant.OTHER_INFO_SECURITY_KEY), clazz);
            }
        }
        return new DecryptResult(t,rightSign);
    }

    public static class DecryptResult<T>{
        private T t;
        private boolean rightSign;

        public DecryptResult() {
        }

        public DecryptResult(T t, boolean rightSign) {
            this.t = t;
            this.rightSign = rightSign;
        }

        public T getT() {
            return t;
        }

        public void setT(T t) {
            this.t = t;
        }

        public boolean isRightSign() {
            return rightSign;
        }

        public void setRightSign(boolean rightSign) {
            this.rightSign = rightSign;
        }
    }


    /**
     * 签名校验
     * @param sign
     * @param securityInfo
     * @param timeStamp
     * @param randomStr
     * @return
     */
    public static boolean checkSign(String sign,String securityInfo,String timeStamp,String randomStr){
        return sign.equals(DecriptUtil.MD5(securityInfo+""+timeStamp+""+randomStr+""+Constant.SIGN_SECURITY_KEY));
    }



    public static String encodeBase64(String info){
        String encodeBase64String = null;
        try {
            encodeBase64String = Base64.encodeBase64String(info.getBytes("UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            //ignore
        }
        return encodeBase64String;
    }

    public static String decodeBase64(String encodeInfo){
        String info = null;
        try {
            info = new String(Base64.decodeBase64(encodeInfo),"UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return info;
    }
    
}
