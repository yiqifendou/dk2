package com.lc.crm.dk.base.charset;

import java.nio.charset.Charset;

import org.springframework.http.converter.StringHttpMessageConverter;

public class UTF8HttpMessageConverter extends StringHttpMessageConverter{
	public UTF8HttpMessageConverter() {
		super(Charset.forName("UTF-8"));
	}
}
