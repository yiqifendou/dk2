<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="panelBar">
		<div class="pages">
			<span>显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value})">
				<option <c:if test="${p.numPerPage == 10}">selected="selected"</c:if>  value="10">10</option>
			<option <c:if test="${p.numPerPage == 20}">selected="selected"</c:if>  value="20">20</option>
			<option <c:if test="${p.numPerPage == 50}">selected="selected"</c:if>  value="50">50</option>
			<option <c:if test="${p.numPerPage == 100}">selected="selected"</c:if>  value="100">100</option>
			<option <c:if test="${p.numPerPage == 200}">selected="selected"</c:if>  value="200">200</option>
		</select> <span>条，共${p.totalCount}条，${p.totalPage}页</span>
	</div>

	<div class="pagination" targetType="navTab" totalCount="${p.totalCount}"
		numPerPage="${p.numPerPage}" pageNumShown="${p.pageNumShown}" currentPage="${p.pageNum}"></div>
</div>