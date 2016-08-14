package com.lc.crm.dk.business.dto;

import java.io.Serializable;
import java.util.Date;

import com.lc.crm.dk.business.util.DateUtil;

public class Student implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String phone;
	//联系人，家长姓名
	private String contactName;
	//总充值费用
	private Integer totalFee;
	//0:删除  1:正常
	private Integer stus;
	private Date birthday;
	private String school;
	private String openId;
	private String remark;
	private Date createTime;
	private Date updateTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public Integer getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(Integer totalFee) {
		this.totalFee = totalFee;
	}
	public Integer getStus() {
		return stus;
	}
	public void setStus(Integer stus) {
		this.stus = stus;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getSimpleBirthday(){
		return birthday==null?"":DateUtil.formatDate(birthday);
	}
	
}
