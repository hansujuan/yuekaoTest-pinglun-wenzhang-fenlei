<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>发布文章</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" type="text/css" href="/libs/bootstrap/css/bootstrap.min.css"/>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
    <script src="//cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.5/umd/popper.js"></script>
	<link href="/libs/bootstrap/summernote/summernote.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/css/cms.css"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
	<!-- 横幅 -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12 my_banner">
			</div>
		</div>
	</div>
	<br/>
	<!-- 主体内容区 -->
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<jsp:include page="/WEB-INF/inc/my_left.jsp"><jsp:param value="blog" name="module"/></jsp:include>
			</div>
			<div class="col-md-9">
				<div class="panel panel-default">
				  <div class="panel-body">
				    	<h1>发布文章</h1>
				    	<hr/>
				    	
				    	<form:form action="/my/blog/save" modelAttribute="article" enctype="multipart/form-data" method="post" >
				    	 <input type="hidden" value="${param.id }" name="id"> 
				    	<p align="center" class="red"> <form:errors path="id"/>  </p>
				    	<p>
				    		 <form:input path="title" class="form-control" placeholder="博客标题"/> 
				    		<span class="red"> <form:errors path="title"/> </span>
				    	</p>
				    	
				    	<p>
				    		 <form:textarea path="content" id="content" rows="20" class="form-control"></form:textarea> 
				    		<span class="red"> <form:errors path="content"/> </span>
				    	</p>
				    	
				    	<p>
				    		 <form:textarea path="summary" rows="3" class="form-control" placeholder="摘要"></form:textarea> 
				    		<span class="red"> <form:errors path="summary"/> </span>
				    	</p>
				    	
				    	<p>
				    		  <form:select path="channel.id" class="form-control" id="cid">
				    			<option value="0">选择栏目</option>
				    			<c:forEach items="${channels }" var="c">
				    				
				    				<option value="${c.id }" <c:if test="${c.id ==article.channel.id  }">selected="selected"</c:if>>${c.name }</option>
				    			</c:forEach>
				    			 <%--  <form:options items="${__CATEGORIES__}" itemLabel="name" itemValue="id"/ >  --%>
				    		</form:select> <br>
				    		<%-- <span class="red"><form:errors path="category"/></span> --%>
				    		<form:select path="category.id" class="form-control" id="cateid">
				    			<option value="0">选择分类</option>
				    			<c:forEach items="${channels }" var="c">
				    				<c:if test="${c.id ==article.channel.id }">
				    				<c:forEach items="${c.categoryList }" var="cate">
				    					<option value="${cate.id }" <c:if test="${cate.id ==article.category.id  }">selected="selected"</c:if>>${cate.name }</option>
				    				</c:forEach>
				    					</c:if>
				    				
				    			</c:forEach>
				    			<%-- <form:options items="${__CATEGORIES__}" itemLabel="name" itemValue="id"/ --%>>
				    		</form:select> 
				    	</p>
				    	
					    	<c:if test="${not empty article.picture}">
					    		<img alt="图片预览" src="/my/showPicture?picture=${article.picture}" height="50">
					    		 <form:hidden path="picture"/> 
					    		 修改封面：<input type="file" name="photo"/>
					    		<%-- <a href="/my/deletePhoto?picture=${article.picture}&id=${param.id }">删除图片</a> --%>
					    	</c:if>
					    	<c:if test="${empty article.picture}">
				    		<p>上传封面：<input type="file" name="photo"/>
				    	</c:if>
				    	</p>
				    	<c:if test="${article.hot == true }">
				    		<input type="checkbox" name="hots" value="on" checked="checked">是否上热搜
				    	</c:if>
				    	<c:if test="${article.hot != true }">
				    		<input type="checkbox" name="hots" value="on">是否上热搜
				    	</c:if>
				    	<p>
				    			<button type="submit" class="btn btn-info btn-block">保存</button> 
				    	</p>
				    	
				    	</form:form>
				  </div>
				</div>
				
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/inc/footer.jsp"/>
	
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#content").summernote({
				placeholder:'博客内容',
				height:300
			});
		});
		
		$(function(){
			$("#cid").change(function(){
				var cid = $("#cid").val();
				$.post("/my/showCateStories","cid="+cid,function(data){
					var str = "<option value='0'>选择分类</option>";
					for ( var i in data) {
						str += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
					}
					$("#cateid").html(str);
				},"json");
			});
		})
	</script>
  </body>
</html>