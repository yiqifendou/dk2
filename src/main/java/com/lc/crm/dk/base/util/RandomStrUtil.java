package com.lc.crm.dk.base.util;

import java.util.Random;

public class RandomStrUtil {
	
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
	
	public static String generateStr(int len){
		StringBuilder sbd = new StringBuilder("");
		for(int i=0;i<len;i++){
			sbd.append(getChar());
		}
		return sbd.toString();
	}
}
