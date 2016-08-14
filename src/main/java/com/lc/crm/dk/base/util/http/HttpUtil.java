package com.lc.crm.dk.base.util.http;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.CharsetUtils;
import org.apache.http.util.EntityUtils;

/**
 * 简单http请求工具类
 * 
 * @author yiqifendou
 * 
 */
public class HttpUtil {

	private static final Log logger = LogFactory.getLog(HttpUtil.class);
	private static final int CONNECTION_REQUEST_TIMEOUT = 10000;
	private static final int CONNECT_TIMEOUT = 10000;
	private static final int SOCKET_TIMEOUT = 10000;
	private static final String UTF8_CHARSET = "utf-8";

	public static String requestGet(String urlWithParams, Map<String, String> params) throws IOException {
		CloseableHttpClient httpclient = HttpClientBuilder.create().build();
		String resultStr = null;
		HttpGet httpget = null;
		CloseableHttpResponse response = null;
		try {
			// 拼接参数
			if (params != null && params.size() != 0) {
				StringBuilder paramsSbd = new StringBuilder();
				Set<String> keySet = params.keySet();
				for (String key : keySet) {
					paramsSbd.append("&").append(key).append("=")
							.append(URLEncoder.encode(params.get(key), UTF8_CHARSET));
				}
				if (urlWithParams.contains("?")) {
					urlWithParams = urlWithParams + paramsSbd.toString();
				} else {
					urlWithParams = urlWithParams + "?" + paramsSbd.toString().substring(1);
				}
			}
			System.out.println("urlWithParams-------------"+urlWithParams);
			httpget = new HttpGet(urlWithParams);
			// 配置请求的超时设置
			RequestConfig requestConfig = RequestConfig.custom().setConnectionRequestTimeout(CONNECTION_REQUEST_TIMEOUT)
					.setConnectTimeout(CONNECT_TIMEOUT).setSocketTimeout(SOCKET_TIMEOUT).build();
			httpget.setConfig(requestConfig);
			response = httpclient.execute(httpget);
			logger.info("statusLine -> " + response.getStatusLine());
			HttpEntity entity = response.getEntity();
			resultStr = EntityUtils.toString(entity, UTF8_CHARSET);
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("http请求出错" + e.getMessage());
			throw e;
		} finally {
			if (httpget != null) {
				httpget.releaseConnection();
			}
			if (response != null) {
				response.close();
			}
			httpclient.close();
		}
		return resultStr;
	}

	public static String requestGet(String urlWithParams) throws IOException {
		return requestGet(urlWithParams, null);
	}

	public static String requestPost(String url, Map<String, String> params) throws IOException {
		CloseableHttpClient httpclient = HttpClientBuilder.create().build();
		String resultStr = null;
		HttpPost httppost = null;
		CloseableHttpResponse response = null;
		try {
			httppost = new HttpPost(url);
			List<NameValuePair> parameters = new ArrayList<NameValuePair>();
			if (params != null && params.size() != 0) {
				for (String key : params.keySet()) {
					parameters.add(new BasicNameValuePair(key, params.get(key)));
				}
			}
			httppost.setEntity(new UrlEncodedFormEntity(parameters, UTF8_CHARSET));
			response = httpclient.execute(httppost);
			logger.info("statusLine -> " + response.getStatusLine());
			HttpEntity entity = response.getEntity();
			resultStr = EntityUtils.toString(entity, UTF8_CHARSET);
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("http请求出错" + e.getMessage());
			throw e;
		} finally {
			if (httppost != null) {
				httppost.releaseConnection();
			}
			if (response != null) {
				response.close();
			}
			httpclient.close();
		}
		return resultStr;
	}

	public static String requestPost(String url) throws IOException {
		return requestPost(url, null);
	}

	/**
	 * 通过流传递数据 Description:
	 * 
	 * @param url
	 * @param data
	 * @return
	 * @throws IOException
	 * @see
	 */
	public static String requestByStream(String url, String data) throws IOException {
		HttpURLConnection httpConn = null;
		InputStream is = null;
		try {
			httpConn = (HttpURLConnection) new URL(url).openConnection();
			httpConn.setRequestMethod("POST");
			httpConn.setDoInput(true);
			httpConn.setDoOutput(true);
			OutputStream out = httpConn.getOutputStream();
			OutputStreamWriter osw = new OutputStreamWriter(out, UTF8_CHARSET);
			osw.write(data);
			osw.flush();
			osw.close();
			out.close();
			is = httpConn.getInputStream();
			return InputStreamUtils.InputStreamToString(is);
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("http请求出错" + e.getMessage());
			throw e;
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static String uploadMedia(String uploadUrl, File f, String partName) throws IOException {
		CloseableHttpClient httpclient = HttpClientBuilder.create().build();
		String resultStr = null;
		HttpPost httppost = null;
		CloseableHttpResponse response = null;
		try {
			httppost = new HttpPost(uploadUrl);
			FileBody bin = new FileBody(f);
			/*
			 * StringBody uploadFileName = new StringBody("my.png",
			 * ContentType.create("text/plain", Consts.UTF_8));
			 */
			// 以浏览器兼容模式运行，防止文件名乱码。
			HttpEntity reqEntity = MultipartEntityBuilder.create().setMode(HttpMultipartMode.BROWSER_COMPATIBLE)
					.addPart(StringUtils.isEmpty(partName) ? "media" : partName, bin) // uploadFile对应服务端类的同名属性<File类型>
					// .addPart("uploadFileName", uploadFileName)//
					// uploadFileName对应服务端类的同名属性<String类型>
					.setCharset(CharsetUtils.get("UTF-8")).build();
			httppost.setEntity(reqEntity);
			logger.info("requestLine -> " + httppost.getRequestLine());
			response = httpclient.execute(httppost);
			logger.info("statusLine -> " + response.getStatusLine());
			HttpEntity entity = response.getEntity();
			resultStr = EntityUtils.toString(entity, UTF8_CHARSET);
		}catch (IOException e) {
			e.printStackTrace();
			logger.error("http请求出错" + e.getMessage());
			throw e;
		} finally {
			if (httppost != null) {
				httppost.releaseConnection();
			}
			if (response != null) {
				response.close();
			}
			httpclient.close();
		}
		return resultStr;
	}
	
	
	public static void downMedia(String url, String destFileName) throws IOException {
		FileUtils.copyURLToFile(new URL(url), new File(destFileName));
	}
	

}
