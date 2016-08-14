package com.lc.crm.dk.business.ctrl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.ctrl.BaseController;
import com.lc.crm.dk.base.dto.MapExt;
import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.util.LoginUserUtil;
import com.lc.crm.dk.base.util.cookie.CookieUtils;
import com.lc.crm.dk.business.dto.Course;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.GrpAndStuCourseRemainList;
import com.lc.crm.dk.business.dto.ResponseVo;
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.dto.TeacherWorkFlow;
import com.lc.crm.dk.business.dto.User;
import com.lc.crm.dk.business.service.CourseService;
import com.lc.crm.dk.business.service.GrpService;
import com.lc.crm.dk.business.service.StuCourseRemainService;
import com.lc.crm.dk.business.service.StudentService;
import com.lc.crm.dk.business.service.UserService;
import com.lc.crm.dk.business.util.DateUtil;
import com.lc.crm.dk.business.util.PwdUtil;

@Controller
@RequestMapping("/user")
public class UserCtrl extends BaseController{
	@Autowired
	private UserService userService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private GrpService grpService;
	@Autowired
	private StudentService studentService;
	@Autowired
	private StuCourseRemainService stuCourseRemainService;
	
	/**
	 * 退出
	 * @throws IOException 
	 */
	@RequestMapping("/logout")
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException{
		request.getSession().invalidate();
		LoginUserUtil.delLoginUser(response);
		response.sendRedirect(Constant.CONTEXTPATH);
	}
	
	
	
