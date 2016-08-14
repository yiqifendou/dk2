package com.lc.crm.dk.business.dto;

import java.io.Serializable;
import java.util.Date;

public class StuCourseFlow implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer studentId;
	private Student student;
	private Integer courseId;
	private Course course;
	//0:消费   1:增加  2:赠送
	private Integer type;
	//操作人id
	private Integer operateId;
	private User operator;
	private Integer courseCount;
	//充值金额
	private Integer rechargeFee;
	private String remark;
	private Date createTime;
	private String teacherWorkId;
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getOperateId() {
		return operateId;
	}
	public void setOperateId(Integer operateId) {
		this.operateId = operateId;
	}
	public Integer getCourseCount() {
		return courseCount;
	}
	public void setCourseCount(Integer courseCount) {
		this.courseCount = courseCount;
	}
	public Integer getRechargeFee() {
		return rechargeFee;
	}
	public void setRechargeFee(Integer rechargeFee) {
		this.rechargeFee = rechargeFee;
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
	public User getOperator() {
		return operator;
	}
	public void setOperator(User operator) {
		this.operator = operator;
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
	public String getTeacherWorkId() {
		return teacherWorkId;
	}
	public void setTeacherWorkId(String teacherWorkId) {
		this.teacherWorkId = teacherWorkId;
	}
}
