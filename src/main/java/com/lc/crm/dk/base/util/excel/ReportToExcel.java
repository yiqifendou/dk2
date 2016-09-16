package com.lc.crm.dk.base.util.excel;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;

/**
 * excel导出工具类
 * 
 * @author yiqifendou
 *
 */
@SuppressWarnings("all")
public class ReportToExcel {
	/**
	 * 将list集合中的数据写入到excel中
	 * 
	 * @param response
	 *            httpservletresponse对象
	 * @param sheetName
	 *            第一个sheet表的名字
	 * @param title
	 *            标题名
	 * @param th
	 *            th头包含哪些字段（字符串数组类型）
	 * @param columnWidths
	 *            int[]类型数组，指定每一列的宽度
	 * @param dataList
	 *            list数据集合
	 * @param classFullName
	 *            list集合中的泛型对象
	 * @param methods
	 *            依次调用泛型对象的哪些方法来和th表头对应，注意：实现为反射，调用getxxx方法
	 * @param fileName
	 *            下载的文件名字
	 * @throws Exception
	 */
	public static void createDataExcel(HttpServletResponse response, String sheetName, String title, String[] th,
			int[] columnWidths, List dataList, Class<?> classFullName, String[] methods, String fileName)
					throws Exception {
		HSSFWorkbook workBook = new HSSFWorkbook();
		HSSFSheet sheet = workBook.createSheet(sheetName);
		// 设置每一列的宽度
		if (columnWidths != null) {
			for (int columnIndex = 0; columnIndex < columnWidths.length; columnIndex++) {
				sheet.setColumnWidth(columnIndex, columnWidths[columnIndex]);
			}
		} else {
			// columnWidths为空时设置每一类4000的宽度
			for (int columnIndex = 0; columnIndex < th.length; columnIndex++) {
				sheet.setColumnWidth(columnIndex, 4000);
			}
		}
		// 合并第一行和第二行作为excel的标题
		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, th.length - 1));
		HSSFCellStyle titleStyle = workBook.createCellStyle();
		HSSFFont titleFont = workBook.createFont();
		titleFont.setFontHeightInPoints((short) 15);
		titleFont.setColor(HSSFColor.BLUE.index);
		titleFont.setFontName("宋体");
		titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle.setFont(titleFont);
		// 标题水平居中
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER_SELECTION);
		// 标题垂直居中
		titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFRow firstRow = sheet.createRow(0);
		HSSFCell firstCell = firstRow.createCell(0);
		firstCell.setCellStyle(titleStyle);
		firstCell.setCellValue(title);

		// 设置excel表头
		HSSFRow secondRow = sheet.createRow(2);
		HSSFCellStyle thStyle = workBook.createCellStyle();
		HSSFFont thFont = workBook.createFont();
		thFont.setFontHeightInPoints((short) 12);
		thFont.setFontName("宋体");
		thFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		thStyle.setFont(thFont);
		for (int i = 0; i < th.length; i++) {
			HSSFCell cell = secondRow.createCell(i);
			cell.setCellStyle(thStyle);
			cell.setCellValue(th[i]);
		}
		// 设置excel正文普通列样式
		HSSFCellStyle bodyStyle = workBook.createCellStyle();
		bodyStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);

		// 设置excel正文强调列的样式
		HSSFCellStyle strongBodyStyle = workBook.createCellStyle();
		strongBodyStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		HSSFFont strongBodyFont = workBook.createFont();
		strongBodyFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		strongBodyFont.setColor(HSSFColor.RED.index);
		strongBodyStyle.setFont(strongBodyFont);
		// 日期格式化工具
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 所有的方法集合
		Method[] realMethods = new Method[methods.length];
		for (int c = 0; c < methods.length; c++) {
			realMethods[c] = classFullName.getDeclaredMethod(
					"get" + (methods[c].charAt(0) + "").toUpperCase() + methods[c].substring(1), null);
		}
		for (int j = 0 + 3; j < dataList.size() + 3; j++) {
			HSSFRow bodyRow = sheet.createRow(j);
			bodyRow.setHeightInPoints(20);
			Object obj = dataList.get(j - 3);
			for (int m = 0; m < th.length; m++) {
				Object value = realMethods[m].invoke(obj, null);
				HSSFCell bodyCell = bodyRow.createCell(m);
				bodyCell.setCellStyle(bodyStyle);
				if (null == value) {
					bodyCell.setCellValue("");
					continue;
				} else if (value instanceof Date) {
					bodyCell.setCellValue(sdf.format((Date) value));
					continue;
				} else {
					// 囊括 byte、short、long、String等其他所有的类型
					bodyCell.setCellValue(value.toString());
				}
			}
		}

		try {
			fileName = new String(fileName.getBytes(), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			response.setHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
			workBook.write(response.getOutputStream());
			response.getOutputStream().close();
			System.out.println("***************excel报表导出完毕*****************");
		}
	}

	/**
	 * 将list集合中的数据写入到excel中
	 * 
	 * @param response
	 *            httpservletresponse对象
	 * @param sheetName
	 *            第一个sheet表的名字
	 * @param title
	 *            标题名
	 * @param th
	 *            th头包含哪些字段（字符串数组类型）
	 * @param columnWidths
	 *            int[]类型数组，指定每一列的宽度
	 * @param dataList
	 *            list数据集合
	 * @param classFullName
	 *            list集合中的泛型对象
	 * @param cellPropertys
	 *            条件列属性（可以设置该列为普通样式、强调样式、条件样式）
	 *            依次调用泛型对象的哪些方法来和th表头对应，注意：实现为反射，调用getxxx方法
	 * @param fileName
	 *            下载的文件名字
	 * @throws Exception
	 */
	public static void createDataExcel(HttpServletResponse response, String sheetName, String title, String[] th,
			int[] columnWidths, List dataList, Class<?> classFullName, CellProperty[] cellPropertys, String fileName)
					throws Exception {
		HSSFWorkbook workBook = new HSSFWorkbook();
		HSSFSheet sheet = workBook.createSheet(sheetName);
		// 设置每一列的宽度
		if (columnWidths != null) {
			for (int columnIndex = 0; columnIndex < columnWidths.length; columnIndex++) {
				sheet.setColumnWidth(columnIndex, columnWidths[columnIndex]);
			}
		} else {
			// columnWidths为空时设置每一类4000的宽度
			for (int columnIndex = 0; columnIndex < th.length; columnIndex++) {
				sheet.setColumnWidth(columnIndex, 4000);
			}
		}
		// 合并第一行和第二行作为excel的标题
		sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, th.length - 1));
		HSSFCellStyle titleStyle = workBook.createCellStyle();
		HSSFFont titleFont = workBook.createFont();
		titleFont.setFontHeightInPoints((short) 15);
		titleFont.setColor(HSSFColor.BLUE.index);
		titleFont.setFontName("宋体");
		titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle.setFont(titleFont);
		// 标题水平居中
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER_SELECTION);
		// 标题垂直居中
		titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFRow firstRow = sheet.createRow(0);
		HSSFCell firstCell = firstRow.createCell(0);
		firstCell.setCellStyle(titleStyle);
		firstCell.setCellValue(title);

		// 设置excel表头
		HSSFRow secondRow = sheet.createRow(2);
		HSSFCellStyle thStyle = workBook.createCellStyle();
		HSSFFont thFont = workBook.createFont();
		thFont.setFontHeightInPoints((short) 12);
		thFont.setFontName("宋体");
		thFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		thStyle.setFont(thFont);
		for (int i = 0; i < th.length; i++) {
			HSSFCell cell = secondRow.createCell(i);
			cell.setCellStyle(thStyle);
			cell.setCellValue(th[i]);
		}
		// 设置excel正文普通列样式
		HSSFCellStyle bodyStyle = workBook.createCellStyle();
		bodyStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);

		// 设置excel正文强调列的样式
		HSSFCellStyle strongBodyStyle = workBook.createCellStyle();
		strongBodyStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		HSSFFont strongBodyFont = workBook.createFont();
		strongBodyFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		strongBodyFont.setColor(HSSFColor.BLACK.index);
		strongBodyStyle.setFont(strongBodyFont);
		// 日期格式化对象
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 所有的方法集合
		Method[] methods = new Method[cellPropertys.length];
		for (int c = 0; c < cellPropertys.length; c++) {
			methods[c] = classFullName
					.getDeclaredMethod("get" + (cellPropertys[c].getMethodName().charAt(0) + "").toUpperCase()
							+ cellPropertys[c].getMethodName().substring(1), null);
		}
		for (int j = 0 + 3; j < dataList.size() + 3; j++) {
			HSSFRow bodyRow = sheet.createRow(j);
			bodyRow.setHeightInPoints(20);
			Object obj = dataList.get(j - 3);
			for (int m = 0; m < th.length; m++) {
				Object value = methods[m].invoke(obj, null);
				HSSFCell bodyCell = bodyRow.createCell(m);
				// 设置列样式
				if (cellPropertys[m].getCellStyle() == CellStyle.COMMON_STYLE) {
					bodyCell.setCellStyle(bodyStyle);
				} else if (cellPropertys[m].getCellStyle() == CellStyle.STRONG_STYLE) {
					bodyCell.setCellStyle(strongBodyStyle);
				} else {
					// 先设定为常规列样式
					bodyCell.setCellStyle(bodyStyle);
					// 条件类型
					CellCondition cellCondition = cellPropertys[m].getCellCondition();
					// 条件参数
					Object[] cellConditionParams = cellPropertys[m].getCellConditionParams();
					// 暂时不提供日期等方面的条件样式
					if (value instanceof String) {
						if (cellCondition == CellCondition.EQUALS) {
							if (value.equals(cellConditionParams[0].toString())) {
								bodyCell.setCellStyle(strongBodyStyle);
							}
						}else if(cellCondition==CellCondition.REGEX){
							if (value.toString().matches(cellConditionParams[0].toString())) {
								bodyCell.setCellStyle(strongBodyStyle);
							}
						}
					} else {
						try {
							switch (cellCondition) {
							case GT:
								if (Double.parseDouble(value.toString()) > Double
										.parseDouble(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case LT:
								if (Double.parseDouble(value.toString()) < Double
										.parseDouble(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case GE:
								if (Double.parseDouble(value.toString()) >= Double
										.parseDouble(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case LE:
								if (Double.parseDouble(value.toString()) <= Double
										.parseDouble(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case EQ:
								if (Double.parseDouble(value.toString()) == Double
										.parseDouble(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case NOT:
								if (Double.parseDouble(value.toString()) != Double
										.parseDouble(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case BOUND:
								Double param1 = Double.parseDouble(cellConditionParams[0].toString());
								Double param2 = Double.parseDouble(cellConditionParams[1].toString());
								Double temp = null;
								if (param1 > param2) {
									temp = param1;
									param1 = param2;
									param2 = temp;
								}
								if (Double.parseDouble(value.toString()) >= param1
										&& Double.parseDouble(value.toString()) <= param2) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							case REGEX:
								if (value.toString().matches(cellConditionParams[0].toString())) {
									bodyCell.setCellStyle(strongBodyStyle);
								}
								break;
							}
						} catch (Exception e) {
							// 当出现类转换异常时还是常规样式，比如说日期类型,下面这行其实可以省略，自己领悟吧
							bodyCell.setCellStyle(bodyStyle);
						}
					}
				}

				// 给列设置值
				if (null == value) {
					bodyCell.setCellValue("");
					continue;
				} else if (value instanceof Date) {
					bodyCell.setCellValue(sdf.format((Date) value));
					continue;
				} else {
					// 囊括 byte、short、long、String等其他所有的类型
					bodyCell.setCellValue(value.toString());
					continue;
				}

			}
		}

		try {
			fileName = new String(fileName.getBytes(), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			response.setHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
			workBook.write(response.getOutputStream());
			response.getOutputStream().close();
			System.out.println("***************excel报表导出完毕*****************");
		}
	}

}
