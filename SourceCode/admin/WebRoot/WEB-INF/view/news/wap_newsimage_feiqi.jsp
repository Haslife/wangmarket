<%@page import="com.xnx3.selfSite.entity.News"%>
<%@page import="com.xnx3.j2ee.Global"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
${headHtml}
<body>
<!-- 网站顶部标题栏 -->
${topHtml}
<script type="text/javascript">
//form提交验证
function validate(){
	if(document.getElementById('input_title').value.length == 0 || document.getElementById('input_title').value.length > 30){
		$.alert("请输入30个字以内的标题", "提示！");
		document.getElementById('input_title').focus();
		return false;
	}
	$.showLoading('正在保存中');
	return true;
}
</script>
<form action="saveNews.do" enctype="multipart/form-data" class="weui_cells weui_cells_form" method="post" onsubmit="return validate();">
	<input type="hidden" name="id" value="${news.id }" />
	<input type="hidden" name="cid" value="${siteColumn.id }" />
	<input type="hidden" name="type" value="<%=News.TYPE_IMAGENEWS %>" />
	
	<div class="weui_cell">
		<div class="weui_cell_hd"><label class="weui_label">标题：</label></div>
		<div class="weui_cell_bd weui_cell_primary">
			<input class="weui_input" type="text" id="input_title" name="title" placeholder="(30个汉字之内，必填)" value="${news.title }">
		</div>
	</div>
	<div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label">列表图：</label></div>
        <div class="weui_cell_bd weui_cell_primary">
        	<input type="file" class="weui_input" value="" name="titlePicFile" />
        </div>
        <div class="weui_cell_ft">
        	${titlepicImage }
        </div>
     </div>
	<div class="weui_cells weui_cells_form">
      <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
          <textarea class="weui_textarea" id="ueditorText" placeholder="请输入新闻内容" name="text" rows="3">${text }</textarea>
        </div>
      </div>
    </div>
	<div class="weui_btn_area">
        <input class="weui_btn weui_btn_primary" type="submit" value="保存">
    </div>
</form>
				
<!-- 配置文件 -->
<script type="text/javascript" src="<%=basePath %>/module/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="<%=basePath %>/module/ueditor/ueditor.all.js"></script>
<!-- 实例化编辑器 -->
<script type="text/javascript">
      var ue = UE.getEditor('ueditorText',{
       toolbars: [
					['fullscreen','bold','fontsize','simpleupload','insertimage','link','emotion','map','insertvideo','attachment']
	],
	autoHeightEnabled: true,
				autoFloatEnabled: true
});
//对编辑器的操作最好在编辑器ready之后再做
ue.ready(function() {
});
</script>

</body>
</html>