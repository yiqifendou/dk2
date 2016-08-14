package com.lc.crm.dk.business.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.service.BaseService;
import com.lc.crm.dk.business.dto.TeacherWorkFlow;
import com.lc.crm.dk.business.dto.User;

public interface UserService extends BaseService<User>{
	public void updateMyInfo(User user);
	public void updatePasswordByUserId(Map<String, Object> map);
	public User queryByAccount(@Param("account")String account);
	public User queryPasswordById(Integer id);
	public List<User> queryUserByStusAndType(Map<String, Object> map);
	public List<User> queryTeacherByCourseId(String courseId);
	 Paging<TeacherWorkFlow> queryWorkFlowJUIPage(HashMap<String, Object> map,HttpServletRequest request);
}
