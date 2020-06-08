<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/ui/act_list_add_upd.css" />
		<title></title>
	</head>
	<style>
		/*-----------分页--------*/
		
		#page li {
			cursor: pointer;
		}
		
		#page input {
			width: 20px!important;
			height: 15px!important;
		}
		/*-----------分页--------*/
	</style>

	<body>
<c:if test="${empty admin }">
	 <c:redirect url="/admin/admin_login.jsp"></c:redirect> 
	</c:if>
		<div class="son_body" style="margin-top: -20px">

			<div class="container-fluid">
				<div class="row" style="padding: 0;">
					<h3>管理员管理</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a href="admin_org_list.html">管理员列表</a>
						</li>

						<li role="presentation">
							<a data-toggle="modal" data-target="#add_admin">添加管理员</a>
						</li>

					</ul>

				</div>

				<div class="row" style="margin: 0;padding: 5px;">

					<div class="col-md-3">

					</div>

					<div class="col-md-9">
						<form class="navbar-form  " method="post" action="${ctx }/AdminServlet?action=getAllAdminList">
							<select name="type" class="form-control input-sm col-md-3 ">
								<option value="AId">管理员账号</option>
								<option value="AName">管理员名称</option>

							</select>
							<input type="text" class="form-control input-sm" placeholder="" name="txtSearch">
							<button type="submit" class="btn btn-default btn-sm">模糊查询</button>

						</form>
					</div>

					<div class="row" style="margin: 0;padding: 0;">
						<table class="table  table-bordered table-hover table-condensed">
							<thead>
								<tr>
									<th>序号</th>
									<th>管理员账号</th>
									<th>管理员名称</th>
									<th>权限/操作</th>
									<th>修改</th>
									<th>删除</th>
								</tr>
							</thead>
							<tbody>
						
<c:if test="${fn:length(adminPageList)==0 }">
							<tr>
								<td colspan="20" style="font-weight: 600;">暂无管理员信息</td>
							</tr>
</c:if>
		<c:if test="${fn:length(adminPageList)>0 }">
	
						<c:forEach items="${adminPageList }"  var="page_admin" varStatus="sm">
					<tr>
									<th scope="row">${sm.index+1 }</th>
									<td>${page_admin.AId }</td>
									<td>${page_admin.AName }</td>
					<!--系统登录 当前普通管理员 -->
					<c:if test="${admin.APower==0 }">
								<!--数据列表APower 0为普通1为超级 -->
								<c:if test="${page_admin.APower==0}">
									<td>普通管理员</td>
									<c:if test="${page_admin.AId != admin.AId }">
									<!-- 修改密码的权限 -->
									<td>无权限</td>
									
									</c:if>
									<!-- 判断当前系统登录的id  可以有修改自身密码的权限 -->
									<!-- 修改密码的权限 -->
									<c:if test="${page_admin.AId == admin.AId }">
									<td>
										<a class="btn btn-xs" data-aid="${page_admin.AId }" data-whatever="${page_admin.AName }" data-toggle="modal" data-target="#upd_admin"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
									</td>
									
									</c:if>
									
								</c:if>
								<!-- 修改密码的权限 -->
								<c:if test="${page_admin.APower==1 }">
									<td>超级管理员</td>
									
									<td>无权限</td>
								</c:if>
									<!-- 删除账号的权限 -->
									<td>无权限</td>
					</c:if>
					
					<!--系统 当前系统超级管理员 -->
<c:if test="${admin.APower==1 }">
							
		
		
											<!-- 系统 当前最高管理员 -->
		<c:if test="${admin.AId==1 }">
						<!-- 列表为普通管理员列表 -->
						<c:if test="${page_admin.APower==0}">
									<td>普通管理员
									<a href="${ctx }/AdminServlet?action=upSadmin&AId=${page_admin.AId }" onclick="return confirm('置为超级管理员？');"><i class="fa fa-arrow-circle-up " style="color:#1FBAB2;font-size: 14px;" aria-hidden="true"></i></a>
									</td>
									<!-- 修改密码的权限 -->
									<td>
										<a class="btn btn-xs" data-aid="${page_admin.AId }" data-whatever="${page_admin.AName }" data-toggle="modal" data-target="#upd_admin"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
									</td>
									<!-- 删除账号的权限 -->
									<td>
										<a class="btn btn-xs " href="${ctx }/AdminServlet?action=delAdmin&AId=${page_admin.AId}" onclick="return confirm('您确认要移除该管理员吗？');"><i class="fa fa-trash" style="color: #C30926;" aria-hidden="true"></i></a>
									</td>
									
									</c:if>
						
						<!-- 列表为超级管理员列表 -->
						<c:if test="${page_admin.APower==1}">
						<c:if test="${admin.AId !=page_admin.AId}">
									<td>超级管理员
									<a href="${ctx }/AdminServlet?action=dropSadmin&AId=${page_admin.AId }" onclick="return confirm('置为普通管理员？');"><i class="fa fa-arrow-circle-down " style="color:#1FBAB2;font-size: 14px;" aria-hidden="true"></i></a>
	
	
									</td>
									<!-- 修改密码的权限 -->
									<td>
										<a class="btn btn-xs" data-aid="${page_admin.AId }" data-whatever="${page_admin.AName }" data-toggle="modal" data-target="#upd_admin"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
									</td>
									<!-- 删除账号的权限 -->
									<c:if test="${admin.AId !=page_admin.AId}">
									
									<td>
										<a class="btn btn-xs " href="${ctx }/AdminServlet?action=delAdmin&AId=${page_admin.AId}" onclick="return confirm('您确认要移除该管理员吗？');"><i class="fa fa-trash" style="color: #C30926;" aria-hidden="true"></i></a>
									</td>
									</c:if>
								</c:if>
								
									<c:if test="${admin.AId ==page_admin.AId}">
									<td>
									超级管理员
									</td>
									<!-- 修改的权限 -->
									<td>
										<a class="btn btn-xs" data-aid="${page_admin.AId }" data-whatever="${page_admin.AName }" data-toggle="modal" data-target="#upd_admin"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
									</td>
									<!-- 删除账号的权限 -->
									<td>无权限</td>
									
									</c:if>
							</c:if>
				
						</c:if>
						
						<!-- 系统当前超级管理员 -->
						<c:if test="${admin.AId !=1 }">
						<!-- 列表为普通管理员列表 -->
						<c:if test="${page_admin.APower==0}">
									<td>普通管理员</td>
									<!-- 修改密码的权限 -->
									<td>
										<a class="btn btn-xs" data-aid="${page_admin.AId }" data-whatever="${page_admin.AName }"  data-toggle="modal" data-target="#upd_admin"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
									</td>
									<!-- 删除账号的权限 -->
									<td>
										<a class="btn btn-xs " href="${ctx }/AdminServlet?action=delAdmin&AId=${page_admin.AId}" onclick="return confirm('您确认要移除该管理员吗？');"><i class="fa fa-trash" style="color: #C30926;" aria-hidden="true"></i></a>
									</td>
									
							</c:if>
				
					
						
						<!-- 列表为超级管理员列表 -->
						<c:if test="${page_admin.APower==1}">
					
								
									<td>超级管理员</td>
									<!-- 修改密码的权限 -->
									<c:if test="${admin.AId !=page_admin.AId}">
									<td>无权限</td>
									</c:if>
									<!-- 修改密码的权限 -->
									<c:if test="${admin.AId ==page_admin.AId}">
									<td>
										<a class="btn btn-xs" data-aid="${page_admin.AId }" data-whatever="${page_admin.AName }" data-toggle="modal" data-target="#upd_admin"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
									</td>
									</c:if>
									<!-- 删除账号的权限 -->
									<td>无权限</td>
									
					
							</c:if>
