---------------------------------------------------------------------------------------------------------------------------------------
一、框架说明
1.分页语句不需要写count语句，因为mybatis的分页插件已经做了语句拦截，分页示例如下
@Override
public PageInfo queryByPage(int pageNum,int pageSize) {
	PageHelper.startPage(pageNum, pageSize);
	//其实page对象是arrayList的子类，该对象含有很多分页信息，但是el无法拿出来，所以用pageInfo封装一下
	List<TestCourse> page = this.testCourseDao.queryList();
	PageInfo<TestCourse> pi = new PageInfo<TestCourse>(page);
	return pi;
}
2.阿里数据源最初设置
<bean name="dataSource" class="com.alibaba.druid.pool.DruidDataSource"
		init-method="init" destroy-method="close">
		<property name="url" value="${jdbc.url}" />
		<property name="username" value="${jdbc.username}" />
		<property name="password" value="${jdbc.password}" />
		<!-- 初始化连接大小 -->
		<property name="initialSize" value="0" />
		<!-- 连接池最大使用连接数量 -->
		<property name="maxActive" value="20" />
		<!-- 连接池最小空闲 -->
		<property name="minIdle" value="0" />
		<!-- 获取连接最大等待时间 -->
		<property name="maxWait" value="60000" />
		<property name="poolPreparedStatements" value="true" />
		<property name="maxPoolPreparedStatementPerConnectionSize"
			value="33" />
		<!-- 用来检测有效sql -->
		<property name="validationQuery" value="${validationQuery}" />
		<property name="testOnBorrow" value="false" />
		<property name="testOnReturn" value="false" />
		<property name="testWhileIdle" value="true" />
		<!-- 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 -->
		<property name="timeBetweenEvictionRunsMillis" value="60000" />
		<!-- 配置一个连接在池中最小生存的时间，单位是毫秒 -->
		<property name="minEvictableIdleTimeMillis" value="25200000" />
		<!-- 打开removeAbandoned功能 -->
		<property name="removeAbandoned" value="true" />
		<!-- 1800秒，也就是30分钟 -->
		<property name="removeAbandonedTimeout" value="1800" />
		<!-- 关闭abanded连接时输出错误日志 -->
		<property name="logAbandoned" value="true" />
		<!-- 监控数据库 -->
		<property name="filters" value="mergeStat" />
	</bean>
	
3.如果要更改项目名称需要全局替换"/webapp"为对应的项目名称,以及改变/WEB-INF/pages/common/c.html中的ctxPath,com.lc.crm.app.base.constant.Constant.CONTEXTPATH


4.同步和异步session校验不通过解决方案
(1).同步，直接redirect到errorRequestMapping页面，如果是easyui同步提交表单，则$("body").html(errorRequestMapping页面html内容);
(2).异步（ajax），响应{"status":Constant.STATUS_SESSION_NOTPASS,"msg":"session校验不通过，点击获取<a href='"+Constant.CONTEXTPATH+errorRequestMapping+"'>详情</a>!"},
easyui的datagrid中列表请求会进行响应拦截，然后提示对应session校验不通过详情(jquery.easyui.min.js,line:9696)

5.banner文字生成http://www.jiqie.com/b/1.htm

6.每个页面必须引入<#include "/common/c.html" />
---------------------------------------------------------------------------------------------------------------------------------------
二.相关配置说明
1.linkIntercept.xml
用于配置可以自由访问的链接，即可以盗链

2.sessionIntercept.xml
<!--
		session拦截配置,拦截某些requestMapping,false时一率转到errPage所对应的页面 
		handleClass:处理类
		handleMethod：处理方法
		errorRequestMapping:session校验不通过时转发的页面
		requestMappings:以逗号分割
	-->
	

---------------------------------------------------------------------------------------------------------------------------------------
三.框架使用说明
1.表单验证
引入formvalidate.expand.js(需要先引入jquery)就可以在input等元素中加入check属性(里面为json)来进行表单的提交检测,可以掉用checkForSubmit来进行js手动提交表单的检验
如：
<input class="inputbtn" maxlength="20" name="account"
check="{'required':true,'remote':{'type':'post','url':'${ctxPath}/rbacUser/checkAccountRepeat','data':{'account':function(){return $('#account').val();}}}}" />

<input type="button" onclick="checkForSubmit(0,checkValidateCode);" class="rlogin"	value="注册" />
								
<style type="text/css">
	label.error {
		color: red;
	}
</style>
用来制定检验不通过的样式
注意:需要验证的input必须有name属性


2.文件上传
引入fileupload.expand.js(需要先引入jquery)
(1)图片上传  moduleName(子模块名)和maxsize(byte)可以不传，suffix(如：部分后缀suffix="jpg,png"所有后缀suffix="all")后缀必须传,表示允许上传的文件后缀
<div>	
		<input type="hidden"  name="f2" value="${ctxPath}/static/imgs/nopicture.jpg" />
		<img src="${ctxPath}/static/imgs/nopicture.jpg" width="120px" height="100px" />
		<input moduleName="test" type="file" style="display: none;" suffix="all" name="wolegequ"  maxsize="10240110" />
		<input style="width:100px; height: 35px; background-color:#FF5D33;color: #FFF;font-size: 14px; border:none;" type="button"  value="上传">  
</div> 
<div>	
		<input type="hidden"  name="f3" value="${ctxPath}/static/imgs/nopicture.jpg"/>
		<img src="${ctxPath}/static/imgs/nopicture.jpg" width="120px" height="100px" />
		<input  type="file" style="display: none;"  suffix="jpg" name="file" maxsize="10240110" />
		<input style="width:100px; height: 35px; background-color:#FF5D33;color: #FFF;font-size: 14px; border:none;" type="button"  value="上传">  
</div> 
(2)文件上传，类同图片上传
<div> 
	<input type="text" name="production" style="border-style: solid;border-width: 1px;border-color: #FF5D33;width: 400px;height: 30px;" readonly="readonly">
	<input style="display: none;" suffix="all" type="file" name="file" />
	<input style="width:100px; height: 35px; margin-left:-5px; background-color:#FF5D33;color: #FFF;font-size: 14px; border:none;" type="button"  value="上传">	
</div>
	
tomcat中server.xml应该加入<Context crossContext="true" docBase="D:/fileupload" path="/data/tomcat/fileupload" reloadable="true" />
	 与config/file/fileupload.properties里面的配置要相同
	 
	 
3.kindEditor
引入	<script src="js/common/jquery.js" type="text/javascript"></script>
	<script src="js/editor/kindeditor.js" type="text/javascript"></script>
	textarea的editor="true"(不需要设定次属性)
(1)手动提交需要手动调用syncAllEditor()方法，已完成html内容同步
(2)submit按钮提交则不需要调用syncAllEditor()方法
如：
<form action="#" method="post">
	<div>
		<textarea  name="aaa"  editor="true"
			style="width: 700px; height: 300px;">
		</textarea>
		<textarea  name="bbb"  editor="true"
			style="width: 700px; height: 300px;">
		</textarea>
		<textarea  name="ccc"  editor="true"
			style="width: 700px; height: 300px;">
		</textarea>
	</div>
	<input type="submit" value="tijiao" />  
	<input type="button" value="button" onclick="syncAllEditor();document.forms[0].submit();" />
</form>



请一定要阅读这个文件哦