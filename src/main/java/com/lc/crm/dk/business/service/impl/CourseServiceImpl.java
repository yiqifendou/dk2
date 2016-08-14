package com.lc.crm.dk.business.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.impl.BaseServiceImpl;
import com.lc.crm.dk.business.dto.Course;
import com.lc.crm.dk.business.mapper.CourseMapper;
import com.lc.crm.dk.business.service.CourseService;

@Service
public class CourseServiceImpl extends BaseServiceImpl<Course> implements CourseService{
	@Autowired 
	private CourseMapper courseMapper;
	
	@Override
	public BaseMapper<Course> getBaseMapper() {
		return courseMapper;
	}

	@Override
	public Map<Integer, Course> queryAllCourseMap() {
		List<Course> allCourse = courseMapper.queryAll();
		Map<Integer, Course> courseMap = new HashMap<Integer,Course>();
		for(Course c:allCourse){
			courseMap.put(c.getId(), c);
		}
		return courseMap;
	}

}
