package com.lc.crm.dk.base.util.codec;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Random;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

public class AESUtil {
	
	/**
	 * 生成1个16字节(128位)的aes密钥
	 * @return
	 */
	public static String generateKey(){
		StringBuilder sbd = new StringBuilder("");
		for(int i=0;i<16;i++){
			sbd.append(getChar());
		}
		return sbd.toString();
	}
	
	private static char getChar(){
		//48-57(0-9) 65-90(A-Z) 97-122(a-z)
		Random r = new Random();
		int l = r.nextInt(3);
		if(l==0){
			return (char)(r.nextInt(10)+48);
		}else if(l==1){
			return (char)(r.nextInt(26)+65);
		}else{
			return (char)(r.nextInt(26)+97);
		}
	} 

	/**
	 * 获取base64(aes(明文))的加密结果
	 * 
	 * @param content
	 *            需要加密的内容
	 * @param aesKey
	 *            密钥
	 * @return
	 */
	public static String encrypt(String content, String aesKey) {
		try {
			
			byte[] byteContent = content.getBytes("utf-8");
			
			//设置AES加密模式为AES/ECB/PKCS5Padding(密钥必须为128位)
			SecretKeySpec key = new SecretKeySpec(aesKey.getBytes(), "AES");
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, key);
			
			//aes加密
			byte[] result = cipher.doFinal(byteContent);
			
			//base加密
			return Base64.encodeBase64String(result);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 解密
	 * 
	 * @param content
	 *            需要解密的密文
	 * @param password
	 *            加密密码
	 * @return
	 */
	public static String decrypt(String content, String aesKey) {
		try {
			//设置AES解密模式为AES/ECB/PKCS5Padding(密钥必须为128位)
			SecretKeySpec key = new SecretKeySpec(aesKey.getBytes(), "AES");
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, key);
			
			//加密的逆过程，先base解密在aes解密,最后生成原字符串
			byte[] result = cipher.doFinal(Base64.decodeBase64(content));
			return new String(result,"utf-8");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 测试工具路径"http://www.seacha.com/tools/aes.html"
	 * @param args
	 */
	public static void main(String[] args) {
		String str = "今天天气真不错啊";
		System.out.println("明文："+str);
		String key = generateKey();
		System.out.println("密钥为:"+key);
		
		long s1 = new Date().getTime();
		String eStr = encrypt(str, key);
		long s2 = new Date().getTime();
		System.out.println("加密后:"+eStr+"\r\n耗时:"+(s2-s1));
		
		long s3 = new Date().getTime();
		String dStr = decrypt(eStr, key);
		long s4 = new Date().getTime();
		System.out.println("解密后:"+dStr+"\r\n耗时:"+(s4-s3));
	}

}
