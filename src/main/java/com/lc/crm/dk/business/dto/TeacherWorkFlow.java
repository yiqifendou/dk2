package com.lc.crm.dk.business.dto;

import java.io.Serializable;
import java.util.Date;

public class TeacherWorkFlow implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private Integer teacherId;
	private String teacherName;
	private Integer courseId;
	private String courseName;
	private Integer courseCount;
	private Integer stuCount;
	private String remark;
	private Date createTime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Integer getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public Integer getCourseCount() {
		return courseCount;
	}
	public void setCourseCount(Integer courseCount) {
		this.courseCount = courseCount;
	}
	public Integer getStuCount() {
		return stuCount;
	}
	public void setStuCount(Integer stuCount) {
		this.stuCount = stuCount;
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
}
