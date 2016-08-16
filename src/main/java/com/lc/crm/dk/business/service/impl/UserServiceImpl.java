package com.lc.crm.dk.business.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.impl.BaseServiceImpl;
import com.lc.crm.dk.business.dto.TeacherWorkFlow;
import com.lc.crm.dk.business.dto.User;
import com.lc.crm.dk.business.mapper.TeacherWorkFlowMapper;
import com.lc.crm.dk.business.mapper.UserMapper;
import com.lc.crm.dk.business.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService{
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private TeacherWorkFlowMapper teacherWorkFlowMapper;
	
	@Override
	public BaseMapper<User> getBaseMapper() {
		return userMapper;
	}
	
	public void updatePasswordByUserId(Map<String, Object> map){
		userMapper.updatePasswordByUserId(map);
	}
	
	@Override
	public User queryByAccount(String account) {
		return userMapper.queryByAccount(account);
	}
	
	@Override
	public void updateMyInfo(User user){
		userMapper.updateMyInfo(user);
	}

	@Override
	public User queryPasswordById(Integer id) {
		return userMapper.queryPasswordById(id);
	}

	@Override
	public List<User> queryUserByStusAndType(Map<String, Object> map) {
		return userMapper.queryUserByStusAndType(map);
	}

	@Override
	public List<User> queryTeacherByCourseId(String courseId) {
		return userMapper.queryTeacherByCourseId(courseId);
	}

	
	@Override
	public Paging<TeacherWorkFlow> queryWorkFlowJUIPage(HashMap<String, Object> map, HttpServletRequest request) {
		//总课时
		Integer totalCourseCount = teacherWorkFlowMapper.queryTotalCourseCount(map);
		request.setAttribute("totalCourseCount", totalCourseCount==null?0:totalCourseCount);
		
		Integer pageNum = StringUtils.isNotEmpty(request.getParameter("pageNum")) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
		Integer numPerPage = StringUtils.isNotEmpty(request.getParameter("numPerPage"))	? Integer.parseInt(request.getParameter("numPerPage")) : Constant.Page.DEFAULT_PAGESIZE;
		PageHelper.startPage(pageNum, numPerPage);
		//其实page对象是arrayList的子类，该对象含有很多分页信息，但是el无法拿出来，所以用pageInfo封装一下
		List<TeacherWorkFlow> page = teacherWorkFlowMapper.queryPageByMap(map);
		PageInfo<TeacherWorkFlow> pi = new PageInfo<TeacherWorkFlow>(page);
		Paging<TeacherWorkFlow> p = new Paging<TeacherWorkFlow>();
		p.setParamsObj(map);
		p.setDataList(pi.getList());
		p.setTotalCount(pi.getTotal());
		p.setPageNum(pageNum);
		p.setNumPerPage(numPerPage);
		p.setTotalPage(pi.getPages());
		return p;
	}
	
}
