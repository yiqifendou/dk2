package com.lc.crm.dk.business.mapper;

import java.util.List;
import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.Grp;

public interface GrpMapper extends BaseMapper<Grp>{
	Grp queryByNameAndCourseIdAndTeacherId(Grp grp);
	List<Grp> queryGrpsByTeacherId(int teacherId);
	/**
	 * 查询某个学生在哪些班级下
	 * @param studentId
	 * @return
	 */
	List<Grp> queryGrpsByStudentId(int studentId);
}
