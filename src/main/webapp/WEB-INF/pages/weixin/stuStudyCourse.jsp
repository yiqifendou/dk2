<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="format-detection" content="address=no">
<meta name="format-detection" content="email=no">
<link rel="stylesheet" href="${ctx}/static/compoment/wap/css/bind.min.css">
<script src="${ctx}/static/script/m.c.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/compoment/layer/layer.js"></script>
<title>点课信息</title>
</head>
<body>
	<header>
		<div class="header">
			填写点课信息
		</div>
	</header>

	<div class="form-section">
        <div class="form-group">
            <label>类型</label>
            <font style="color:gray;margin-left:32px;">
                <c:if test="${param.operateType=='all'}">
                    集体点课
                </c:if>
                <c:if test="${param.operateType=='single'}">
                       单个点课
                </c:if>
            </font>
            <i class="vl-clear js-vl-clear"></i>
        </div>
        <div class="form-group">
            <label>班级</label>
            <font style="color:gray;margin-left:32px;">
                ${grp.grpName}(${grp.courseName})
            </font>
            <i class="vl-clear js-vl-clear"></i>
        </div>
        <c:if test="${not empty student}" >
            <div class="form-group">
                <label>学生</label>
                <font style="color:gray;margin-left:32px;">
                        ${student.name}
                </font>
                <i class="vl-clear js-vl-clear"></i>
            </div>
        </c:if>
		<div class="form-group">
			<label>课时</label>
			<input type="number" id="courseCount" pattern="[0-9]*" placeholder="课时" class="js-input" maxlength="20">
			<i class="vl-clear js-vl-clear"></i>
		</div>
		<div class="form-group">
			<label>备注</label>
			<input type="text" id="remark"  placeholder="备注" class="js-input" maxlength="20">
			<i class="vl-clear js-vl-clear"></i>
		</div>
	</div>
	<div class="btn-box" style="padding: 0;">
		<div class="btn" id="studyBtn">立即点课</div>
	</div>
	<script type="text/javascript">
		$(function(){
           init();
		    function init(){
                var now = new Date();
                var monthStr = (now.getMonth()+1)+"";
                if(monthStr.length==1){
                    monthStr="0"+monthStr;
                }
                var ymd = now.getFullYear()+monthStr+now.getDate();
                var remark = ymd+"日学习";
                $("#remark").val(remark);
            }

            var canStudy = true;

			$("#studyBtn").on("click",function(){
                var courseCount = $("#courseCount").val();
                if(!courseCount){
                    layer.msg("请输入课时数");
                    return;
                }
                var remark = $("#remark").val();
                if(!remark){
                    layer.msg("请输入备注");
                    return;
                }
			    var flag = confirm("确认点课吗?");
                if(flag&&canStudy){
                    canStudy = false;
                    var data = {};
                    data.courseCount = courseCount;
                    data.remark = remark;
                    var operateType = "${param.operateType}";
                    data.operateType = operateType;
                    var grpId = "${param.grpId}";
                    data.grpId = grpId;
                    var url;
                    if(operateType=="all"){
                        url = "${ctx}/weixin/studyCourseInPublic";
                    }else{
                        data.studentId = "${param.studentId}";
                        url = "${ctx}/weixin/studyCourseInPrivete";
                    }
                    $.ajax({
                        type:"post",
                        url:url,
                        dataType:"json",
                        data:data,
                        success:function(rs){
                            if(rs.status==0){
                                alert("点课成功！");
                                var fromUrl = decodeURIComponent("${param.fromUrl}");
                                location.href = fromUrl;
                            }else{
                                layer.msg(rs.msg);
                            }
                            //canStudy = true;
                        },
                        error:function(){
                            layer.msg("系统繁忙！");
                            //canStudy = true;
                        }
                    });
                }
			});
		});


	</script>
</body>
</html>