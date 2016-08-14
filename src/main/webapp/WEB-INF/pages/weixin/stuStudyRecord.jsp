<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/static/include/c.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=no,minimum-scale=1" />
<link rel="apple-touch-icon" href="http://icon.zol-img.com.cn/m/images/apple-touch-icons/default.png" />
<link rel="stylesheet" href="${ctx}/static/compoment/wap/css/list.css">
<script src="${ctx}/static/script/m.c.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/static/compoment/layer/layer.js"></script>
<script type="text/javascript">
if(!com.lc.crm.dk.c.getCookie("bindPhone")){
	location.href = "${ctx}/weixin/toBindPhone";
}
</script>
<title>课程流水</title>
</head>
<body>
	<header>
		<div class="header" style="height: 3rem;line-height: 3rem;background: #1389FE;font-size: 1rem;color: #fff;text-align: center;">
			${student.name}(${course.courseName}|剩${param.remain}|学${param.alreadyStudy})
		</div>
	</header>
 
	<div class="account-menu menu" role="menu">
		<c:forEach items="${scfList}" var="b">
			<a role="menuitem" class="menuitem" href="javascript:layer.msg('备注：${b.remark}');">
				<em class="fav">
						<fmt:formatDate value="${b.createTime}" pattern="yyyyMMdd" />
						&nbsp;&nbsp;
						<c:if test="${b.type==0}">
							<font color="#FF0097">学习(教师：${b.operator.name})</font>
						</c:if>
						<c:if test="${b.type==1}">
							<font color="#19D062">充值(管理员)</font>
						</c:if>
						<c:if test="${b.type==2}">
							<font color="#19D062">赠送(管理员)</font>
						</c:if>
						&nbsp;&nbsp;
						${b.courseCount}节
				</em>
			</a>
		</c:forEach>
	</div>
</body>
</html>