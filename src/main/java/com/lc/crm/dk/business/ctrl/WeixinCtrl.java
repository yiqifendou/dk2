package com.lc.crm.dk.business.ctrl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.ctrl.BaseController;
import com.lc.crm.dk.base.dto.MapExt;
import com.lc.crm.dk.base.dto.Paging;
import com.lc.crm.dk.base.util.BusinessErrorPageUtil;
import com.lc.crm.dk.base.util.EncryptionUtil;
import com.lc.crm.dk.base.util.LoginUserUtil;
import com.lc.crm.dk.base.util.codec.DecriptUtil;
import com.lc.crm.dk.base.util.cookie.CookieUtils;
import com.lc.crm.dk.base.util.http.HttpUtil;
import com.lc.crm.dk.base.util.http.InputStreamUtils;
import com.lc.crm.dk.business.dto.*;
import com.lc.crm.dk.business.service.*;
import com.lc.crm.dk.business.util.PwdUtil;
import com.lc.crm.dk.business.util.WeixinConstant;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.Validate;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

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
    @Autowired
    private UserService userService;
    @Autowired
    private GrpService grpService;
	
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
     * 静默oauth获取code
     * @param request
     * @return
     */
    @RequestMapping("/oauthGetCodeBySilence")
    public String oauthGetCodeBySilence(HttpServletRequest request){
        String rUrl = "http://"+request.getHeader("host")+request.getContextPath()+"/weixin/codeTransBySilence";
        String oauthUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+ WeixinConstant.appid+"&redirect_uri="+rUrl+"&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
        //return "redirect:"+oauthUrl;
        return "redirect:"+rUrl+"?code=111111";
    }

    /**
     * code转openid
     * @return
     */
    @RequestMapping("/codeTransBySilence")
    public String codeTransBySilence(HttpServletRequest request,HttpServletResponse response,Model model) throws IOException {
        String code = request.getParameter("code");
        String accessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+WeixinConstant.appid+"&secret="+WeixinConstant.appsecret+"&code="+code+"&grant_type=authorization_code";
        //String responseStr = HttpUtil.requestGet(accessTokenUrl);
        //TODO 专门用于测试
        String responseStr = "{\"access_token\":\"OadT0_fTGO9i7DuOxhlrn7f8m_Ieb4ftIIBIms_bX3QOueirYX3o6RTkqUo96egFfh4UneXoy4Uj5He_FN1oar82pFkjnkbfP36Q_cB_wns\",\"expires_in\":7200,\"refresh_token\":\"nYArAQwxhW14pvENm76CbjFr-lI5V8eOW_CtnvzRksBr4j5225fxjULE7QC6sQVWABmy_yQnPb4b3eEpSMA3j-Tga2Q3lkxI49LcSx99NRk\",\"openid\":\"o8E_xwxCSghQCcePBTongP5nBqWo\",\"scope\":\"snsapi_base\"}";
        JSONObject responseJson = JSONObject.parseObject(responseStr);
        String openId = responseJson.getString("openid");
        if(StringUtils.isNotBlank(openId)){
            //将openid和签名一并下发到用户端,并转到绑定教师页面
            String encryptKey = EncryptionUtil.encrypt(openId);
            CookieUtils.addCookie(response,"encryptKey",encryptKey);
            return "redirect:/weixin/toBindTeacher";
        }else{
            return BusinessErrorPageUtil.toErrorPage(model,"openid获取失败！");
        }
    }

    /**
     * 转到教师信息信息绑定页面或教学中心
     * @param request
     * @return
     */
	@RequestMapping("/toBindTeacher")
	public String toBindTeacher(HttpServletRequest request){
        String openid = getOpenId(request);
        User dbUser = new User();
        dbUser.setOpenid(openid);
        dbUser = userService.queryByOpenid(dbUser);
        if(dbUser==null){
            //转到账号绑定页面
            return "weixin/bindTeacher";
        }else{
            //已经进行过账号绑定，直接转到点课中心
            return "redirect:/weixin/toTeacherMain";
        }
	}

    /**
     * 教师信息绑定
     * @param request
     * @param response
     * @param model
     */
	@RequestMapping("/bindTeacher")
	public void bindTeacher(HttpServletRequest request,HttpServletResponse response,Model model){
	    ResponseVo responseVo = new ResponseVo();
        try {
            String account = request.getParameter("account");
            String password = request.getParameter("password");
            Validate.notBlank(account,"账号不能为空");
            Validate.notBlank(password,"密码不能为空");
            String openid = getOpenId(request);
            Validate.notBlank(openid,"openid不能为空");

            User dbUser = userService.queryByAccount(account);
            if(null!=dbUser) {
                if(dbUser.getOpenid()==null){
                    dbUser.setOpenid(openid);
                    if(null == userService.queryByOpenid(dbUser)){
                        //校验密码密码是否正确
                        if(PwdUtil.encoding(password).equals(userService.queryPasswordById(dbUser.getId()).getPassword())){
                            //进行账号绑定
                            userService.teacherBindWeixin(dbUser);
                            responseVo.setMsg("绑定成功");
                        }else{
                            //密码错误
                            responseVo.setStatus(Constant.Code.PWD_ERROR);
                            responseVo.setMsg("账号或者密码错误");
                        }
                    }else{
                        //重复绑定
                        responseVo.setStatus(Constant.Code.REPEAT_BIND_WEIXIN);
                        responseVo.setMsg("您已绑定过微信了");
                    }
                }else{
                    //重复绑定
                    responseVo.setStatus(Constant.Code.REPEAT_BIND_WEIXIN);
                    responseVo.setMsg("您已绑定过微信了");
                }
            }else{
                //用户不存在
                responseVo.setStatus(Constant.Code.USER_NOTEXIST);
                responseVo.setMsg("账号或者密码错误");
            }
        } catch (Exception e) {
            e.printStackTrace();
            responseVo.setStatus(Constant.Code.STATUS_EXCEPTION);
            responseVo.setMsg(Constant.SYSTEM_BUSY+e.getMessage());
        }
        responseToBrowser(response, responseVo);
    }

    @RequestMapping("/toTeacherMain")
    public String toTeacherMain(HttpServletRequest request,Model model){
        User loginUser = getLoginUser(request);
        //查询当前教师负责哪几个班级
        List<Grp> grpList = grpService.queryGrpsByTeacherId(loginUser.getId());
        model.addAttribute("grpList", grpList);
        model.addAttribute("teacher", loginUser);
        return "weixin/teacherMain";
    }

    @RequestMapping("/toGsrDetail")
    public String toGsrDetail(HttpServletRequest request,Model model){
        User loginUser = getLoginUser(request);
        String grpId = request.getParameter("grpId");
        Grp grp = grpService.selectByPrimaryKey(Integer.parseInt(grpId));
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
        model.addAttribute("gsr", gsr);
        model.addAttribute("teacher", loginUser);
        return "weixin/gsrDetail";
    }

    @RequestMapping("/toStuStudyCourse")
    public String toStuStudyCourse(HttpServletRequest request,Model model){
        String studentId = request.getParameter("studentId");
        String grpId = request.getParameter("grpId");
        Validate.notEmpty(grpId, "grpId不能为空！");
        Grp grp = grpService.selectByPrimaryKey(Integer.parseInt(grpId));
        if(StringUtils.isNotBlank(studentId)){
            Student student = studentService.selectByPrimaryKey(Integer.parseInt(studentId));
            model.addAttribute("student",student);
        }
        model.addAttribute("grp",grp);
        return "weixin/stuStudyCourse";
    }


    /**
     *小课  学生点课studentId，grpId，remark，courseCount
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
            User loginUser = getLoginUser(request);
            if(!grp.getTeacherId().equals(loginUser.getId())){
                //登录人不是该班级的负责人
                throw new RuntimeException("对不起，只有班级负责人才能点课！");
            }
            //查询该课程是否是小课
            if(grp.getCourseType()==1){
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
                Map<String, Object> map = new MapExt<String,Object>("studentId",studentId,"courseId",grp.getCourseId(),"courseCount",courseCount,"type",0,"rechargeFee",0,"remark",remark,"operateId",operateId);
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
     *大课  学生点课grpId，remark，courseCount
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
            User loginUser = getLoginUser(request);
            if(!grp.getTeacherId().equals(loginUser.getId())){
                //登录人不是该班级的负责人
                throw new RuntimeException("对不起，只有班级负责人才能点课！");
            }
            //查询该课程是否是大课
            if(grp.getCourseType()==0){
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
                Map<String, Object> map = new MapExt<String,Object>("studentId",s.getId(),"courseId",grp.getCourseId(),"courseCount",courseCount,"type",0,"rechargeFee",0,"remark",remark,"operateId",loginUser.getId());
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


    private User getLoginUser(HttpServletRequest request){
        String openid = getOpenId(request);
        User user = new User();
        user.setOpenid(openid);
        return userService.queryByOpenid(user);
    }

    private String getOpenId(HttpServletRequest request){
        String encryptKey = CookieUtils.getCookie(request, "encryptKey");
        EncryptionUtil.DecryptResult<String> decryptResult = EncryptionUtil.decrypt(encryptKey, String.class);
        return decryptResult.getT();
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

    /*public String toBindTeacher(HttpServletRequest request,HttpServletResponse response,Model model){
        //首先获取opendid,然后查找该openid有没有绑定过教师账号，如果已绑定则转到点课中心
        String encryptKey = CookieUtils.getCookie(request, "encryptKey");
        if(StringUtils.isNotBlank(encryptKey)){
            EncryptionUtil.DecryptResult<String> decryptResult = EncryptionUtil.decrypt(encryptKey, String.class);
            boolean rightSign = decryptResult.isRightSign();
            if(rightSign){
                String openid = decryptResult.getT();
                User dbUser = new User();
                dbUser.setOpenid(openid);
                dbUser = userService.queryByOpenid(dbUser);
                if(dbUser==null){
                    //转到账号绑定页面
                    return "weixin/bindTeacher";
                }else{
                    //已经进行过账号绑定，直接转到点课中心
                    return "redirect:/weixin/toTeacherMain";
                }
            }
        }
        //转到获取授权信息页面
        CookieUtils.delAllCookie(request,response);
        return "redirect:/weixin/oauthGetCodeBySilence";
    }*/
}
