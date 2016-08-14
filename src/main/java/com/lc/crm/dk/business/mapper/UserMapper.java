package com.lc.crm.dk.business.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.business.dto.User;

public interface UserMapper extends BaseMapper<User>{
	public void updateMyInfo(User user);
	public void updatePasswordByUserId(Map<String, Object> map);
	public User queryByAccount(@Param("account")String account);
	public User queryPasswordById(Integer id);
	public List<User> queryUserByStusAndType(Map<String, Object> map);
	public List<User> queryTeacherByCourseId(@Param("courseId")String courseId);
}
