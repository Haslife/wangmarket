<%@page import="com.xnx3.j2ee.Global"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.xnx3.admin.G"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<jsp:include page="../iw/common/head.jsp">
	<jsp:param name="title" value="编辑输入模型"/>
</jsp:include>

<form id="form" class="layui-form layui-form-pane" action="save.do" method="post" style="padding:5px;">
  <input type="hidden" name="id" value="${inputModel.id }" />
  
      <div class="layui-form-item" style="">
    <label class="layui-form-label">模型代码</label>
    <div class="layui-input-inline">
      <input type="text" name="codeName" lay-verify="codeName" placeholder="请输入模型代码" autocomplete="off" class="layui-input" value="${inputModel.codeName }">
    </div>
    <div class="layui-form-mid" style="color: gray; font-size: 14px; padding-top:0px;">同一个网站中的模型代码必须是唯一的,限30字以内。<b>强烈建议添加后就不要改动了！</b><br/>备份还原、栏目绑定模型都是使用此模型代码</div>
  </div>
  
  
  <div class="layui-form-item" style="">
    <label class="layui-form-label">备注说明</label>
    <div class="layui-input-inline">
      <input type="text" name="remark" lay-verify="remark" placeholder="请输入备注" autocomplete="off" class="layui-input" value="${inputModel.remark }">
    </div>
    <div class="layui-form-mid" style="color: gray; font-size: 14px;">仅为提示备注,无其他任何作用,限制30字以内</div>
  </div>
  

  <div class="layui-form-item layui-form-text" style="height: 80%;">
    <label class="layui-form-label">模型内容(2万字以内)</label>
    <div class="layui-input-block">
      <textarea name="text" id="text" style="height:600px;" lay-verify="text" placeholder="请输入输入模型的提交表单的html代码" class="layui-textarea" style="height: 95%;"></textarea>
    </div>
  </div>
  
	<!-- 说明区域 -->
	<div class="layui-collapse" style="margin-top:-17px;">
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">动态调取参数说明(若是修改数据，可用此参数调取原本数据的信息)</h2>
	    <div class="layui-colla-content" style="font-size:12px;">
	    	{news.title} 标题<br/>
	    	{news.intro} 简介<br/>
	    	{titlepicImage} 标题图/列表图，用于列表展示的图片，若有，会以<img ...>标签显示出来<br/>
	    	{siteColumn.type} 当前操作的内容所属栏目的类型编码<br/>
	    	{text} 内容，正文<br/>
	    </div>
	  </div>
	  <div class="layui-colla-item">
	    <h2 class="layui-colla-title">表单提交保存数据的input标签的name说明</h2>
	    <div class="layui-colla-content" style="font-size:12px;">
	    	name="title" 标题(最大可输入30字，必填项，不可省去，必须存在此项)<br/>
	    	name="intro" 简介(最大可输入160字，选填，若不需要可不再表单中体现).<br/>
	    	&nbsp;&nbsp;&nbsp;&nbsp;当提交的简介为空，或者没有简介这个字段时，会自动从正文text中截取前160个字作为简介<br/>
	    	&nbsp;&nbsp;&nbsp;&nbsp;当提交的简介有内容时，保存简介的内容<br/>
	    	name="titlePicFile" 标题图，用于存储信息列表展示的图片，如产品展示栏目所需要的产品列表图，注意，此处input标签的type类型需要为file！(选填，若不需要可不再表单中体现)
	    	name="text" 内容，正文，最大可保存五十万字。几乎可忽略字数限制。<br/>
	    </div>
	  </div>
	  <div class="layui-colla-item" style="font-size:12px;">
	    <h2 class="layui-colla-title">其他说明</h2>
	    <div class="layui-colla-content">
	    	1.模型内容最大可存储两万字。
    		<br/>2.建议不要引入外部资源文件,如图片、css、js。
    		<br/>3.已引入JQuery、Layer等js框架，可直接再其中使用
	    </div>
	  </div>
	</div>


  <br/>
  <div class="layui-form-item" style="text-align:center;">
  	<button class="layui-btn" lay-submit="" lay-filter="demo1">保存</button>
  </div>
</form>

<script>

layui.use(['element', 'form', 'layedit', 'laydate'], function(){
  var form = layui.form;
  var element = layui.element;
  
  //自定义验证规则
  form.verify({
    remark: function(value){
      if(value.length > 30){
      	return '请输入30个字以内的输入模型的名称';
      }
    },
    codeName: function(value){
        if(value.length == 0){
          return '请输入输入模型代码';
        }
        if(value.length > 30){
        	return '请输入30个字以内的输入模型代码';
        }
      }
  });
  
  //监听提交
  form.on('submit(demo1)', function(data){
		parent.iw.loading('保存中');
		var d=$("form").serialize();
        $.post("<%=basePath %>inputModel/save.do", d, function (result) { 
        	parent.iw.loadClose();
        	var obj = JSON.parse(result);
        	if(obj.result == '1'){
        		parent.iw.msgSuccess("保存成功");
        		window.location.href="list.do";
        	}else if(obj.result == '0'){
        		layer.msg(obj.info, {shade: 0.3})
        	}else{
        		layer.msg(result, {shade: 0.3})
        	}
         }, "text");
		
    return false;
  });
  
});

//加载输入模型的主要数据
function load(){
	$.showLoading();
	$.getJSON("<%=basePath %>inputModel/getInputModelTextById.do?id=${inputModel.id }",function(result){
		 $.hideLoading();
		if(result.result == '1'){
			//编辑模式，获取模型主要内容成功，加载到textarea
			document.getElementById("text").innerHTML = result.info;
			//alert(result.info);  //这里应该是添加，添加时输入模型数据是不存在的，会返回错误提示
		}else if (result.result == '3') {
			//新增模式，获取默认的输入模型内容，赋予textarea
			document.getElementById("text").innerHTML = result.info;
			layer.msg("自动赋予系统默认输入模型，可以在此基础上进行修改，以创建自己的输入模型！", {shade: 0.3})
		}
	});
}
load();
</script>

<jsp:include page="../iw/common/foot.jsp"></jsp:include>