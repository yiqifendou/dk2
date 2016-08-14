package com.lc.crm.dk.business.service.impl;

import java.util.HashMap;
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
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.mapper.StuCourseRemainMapper;
import com.lc.crm.dk.business.mapper.StudentMapper;
import com.lc.crm.dk.business.service.StuCourseRemainService;

@Service
public class StuCourseRemainServiceImpl extends BaseServiceImpl<StuCourseRemain> implements StuCourseRemainService{
	@Autowired
	private StuCourseRemainMapper stuCourseRemainMapper;
	@Autowired
	private StudentMapper studentMapper;
	
	@Override
	public BaseMapper<StuCourseRemain> getBaseMapper() {
		return stuCourseRemainMapper;
	}
	
	@Override
	public List<StuCourseRemain> queryCanJoinGrp(Map<String, Object> map) {
		//分好多步是为了减少多表关联以及子查询
		List<StuCourseRemain> sList =  stuCourseRemainMapper.queryCanJoinGrpStuIds(map);
		String stuIds = "";
		for(StuCourseRemain s:sList){
			stuIds+=","+s.getStudentId();
		}
		if(StringUtils.isNotEmpty(stuIds)){
			List<Student> stuList = studentMapper.queryByIds(stuIds.substring(1));
			Map<Integer, Student> stuMap = new HashMap<Integer,Student>();
			for(Student stu:stuList){
				stuMap.put(stu.getId(), stu);
			}
			for(StuCourseRemain s:sList){
				s.setStudent(stuMap.get(s.getStudentId()));
			}
		}
		return sList;
	}
	
	@Override
	public List<StuCourseRemain> queryStusRemainByCourseId(Map<String, Object> map) {
		return stuCourseRemainMapper.queryStusRemainByCourseId(map);
	}
	
	/**
	 * 分页查询学生剩余课程
	 */
	@Override
	public Paging<StuCourseRemain> queryCourseRemainJUIPage(Map<String, Object> map,HttpServletRequest request) {
		Integer pageNum = StringUtils.isNotEmpty(request.getParameter("pageNum")) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
		Integer numPerPage = StringUtils.isNotEmpty(request.getParameter("numPerPage"))	? Integer.parseInt(request.getParameter("numPerPage")) : Constant.Page.DEFAULT_PAGESIZE;
		
		PageHelper.startPage(pageNum, numPerPage);
		PageInfo<StuCourseRemain> pi = new PageInfo<StuCourseRemain>(stuCourseRemainMapper.queryStuCourseRemainList(map));
		
		Paging<StuCourseRemain> p = new Paging<StuCourseRemain>();
		p.setParamsObj(null);
		p.setDataList(pi.getList());
		p.setTotalCount(pi.getTotal());
		p.setPageNum(pageNum);
		p.setNumPerPage(numPerPage);
		p.setTotalPage(pi.getPages());
		return p;
	}

	
	/**
	 * 查询某个学生还有余课的科目
	 * @param studentId
	 * @return
	 */
	@Override
	public List<StuCourseRemain> queryHasRemainCouseByStudentId(int studentId) {
		return stuCourseRemainMapper.queryHasRemainCouseByStudentId(studentId);
	}
	
	/**
	 * 根据家长号码，查询学生剩余课程
	 * @param map
	 * @return
	 */
	@Override
	public List<StuCourseRemain> queryStuCourseRemainListByPhone(Map<String, Object> map) {
		return stuCourseRemainMapper.queryStuCourseRemainListByPhone(map);
	}
	

}
