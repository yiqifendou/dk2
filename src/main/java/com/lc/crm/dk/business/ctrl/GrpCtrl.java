package com.lc.crm.dk.business.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.ctrl.BaseController;
import com.lc.crm.dk.base.dto.MapExt;
import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.business.dto.Course;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.ResponseVo;
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.dto.User;
import com.lc.crm.dk.business.service.CourseService;
import com.lc.crm.dk.business.service.GrpService;
import com.lc.crm.dk.business.service.StuCourseRemainService;
import com.lc.crm.dk.business.service.StudentService;
import com.lc.crm.dk.business.service.UserService;

@Controller
@RequestMapping("/grp")
public class GrpCtrl extends BaseController{
	@Autowired
	private GrpService grpService;
	@Autowired
	private CourseService courseService;
	@Autowired
	private UserService userService;
	@Autowired
	private StudentService studentService;
	@Autowired
	private StuCourseRemainService stuCourseRemainService;
	
	
	@RequestMapping("/grpList")
	public String courseList(HttpServletRequest request,HttpServletResponse response,Model model){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("grpName", request.getParameter("grpName"));
		Paging<Grp> p = grpService.queryJUIPage(map, request);
		model.addAttribute("p", p);
		return "admin/grpList";
	}
	
	@RequestMapping("/toAddGrp")
	public String toAddGrp(HttpServletRequest request,HttpServletResponse response,Model model){
		List<Course> courseList = courseService.queryAll();
		model.addAttribute("courseList", courseList);
		String firstCourseId = courseList.get(0).getId()+"";
		List<User> firstTeacherList = new ArrayList<User>();
		List<User> teacherList = userService.queryTeacherByCourseId(firstCourseId);
		for(User u:teacherList){
			//进行过滤，防止11，111，1111等混进courseId为1中
			String[] cArr = u.getCourseArr().split(",");
			for(String c:cArr){
				if(firstCourseId.equals(c)){
					firstTeacherList.add(u);
					break;
				}
			}
		}
		model.addAttribute("firstTeacherList", firstTeacherList);
		return "admin/addGrp";
	}
	
	@RequestMapping("/deleteGrp")
	public void deleteGrp(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer id = Integer.parseInt(request.getParameter("id"));
			Grp grp = new Grp();
			grp.setId(id);
			//删除班级，查询该班级下是否还有学生，有则不允许删除，无则允许删除
			List<Student> studentList = studentService.queryStusByGrpId(grp);
			if(studentList.size()==0){
				grpService.deleteByPrimaryKey(id);
			}else{
				throw new RuntimeException("删除失败，请先移除该班级下的所有学生！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/joinGrpStuList")
	public String joinGrpStuList(HttpServletRequest request,HttpServletResponse response,Model model){
		Integer courseId = Integer.parseInt(request.getParameter("courseId"));
		//Integer teacherId = Integer.parseInt(request.getParameter("teacherId"));
		//查询courseId有课，且未加入任何班级的学员
		List<StuCourseRemain> canJoinStuList = stuCourseRemainService.queryCanJoinGrp(new MapExt<String,Object>("courseId",courseId));
		model.addAttribute("canJoinStuList", canJoinStuList);
		return "admin/joinGrpStuList";
	}
	
	@RequestMapping("/addGrp")
	public void addGrp(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String courseId = request.getParameter("courseId");
			Validate.notEmpty(courseId, "courseId不能为空！");
			String teacherId = request.getParameter("teacherId");
			Validate.notEmpty(teacherId, "teacherId不能为空！");
			String grpName = request.getParameter("grpName");
			Validate.notEmpty(grpName, "grpName不能为空！");
			String remark = request.getParameter("remark");
			Grp grp = new Grp();
			grp.setCourseId(Integer.parseInt(courseId));
			grp.setTeacherId(Integer.parseInt(teacherId));
			grp.setGrpName(grpName);
			grp.setRemark(remark);
			String cStuIds = request.getParameter("cStuIds");
			responseVo = grpService.addGrpAndGrpStus(grp, cStuIds);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	
	@RequestMapping("/toUpdateGrp")
	public String toUpdateGrp(HttpServletRequest request,HttpServletResponse response,Model model){
		Grp grp = grpService.selectByPrimaryKey(Integer.parseInt(request.getParameter("id")));
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
			model.addAttribute("stuCourseRemainList", JSONArray.toJSONString(stuCourseRemainList));
		}else{
			model.addAttribute("stuCourseRemainList", "[]");
		}
		model.addAttribute("grp", grp);
		return "admin/updateGrp";
	}
	
	@RequestMapping("/updateGrp")
	public void updateGrp(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer grpId = Integer.parseInt(request.getParameter("grpId"));
			String remark = request.getParameter("remark");
			Grp grp = new Grp();
			grp.setId(grpId);
			grp.setRemark(remark);
			String cStuIds = request.getParameter("cStuIds");
			responseVo = grpService.updateGrpAndGrpStus(grp, cStuIds);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
}
