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
    <link href="${ctx}/static/compoment/nav/nav_sytle.css" rel="stylesheet">
    <script src="${ctx}/static/compoment/nav/nav.js"></script>
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
        body{
            -moz-user-select:none;/*火狐*/
            -webkit-user-select:none;/*webkit浏览器*/
            -ms-user-select:none;/*IE10*/
            -khtml-user-select:none;/*早期浏览器*/
            user-select:none;
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
        <a role="menuitem" data-stuid="${scr.student.id}" data-href="${ctx}/weixin/queryStuStudyRecord?studentId=${scr.student.id}&courseId=${gsr.grp.courseId}" class="menuitem downContextMenuBtn" href="javascript:;">
            <i>操作</i>
            <em class="fav">
                    ${scr.student.name}&nbsp;&nbsp;剩${scr.remain}节&nbsp;&nbsp;学${scr.alreadyStudy}节
            </em>
        </a>
    </c:forEach>
</div>
<div class="bgDiv"></div>
<div class="downNav">
    <c:if test="${gsr.grp.courseType==0}">
        <span data-clickfun="showStudyCourseInPriveteDialog">立即点课</span>
    </c:if>
    <c:if test="${gsr.canStudyAll==1}">
        <span data-clickfun="showStudyCourseInPublicDialog">全部点课</span>
    </c:if>
    <span data-clickfun="toStuCourseFlow">学习记录</span>
    <span>取消操作</span>
</div>
</body>
<script type="text/javascript" >
    function toStuCourseFlow(){
        location.href = targetTriggerNode.attr("data-href");
    }
    function showStudyCourseInPriveteDialog(){
        var studentId = targetTriggerNode.attr("data-stuid");
        var fromUrl = encodeURIComponent(location.href);
        location.href = "${ctx}/weixin/toStuStudyCourse?operateType=single&studentId="+studentId+"&grpId=${gsr.grp.id}&fromUrl="+fromUrl;
    }
    function showStudyCourseInPublicDialog(){
        var fromUrl = encodeURIComponent(location.href);
        location.href = "${ctx}/weixin/toStuStudyCourse?operateType=all&grpId=${gsr.grp.id}&fromUrl="+fromUrl;
    }
</script>
</html>