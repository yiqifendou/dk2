package com.lc.crm.dk.business.service;

import java.util.List;
import java.util.Map;

import com.lc.crm.dk.base.service.BaseService;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.Student;

public interface StudentService extends BaseService<Student>{
	Student queryByNameAndPhone(Student stu);
	List<Student> queryStusByGrpId(Grp grp);
	/**
	 * 充值课程
	 * @param map
	 */
	void rechargeCourse(Map<String, Object> map);
	/**
	 * 点课
	 * @param map
	 */
	void batchStudyCourse(List<Map<String,Object>> mapList);
	
	List<Student> queryStusByPhone(String phone);
}
