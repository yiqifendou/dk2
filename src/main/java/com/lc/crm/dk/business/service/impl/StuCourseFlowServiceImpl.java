package com.lc.crm.dk.business.service.impl;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.impl.BaseServiceImpl;
import com.lc.crm.dk.business.dto.StuCourseFlow;
import com.lc.crm.dk.business.mapper.StuCourseFlowMapper;
import com.lc.crm.dk.business.service.StuCourseFlowService;

@Service
public class StuCourseFlowServiceImpl extends BaseServiceImpl<StuCourseFlow> implements StuCourseFlowService{
	@Autowired
	private StuCourseFlowMapper stuCourseFlowMapper;
	
	@Override
	public BaseMapper<StuCourseFlow> getBaseMapper() {
		return stuCourseFlowMapper;
	}
	
	/**
	 * 查询某个学生的课程流水
	 */
	@Override
	public Paging<StuCourseFlow> queryStuCourseFlowJUIPageByStudentId(Map<String, Object> map, HttpServletRequest request) {
		Integer pageNum = StringUtils.isNotEmpty(request.getParameter("pageNum")) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
		Integer numPerPage = StringUtils.isNotEmpty(request.getParameter("numPerPage"))	? Integer.parseInt(request.getParameter("numPerPage")) : Constant.Page.DEFAULT_PAGESIZE;
		
		PageHelper.startPage(pageNum, numPerPage);
		PageInfo<StuCourseFlow> pi = new PageInfo<StuCourseFlow>(stuCourseFlowMapper.queryStuCourseFlowBySelective(map));
		
		Paging<StuCourseFlow> p = new Paging<StuCourseFlow>();
		p.setParamsObj(null);
		p.setDataList(pi.getList());
		p.setTotalCount(pi.getTotal());
		p.setPageNum(pageNum);
		p.setNumPerPage(numPerPage);
		p.setTotalPage(pi.getPages());
		return p;
	}
	
	/**
	 * 条件查询
	 */
	@Override
	public List<StuCourseFlow> queryStuCourseFlowBySelective(Map<String, Object> map) {
		return stuCourseFlowMapper.queryStuCourseFlowBySelective(map);
	}


}
