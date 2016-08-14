package com.lc.crm.dk.business.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.GrpStuMapping;

public interface GrpStuMappingMapper extends BaseMapper<GrpStuMapping>{
	void addGrpStus(@Param("list")List<GrpStuMapping> list);
	void deleteGrpStuIds(Map<String, Object> map);
	int stuInGrp(Map<String, Object> map);
}
