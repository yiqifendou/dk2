package com.lc.crm.dk.base.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.github.pagehelper.PageInfo;
import com.lc.crm.dk.base.dto.Paging;


/**
 * 如果需要影响行数等返回值的，请在子类另行写
 * @author yiqifendou
 *
 * @param <T>
 */
public interface BaseService<T extends Serializable> {
	void deleteByPrimaryKey(Integer id);

	void insert(T record);

	void insertSelective(T record);

    T selectByPrimaryKey(Integer id);

    void updateByPrimaryKeySelective(T record);

    void updateByPrimaryKey(T record);
    
    List<T> queryAll();
    
    List<T> queryByT(T record);
    
    List<T> queryByMap(HashMap<Object, Object> paramsMap);
    
    PageInfo<T> queryPage(int pageNum,int pageSize);
    
    PageInfo<T> queryPageByT(T record,int pageNum,int pageSize);
    
    PageInfo<T> queryPageByMap(HashMap<String, Object> paramsMap,int pageNum,int pageSize);
    
    Paging<T> queryJUIPage(HashMap<String, Object> map,HttpServletRequest request);
    
}
