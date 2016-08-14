package com.lc.crm.dk.business.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.impl.BaseServiceImpl;
import com.lc.crm.dk.business.dto.TeacherWorkFlow;
import com.lc.crm.dk.business.mapper.TeacherWorkFlowMapper;
import com.lc.crm.dk.business.service.TeacherWorkFlowService;

@Service
public class TeacherWorkFlowServiceImpl extends BaseServiceImpl<TeacherWorkFlow> implements TeacherWorkFlowService{
	@Autowired
	private TeacherWorkFlowMapper teacherWorkFlowMapper;
	
	@Override
	public BaseMapper<TeacherWorkFlow> getBaseMapper() {
		return teacherWorkFlowMapper;
	}


}
