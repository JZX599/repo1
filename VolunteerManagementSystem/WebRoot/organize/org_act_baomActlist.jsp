<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta charset="utf-8" />

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
					<h3>报名管理</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a href="${ctx }/ActivityServlet?action=getPageActBaomList&state=showAll&page=1">活动列表</a>
						</li>
						
						
					</ul>

				</div>

				<div class="row" style="margin: 0;padding: 5px;">

					<!--活动查询表单-->
					<div class="col-md-2">

					</div>

					<div class="col-md-8">
						<form class="navbar-form  ">
							<input type="text" class="form-control input-sm" placeholder="活动名称">
							<button type="submit" class="btn btn-default btn-sm">查询</button>

							<a href="${ctx }/ActivityServlet?action=getPageActBaomList&state=pass&page=1" class="btn btn-pass btn-sm">招募中</a>
							<a href="${ctx }/ActivityServlet?action=getPageActBaomList&state=godoing&page=1" class="btn btn-godoing btn-sm">进行中</a>
							<a href="${ctx }/ActivityServlet?action=getPageActBaomList&state=end&page=1" class="btn btn-danger btn-sm">已结束</a>
							<a href="${ctx }/ActivityServlet?action=getPageActBaomList&state=showAll&page=1" class="btn btn-info btn-sm">全部活动</a>
						</form>
					</div>

					<div class="col-md-2">

					</div>
				</div>

				<div class="row" style="margin: 0;padding: 0;">
					<table class="table  table-bordered table-hover table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>活动编号</th>
								<th>活动名</th>
								<th>活动时间</th>
								<th>预计招募人数</th>
								<th>已报名人数</th>
								<th>已通过人数</th>
								<th>活动状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${empty baomActpageList}">
							<tr>
								<td colspan="9" style="font-weight: 600;">搜索不到活动报名信息</td>
							</tr>
						</c:if>
<c:forEach items="${baomActpageList }" var="act"  varStatus="om" >

								<tr>
								<th scope="row">${om.index+1 }</th>
								<td>${act.AId }</td>
								<td>${act.AName }</td>
								<td>${act.AStartDate } 至 ${act.AEndDate }</td>
								<td>${act.AEstimate}</td>

								<td>${act.EBaom }</td>
								<td>${act.ETong }</td>
								<!-- /*活动状态0正在招募1正在进行2已结束*/ -->
								<c:if test="${act.AState==0 }">
								<td><span class="btn btn-pass btn-xs">招募中</span></td>

								<td>
									<a href="${ctx }/ActivityServlet?action=getUserBaomList&AState=0&AId=${act.AId}&page=1" class="btn btn-pass btn-xs ">查看报名详情</a>
								</td>
								</c:if>
								<c:if test="${act.AState==1 }">
								<td><span class="btn btn-godoing btn-xs">进行中</span></td>

								<td>
									<a href="${ctx }/ActivityServlet?action=getUserBaomList&AState=1&AId=${act.AId}&page=1" class="btn btn-godoing btn-xs ">查看人员列表</a>
								</td>
								</c:if>
								<c:if test="${act.AState==2 }">
								<td><span class="btn btn-end btn-xs">已结束</span></td>
								<td>
									<a href="${ctx }/ActivityServlet?action=getUserBaomList&AState=2&AId=${act.AId}&page=1" class="btn btn-info btn-xs ">用户参加审核</a>
								</td>
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
	<script src="${ctx }/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<!--分页js-->
	<script src="${ctx }/js/bootstrap-paginator.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		$(function() {
			
			$("#page").bootstrapPaginator({
				bootstrapMajorVersion: 3, //对应的bootstrap版本
				currentPage: ${currentPage}, //当前页数
				numberOfPages: 5, //每次显示页数
				totalPages: ${totalPage}, //总页数
				shouldShowPage: true, //是否显示该按钮
				useBootstrapTooltip: true,
				//点击事件
				onPageClicked: function(event, originalEvent, type, page) {
					$(window).attr('location',"${ctx }/ActivityServlet?action=getPageActBaomList&state=${actState}&page="+page);
			

				}
			});

		});
	</script>

</html>