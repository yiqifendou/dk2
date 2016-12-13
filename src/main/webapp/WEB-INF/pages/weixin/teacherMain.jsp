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
        .menu .menuitem em {
            line-height: 40px;
        }
        .account-menu em {
            padding-left: 0px;
        }
    </style>
</head>
<body>
<header>
    <div class="header" style="height: 3rem;line-height: 3rem;background: #1389FE;font-size: 1rem;color: #fff;text-align: center;">
        ${teacher.name}<%--(${teacher.account})--%>
    </div>
</header>



<div class="account-menu menu" role="menu">
    <c:forEach items="${grpList}" var="grp">
        <a role="menuitem" href="${ctx}/weixin/toGsrDetail?grpId=${grp.id}" class="menuitem">
            <i>详情</i>
            <em>
                ${grp.grpName}(${grp.courseName})
            </em>
        </a>
    </c:forEach>
</div>

</body>
</html>