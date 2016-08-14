package com.lc.crm.dk.business.ctrl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.Validate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.ctrl.BaseController;
import com.lc.crm.dk.business.dto.Course;
import com.lc.crm.dk.business.dto.ResponseVo;
import com.lc.crm.dk.business.service.CourseService;

@Controller
@RequestMapping("/course")
public class CourseCtrl extends BaseController{
	@Autowired
	private CourseService courseService;
	
	
	@RequestMapping("/courseList")
	public ModelAndView courseList(HttpServletRequest request,HttpServletResponse response,ModelAndView mv){
		mv.addObject("dataList", courseService.queryAll());
		mv.setViewName("admin/courseList");
		return mv;
	}
	
	@RequestMapping("/toAddCourseDialog")
	public String toAddCourseDialog(){
		return "admin/addCourseDialog";
	}
	
	@RequestMapping("/addCourse")
	public void addCourse(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String courseName = request.getParameter("courseName");
			Validate.notEmpty(courseName,"courseName不能为空！");
			Integer courseType = Integer.parseInt(request.getParameter("courseType"));
			String remark = request.getParameter("remark");
			Course tempCourse = new Course();
			tempCourse.setCourseName(courseName);
			tempCourse.setCourseType(courseType);
			tempCourse.setRemark(remark);
			courseService.insert(tempCourse);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	
	@RequestMapping("/queryByCourseId")
	public void queryByCourseId(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer courseId = Integer.parseInt(request.getParameter("courseId"));
			Course dbCourse = courseService.selectByPrimaryKey(courseId);
			responseVo.setData(dbCourse);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	@RequestMapping("/toUpdateCourseDialog")
	public String toUpdateCourseDialog(){
		return "admin/updateCourseDialog";
	}
	
	@RequestMapping("/updateCourse")
	public void updateCourse(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			Integer courseId = Integer.parseInt(request.getParameter("courseId"));
			String courseName = request.getParameter("courseName");
			Integer courseType = Integer.parseInt(request.getParameter("courseType"));
			String remark = request.getParameter("remark");
			Course tempCourse = new Course();
			tempCourse.setId(courseId);
			tempCourse.setCourseName(courseName);
			tempCourse.setCourseType(courseType);
			tempCourse.setRemark(remark);
			courseService.updateByPrimaryKey(tempCourse);
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
}
