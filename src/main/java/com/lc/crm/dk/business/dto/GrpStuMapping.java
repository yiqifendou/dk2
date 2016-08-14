package com.lc.crm.dk.business.dto;

import java.io.Serializable;
import java.util.Date;

public class GrpStuMapping implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer studentId;
	private Integer grpId;
	private Date createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStudentId() {
		return studentId;
	}
	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}
	public Integer getGrpId() {
		return grpId;
	}
	public void setGrpId(Integer grpId) {
		this.grpId = grpId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
