<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

		<link rel="stylesheet" type="text/css" href="${ctx }/css/bootstrap.min.css" />

		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/act_list_add_upd.css" />
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

		<div class="son_body">

			<div class="container-fluid">
				<div class="row" style="padding: 0;">
					<h3>我的活动</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a href="${ctx }/UserServlet?action=getUPageBamList&usState=showAll&page=1">活动报名列表</a>
						</li>

						<li role="presentation">
							<a href="${ctx}/UserServlet?action=getUPageCanList&type=showAll">活动已参加列表</a>
						</li>

					</ul>

				</div>

				<div class="row" style="margin: 0;padding: 5px;">

					<!--活动查询表单-->
					<div class="col-md-8">

					</div>

				<div class="col-md-4">
						<form class="navbar-form  pull-right" method="post" action="${ctx }/UserServlet?action=getUPageBamList&usState=actname&page=1">
							<input type="text" class="form-control input-sm" name="AName" placeholder="活动名">
							<button type="submit" class="btn btn-default btn-sm">模糊查询</button>
						</form>
					</div>

					
				</div>

					<div class="row" style="margin: 0;padding: 0;">
					<table class="table  table-bordered table-hover table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>活动名</th>
								<th>活动时间</th>
								<th>活动地址</th>
								<th>服务时长</th>
								<th>活动状态</th>
								<th>报名状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${empty userPageEnlist }">
						<tr>
								<td colspan="11" style="font-weight: 600;">您暂时未报名任何活动</td>
							</tr>
						</c:if>
						<c:forEach  items="${userPageEnlist }" var="act"  varStatus="om">
						
						<tr>
								<th scope="row">${om.index+1 }</th>

								<td>${act.AName }</td>
							
								<td>${act.AStartDate } 至 ${act.AEndDate }</td>
									<td > ${act.AAddress}</td>
								
								<td>${act.AHours}</td>
								<!-- /*AState活动状态0正在招募1正在进行2已结束*/ -->
								<!-- EState活动报名状态0已报名1已通过2已拒绝 -->
								
	<!-- 活动招募中 -->
<c:if test="${act.AState==0}">
	<td><span class="btn btn-pass btn-xs">招募中</span></td>
	<c:if test="${act.EState==0}">
	<td>
		<a href="javascript:void(0);" class="btn btn-info btn-xs ">待通过</a>
		
	</td>
	<td>
		<a href="${ctx }/UserServlet?action=userQXBaom&AId=${act.AId}" onclick="return confirm('确认取消报名该活动？');" class="btn btn-danger btn-xs ">取消报名</a>
	</td>
	</c:if>
	
	<c:if test="${act.EState==1}">
	<td>
		<a href="javascript:void(0);" class="btn btn-info btn-xs ">已通过</a>
		
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==2}">
	<td>
		<a href="javascript:void(0);" class="btn btn-info btn-xs ">未通过</a>
		
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==3}">
	<td>
			<a href="javascript:void(0);" class="btn btn-info btn-xs ">已取消</a>
	</td>
	<td></td>
	</c:if>
	</c:if>
	<!-- 活动进行中 -->
	<c:if test="${act.AState==1}">
		<td><span class="btn btn-godoing btn-xs">进行中</span></td>
	<c:if test="${act.EState==0}">
	<td>
			<a href="javascript:void(0);" class="btn btn-end btn-xs ">未审核</a>
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==1}">
	<td>
			<a href="javascript:void(0);" class="btn btn-end btn-xs ">已通过</a>
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==2}">
	<td>
			<a href="javascript:void(0);" class="btn btn-end btn-xs ">未通过</a>
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==3}">
	<td>
			<a href="javascript:void(0);" class="btn btn-end btn-xs ">已取消</a>
	</td>
	<td></td>
	</c:if>
	</c:if>
	
	<!-- 活动已结束 -->
	<c:if test="${act.AState==2}">
	<td><span class="btn btn-end btn-xs">已结束</span></td>
	<c:if test="${act.EState==0}">
	<td>
			<a href="javascript:void(0)" class="btn btn-end btn-xs ">未审核</a>
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==1}">
	<td>
			<a href="javascript:void(0)" class="btn btn-end btn-xs ">已通过</a>
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==2}">
	<td>
			<a href="javascript:void(0)" class="btn btn-end btn-xs ">未通过</a>
	</td>
	<td></td>
	</c:if>
	<c:if test="${act.EState==3}">
	<td>
			<a href="javascript:void(0);" class="btn btn-end btn-xs ">已取消</a>
	</td>
	<td></td>
	</c:if>
	</c:if>
	
	
								
							</tr>
						</c:forEach>
						
							
						</tbody>
					</table>
				</div>
				<!--分页-->
				<div class="row" style="margin: 0;padding: 0;">

					<ul id="page" style="font-size: 12px;float: right!important;"></ul>

				</div>
			</div>

		</div>

	</body>
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<!--分页js-->
	<script src="../js/bootstrap-paginator.js" type="text/javascript" charset="utf-8"></script>
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
					$(window).attr('location',"${ctx }/UserServlet?action=getUPageBamList&usState=${usState}&AName=${AName}&page="+page);
				}
			});

		});
	</script>

</html>