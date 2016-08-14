package com.lc.crm.dk.business.mapper;

import java.util.List;
import java.util.Map;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.StuCourseFlow;

public interface StuCourseFlowMapper extends BaseMapper<StuCourseFlow>{
	void addStuCourseFlow(Map<String, Object> map);
	/**
	 * 查询学生的课程流水
	 * @return
	 */
	List<StuCourseFlow> queryStuCourseFlowBySelective(Map<String, Object> map);
}