	/**
	 * 管理员查询用户信息
	 */
	@RequestMapping("/queryUserInfoByAdmin")
	public void queryUserInfoByAdmin(HttpServletRequest request,HttpServletResponse response,Integer id){
		ResponseVo responseVo = new ResponseVo();
		try {
			User user = userService.selectByPrimaryKey(id);
			responseVo.setData(user);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	/**
	 * 转到新增用户对话框
	 * @return
	 */
	@RequestMapping("/toAddUserDialog")
	public String toAddUserDialog(HttpServletRequest request,HttpServletResponse response,Model model){
		model.addAttribute("courseList", courseService.queryAll());
		return "admin/addUserDialog";
	}
	
	
	/**
	 * 增加用户
	 */
	@RequestMapping("/addUser")
	public void addUser(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String account = request.getParameter("account");
			Validate.notEmpty(account, "account不能为空！");
			String name = request.getParameter("name");
			Validate.notEmpty(name, "name不能为空！");
			String phone = request.getParameter("phone");
			Validate.notEmpty(phone, "phone不能为空！");
			String entryTime = request.getParameter("entryTime");
			String[] courseStrArr = request.getParameterValues("courseArr");
			String courseArr = "";
			if(null!=courseStrArr && courseStrArr.length>0){
				for(String c:courseStrArr){
					courseArr+=","+c;
				}
				courseArr = courseArr.substring(1);
			}
			String stusStr = request.getParameter("stus");
			String remark = request.getParameter("remark");
			//首先查询该工号的员工是否已经存在
			User user = new User();
			user.setAccount(account.trim());
			user.setPassword(PwdUtil.encoding(Constant.DEFAULT_LOGIN_PWD));
			user.setName(name.trim());
			user.setPhone(phone.trim());
			if(StringUtils.isNotEmpty(entryTime)){
				user.setEntryTime(DateUtil.parseDate(entryTime));
			}
			user.setCourseArr(courseArr);
			Integer stus = 1;
			if(StringUtils.isNotEmpty(stusStr)&&"0".equals(stusStr)){
				stus = 0;
			}
			user.setStus(stus);
			user.setRemark(remark);
			
			//防止并发出现重复注册问题
			synchronized (UserCtrl.class) {
				User dbUser = userService.queryByAccount(account);
				if(null==dbUser){
					//可以增加
					userService.insert(user);
				}else{
					//该员工已经存在
					responseVo.setStatus(Constant.Code.ACCOUNT_EXIST);
					responseVo.setMsg("该用户已经存在");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	
	
	/**
	 * 用户登录
	 */
	@RequestMapping("/login")
	public void login(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String account = request.getParameter("account");
			User dbUser = userService.queryByAccount(account);
			if(dbUser!=null){
				//校验密码是否正确
				String password = request.getParameter("password");
				if(dbUser.getPassword().equals(PwdUtil.encoding(password))){
					//密码正确
					if(dbUser.getStus()==1){
						//有效
						//可以登录，写到cookie中
						LoginUserUtil.saveLoginUser(response, dbUser);
						if(dbUser.getType()==1){
							//是管理员，有menu菜单,有效期为浏览器打开这段时间
							Cookie cookie = new Cookie("adminMenu", "1"); 
							cookie.setPath("/");
							cookie.setMaxAge(86400);
							response.addCookie(cookie);
						}else{
							//无管理员菜单
							Cookie cookie = new Cookie("adminMenu", null); 
							cookie.setPath("/");
							cookie.setMaxAge(0);
							response.addCookie(cookie);
						}
					}else{
						//用户已经被禁用
						//响应给前端
						responseVo.setStatus(Constant.Code.USER_INVALID);
						responseVo.setMsg("账号已被冻结，请联系管理员");
					}
				}else{
					responseVo.setStatus(Constant.Code.PWD_ERROR);
					responseVo.setMsg("登录失败，用户名或密码错误!");
				}
			}else{
				//用户不存在
				responseVo.setStatus(Constant.Code.USER_NOTEXIST);
				responseVo.setMsg("登录失败，用户不存在,请联系管理员添加账号!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	/**
	 * 用户中心
	 * @return
	 */
	@RequestMapping("/console")
	public String console(HttpServletRequest request,HttpServletResponse response,Model model){
		model.addAttribute("loginUser", LoginUserUtil.getLoginUser(request, response));
		return "console";
	}
	
	@RequestMapping("/toUpdatePwdDialog")
	public String toUpdatePwdDialog(HttpServletRequest request,HttpServletResponse response){
		return "user/updatePwdDialog";
	}
	
	/**
	 * 用户修改自己的登录密码
	 * @param request
	 * @param response
	 */
	@RequestMapping("/updatePwd")
	public void updatePwd(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String oldPwd = request.getParameter("oldPwd");
			Validate.notEmpty(oldPwd, "原密码不能为空！");
			String newPwd = request.getParameter("newPwd");
			Validate.notEmpty(newPwd, "新密码不能为空！");
			String confirmNewPwd = request.getParameter("confirmNewPwd");
			Validate.notEmpty(confirmNewPwd, "确认密码不能为空！");
			if(newPwd.equals(confirmNewPwd)){
				User loginUser = LoginUserUtil.getLoginUser(request, response);
				User dbUser = userService.queryPasswordById(loginUser.getId());
				if(dbUser.getPassword().equals(PwdUtil.encoding(oldPwd))){
					//原密码校验成功
					Map<String, Object> map = new MapExt<String,Object>("id",loginUser.getId(),"password",PwdUtil.encoding(newPwd));
					userService.updatePasswordByUserId(map);
				}else{
					responseVo.setStatus(Constant.Code.OLDPWD_ERROR);
					responseVo.setMsg("原密码错误！");
				}
			}else{
				responseVo.setStatus(Constant.Code.NEWPWD_NOT_MATCH);
				responseVo.setMsg("2次输入的密码不匹配！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	/**
	 * 管理员重置某用户的密码
	 */
	@RequestMapping("/resetLoginPwd")
	public void resetLoginPwd(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Map<String, Object> map = new MapExt<String,Object>("id",Integer.parseInt(request.getParameter("id")),"password",PwdUtil.encoding(Constant.DEFAULT_LOGIN_PWD));
			userService.updatePasswordByUserId(map);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/toUpdateMyInfoDialog")
	public String toUpdateMyInfoDialog(HttpServletRequest request,HttpServletResponse response,Model model){
		model.addAttribute("courseList", courseService.queryAll());
		return "user/myInfoDialog";
	}
	
	/**
	 * 查询我的信息
	 */
	@RequestMapping("/queryMyInfo")
	public void queryMyInfo(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			User loginUser = LoginUserUtil.getLoginUser(request, response);
			User user = userService.selectByPrimaryKey(loginUser.getId());
			responseVo.setData(user);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/updateMyInfo")
	public void updateMyInfo(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			User loginUser = LoginUserUtil.getLoginUser(request, response);
			User tempUser = new User();
			tempUser.setId(loginUser.getId());
			
			String phone = request.getParameter("phone");
			Validate.notEmpty(phone, "phone不能为空！");
			String remark = request.getParameter("remark");
			tempUser.setPhone(phone.trim());
			tempUser.setRemark(remark);
			userService.updateMyInfo(tempUser);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	
	@RequestMapping("/toUpdateUserDialog")
	public String toUpdateUserDialog(HttpServletRequest request,HttpServletResponse response,Model model){
		model.addAttribute("courseList", courseService.queryAll());
		return "admin/updateUserDialog";
	}
	
	@RequestMapping("/updateUserByAdmin")
	public void updateUserByAdmin(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			Validate.notEmpty(name, "name不能为空！");
			String phone = request.getParameter("phone");
			Validate.notEmpty(phone, "phone不能为空！");
			String entryTime = request.getParameter("entryTime");
			
			String[] courseStrArr = request.getParameterValues("courseArr");
			String courseArr = "";
			if(null!=courseStrArr && courseStrArr.length>0){
				for(String c:courseStrArr){
					courseArr+=","+c;
				}
				courseArr = courseArr.substring(1);
			}
			String stusStr = request.getParameter("stus");
			String remark = request.getParameter("remark");
			
			//首先查询该工号的员工是否已经存在
			User tempUser = new User();
			tempUser.setId(id);
			tempUser.setName(name.trim());
			tempUser.setPhone(phone.trim());
			if(StringUtils.isNotEmpty(entryTime)){
				tempUser.setEntryTime(DateUtil.parseDate(entryTime));
			}
			tempUser.setCourseArr(courseArr);
			Integer stus = 1;
			if(StringUtils.isNotEmpty(stusStr)&&"0".equals(stusStr)){
				stus = 0;
			}
			
			//冻结教师，如果该教师还负责班级则不允许冻结，如果不负责班级则允许冻结
			if(stus==0){
				List<Grp> grpList = grpService.queryGrpsByTeacherId(id);
				if(grpList.size()>0){
					StringBuilder grpBuilder = new StringBuilder();
					for(Grp g:grpList){
						grpBuilder.append(","+g.getGrpName());
					}
					throw new RuntimeException("无法冻结该教师，请先删除该教师负责的以下班级（"+grpBuilder.toString().substring(1)+"）");
				}
			}
			
			tempUser.setStus(stus);
			tempUser.setRemark(remark);
			userService.updateByPrimaryKeySelective(tempUser);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	
	
	@RequestMapping("/userList")
	public String userList(HttpServletRequest request,HttpServletResponse response,Model model){
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(request.getParameter("account"))) {
			map.put("account", request.getParameter("account"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("name"))) {
			map.put("name", request.getParameter("name"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("phone"))) {
			map.put("phone", request.getParameter("phone"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("stus"))) {
			map.put("stus", request.getParameter("stus"));
		}
		Paging<User> p = userService.queryJUIPage(map, request);
		Map<Integer, Course> allCourseMap = courseService.queryAllCourseMap();
		for(int i=0;i<p.getDataList().size();i++){
			User curUser = p.getDataList().get(i);
			curUser.setCourseList(queryCourseListByIds(allCourseMap, curUser.getCourseArr()));
		}
		model.addAttribute("p", p);
		return "admin/userList";
	}
	
	private List<Course> queryCourseListByIds(Map<Integer, Course> allCourseMap,String courseArr){
		List<Course> resultList = new ArrayList<Course>();
		if(StringUtils.isNotEmpty(courseArr)){
			String[] ids = courseArr.split(",");
			for(String id:ids){
				Course tempCourse = allCourseMap.get(Integer.parseInt(id));
				if(null != tempCourse){
					resultList.add(tempCourse);
				}
			}
		}
		return resultList;
	}
	
	
	@RequestMapping("/queryTeacherByCourseId")
	public void queryTeacherByCourseId(HttpServletRequest request,HttpServletResponse response){
		String resultJson = "[]";
		try {
			String courseId = request.getParameter("courseId");
			Validate.notEmpty(courseId, "courseId不能为空");
			List<User> teacherList = userService.queryTeacherByCourseId(courseId);
			StringBuilder tempSbd = new StringBuilder();
			for(User u:teacherList){
				//进行过滤，防止11，111，1111等混进courseId为1中
				String[] cArr = u.getCourseArr().split(",");
				for(String c:cArr){
					if(courseId.equals(c)){
						tempSbd.append(",[\""+u.getId()+"\",\""+u.getName()+"\"]");
						break;
					}
				}
			}
			if(StringUtils.isNotEmpty(tempSbd.toString())){
				resultJson = "["+tempSbd.toString().substring(1)+"]";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		responseToBrowser(response, resultJson);
	}
	

	@RequestMapping("/teacherMain")
	public String teacherMain(HttpServletRequest request,HttpServletResponse response,Model model){
		User loginUser = LoginUserUtil.getLoginUser(request, response);
		List<GrpAndStuCourseRemainList> gsrList = new ArrayList<GrpAndStuCourseRemainList>();
		//查询当前教师负责哪几个班级
		List<Grp> grpList = grpService.queryGrpsByTeacherId(loginUser.getId());
		for(Grp grp:grpList){
			GrpAndStuCourseRemainList gsr = new GrpAndStuCourseRemainList();
			gsr.setGrp(grp);
			List<Student> studentList = studentService.queryStusByGrpId(grp);
			if(studentList.size()>0){
				Map<Integer, Student> studentMap = new HashMap<Integer,Student>();
				String stuIds = "";
				for(Student s:studentList){
					stuIds+=(","+s.getId());
					studentMap.put(s.getId(), s);
				}
				List<StuCourseRemain> stuCourseRemainList = stuCourseRemainService.queryStusRemainByCourseId(new MapExt<String,Object>("stuIds",stuIds.substring(1),"courseId",grp.getCourseId()));
				for(StuCourseRemain r:stuCourseRemainList){
					r.setStudent(studentMap.get(r.getStudentId()));
				}
				gsr.setStuCourseRemainList(stuCourseRemainList);
			}else{
				gsr.setStuCourseRemainList(new ArrayList<StuCourseRemain>());
			}
			gsrList.add(gsr);
		}
		model.addAttribute("gsrList", gsrList);
		model.addAttribute("teacher", loginUser);
		String selectedTabIndex = CookieUtils.getCookie(request, "selectedTabIndex");
		model.addAttribute("selectedTabIndex", StringUtils.isEmpty("selectedTabIndex")?"0":selectedTabIndex);
		return "user/teacherMain";
	}
	
	@RequestMapping("/teacherWorkFlowList")
	public String teacherWorkFlowList(HttpServletRequest request,HttpServletResponse response,Model model){
		model.addAttribute("courseList", courseService.queryAll());
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(request.getParameter("courseId"))) {
			map.put("courseId", request.getParameter("courseId"));
		}
		//管理员可以查询任意教师的工作流水
		User loginUser = LoginUserUtil.getLoginUser(request, response);
		if(loginUser.getType()==1&&"all".equals(request.getParameter("qType"))){
			if (StringUtils.isNotEmpty(request.getParameter("teacherName"))) {
				map.put("teacherName", request.getParameter("teacherName"));
			}
		}else{
			map.put("teacherName", loginUser.getName());
		}
		if (StringUtils.isNotEmpty(request.getParameter("startTime"))) {
			map.put("startTime", request.getParameter("startTime"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("endTime"))) {
			map.put("endTime", request.getParameter("endTime"));
		}
		Paging<TeacherWorkFlow> p = userService.queryWorkFlowJUIPage(map, request);
		model.addAttribute("p", p);
		return "user/teacherWorkFlowList";
	}
}
