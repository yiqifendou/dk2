package com.lc.crm.dk.business.dto;

import java.io.Serializable;
import java.util.Date;

public class StuCourseRemain implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer studentId;
	private Student student;
	private Integer courseId;
	private Course course;
	private Integer remain;
	private Integer alreadyStudy;
	private Date createTime;
	private Date updateTime;
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
	public Integer getCourseId() {
		return courseId;
	}
	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}
	public Integer getRemain() {
		return remain;
	}
	public void setRemain(Integer remain) {
		this.remain = remain;
	}
	public Integer getAlreadyStudy() {
		return alreadyStudy;
	}
	public void setAlreadyStudy(Integer alreadyStudy) {
		this.alreadyStudy = alreadyStudy;
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
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
	
}
