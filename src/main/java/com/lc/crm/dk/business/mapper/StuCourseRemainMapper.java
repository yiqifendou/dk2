package com.lc.crm.dk.business.mapper;

import java.util.List;
import java.util.Map;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.StuCourseRemain;

public interface StuCourseRemainMapper extends BaseMapper<StuCourseRemain>{
	List<StuCourseRemain> queryCanJoinGrpStuIds(Map<String, Object> map);
	List<StuCourseRemain> queryStusRemainByCourseId(Map<String, Object> map);
	/**
	 * 以下是关于学生课程剩余的重置和点课等操作的sql
	 * @param map
	 * @return
	 */
	StuCourseRemain queryStusRemainByCourseIdAndStuId(Map<String, Object> map);
	void insertCourseRemian(Map<String, Object> map);
	void addCourseRemain(Map<String, Object> map);
	int reduceCourseRemain(Map<String, Object> map);
	
	/**
	 * 课程报警
	 * @return
	 */
	List<StuCourseRemain> queryStuCourseRemainList(Map<String, Object> map);
	
	/**
	 * 根据家长号码，查询学生剩余课程
	 * @param map
	 * @return
	 */
	List<StuCourseRemain> queryStuCourseRemainListByPhone(Map<String, Object> map);
	
	/**
	 * 查询某个学生还有余课的科目
	 * @param studentId
	 * @return
	 */
	List<StuCourseRemain> queryHasRemainCouseByStudentId(int studentId);
}
