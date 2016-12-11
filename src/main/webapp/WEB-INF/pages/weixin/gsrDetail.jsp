<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/static/include/c.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=no,minimum-scale=1" />
    <link rel="apple-touch-icon" href="http://icon.zol-img.com.cn/m/images/apple-touch-icons/default.png" />
    <link rel="stylesheet" href="${ctx}/static/compoment/wap/css/list.css">
    <script src="${ctx}/static/script/m.c.js" type="text/javascript"></script>
    <title>教师点课中心</title>
    <script type="text/javascript" src="${ctx}/static/compoment/layer/layer.js"></script>
    <title>教师点课(${teacher.name})</title>
    <style type="text/css">
        .menu .menuitem {
            height: 41px;
        }
        .menu .menuitem i{
            line-height: 41px;
        }
        .account-menu .fav {
            background-position: 0 -40px;
            margin-top: 10px;
        }
        a:last-child{
            border-bottom:1px solid #f0f1f2;
        }
        .btn{
            margin-top:50px;
            width: 100%;
            height: 2.5rem;
            line-height: 2.5rem;
            border-radius: .3125rem;
            background: #1389FE;
            font-size: 1rem;
            color: #fff;
            text-align: center;
        }
    </style>
</head>
<body>
<header>
    <div class="header" style="height: 3rem;line-height: 3rem;background: #1389FE;font-size: 1rem;color: #fff;text-align: center;">
        ${gsr.grp.grpName}(${gsr.grp.courseName})
    </div>
</header>

<div class="account-menu menu" role="menu">
    <c:forEach items="${gsr.stuCourseRemainList}" var="scr" varStatus="i">
        <a role="menuitem" href="${ctx}/weixin/queryStuStudyRecord?studentId=${scr.student.id}&courseId=${gsr.grp.courseId}" class="menuitem" href="javascript:;">
            <i>操作</i>
            <em class="fav">
                    ${scr.student.name}&nbsp;&nbsp;剩${scr.remain}节&nbsp;&nbsp;学${scr.alreadyStudy}节
                       <%--<<td align="center" style="background-color:#0CDDFF;">
                            <c:if test="${gsr.grp.courseType==0}">
                                <a style="color:white;margin-right: 20px;"	width="600" height="300" target="dialog" rel="studyCourseDialog" mask="true"
                                   href="${ctx}/student/toStudyCourseDialog?operateType=single&grpId=${gsr.grp.id}&studentId=${scr.student.id}" >点课</a>
                            </c:if>
                            <a style="color:white;"	target="navTab" rel="courseFlowList" title="课程流水" fresh="true" external="false"
                               href="${ctx}/student/courseFlowList?studentId=${scr.student.id}&courseId=${gsr.grp.courseId}" >流水</a>
                        </td>--%>
            </em>
        </a>
    </c:forEach>
</div>
<c:if test="${gsr.canStudyAll==1}">
    <div class="btn-box" <%--onclick="location.href ='${ctx}/student/studyCourseInPublic?grpId=${param.grpId}'"--%> style="padding: 0;">
        <div id="studyCourseInPublicBtn" class="btn">点课(all)</div>
    </div>
</c:if>
</body>
<script type="text/javascript">
    $("#studyCourseInPublicBtn").on("click",function(){
        layer.prompt(function(val, index){
            layer.msg('得到了'+val);
            layer.close(index);
        });
    });
</script>
</html>