package com.lc.crm.dk.business.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.impl.BaseServiceImpl;
import com.lc.crm.dk.base.util.UUIDUtil;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.dto.TeacherWorkFlow;
import com.lc.crm.dk.business.mapper.StuCourseFlowMapper;
import com.lc.crm.dk.business.mapper.StuCourseRemainMapper;
import com.lc.crm.dk.business.mapper.StudentMapper;
import com.lc.crm.dk.business.mapper.TeacherWorkFlowMapper;
import com.lc.crm.dk.business.service.StudentService;

@Service
public class StudentServiceImpl extends BaseServiceImpl<Student> implements StudentService{
	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private StuCourseFlowMapper stuCourseFlowMapper;
	@Autowired
	private StuCourseRemainMapper stuCourseRemainMapper;
	@Autowired
	private TeacherWorkFlowMapper teacherWorkFlowMapper;
	
	@Override
	public BaseMapper<Student> getBaseMapper() {
		return studentMapper;
	}
	
	@Override
	public Student queryByNameAndPhone(Student stu){
		return studentMapper.queryByNameAndPhone(stu);
	}

	@Override
	public List<Student> queryStusByGrpId(Grp grp) {
		return studentMapper.queryStusByGrpId(grp);
	}

	
	/**
	 * 充值课程
	 */
	@Override
	@Transactional
	public void rechargeCourse(Map<String, Object> map) {
		//先查询是否有remain记录
		StuCourseRemain scr = stuCourseRemainMapper.queryStusRemainByCourseIdAndStuId(map);
		//学生课程剩余量添加
		if(null != scr){
			stuCourseRemainMapper.addCourseRemain(map);
		}else{
			stuCourseRemainMapper.insertCourseRemian(map);
		}
		//增加充值记录
		map.put("teacherWorkId", UUIDUtil.generate());
		stuCourseFlowMapper.addStuCourseFlow(map);
		if("1".equals(map.get("type").toString())){
			//1：充值，2：免费赠送
			//更新总充值费用
			studentMapper.updateStuTotalFee(map);
		}
	}
	
	
	private boolean studyCourse(Map<String, Object> map) {
		//是否有学生真是扣减了课程，没有则为false，有则为true
		boolean flag = false;
		//学生课程剩余量减少
		int resultCount = stuCourseRemainMapper.reduceCourseRemain(map);
		if(resultCount>0){
			//增加学习记录
			stuCourseFlowMapper.addStuCourseFlow(map);
			flag = true;
		}
		return flag;
	}
	
	
	/**
	 * 点课
	 */
	@Override
	@Transactional
	public void batchStudyCourse(List<Map<String,Object>> mapList) {
		//studentId,courseId,courseCount,type,rechargeFee,remark,operateId
		if(null!=mapList && (mapList.size()>0)){
			String twfId = UUIDUtil.generate();
			TeacherWorkFlow twf = new TeacherWorkFlow();
			twf.setId(twfId);
			twf.setTeacherId(Integer.parseInt(mapList.get(0).get("operateId").toString()));
			twf.setCourseId(Integer.parseInt(mapList.get(0).get("courseId").toString()));
			twf.setCourseCount(Integer.parseInt(mapList.get(0).get("courseCount").toString()));
			twf.setRemark(mapList.get(0).get("remark").toString());
			
			//实际扣课学生数
			int stuCount = 0;
			
			//此时点课是否真是有效，是否有学生真是扣减了课程，没有则为false，有则为true
			for(int i=0;i<mapList.size();i++){
				mapList.get(i).put("teacherWorkId", twfId);
				boolean tempflag = studyCourse(mapList.get(i));
				if(tempflag){
					stuCount++;
				}
			}
			
			twf.setStuCount(stuCount);
			if(stuCount>0){
				teacherWorkFlowMapper.insert(twf);
			}
		}
	}

	@Override
	public List<Student> queryStusByPhone(String phone) {
		return studentMapper.queryStusByPhone(phone);
	}
	
	
}
