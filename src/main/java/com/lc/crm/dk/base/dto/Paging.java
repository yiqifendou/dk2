package com.lc.crm.dk.base.dto;

import java.util.List;

import com.lc.crm.dk.base.constant.Constant;

public class Paging<T> {
	private Object paramsObj;
	private List<T> dataList;
	private Long totalCount;
	private Integer pageNum;
	private int numPerPage;
	private int totalPage;
	public Object getParamsObj() {
		return paramsObj;
	}
	public void setParamsObj(Object paramsObj) {
		this.paramsObj = paramsObj;
	}
	public List<T> getDataList() {
		return dataList;
	}
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	public Long getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Long totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getPageNum() {
		return pageNum;
	}
	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	
	public long getPageNumShown(){
		return totalPage>Constant.Page.DEFAULT_SHOWPAGES?Constant.Page.DEFAULT_SHOWPAGES:totalPage;
	}
	
	public void setTotalPage(int totalPage){
		this.totalPage = totalPage;
	}
	
	public int getTotalPage(){
		return totalPage;
	}
}
