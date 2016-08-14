package com.lc.crm.dk.business.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.Student;

public interface StudentMapper extends BaseMapper<Student>{
	Student queryByNameAndPhone(Student stu);
	List<Student> queryByIds(@Param("ids")String ids);
	List<Student> queryStusByGrpId(Grp grp);
	void updateStuTotalFee(Map<String, Object> map);
	List<Student> queryStusByPhone(@Param("phone")String phone);
}
