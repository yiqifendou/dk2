package com.lc.crm.dk.business.service;

import java.util.List;
import java.util.Map;

import com.lc.crm.dk.base.service.BaseService;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.ResponseVo;

public interface GrpService extends BaseService<Grp>{
	public ResponseVo addGrpAndGrpStus(Grp grp,String cSstuIds);
	public ResponseVo updateGrpAndGrpStus(Grp grp,String cStuIds);
	List<Grp> queryGrpsByTeacherId(int teacherId);
	int stuInGrp(Map<String, Object> map);
	/**
	 * 查询某个学生在哪些班级下
	 * @param studentId
	 * @return
	 */
	List<Grp> queryGrpsByStudentId(int studentId);
}
