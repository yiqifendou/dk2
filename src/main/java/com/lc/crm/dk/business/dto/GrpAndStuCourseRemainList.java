package com.lc.crm.dk.business.dto;

import java.util.List;

/**
 * 班级及其下面关联的学生剩余课时集合
 * @author yiqifendou
 *
 */
public class GrpAndStuCourseRemainList {
	private Grp grp;
	private List<StuCourseRemain> stuCourseRemainList;
	public Grp getGrp() {
		return grp;
	}
	public void setGrp(Grp grp) {
		this.grp = grp;
	}
	public List<StuCourseRemain> getStuCourseRemainList() {
		return stuCourseRemainList;
	}
	public void setStuCourseRemainList(List<StuCourseRemain> stuCourseRemainList) {
		this.stuCourseRemainList = stuCourseRemainList;
	}
	public int getCanStudyAll(){
		if(grp.getCourseType()==1 && stuCourseRemainList.size()>0){
			return 1;
		}
		return 0;
	}
}
