<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="howsun">

    <title>CMS后台管理系统</title>

    <!-- Bootstrap core CSS-->
    <link href="/libs/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="/libs/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Custom styles for this template-->
    <link href="/libs/sb-admin/sb-admin.css" rel="stylesheet">

  </head>

  <body id="page-top">

	<!-- 后台管理系统顶部 -->
 	<jsp:include page="_inc_top.jsp"/>

    <div id="wrapper">

 		<!-- 后台管理系统左部菜单 -->
 		<jsp:include page="_inc_left.jsp"/>

      <div id="content-wrapper">

        <div class="container-fluid">

          <!-- Breadcrumbs-->
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a href="/admin/index">后台首页</a>
            </li>
            <li class="breadcrumb-item active">概览</li>
          </ol>

          <!-- Icon Cards-->
          <br/>
          <br/>
         <div class="table-responsive"  style="font-size: small;">
         	<form action="/admin/articles" method="post">
         		文章标题：<input type="text" name="title">
         		发布人：<input type="text" name="author.nickname">
         		审核状态：
         		<select name="status">
         			<option value="">请选择审核状态</option>
         			<option value="0">待审核</option>
         			<option value="1">通过</option>
         			<option value="2">未通过</option>
         		</select>
         		文章内容：<input type="text" name="content">
         		发布时间：<input type="date" name="created">
         		<input type="submit" value="搜索"class="btn btn-primary" style="font-size: xx-small;">
         	</form><br>
          <table class="table">
          	<tr>
          		<td>文章ID</td>
          		<td>文章标题</td>
          		<td>文章内容</td>
          		<td>发布人</td>
          		<td>发布时间</td>
          		<td>审核状态</td>
          		<td>操作</td>
          	</tr>
          	<c:forEach items="${slist }" var="list">
          		<tr>
	          		<td>${list.id }</td>
	          		<td>${list.title }</td>
	          		<td>${list.content }</td>
	          		<td>${list.author.nickname }</td>
	          		<td>
	          			<fmt:formatDate value="${list.created }" pattern="yyyy-MM-dd HH:mm:ss"/>
	          		</td>
	          		<td>${list.status==0?"待审核":list.status==1?"通过":"未通过" }</td>
	          		<td>
	          			<c:choose>
	          				<c:when test="${list.status==0}">
	          					<input type="button" value="通过" onclick="checkArticle(${list.id },1)" class="btn btn-success" style="font-size: xx-small;">
	          					<input type="button" value="未通过" onclick="checkArticle(${list.id },2)" class="btn btn-danger" style="font-size: xx-small;">
	          				</c:when>
	          				<c:when test="${list.status==1}">
	          					<c:if test="${list.hot==false}">
	          						<input type="button" value="热门"  class="btn btn-info" style="font-size: xx-small;" onclick="remen(${list.id },1)">
	          					</c:if>
	          					<c:if test="${list.hot == true}">
	          						<input type="button" value="普通"  class="btn btn-inverse" style="font-size: xx-small;"  onclick="remen(${list.id },0)">
	          					</c:if>
	          				</c:when>
	          				<c:otherwise>
	          					<!-- <input type="button" value="热门" class="btn btn-success" style="font-size: xx-small;">
	          					<input type="button" value="普通"  class="btn btn-danger" style="font-size: xx-small;"> -->
	          				</c:otherwise>
	          			</c:choose>
	          			
	          		</td>
          		</tr>
          	</c:forEach>
          </table>
          <a href="?pageIndex=1">首页</a>
          <a href="?pageIndex=${page.pageIndex-1<1?1:page.pageIndex-1 }">上一页</a>
          <a href="?pageIndex=${page.pageIndex+1>page.pageCount?page.pageCount:page.pageIndex+1 }">下一页</a>
          <a href="?pageIndex=${page.pageCount }">尾页</a>
          </div>

        </div>
        </div>
        <!-- /.container-fluid -->

        <!-- Sticky Footer -->
        <footer class="sticky-footer">
          <div class="container my-auto">
            <div class="copyright text-center my-auto">
              <span>Copyright Â© Your Website 2019</span>
            </div>
          </div>
        </footer>

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="/libs/jquery/jquery.min.js"></script>
    <script src="/libs/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/libs/sb-admin/sb-admin.min.js"></script>
    <script type="text/javascript">
    	function checkArticle(id,status){
    		var b = confirm("确认要执行此操作，操作后不能修改");
    		if(b){
    			$.post("/admin/checkArticle",{"id":id,"status":status},function(data){
        			if(data.trim()=="succ"){
        				window.location.reload();
        			}
        		});
    		}
    	}
		function remen(id,hot){
			$.post("/admin/remenArticle",{"id":id,"hot":hot},function(data){
    			if(data.trim()=="succ"){
    				window.location.reload();
    			}
    		});
		}
    </script>
  </body>
</html>
