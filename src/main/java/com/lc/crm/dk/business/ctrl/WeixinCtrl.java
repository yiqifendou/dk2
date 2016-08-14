package com.lc.crm.dk.business.ctrl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.ctrl.BaseController;
import com.lc.crm.dk.base.dto.MapExt;
import com.lc.crm.dk.base.util.codec.DecriptUtil;
import com.lc.crm.dk.base.util.cookie.CookieUtils;
import com.lc.crm.dk.base.util.http.InputStreamUtils;
import com.lc.crm.dk.business.dto.Course;
import com.lc.crm.dk.business.dto.ResponseVo;
import com.lc.crm.dk.business.dto.StuCourseFlow;
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.service.CourseService;
import com.lc.crm.dk.business.service.StuCourseFlowService;
import com.lc.crm.dk.business.service.StuCourseRemainService;
import com.lc.crm.dk.business.service.StudentService;

@Controller
@RequestMapping("/weixin")
public class WeixinCtrl extends BaseController{
	private Log logger = LogFactory.getLog(WeixinCtrl.class);
	
	@Autowired
	private StudentService studentService;
	@Autowired
	private StuCourseRemainService stuCourseRemainService;
	@Autowired
	private StuCourseFlowService stuCourseFlowService;
	@Autowired
	private CourseService courseService;
	
	@RequestMapping("/toBindPhone")
	public String toBindPhone(){
		return "weixin/bindPhone";
	}
	
	@RequestMapping("/bindPhone")
	public void bindPhone(HttpServletRequest request,HttpServletResponse response){
		ResponseVo responseVo = new ResponseVo();
		try {
			String phone = request.getParameter("phone");
			//查询是否有该号码的学生列表
			List<Student> studentList = studentService.queryStusByPhone(phone.trim());
			if(null!=studentList && (studentList.size()>0)){
				//允许绑定
				CookieUtils.addCookie(response, "bindPhone", phone.trim());
			}else{
				//未查询到该号码学生数据
				responseVo.setStatus(Constant.Code.PHONE_NOT_EXIST);
				responseVo.setMsg("绑定失败，未查询到该号码学生数据");
			}
		} catch (Exception e) {
			e.printStackTrace();
			responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
			responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
		}
		responseToBrowser(response, responseVo);
	}
	
	/**
	 * 家长查询他关联的学生课程课时情况
	 */
	@RequestMapping("/queryRelativeStus")
	public String queryRelativeStus(HttpServletRequest request,HttpServletResponse response,@CookieValue(value="bindPhone",required=false) String bindPhone){
		List<StuCourseRemain> stuCourseRemainList = new ArrayList<StuCourseRemain>();
		if(StringUtils.isNotEmpty(bindPhone)){
			//查询是否有该号码的学生列表
			stuCourseRemainList = stuCourseRemainService.queryStuCourseRemainListByPhone(new MapExt<String,Object>("phone",bindPhone));
		}
		request.setAttribute("stuCourseRemainList", stuCourseRemainList);
		request.setAttribute("bindPhone", bindPhone);
		return "weixin/relativeStus";
	}
	
	/**
	 * 家长分页查询学生的学习记录
	 */
	@RequestMapping("/queryStuStudyRecord")
	public String queryStuStudyRecord(HttpServletRequest request,HttpServletResponse response,Model model){
		Integer studentId = Integer.parseInt(request.getParameter("studentId"));
		Student student = studentService.selectByPrimaryKey(studentId);
		Course course = courseService.selectByPrimaryKey(Integer.parseInt(request.getParameter("courseId")));
		List<StuCourseFlow> scfList = stuCourseFlowService.queryStuCourseFlowBySelective(new MapExt<String,Object>("studentId",studentId,"courseId",request.getParameter("courseId")));
		model.addAttribute("student", student);
		model.addAttribute("course", course);
		model.addAttribute("scfList", scfList);
		return "weixin/stuStudyRecord";
	}
	
	/**
	 * 对接微信回调
	 * @param request
	 * @param response
	 */
	public void docking(HttpServletRequest request,HttpServletResponse response) {
		String echostr = request.getParameter("echostr");
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		boolean orgin = checkOrgin(signature, timestamp, nonce);
		if(!orgin){
			//非腾讯请求 ignore
			return;
		}
		if (StringUtils.isNotEmpty(echostr)) {
			// 第一次对接
			responseToBrowser(response, echostr);
			return;
		}

		// 非第一次验证
		InputStream is = null;
		try {
			is = request.getInputStream();
			String xml = InputStreamUtils.InputStreamToString(is);
			logger.info("xml***" + xml);
			/*Document doc = DocumentHelper.parseText(xml);
			Element rootElement = doc.getRootElement();
			String msgType = rootElement.elementText("MsgType");
			String toUserName = rootElement.elementText("ToUserName");
			String fromUserName = rootElement.elementText("FromUserName");
			String createTime = rootElement.elementText("CreateTime");
			String content = rootElement.elementText("Content");

			if (msgType.equals("text")) {
				// 文本事件
			} else if(msgType.equals("event")){
				// 其他事件
				if("subscribe".equals(rootElement.elementText("Event"))){
					//订阅
				}else{
					//ignore
					logger.info("other event ignore ");
				}
			}
			return;*/
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
					// ignore
				}
			}
		}
	}

	/**
	 * 检查是否来源于腾讯
	 * 
	 * @return
	 */
	private boolean checkOrgin(String signature, String timestamp, String nonce) {
		String[] arr = new String[] { Constant.Weixin.TOKEN, timestamp, nonce };
		Arrays.sort(arr);
		return DecriptUtil.SHA1(arr[0] + arr[1] + arr[2]).equals(signature);
	}
}
