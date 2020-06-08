<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/act_list_add_upd.css"/>
		<title>往期已参加活动</title>
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

		<div class="son_body" style="margin-top: -20px">

			<div class="container-fluid">
				<div class="row" style="padding: 0;">
					<h3>我的活动</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation" >
							<a href="${ctx }/UserServlet?action=getUPageBamList&usState=showAll&page=1">活动报名列表</a>
						</li>

						<li role="presentation" class="active">
							<a href="${ctx}/UserServlet?action=getUPageCanList&type=showAll">活动已参加列表</a>
						</li>
					</ul>

				</div>

				<div class="row" style="margin: 0;padding: 5px;padding-bottom: 10px;">

					<!--活动查询表单-->
					<div class="col-md-3">

					</div>

					<div class="col-md-6">
						<form class="navbar-form  pull-right"  action="${ctx }/UserServlet?action=getUPageCanList" method="post">
						
						<select name="type" class="form-control input-sm col-md-3 ">
								<option value="AName"><span>活动名称</span></option>
								<option value="OName">组织名称</option>
							</select>
							<input type="text"  name="txtSearch" class="form-control input-sm" placeholder="活动名">
							<button type="submit" class="btn btn-default btn-sm">模糊查询</button>
								<a href="${ctx}/UserServlet?action=getUPageCanList&type=showAll" class="btn btn-info btn-sm">全部记录</a>
						</form>
					</div>
<div class="col-md-3">

					</div>
				</div>

				<div class="row" style="margin: 0;padding: 0;">
					<table class="table  table-bordered table-hover table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>活动名</th>
								
								<th>组织</th>
								<th>活动地址</th>
								<th>服务时长(h)</th>
								<th>活动积分</th>
								<th>状态</th>
								
							</tr>
						</thead>
						<tbody>
	
			<c:if test="${fn:length(enpageList)>0 }">
				<c:forEach items="${enpageList }"  var="enlist" varStatus="vs">
			
			<tr>
								<th scope="row">${vs.index+1 }</th>

								<td>${enlist.AName }</td>
							
								<td>${enlist.OName }</td>
									<td >${enlist.AAddress }</td>
								
								<td>${enlist.AHours }</td>
								<td>${enlist.AIntegral }</td>
								<!-- 活动参加确认0未确认1通过2未通过 -->
								<td>
									<c:if test="${enlist.EFlag==0 }">
									
									<a href="javascript:void(0);" class="btn btn-end btn-xs ">待审核</a>
									</c:if>
									<c:if test="${enlist.EFlag==1 }">
									
									<a href="javascript:void(0);" class="btn btn-end btn-xs ">已参加</a>
									</c:if>
									<c:if test="${enlist.EFlag==2 }">
									
									<a href="javascript:void(0);" class="btn btn-end btn-xs ">未参加</a>
									</c:if>
								</td>
							
							</tr>
			
			
			</c:forEach>
			
		</c:if>
						<c:if test="${fn:length(enpageList)==0 }">
						<div class="col-md-12" style="margin-top: 15px;">
										
								<td colspan="11" style="font-weight: 600;">暂无参加活动信息</td>
						
									</div>
		</c:if>	
								
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
				totalPages: ${totalPages}, //总页数
				shouldShowPage: true, //是否显示该按钮
				useBootstrapTooltip: true,
				//点击事件
				onPageClicked: function(event, originalEvent, type, page) {
			$(window).attr('location',"${ctx }/UserServlet?action=getUPageCanList&type=${type}&page="+page);
				

				}
			});

		});
	</script>

</html>