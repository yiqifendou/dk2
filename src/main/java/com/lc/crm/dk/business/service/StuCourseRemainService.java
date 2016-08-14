package com.lc.crm.dk.business.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.service.BaseService;
import com.lc.crm.dk.business.dto.StuCourseRemain;

public interface StuCourseRemainService extends BaseService<StuCourseRemain>{
	List<StuCourseRemain> queryCanJoinGrp(Map<String, Object> map);
	List<StuCourseRemain> queryStusRemainByCourseId(Map<String, Object> map);
	/**
	 * 课程报警
	 * @return
	 */
	Paging<StuCourseRemain> queryCourseRemainJUIPage(Map<String, Object> map,HttpServletRequest request);
	
	
	/**
	 * 查询某个学生还有余课的科目
	 * @param studentId
	 * @return
	 */
	List<StuCourseRemain> queryHasRemainCouseByStudentId(int studentId);
	
	/**
	 * 根据家长号码，查询学生剩余课程
	 * @param map
	 * @return
	 */
	List<StuCourseRemain> queryStuCourseRemainListByPhone(Map<String, Object> map);
}
