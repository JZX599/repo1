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
		<!--bootstrap表单验证cssf-->
		<link rel="stylesheet" type="text/css" href="../css/bootstrapValidator.css" />
		<link rel="stylesheet" type="text/css" href="../css/ui/act_list_add_upd.css" />

		<title></title>
	</head>
	<style>
		/*-----------分页css--------*/
		
		#page li {
			cursor: pointer;
		}
		
		#page input {
			width: 20px!important;
			height: 15px!important;
		}
		/*-----------分页css--------*/
	</style>

	<body>

		<div class="son_body" style="margin-top: -20px">

			<div class="container-fluid">
				<div class="row" style="padding: 0;">
					<h3>分类管理</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a href="admin_org_list.html">分类列表</a>
						</li>

						<li role="presentation">
							<a data-toggle="modal" data-target="#cate_add_modal">添加分类</a>
						</li>

					</ul>

				</div>

				<div class="row" style="margin: 0;padding: 5px;">

				</div>
				<div class="row" style="margin: 0;padding: 0;">
					<table class="table  table-bordered table-hover table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>分类id</th>
								<th>分类名称</th>
								<th>修改分类</th>
								<th>删除分类</th>
							</tr>
						</thead>
						<tbody>
						
						<c:if test="${fn:length(adminCatePageList)==0 }">
							<tr>
								<td colspan="20" style="font-weight: 600;">暂无分类信息</td>
							</tr>
						</c:if>
			<c:if test="${fn:length(adminCatePageList)>0 }">
	
						<c:forEach items="${adminCatePageList }"  var="cate" varStatus="sm">
							<tr>
								<th scope="row">${sm.index+1 }</th>
								<td>${cate.CId }</td>
								<td>${cate.CName }</td>

								<td>
									<a id="upd_a" class="btn btn-xs" data-cid="${cate.CId }" data-cname="${cate.CName }"  data-toggle="modal" data-target="#cate_upd_modal"><i class="fa fa-edit" style="color: #077E04;" aria-hidden="true"></i></a>
								</td>

								<td>
									<a  href="${ctx }/AdminServlet?action=delCate&CId=${cate.CId }" class="btn btn-xs " onclick="return confirm('您确认要删除该分类吗？');"><i class="fa fa-trash" style="color: #C30926;" aria-hidden="true"></i></a>
								</td>

							</tr>
						</c:forEach>										
							
				
			</c:if>
				
						</tbody>
					</table>
				</div>
				<form action="${ctx }/AdminServlet?action=addCate" method="post" id="cate_add_from">
					<!--添加分类模态框-->
					<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="cate_add_modal">
						<div class="modal-dialog modal-sm" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
									<h4 class="modal-title text-center" id="myModalLabel">添加分类</h4>
								</div>
								<div class="modal-body">

									<div class="form-group " style="margin:10px 0px 10px 0px;">
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">分类名称</span>
											<input type="text" class="form-control " name="CName">
										</div>

									</div>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
									<button type="submit" class="btn btn-primary">添加</button>
								</div>
							</div>
						</div>
					</div>
				</form>

				<form action="${ctx }/AdminServlet?action=updCate" method="post" id="cate_upd_from">
					<!--修改分类模态框-->
					<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" id="cate_upd_modal">
						<div class="modal-dialog modal-sm" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
									<h4 class="modal-title text-center" id="myModalLabel">修改分类</h4>
								</div>
								<div class="modal-body">
									<input type="text" name="CId" id="input_CId" hidden="hidden"/>
									<div class="form-group " style="margin:10px 0px 10px 0px;" >
										<div class="input-group">
											<span class="input-group-addon" id="basic-addon1">分类名称</span>
											<input  name="CName" type="text" class="form-control " aria-describedby="basic-addon1" id="input_CName">
										</div>
									</div>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
									<button  type="submit" class="btn btn-primary">修改</button>
								</div>
							</div>
						</div>
					</div>

				</form>

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
	<!--bootstrap表单验证js-->
	<script src="../js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(function() {
			
			///////////////////////////////////////分页js/////////////////////////////////////////////////////////
			var currentPage = 1;
			var totalPages = 25;
			$("#page").bootstrapPaginator({
				bootstrapMajorVersion: 3, //对应的bootstrap版本
				currentPage: ${currentPage}, //当前页数
				numberOfPages: 5, //每次显示页数
				totalPages: ${totalPages}, //总页数
				shouldShowPage: true, //是否显示该按钮
				useBootstrapTooltip: true,
				//点击事件
				onPageClicked: function(event, originalEvent, type, page) {
				
				$(window).attr('location',"${ctx }/AdminServlet?action=getAllCateList&page="+page);
			

				}
			});
			
			/*****************************************表单提交js*******************************************************/
				/////////////////////////////////////分类修改/////////////////////////////////////////////////////////////////
				$('#cate_add_from').bootstrapValidator({
					message: '此值无效',
					excluded: ':disabled',
					feedbackIcons: {
						valid: 'glyphicon glyphicon-ok',
						invalid: 'glyphicon glyphicon-remove',
						validating: 'glyphicon glyphicon-refresh'
					},
					fields: {

						CName: {
							
							validators: {
								notEmpty: {
									message: '分类名称不能为空'
								},
							regexp: {
									regexp: /^[\u2E80-\u9FFF]+$/,
									/*匹配中文*/
									message: '分类名称只能由中文组成'
								}
							}
						}
					}
				});


/////////////////////////////////////组织信息修改/////////////////////////////////////////////////////////////////

				$('#cate_upd_from').bootstrapValidator({
					message: '此值无效',
					excluded: ':disabled',
					feedbackIcons: {
						valid: 'glyphicon glyphicon-ok',
						invalid: 'glyphicon glyphicon-remove',
						validating: 'glyphicon glyphicon-refresh'
					},
					fields: {

						CName: {
							
							validators: {
								notEmpty: {
									message: '分类名称不能为空'
								},
							regexp: {
									regexp: /^[\u2E80-\u9FFF]+$/,
									/*匹配中文*/
									message: '分类名称只能由中文组成'
								}
							}
						}
					}
				});
				
				
			/*****************************************表单提交js*******************************************************/
			
			
			/*****************************************模态框传值的js********************************************/
			$('#cate_upd_modal').on('show.bs.modal', function(event) {
				var button = $(event.relatedTarget) // Button that triggered the modal
				/*只能加小写  使用模态框data-cname 传值*/
				var CName = button.data('cname')
				var CId = button.data('cid')
				var modal = $(this)
		
				modal.find('.modal-body #input_CName').val(CName)
				modal.find('.modal-body #input_CId').val(CId)
			});

			
			
			
		});
		
	
	</script>

</html>