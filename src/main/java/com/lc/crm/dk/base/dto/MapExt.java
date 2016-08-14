package com.lc.crm.dk.base.dto;

import java.security.InvalidParameterException;
import java.util.HashMap;

@SuppressWarnings("all")
public class MapExt<K, V> extends HashMap<K, V>{
	public MapExt(){
		
	}
	
	public MapExt(Object... kvPair){
		if(kvPair.length%2!=0){
			throw new InvalidParameterException("kv必须成对存在");
		}
		for(int i=0;i<kvPair.length;i=i+2){
			this.put((K)kvPair[i], (V)kvPair[i+1]);
		}
	}
	
	public MapExt<K, V> putKV(K k,V v){
		this.put(k, v);
		return this;
	}
}
