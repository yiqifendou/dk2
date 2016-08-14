package com.lc.crm.dk.business.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
	private static final DateFormat DATE_PATTERN = new SimpleDateFormat("yyyy-MM-dd");
	private static final DateFormat DATE_TIME_PATTERN = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static Date parseDate(String dateStr) throws ParseException{
		return DATE_PATTERN.parse(dateStr);
	}
	public static Date parseDateTime(String dateTimeStr) throws ParseException{
		return DATE_TIME_PATTERN.parse(dateTimeStr);
	}
	public static Date parse(String dStr,String patternStr) throws ParseException{
		return new SimpleDateFormat(patternStr).parse(dStr);
	}
	public static String formatDate(Date date){
		return DATE_PATTERN.format(date);
	}
	public static String formatDateTime(Date date){
		return DATE_TIME_PATTERN.format(date);
	}
	public static String formatDateTime(Date date,String patternStr){
		return new SimpleDateFormat(patternStr).format(date);
	}
}
