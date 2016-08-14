package com.lc.crm.dk.business.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.service.BaseService;
import com.lc.crm.dk.business.dto.StuCourseFlow;

public interface StuCourseFlowService extends BaseService<StuCourseFlow>{
	/**
	 * 查询学生的课程流水
	 * @param map
	 * @param request
	 * @return
	 */
	Paging<StuCourseFlow> queryStuCourseFlowJUIPageByStudentId(Map<String, Object> map,HttpServletRequest request);
	
	/**
	 * 条件查询
	 * @param map
	 * @return
	 */
	List<StuCourseFlow> queryStuCourseFlowBySelective(Map<String, Object> map);
}
