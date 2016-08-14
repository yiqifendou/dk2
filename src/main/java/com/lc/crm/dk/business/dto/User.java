package com.lc.crm.dk.business.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import com.lc.crm.dk.business.util.DateUtil;

public class User implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String account;
	private String password;
	private String name;
	private String phone;
	//身份类型：0：普通教师，1：管理员
	private Integer type;
	//入职时间
	private Date entryTime;
	//代教的课程列表，以英文逗号分割
	private String courseArr;
	private List<Course> courseList;
	//用户状态 1：正常，0：冻结
	private Integer stus;
	private String remark;
	private Date createTime;
	private Date updateTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Date getEntryTime() {
		return entryTime;
	}
	public void setEntryTime(Date entryTime) {
		this.entryTime = entryTime;
	}
	public String getCourseArr() {
		return courseArr;
	}
	public void setCourseArr(String courseArr) {
		this.courseArr = courseArr;
	}
	public Integer getStus() {
		return stus;
	}
	public void setStus(Integer stus) {
		this.stus = stus;
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
	public List<Course> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<Course> courseList) {
		this.courseList = courseList;
	}
	public String getSimpleEntryTime(){
		return entryTime==null?"":DateUtil.formatDate(entryTime);
	}
}
