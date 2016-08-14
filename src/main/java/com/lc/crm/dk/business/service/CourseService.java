package com.lc.crm.dk.business.service;


import java.util.Map;
import com.lc.crm.dk.base.service.BaseService;
import com.lc.crm.dk.business.dto.Course;

public interface CourseService extends BaseService<Course>{
	public Map<Integer, Course> queryAllCourseMap();
}
