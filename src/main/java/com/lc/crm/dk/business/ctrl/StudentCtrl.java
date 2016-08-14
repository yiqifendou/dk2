package com.lc.crm.dk.business.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.lc.crm.dk.business.dto.Course;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.ResponseVo;
import com.lc.crm.dk.business.dto.StuCourseFlow;
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.dto.User;
import com.lc.crm.dk.business.service.CourseService;
import com.lc.crm.dk.business.service.GrpService;
import com.lc.crm.dk.business.service.StuCourseFlowService;
import com.lc.crm.dk.business.service.StuCourseRemainService;
import com.lc.crm.dk.business.service.StudentService;
import com.lc.crm.dk.business.util.DateUtil;

@Controller
@RequestMapping("/student")
public class StudentCtrl extends BaseController{
	@Autowired
	private StudentService studentService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private GrpService grpService;
	@Autowired
	private StuCourseFlowService stuCourseFlowService;
	@Autowired
	private StuCourseRemainService stuCourseRemainService;
	
	@RequestMapping("/studentList")
	public String studentList(HttpServletRequest request,HttpServletResponse response,Model model){
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(request.getParameter("name"))) {
			map.put("name", request.getParameter("name"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("phone"))) {
			map.put("phone", request.getParameter("phone"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("contactName"))) {
			map.put("contactName", request.getParameter("contactName"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("stus"))) {
			map.put("stus", request.getParameter("stus"));
		}
		Paging<Student> p = studentService.queryJUIPage(map, request);
		model.addAttribute("p", p);
		return "admin/studentList";
	}
	
	@RequestMapping("/toAddStudentDialog")
	public String toAddStudentDialog(){
		return "admin/addStudentDialog";
	}
	
	@RequestMapping("/addStudent")
	public void addStudent(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String name = request.getParameter("name");
			Validate.notEmpty(name, "name不能为空！");
			String phone = request.getParameter("phone");
			Validate.notEmpty(phone, "phone不能为空！");
			String contactName = request.getParameter("contactName");
			Validate.notEmpty(contactName, "contactName不能为空！");
			String school = request.getParameter("school");
			Validate.notEmpty(school, "school不能为空！");
			String stusStr = request.getParameter("stus");
			Integer stus = 1;
			if("0".equals(stusStr)||"1".equals(stusStr)){
				stus = Integer.parseInt(stusStr);
			}
			String birthday = request.getParameter("birthday");
			String remark = request.getParameter("remark");
			
			//首先根据手机号查询该学生是否已经存在
			Student stu = new Student();
			stu.setName(name.trim());
			stu.setPhone(phone.trim());
			stu.setContactName(contactName.trim());
			stu.setStus(stus);
			stu.setSchool(school.trim());
			if(StringUtils.isNotEmpty(birthday)){
				stu.setBirthday(DateUtil.parseDate(birthday));
			}
			stu.setRemark(remark);
			//防止并发出现重复注册问题
			synchronized (StudentCtrl.class) {
				Student dbStu = studentService.queryByNameAndPhone(stu);
				if(null==dbStu){
					//可以增加
					studentService.insert(stu);
				}else{
					//该学生已经存在
					responseVo.setStatus(Constant.Code.ACCOUNT_EXIST);
					responseVo.setMsg("该学员已经存在");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/toUpdateStudentDialog")
	public String toUpdateStudentDialog(){
		return "admin/updateStudentDialog";
	}
	
	@RequestMapping("/queryStudent")
	public void queryStudent(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer id = Integer.parseInt(request.getParameter("id"));
			responseVo.setData(studentService.selectByPrimaryKey(id));
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/updateStudent")
	public void updateStudent(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			Validate.notEmpty(name, "name不能为空！");
			String phone = request.getParameter("phone");
			Validate.notEmpty(phone, "phone不能为空！");
			String contactName = request.getParameter("contactName");
			Validate.notEmpty(contactName, "contactName不能为空！");
			String school = request.getParameter("school");
			Validate.notEmpty(school, "school不能为空！");
			String stusStr = request.getParameter("stus");
			Integer stus = 1;
			if("0".equals(stusStr)||"1".equals(stusStr)){
				stus = Integer.parseInt(stusStr);
			}
			String birthday = request.getParameter("birthday");
			String remark = request.getParameter("remark");
			
			//首先根据手机号查询该学生是否已经存在
			Student stu = new Student();
			stu.setId(id);
			stu.setName(name.trim());
			stu.setPhone(phone.trim());
			stu.setContactName(contactName.trim());
			stu.setSchool(school);
			stu.setStus(stus);
			if(StringUtils.isNotEmpty(birthday)){
				stu.setBirthday(DateUtil.parseDate(birthday));
			}
			stu.setRemark(remark);
			
			
			//冻结学生需要满足2个条件，如果该学生某门课还有剩余，则不允许冻结；并且如果该学生还在某个班级下也不允许冻结，提示先移出该班级才能冻结
			if(stus==0){
				//查询该学生是否还有剩余的课
				List<StuCourseRemain> stuCourseRemainList = stuCourseRemainService.queryHasRemainCouseByStudentId(stu.getId());
				if(stuCourseRemainList.size()>0){
					StringBuilder remainBuilder = new StringBuilder();
					for(StuCourseRemain r:stuCourseRemainList){
						remainBuilder.append(","+r.getCourse().getCourseName());
					}
					throw new RuntimeException("无法冻结该学生，该学生以下课程还有课（"+remainBuilder.toString().substring(1)+"）");
				}
				//查询该学生在哪些班级下
				List<Grp> grpList = grpService.queryGrpsByStudentId(stu.getId());
				if(grpList.size()>0){
					StringBuilder grpBuilder = new StringBuilder();
					for(Grp g:grpList){
						grpBuilder.append(","+g.getGrpName());
					}
					throw new RuntimeException("无法冻结该学生，请先将该学生移出以下班级（"+grpBuilder.toString().substring(1)+"）");
				}
			}
			
			//防止出现重复学生问题
			synchronized (StudentCtrl.class) {
				//加入id不等于当前用户id防重复判断
				Student dbStu = studentService.queryByNameAndPhone(stu);
				if(null==dbStu){
					//可以修改
					studentService.updateByPrimaryKeySelective(stu);
				}else{
					//该学生已经存在
					responseVo.setStatus(Constant.Code.ACCOUNT_EXIST);
					responseVo.setMsg("该学员已经存在");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	
	@RequestMapping("/toRechargeStuCourseDialog")
	public String toRechargeStuCourseDialog(HttpServletRequest request,HttpServletResponse response,Model model){
		Integer studentId = Integer.parseInt(request.getParameter("studentId"));
		model.addAttribute("student", studentService.selectByPrimaryKey(studentId));
		model.addAttribute("courseList", courseService.queryAll());
		return "admin/rechargeStuCourseDialog";
	}
	
	/**
	 * 学生充值
	 */
	@RequestMapping("/rechargeCourse")
	public void rechargeCourse(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String studentId = request.getParameter("studentId");
			Validate.notEmpty(studentId, "studentId不能为空！");
			String courseId = request.getParameter("courseId");
			Validate.notEmpty(courseId, "courseId不能为空！");
			String courseCount = request.getParameter("courseCount");
			Validate.notEmpty(courseCount, "courseCount不能为空！");
			if(Integer.parseInt(courseCount)<1){
				throw new RuntimeException("充值课程必须大于1节！");
			}
			String type = request.getParameter("type");
			Validate.notEmpty(type, "type不能为空！");
			if(!("1".equals(type) || "2".equals(type))){
				throw new RuntimeException("type类型不合法！");
			}
			String rechargeFee = ("2".equals(type)?"0":request.getParameter("rechargeFee"));
			Validate.notEmpty(rechargeFee, "rechargeFee不能为空！");
			if(Integer.parseInt(rechargeFee)<0){
				throw new RuntimeException("充值费用不能小于0！");
			}
			String remark = request.getParameter("remark");
			User loginUser = LoginUserUtil.getLoginUser(request, response);
			Integer operateId = loginUser.getId();
			
			Student student = studentService.selectByPrimaryKey(Integer.parseInt(studentId));
			if(student.getStus()==1){
				Map<String, Object> map = new MapExt<String,Object>("studentId",studentId,"courseId",courseId,"courseCount",courseCount,"type",type,"rechargeFee",rechargeFee,"remark",remark,"operateId",operateId);
				studentService.rechargeCourse(map);
			}else{
				throw new RuntimeException("该学生已被冻结，请先解冻该学生！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/toStudyCourseDialog")
	public String toStudyCourseDialog(HttpServletRequest request,HttpServletResponse response,Model model){
		String grpId = request.getParameter("grpId");
		Grp grp = grpService.selectByPrimaryKey(Integer.parseInt(grpId));
		model.addAttribute("grp", grp);
		String studentId = request.getParameter("studentId");
		if(StringUtils.isNotEmpty(studentId)){
			model.addAttribute("student", studentService.selectByPrimaryKey(Integer.parseInt(studentId)));
		}
		return "user/studyCourseDialog";
	}
	
	/**
	 *小课  学生点课
	 * @param request
	 * @param response
	 */
	@RequestMapping("/studyCourseInPrivete")
	public void studyCourseInPrivete(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String studentId = request.getParameter("studentId");
			Validate.notEmpty(studentId, "studentId不能为空！");
			String grpId = request.getParameter("grpId");
			Validate.notEmpty(grpId, "grpId不能为空！");
			String remark = request.getParameter("remark");
			Validate.notEmpty(remark, "remark不能为空！");
			
			Grp grp = grpService.selectByPrimaryKey(Integer.parseInt(grpId));
			User loginUser = LoginUserUtil.getLoginUser(request, response);
			if(!grp.getTeacherId().equals(loginUser.getId())){
				//登录人不是该班级的负责人
				throw new RuntimeException("对不起，只有班级负责人才能点课！");
			}
			//查询该课程是否是小课
			Integer courseId = grp.getCourseId();
			Course course = courseService.selectByPrimaryKey(courseId);
			if(course.getCourseType()==1){
				//大课，无法单个学生点课
				throw new RuntimeException("集体课不允许对单个学生进行点课！");
			}
			//查询该班级有没有该学生，有则允许点课
			int count = grpService.stuInGrp(new MapExt<String,Object>("studentId",studentId,"grpId",grpId));
			if(count>0){
				//该学生在此班级内
				String courseCount = request.getParameter("courseCount");
				Validate.notEmpty(courseCount, "courseCount不能为空！");
				if(Integer.parseInt(courseCount)<1){
					throw new RuntimeException("课时必须大于1节！");
				}
				Integer operateId = loginUser.getId();
				Map<String, Object> map = new MapExt<String,Object>("studentId",studentId,"courseId",courseId,"courseCount",courseCount,"type",0,"rechargeFee",0,"remark",remark,"operateId",operateId);
				List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
				mapList.add(map);
				studentService.batchStudyCourse(mapList);
			}else{
				//该学生不在此班级内
				throw new RuntimeException("该学生已不在此班级内！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	/**
	 *大课  学生点课
	 * @param request
	 * @param response
	 */
	@RequestMapping("/studyCourseInPublic")
	public void studyCourseInPublic(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String grpId = request.getParameter("grpId");
			Validate.notEmpty(grpId, "grpId不能为空！");
			String remark = request.getParameter("remark");
			Validate.notEmpty(remark, "remark不能为空！");
			
			Grp grp = grpService.selectByPrimaryKey(Integer.parseInt(grpId));
			User loginUser = LoginUserUtil.getLoginUser(request, response);
			if(!grp.getTeacherId().equals(loginUser.getId())){
				//登录人不是该班级的负责人
				throw new RuntimeException("对不起，只有班级负责人才能点课！");
			}
			//查询该课程是否是大课
			Integer courseId = grp.getCourseId();
			Course course = courseService.selectByPrimaryKey(courseId);
			if(course.getCourseType()==0){
				//小课无法进行全班级点课
				throw new RuntimeException("小课不允许对整个班级进行点课！");
			}
			String courseCount = request.getParameter("courseCount");
			Validate.notEmpty(courseCount, "courseCount不能为空！");
			if(Integer.parseInt(courseCount)<1){
				throw new RuntimeException("课时必须大于1节！");
			}
			//查询出该班级的所有学生
			List<Student> studentList = studentService.queryStusByGrpId(grp);
			List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
			for(Student s:studentList){
				Map<String, Object> map = new MapExt<String,Object>("studentId",s.getId(),"courseId",courseId,"courseCount",courseCount,"type",0,"rechargeFee",0,"remark",remark,"operateId",loginUser.getId());
				mapList.add(map);
			}
			studentService.batchStudyCourse(mapList);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	/**
	 * 课程报警
	 */
	@RequestMapping("/courseRemainList")
	public String courseRemainList(HttpServletRequest request,HttpServletResponse response,Model model){
		model.addAttribute("courseList", courseService.queryAll());
		Paging<StuCourseRemain> p = stuCourseRemainService.queryCourseRemainJUIPage(new MapExt<String,Object>("courseId",request.getParameter("courseId")),request);
		model.addAttribute("p", p);
		return "admin/courseRemainList";
	}
	
	
	/**
	 * 某个学生课程流水
	 */
	@RequestMapping("/courseFlowList")
	public String courseFlowList(HttpServletRequest request,HttpServletResponse response,Model model){
		Integer studentId = Integer.parseInt(request.getParameter("studentId"));
		Student student = studentService.selectByPrimaryKey(studentId);
		Paging<StuCourseFlow> p = stuCourseFlowService.queryStuCourseFlowJUIPageByStudentId(new MapExt<String,Object>("studentId",studentId,"courseId",request.getParameter("courseId")), request);
		model.addAttribute("student", student);
		model.addAttribute("p", p);
		return "user/courseFlowList";
	}
	
}
