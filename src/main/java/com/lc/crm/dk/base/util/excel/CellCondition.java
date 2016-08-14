package com.lc.crm.dk.base.util.excel;
/*
 * 文件名：ConditionType.java
 * 版权：Copyright by www.vyuns.com
 * 描述：
 * 修改人：WZB
 * 修改时间：2014-8-18
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */
/**
 * 暂时不提供日期方面的枚举,后期可以再拓展
 * 
 * @author WZB
 * @version 2014-8-19
 * @see CellCondition
 * @since
 */
public enum CellCondition {
    /**
     * GT大于
     * LT小于
     * GE大于等于
     * LE小于等于
     * EQ等于
     * NOT不等于
     * EQUALS字符串相等
     * BOUND 范围(即包括起始又包括结尾)
     * REGEX 匹配正则
     */
    GT,LT,GE,LE,EQ,NOT,EQUALS,BOUND,REGEX;
    
}