<!--系统 当前系统超级管理员 -->			
</c:if>
							</c:if>		
							
			</tr>	
</c:forEach>										
							
				
	</c:if>
							
							
								

							</tbody>
						</table>

						

						<!--修改管理员模态框-->
						<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="upd_admin">
							<div class="modal-dialog modal-sm" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										<h4 class="modal-title text-center" id="myModalLabel">修改管理员</h4>
									</div>
									<div class="modal-body">
									
									<form action="${ctx }/AdminServlet?action=updAdmin" method="post" id="updadmin_form">
									<!-- 修改密码的管理员id   通过模态框js传值 -->
									<input type="text" name="AId" id="input_AId" hidden="hidden" />
										<div class="form-group " style="margin:10px 0px 10px 0px;" id="input_Aname_hint">
											<div class="input-group">
												<span class="input-group-addon" id="basic-addon1">名称</span>
												<input id="input_Aname" name="AName" type="text" class="form-control " aria-describedby="basic-addon1">
											</div>
										</div>
										<div class="form-group " style="margin:10px 0px 10px 0px;" id="input_APwd_hint">
											<div class="input-group">
												<span class="input-group-addon" id="basic-addon1">密码</span>
												<input id="input_APwd" type="password" name="APwd" class="form-control " aria-describedby="basic-addon1">
											</div>
										</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
										<button id="updadmin_btn" type="button" class="btn btn-primary">提交</button>
									</div>
								</div>
							</div>
						</div>
						
						
						
						<!--添加管理员模态框-->
						<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="add_admin">
							<div class="modal-dialog modal-sm" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										<h4 class="modal-title text-center" id="myModalLabel">添加管理员</h4>
									</div>
									<div class="modal-body">
										<form action="${ctx }/AdminServlet?action=addAdmin" method="post" id="addadmin_form">
										<div class="form-group " style="margin:10px 0px 10px 0px;" id="add_Aname_hint">
											<div class="input-group">
												<span class="input-group-addon" id="basic-addon1" >名称</span>
												<input id="add_Aname" name="AName" type="text" class="form-control " aria-describedby="basic-addon1">
											</div>
										</div>
										<div class="form-group " style="margin:10px 0px 10px 0px;" id="add_APwd_hint">
											<div class="input-group">
												<span class="input-group-addon" id="basic-addon1">密码</span>
												<input id="add_APwd" name="APwd" type="password" class="form-control " aria-describedby="basic-addon1">
											</div>
										</div>
										</form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
										<button id="addadmin_btn" type="button" class="btn btn-primary">提交</button>
									</div>
								</div>
							</div>
						</div>
						
						
					</div>
					<!--分页-->
					<div class="row" style="margin: 0;padding: 0;">

						<ul id="page" style="font-size: 12px;float: right!important;"></ul>

					</div>
				</div>

			</div>

	</body>
	<!--JQuery   popper   bootstrap-->
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<!--下拉提示框使用-->
	<script src="../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<!--分页js-->
	<script src="../js/bootstrap-paginator.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/ui/admin_add_upd.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
	
	
	
		$(function() {
			
			$("#page").bootstrapPaginator({
				bootstrapMajorVersion: 3, //对应的bootstrap版本
				currentPage: ${currentPage}, //当前页数
				numberOfPages: 5, //每次显示页数
				totalPages: ${totalPages}, //总页数
				shouldShowPage: true, //是否显示该按钮
				useBootstrapTooltip: true,
				//点击事件
				onPageClicked: function(event, originalEvent, type, page) {
			$(window).attr('location',"${ctx }/AdminServlet?action=getAllAdminList&type=${type}&page="+page);
				

				}
			});

		});
		
		
	</script>

</html>