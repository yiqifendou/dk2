package com.lc.crm.dk.base.ctrl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lc.crm.dk.base.constant.Constant;
import com.lc.crm.dk.base.listener.ApplicationListener;

@Controller
@RequestMapping("/media")
public class FileUploadController extends BaseController{
		// 日志对象
		private static Log log = LogFactory.getLog(FileUploadController.class);
		private static SimpleDateFormat sdf = new SimpleDateFormat(
				"yyyyMMddHHmmssSSS");
		private static Random random = new Random();
		private static Boolean autoMatch = false;
		private static String saveBasePath;
		private static String mappingBasePath;
		//默认文件上传的最大大小
		private static Long defaultMaxSize;

		/**
		 * 静态快加载文件保存基础路径以及文件访问基础映射路径
		 */
		static {
			log.info("loading file upload config");
			Properties fileUploadProperties = new Properties();
			InputStream is = null;
			try {
				is = FileUploadController.class.getResourceAsStream("/conf/fileupload/fileupload.properties");
				fileUploadProperties.load(is);
				defaultMaxSize = Long.parseLong(fileUploadProperties.getProperty("defaultMaxSize"));
				autoMatch = Boolean.parseBoolean(fileUploadProperties.getProperty("autoMatch", "false"));
				if(autoMatch){
					String contextPath = ApplicationListener.getContextPath();
					if("".equals(contextPath)){
						saveBasePath = new File(ApplicationListener.getProjectRealPath()).getParent()+"/_fileupload/";
						mappingBasePath = "/_fileupload/";
					}else{
						saveBasePath = new File(ApplicationListener.getProjectRealPath()).getParent()+contextPath+"_fileupload/";
						mappingBasePath = contextPath+"_fileupload/";
					}
					
				}else{
					String tempSaveBasePath = fileUploadProperties
							.getProperty("saveBasePath");
					String tempMappingBasePath = fileUploadProperties
							.getProperty("mappingBasePath");
					if ("/".equals(tempSaveBasePath.substring(tempSaveBasePath.length() - 1))) {
						saveBasePath = tempSaveBasePath;
					} else {
						saveBasePath = tempSaveBasePath + "/";
					}
					if ("/".equals(tempMappingBasePath.substring(tempMappingBasePath.length() - 1))) {
						mappingBasePath = tempMappingBasePath;
					} else {
						mappingBasePath = tempMappingBasePath + "/";
					}
				}
				log.info("file upload config:saveBasePath:"+saveBasePath+" mappingBasePath:"+mappingBasePath+" defaultMaxSize:"+defaultMaxSize);
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if(is!=null){
						is.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		@RequestMapping("/upload")
		public void upload(HttpServletRequest request,HttpServletResponse response){
			executeUpload(request,response,"general","file");
		}
		
		@RequestMapping("/upload2/{fileId}")
		public void upload2(HttpServletRequest request,HttpServletResponse response,@PathVariable String fileId){
			executeUpload(request,response,"general",fileId);
		}
		
		@RequestMapping("/upload3/{moduleName}/{fileId}")
		public void upload3(HttpServletRequest request,HttpServletResponse response,@PathVariable String moduleName,@PathVariable String fileId){
			executeUpload(request,response,moduleName,fileId);
		}
		
		@RequestMapping("/kindeditorUpload")
		public void kindeditorUpload(HttpServletRequest request,HttpServletResponse response){
			try {
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
				MultipartFile mf = multipartRequest.getFile("imgFile");
				String originalFileName = mf.getOriginalFilename();
				//文件类型
				//String fileContentType = mf.getContentType();
				long fileSize = mf.getSize();
				if(fileSize>defaultMaxSize){
					responseToBrowser(response,"{\"error\":1,\"message\":\"文件大小超过限制,最大允许上传"+defaultMaxSize+"字节\"}");
				}else if(fileSize<=0){
					responseToBrowser(response,"{\"error\":1,\"message\":\"文件大小异常\"}");
				}else{
					String moduleName = "kindeditor";
					String destPath = getDestPath(originalFileName);
					File destFile = new File(saveBasePath+moduleName+"/"+destPath);
					if(!destFile.getParentFile().exists()){
						destFile.getParentFile().mkdirs();
					}
					mf.transferTo(destFile);
					responseToBrowser(response,"{\"error\":0,\"message\":\"文件上传成功\",\"url\":\""+mappingBasePath+moduleName+"/"+destPath+"\"}");
				}
			}catch (IOException e) {
				e.printStackTrace();
				responseToBrowser(response,"{\"error\":1,\"message\":\"服务器异常\"}");
			}
		}
		
		
		private void executeUpload(HttpServletRequest request,HttpServletResponse response,String moduleName,String fileId){
			try {
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
				MultipartFile mf = multipartRequest.getFile(fileId);
				String originalFileName = mf.getOriginalFilename();
				//文件类型
				//String fileContentType = mf.getContentType();
				long fileSize = mf.getSize();
				
				long allowMaxSize = request.getParameter("maxsize")!=null?Long.parseLong(request.getParameter("maxsize")):defaultMaxSize;
				if(fileSize>allowMaxSize){
					responseToBrowser(response,"{\"status\":"+Constant.Code.STATUS_EXCEPTION+",\"message\":\"文件大小超过限制,最大允许上传"+allowMaxSize+"字节\"}");
				}else if(null == mf || fileSize<=0){
					responseToBrowser(response,"{\"status\":"+Constant.Code.STATUS_EXCEPTION+",\"message\":\"文件大小异常\"}");
				}else{
					String destPath = getDestPath(originalFileName);
					File destFile = new File(saveBasePath+moduleName+"/"+destPath);
					if(!destFile.getParentFile().exists()){
						destFile.getParentFile().mkdirs();
					}
					mf.transferTo(destFile);
					System.out.println("path:"+destFile.getPath());
					responseToBrowser(response,"{\"status\":"+Constant.Code.STATUS_OK+",\"message\":\"文件上传成功\",\"src\":\""+mappingBasePath+moduleName+"/"+destPath+"\"}");
				}
			} catch (NumberFormatException e) {
				e.printStackTrace();
				responseToBrowser(response,"{\"status\":"+Constant.Code.STATUS_EXCEPTION+",\"message\":\"maxsize格式不正确\"}");
			} catch (Exception e) {
				e.printStackTrace();
				responseToBrowser(response,"{\"status\":"+Constant.Code.STATUS_EXCEPTION+",\"message\":\"服务器异常\"}");
			}
		}
		
		
		/**
		 * 创建目标路径 如: basePath/2014/09/21/2014092115234_12345.png
		 * 
		 * @return
		 */
		private String getDestPath(String fileFileName) {
			String destPath = null;
			Date now = new Date();
			String timeStamp = sdf.format(now);
			destPath = timeStamp.substring(0, 4) + "/" + timeStamp.substring(4, 6)
					+ "/" + timeStamp.substring(6, 8) + "/" + timeStamp + "_"
					+ zeroFill(random.nextInt(10000))
					+ fileFileName.substring(fileFileName.lastIndexOf("."));
			return destPath;
		}
		
		/**
		 * 左补零
		 * @param digital
		 * @return
		 */
		private String zeroFill(Integer digital){
			String result = digital.toString();
			int zeroLen = 4-result.length();
			if(zeroLen>0){
				for(int i=0;i<zeroLen;i++){
					result = "0"+result;
				}
				return result;
			}else{
				return result;
			}
		}
		
		
}
