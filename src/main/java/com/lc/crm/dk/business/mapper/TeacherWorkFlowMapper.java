package com.lc.crm.dk.business.mapper;

import java.util.Map;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.TeacherWorkFlow;

public interface TeacherWorkFlowMapper extends BaseMapper<TeacherWorkFlow>{
	/**
	 * 查询总课时数量
	 * @param map
	 * @return
	 */
	public int queryTotalCourseCount(Map<String, Object> map);
}
