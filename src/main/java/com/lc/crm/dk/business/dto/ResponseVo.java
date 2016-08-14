package com.lc.crm.dk.business.dto;

import com.lc.crm.dk.base.constant.Constant;

public class ResponseVo {
	private Integer status = Constant.Code.STATUS_OK;
	private String msg = "操作成功";
	private Object data;
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
}
