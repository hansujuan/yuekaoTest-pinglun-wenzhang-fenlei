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
          <c:if test="${channels != null }">
          <div id="div2">
          <button class="btn btn-primary btn-xs" data-toggle="modal" data-target="#myModals" onclick="showCatestory()">
			添加分类
			</button>
          		<ul>
          	<c:forEach items="${channels }" var="c">
          			<li>
          			${c.name }
          			 <input type="button" value="删除" class="btn btn-danger btn-primary btn-sm" onclick="delChannel(${c.id},${c.categoryList.size() })">
	          		<input type="button" value="编辑" class="btn btn-primary btn-primary btn-sm"  class="btn btn-primary btn-primary btn-sm" data-target="#myModal" data-toggle="modal" onclick="getChannel(${c.id})"> 
          			<c:forEach items="${c.categoryList }" var="cate">
          				<ul style="margin: 5px;right: 30px;">${cate.name }
          					<span>
	          				<input type="button" value="删除" class="btn btn-danger btn-primary btn-sm" onclick="delcatestory(${cate.id})">
	          				<input type="button" value="编辑" class="btn btn-primary btn-primary btn-sm" data-target="#myModals" data-toggle="modal" onclick="toUpdateCatestory(${cate.id})"></span>
          				</ul>
          			</c:forEach>
          			</li>
          	</c:forEach>
          		</ul>
          </div>
          </c:if>
          <!-- 添加|修改 --> 
		<div class="modal fade" id="myModals" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		            </div>
		            <div class="modal-body">
		            	<input type="hidden" id="cateid">
		            	栏目:<select id="cid" >
								<option value="0">请选择栏目</option>
		            		</select>
		            	分类:<input type="text" id="catename">
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" onclick="saveOrUpdateCatetory()">提交</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		            </div>
		            <div class="modal-body">
		            <input type="hidden" id="cids">
		            	请输入栏目：<input type="text" name="cname" id="cnames">
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		                <button type="button" class="btn btn-primary" onclick="updateChannel()">提交</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
          <div id="div1">
          <c:if test="${channels==null }">
          <h1 align="center">欢迎光临后台管理系统</h1>
           </c:if>
          <br/>
          <br/>
                  <c:if test="${channels==null }">
          <div class="row">
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-primary o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-comments"></i>
                  </div>
                  <div class="mr-5">26 篇文章!</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="#">
                  <span class="float-left">View Details</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
                </c:if>
             
                  <c:if test="${channels==null }">
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-warning o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-list"></i>
                  </div>
                  	 <div class="mr-5">11 新用户!</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="#">
                  <span class="float-left">View Details</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
                </c:if>
            
            
                   <c:if test="${channels==null }">
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-success o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-shopping-cart"></i>
                  </div>
                  <div class="mr-5">6 个频道!</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="#">
                  <span class="float-left">View Details</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
                 </c:if>
                  <c:if test="${channels==null }">
            <div class="col-xl-3 col-sm-6 mb-3">
              <div class="card text-white bg-danger o-hidden h-100">
                <div class="card-body">
                  <div class="card-body-icon">
                    <i class="fas fa-fw fa-life-ring"></i>
                  </div>
                  <div class="mr-5">20 个分类!</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="#">
                  <span class="float-left">View Details</span>
                  <span class="float-right">
                    <i class="fas fa-angle-right"></i>
                  </span>
                </a>
              </div>
            </div>
                </c:if>
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
    	$(function(){
    		//showCatestory();
    	});
    	function showCatestory(){
    		$("#catename").val('');
    		$.post("/channelCategory/getChannels",function(data){
    			var str = "<option value='0'>请选择栏目</option>";
    			for ( var i in data) {
					str += "<option value='"+data[i].id+"'>"+data[i].name+"</option>";
				}
    			$("#cid").html(str);
    		},"json");
    	}
    	function saveOrUpdateCatetory(){
    		
    		var cid = $("#cid").val();
    		var catename = $("#catename").val();
    		var cateid = $("#cateid").val();
    		if(cid != null || cid != ""){
    		$.post("/channelCategory/saveOrUpdateCatetory",{"cid":cid,"catename":catename,"cateid":cateid},function(data){
    			if(data.trim()=="succ"){
    				alert("提交成功");
    				window.location.reload();
    			}else{
    				alert("提交失败");
    			}
    		});
    			
    		}else{
    			alert("栏目不能为空");
    		}
    	}
    	function toUpdateCatestory(id){
    		$.post("/channelCategory/toUpdateCatestory","id="+id,function(data){
    			var str = "<option value='0'>请选择栏目</option>";
    			var list = data.channels;
    			var c = data.channel;
    			var cate = data.category;
    			for ( var i in list) {
					str += "<option value='"+list[i].id+"'>"+list[i].name+"</option>";
				}
    			$("#cid").html(str);
    			$("#cid").val(c.id);
    			$("#catename").val(cate.name);
    			$("#cateid").val(cate.id);
    		},"json");
    	}
    	function delcatestory(id){
    		$.post("/channelCategory/delcatestory","id="+id,function(data){
    			if(data.trim()=="succ"){
    				alert("删除成功");
    				window.location.reload();
    			}else{
    				alert("删除失败");
    			}
    		});
    	}
    	function delChannel(id,size){
    		if(size==0){
    		$.post("/channelCategory/delChannel","id="+id,function(data){
    			if(data.trim()=="succ"){
    				alert("删除成功");
    				window.location.reload();
    			}else{
    				alert("删除失败");
    			}
    		});
    			
    		}else{
    			alert("栏目中含有信息信息内容，不能删除");
    		}
    	}
    	function getChannel(id){
    		$.post("/channelCategory/getChannel","id="+id,function(data){
    			$("#cnames").val(data.name);
    			$("#cids").val(data.id);
    		},"json");
    	}
    	function updateChannel(){
    		var cnames = $("#cnames").val();
    		var cids = $("#cids").val();
    		$.post("/channelCategory/updateChannel",{"cnames":cnames,"cids":cids},function(data){
    			if(data.trim()=="succ"){
    				alert("提交成功");
    				window.location.reload();
    			}else{
    				alert("提交失败");
    			}
    		});
    	}
    </script>
  </body>
</html>
