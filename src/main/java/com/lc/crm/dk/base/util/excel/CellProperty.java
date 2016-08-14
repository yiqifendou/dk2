package com.lc.crm.dk.base.util.excel;

/*
 * 文件名：Property.java
 * 版权：Copyright by www.vyuns.com
 * 描述：
 * 修改人：WZB
 * 修改时间：2014-8-18
 * 跟踪单号：
 * 修改单号：
 * 修改内容：
 */
/**
 * 导出excel报表的列对象
 * 
 * @author WZB
 * @version 2014-8-18
 * @see CellProperty
 * @since
 */
public class CellProperty
{   
    //默认是0表示不启用强调样式判断,1启用强调样式，2表示根据条件Condition进行判断
    private CellStyle cellStyle = CellStyle.COMMON_STYLE;
    //方法名，后期通过反射调用对象的"get+methodName首字母大写"方法以获取列值
    private String methodName;
    //条件
    private CellCondition cellCondition;
    //参数列表
    private Object[] cellConditionParams;
    /**
     * 普通样式的列
     * @param methodName
     */
    public CellProperty(String methodName){
        this.methodName = methodName;
    }
    /**
     * 自定义样式的列
     * @param methodName
     * @param cellStyle
     * @param cellConditionDeail , >、<、.>=、<=、==、!= 一个值即可,equals时传入String,bounds时传入2个值前面传入小的，后面传入大的
     */
    public CellProperty(String methodName,CellStyle cellStyle,CellCondition cellCondition,Object[] cellConditionParams){
        this.methodName = methodName;
        this.cellStyle = cellStyle;
        //只有当为条件样式时才为condition赋值
        if(cellStyle == CellStyle.CONDITION_STYLE){
            this.cellCondition = cellCondition;
            this.cellConditionParams = cellConditionParams;
        }
    }
    
    
    public CellStyle getCellStyle()
    {
        return cellStyle;
    }
    public String getMethodName()
    {
        return methodName;
    }
    public CellCondition getCellCondition()
    {
        return cellCondition;
    }
    public Object[] getCellConditionParams()
    {
        return cellConditionParams;
    }
    
    
    
    
}
