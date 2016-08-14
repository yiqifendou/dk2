package com.lc.crm.dk.base.mapper;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

/**
 * 如果需要影响行数等返回值的，请在子类另行写
 * @author yiqifendou
 *
 * @param <T>
 */
public interface BaseMapper<T extends Serializable> {
	void deleteByPrimaryKey(Integer id);

    void insert(T record);

    int insertSelective(T record);

    T selectByPrimaryKey(Integer id);

    void updateByPrimaryKeySelective(T record);

    void updateByPrimaryKey(T record);
    
    List<T> queryAll();
    
    List<T> queryByT(T record);
    
    List<T> queryByMap(HashMap<Object, Object> paramsMap);
    
    List<T> queryPageByT(T record);
    
    List<T> queryPageByMap(HashMap<String, Object> paramsMap);
    
   
    
}
