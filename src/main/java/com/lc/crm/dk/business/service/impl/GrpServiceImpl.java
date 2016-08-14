package com.lc.crm.dk.business.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.dto.MapExt;
import com.lc.crm.dk.base.mapper.BaseMapper;
import com.lc.crm.dk.base.service.impl.BaseServiceImpl;
import com.lc.crm.dk.business.dto.Grp;
import com.lc.crm.dk.business.dto.GrpStuMapping;
import com.lc.crm.dk.business.dto.ResponseVo;
import com.lc.crm.dk.business.dto.StuCourseRemain;
import com.lc.crm.dk.business.dto.Student;
import com.lc.crm.dk.business.mapper.GrpMapper;
import com.lc.crm.dk.business.mapper.GrpStuMappingMapper;
import com.lc.crm.dk.business.mapper.StuCourseRemainMapper;
import com.lc.crm.dk.business.mapper.StudentMapper;
import com.lc.crm.dk.business.service.GrpService;

@Service
public class GrpServiceImpl extends BaseServiceImpl<Grp> implements GrpService{
	@Autowired
	private GrpMapper grpMapper;
	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private GrpStuMappingMapper grpStuMappingMapper;
	@Autowired
	private StuCourseRemainMapper stuCourseRemainMapper;
	
	@Override
	public BaseMapper<Grp> getBaseMapper() {
		return grpMapper;
	}
	
	/**
	 * 有切面事物控制
	 */
	@Override
	public ResponseVo addGrpAndGrpStus(Grp grp, String cStuIds) {
		ResponseVo responseVo = new ResponseVo();
		synchronized (GrpServiceImpl.class) {
			//添加班级,要根据grpName,courseId,teacherId组合查重
			Grp dbGrp = grpMapper.queryByNameAndCourseIdAndTeacherId(grp);
			if(dbGrp==null){
				//可以添加
				grpMapper.insert(grp);
				dbGrp = grpMapper.queryByNameAndCourseIdAndTeacherId(grp);
				if(StringUtils.isNotEmpty(cStuIds)){
					//添加班级学生,先查询这些学生是否都有课
					List<StuCourseRemain> sList =  stuCourseRemainMapper.queryCanJoinGrpStuIds(new MapExt<String,Object>("courseId",grp.getCourseId()));
					String stuIdsReg = "";
					for(StuCourseRemain s:sList){
						stuIdsReg+="|(^"+s.getStudentId()+"$)";
					}
					if(StringUtils.isNotEmpty(stuIdsReg)){
						stuIdsReg = stuIdsReg.substring(1);
						List<GrpStuMapping> gsmList = new ArrayList<GrpStuMapping>();
						String[] cStuIdArr = cStuIds.split(",");
						//对cStuIdArr去重
						Map<String,Object> cStuIdMap = new HashMap<String,Object>();
						for(String sId:cStuIdArr){
							cStuIdMap.put(sId, null);
						}
						Set<String> cStuIdSet = cStuIdMap.keySet();
						for(String sId:cStuIdSet){
							if(sId.matches(stuIdsReg)){
								GrpStuMapping gsm = new GrpStuMapping();
								gsm.setGrpId(dbGrp.getId());
								gsm.setStudentId(Integer.parseInt(sId));
								gsmList.add(gsm);
							}
						}
						if(gsmList.size()>0){
							grpStuMappingMapper.addGrpStus(gsmList);
						}
					}
				}
			}else{
				responseVo.setStatus(Constant.Code.ACCOUNT_EXIST);
				responseVo.setMsg("班级重复了哦！");
			}
			return responseVo;
		}
	}

	@Override
	public ResponseVo updateGrpAndGrpStus(Grp grp, String cStuIds) {
		ResponseVo responseVo = new ResponseVo();
		synchronized (GrpServiceImpl.class) {
			grpMapper.updateByPrimaryKey(grp);
			Grp dbGrp = grpMapper.selectByPrimaryKey(grp.getId());
			//查询班级原有学员
			List<Student> existSstudentList = studentMapper.queryStusByGrpId(grp);
			Set<Integer> existStuIds = new HashSet<Integer>();
			for(Student s:existSstudentList){
				existStuIds.add(s.getId());
			}
			Set<Integer> newStuIds = new HashSet<Integer>();
			if(StringUtils.isNotEmpty(cStuIds)){
				String[] newStuIdArr = cStuIds.split(",");
				for(String sid:newStuIdArr){
					newStuIds.add(Integer.parseInt(sid));
				}
			}
			//计算出应该删除的，可以添加的
			String[] delAndAddStuIds = calGrpAddStusAndDelStus(existStuIds, newStuIds);
			
			//删除对应的学生
			if(StringUtils.isNotEmpty(delAndAddStuIds[0])){
				grpStuMappingMapper.deleteGrpStuIds(new MapExt<String,Object>("grpId",dbGrp.getId(),"delStudentIds",delAndAddStuIds[0].substring(1)));
			}
			//添加对应的学生
			String addStuIds = delAndAddStuIds[1];
			if(StringUtils.isNotEmpty(addStuIds)){
				//添加班级学生,先查询这些学生是否都有课
				List<StuCourseRemain> sList =  stuCourseRemainMapper.queryCanJoinGrpStuIds(new MapExt<String,Object>("courseId",dbGrp.getCourseId()));
				String stuIdsReg = "";
				for(StuCourseRemain s:sList){
					stuIdsReg+="|(^"+s.getStudentId()+"$)";
				}
				if(StringUtils.isNotEmpty(stuIdsReg)){
					stuIdsReg = stuIdsReg.substring(1);
					List<GrpStuMapping> gsmList = new ArrayList<GrpStuMapping>();
					String[] cStuIdArr = addStuIds.split(",");
					//对cStuIdArr去重
					Map<String,Object> cStuIdMap = new HashMap<String,Object>();
					for(String sId:cStuIdArr){
						cStuIdMap.put(sId, null);
					}
					Set<String> cStuIdSet = cStuIdMap.keySet();
					for(String sId:cStuIdSet){
						if(sId.matches(stuIdsReg)){
							GrpStuMapping gsm = new GrpStuMapping();
							gsm.setGrpId(dbGrp.getId());
							gsm.setStudentId(Integer.parseInt(sId));
							gsmList.add(gsm);
						}
					}
					if(gsmList.size()>0){
						grpStuMappingMapper.addGrpStus(gsmList);
					}
				}
			}
			return responseVo;
		}
	}
	
	/**
	 * 计算某个班级应该删除的和应该添加的学生
	 * @return
	 */
	private String[] calGrpAddStusAndDelStus(Set<Integer> existStuIds,Set<Integer> newStuIds){
		String delStuIds = "";
		String addStuIds = "";
		for(Integer id:existStuIds){
			if(!newStuIds.contains(id)){
				delStuIds+=(","+id);
			}
		}
		for(Integer id:newStuIds){
			if(!existStuIds.contains(id)){
				addStuIds+=(","+id);
			}
		}
		return new String[]{delStuIds,addStuIds};
	}

	@Override
	public List<Grp> queryGrpsByTeacherId(int teacherId) {
		return grpMapper.queryGrpsByTeacherId(teacherId);
	}

	@Override
	public int stuInGrp(Map<String, Object> map) {
		return grpStuMappingMapper.stuInGrp(map);
	}
	
	/**
	 * 查询某个学生在哪些班级下
	 * @param studentId
	 * @return
	 */
	@Override
	public List<Grp> queryGrpsByStudentId(int studentId) {
		return grpMapper.queryGrpsByStudentId(studentId);
	}
	
}
