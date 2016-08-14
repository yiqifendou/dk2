package com.lc.crm.dk.base.service.impl;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.BaseService;

/**
 * 如果需要影响行数等返回值的，请在子类另行写
 * @author yiqifendou
 *
 * @param <T>
 */
public abstract class BaseServiceImpl<T extends Serializable> implements BaseService<T>{
	
	/**
	 * 由子类实现
	 * @return
	 */
	public abstract BaseMapper<T> getBaseMapper();
	
	@Override
	public void deleteByPrimaryKey(Integer id) {
		getBaseMapper().deleteByPrimaryKey(id);
	}

	@Override
	public void insert(T record) {
		getBaseMapper().insert(record);
	}

	@Override
	public void insertSelective(T record) {
		getBaseMapper().insertSelective(record);
	}

	@Override
	public T selectByPrimaryKey(Integer id) {
		return getBaseMapper().selectByPrimaryKey(id);
	}

	@Override
	public void updateByPrimaryKeySelective(T record) {
		getBaseMapper().updateByPrimaryKeySelective(record);
	}

	@Override
	public void updateByPrimaryKey(T record) {
		getBaseMapper().updateByPrimaryKey(record);
	}
	
	@Override
	public List<T> queryAll(){
		return getBaseMapper().queryAll();
	}
	
	    
	@Override
    public List<T> queryByT(T record){
    	return getBaseMapper().queryByT(record);
    }
    
	@Override
    public List<T> queryByMap(HashMap<Object, Object> paramsMap){
		return getBaseMapper().queryByMap(paramsMap);
	}
	
	
	@Override
    public PageInfo<T> queryPage(int pageNum,int pageSize){
		PageHelper.startPage(pageNum, pageSize);
		//其实page对象是arrayList的子类，该对象含有很多分页信息，但是el无法拿出来，所以用pageInfo封装一下
		List<T> page = getBaseMapper().queryAll();
		PageInfo<T> pi = new PageInfo<T>(page);
		return pi;
    }
    
	
    @Override
    public PageInfo<T> queryPageByT(T t,int pageNum,int pageSize){
		PageHelper.startPage(pageNum, pageSize);
		//其实page对象是arrayList的子类，该对象含有很多分页信息，但是el无法拿出来，所以用pageInfo封装一下
		List<T> page = getBaseMapper().queryPageByT(t);
		PageInfo<T> pi = new PageInfo<T>(page);
		return pi;
    }
    
	
	@Override
    public PageInfo<T> queryPageByMap(HashMap<String, Object> paramsMap,int pageNum,int pageSize){
		PageHelper.startPage(pageNum, pageSize);
		//其实page对象是arrayList的子类，该对象含有很多分页信息，但是el无法拿出来，所以用pageInfo封装一下
		List<T> page = getBaseMapper().queryPageByMap(paramsMap);
		PageInfo<T> pi = new PageInfo<T>(page);
		return pi;
    }
	
	
	@Override
	public Paging<T> queryJUIPage(HashMap<String, Object> map,HttpServletRequest request) {
		Integer pageNum = StringUtils.isNotEmpty(request.getParameter("pageNum")) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
		Integer numPerPage = StringUtils.isNotEmpty(request.getParameter("numPerPage"))	? Integer.parseInt(request.getParameter("numPerPage")) : Constant.Page.DEFAULT_PAGESIZE;
		
		PageInfo<T> pi = this.queryPageByMap(map, pageNum, numPerPage);
		
		Paging<T> p = new Paging<T>();
		p.setParamsObj(map);
		p.setDataList(pi.getList());
		p.setTotalCount(pi.getTotal());
		p.setPageNum(pageNum);
		p.setNumPerPage(numPerPage);
		p.setTotalPage(pi.getPages());
		return p;
	}

}
