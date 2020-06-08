<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/act_list_add_upd.css"/>
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
<c:if test="${empty organize }">
	 <c:redirect url="/user/user_org_login.jsp"></c:redirect> 
</c:if>
		<div class="son_body">

			<div class="container-fluid">
				<div class="row" style="padding: 0;">
					<h3>活动管理</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation" class="active">
							<a href="${ctx }/organize/org_act_list.jsp">活动列表</a>
						</li>

						<li role="presentation">
							<!-- 添加用户弹出模态框按钮 -->
							<a href="${ctx }/ActivityServlet?action=jumpAddActPage">发布活动</a>
						</li>

					</ul>

				</div>

				<div class="row" style="margin: 0;padding: 5px;">

					<!--活动查询表单-->
					<div class="col-md-2">

					</div>

					<div class="col-md-8">
						<form class="navbar-form  " action="${ctx }/ActivityServlet?action=getPageActList&state=byName&page=1" method="post">
							<input type="text" name="AName" class="form-control input-sm" placeholder="活动名称" >
							<button type="submit" class="btn btn-default btn-sm">模糊查询</button>

							<a href="${ctx }/ActivityServlet?action=getPageActList&state=pass&page=1" class="btn btn-pass btn-sm">招募中</a>
							<a href="${ctx }/ActivityServlet?action=getPageActList&state=godoing&page=1" class="btn btn-godoing btn-sm">进行中</a>
							<a href="${ctx }/ActivityServlet?action=getPageActList&state=end&page=1" class="btn btn-danger btn-sm">已结束</a>
							<a href="${ctx }/ActivityServlet?action=getPageActList&state=showAll&page=1" class="btn btn-info btn-sm">全部活动</a>
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
								<th>活动名</th>
								<th>活动时间</th>
								<th>预计招募人数</th>

								<th>联系人</th>
								<th>手机</th>
								<th>活动地址</th>
								<th>活动时长</th>
								<th>积分</th>
								<th>活动状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						
									<c:if test="${empty ActPagelist}">
							<tr>
								<td colspan="10" style="font-weight: 600;">搜索不到活动信息</td>
							</tr>
									</c:if>
		<c:forEach items="${ActPagelist }" var="activitys"  varStatus="om">
							<tr>
								<th scope="row">${om.index+1 }</th>
								<td>${activitys.AName }</td>
								<td>${activitys.AStartDate } 至 ${activitys.AEndDate }</td>
								<td>${activitys.AEstimate }</td>
								<td>${activitys.APerson }</td>
								<td>${activitys.APhone }</td>
								<td>${activitys.AAddress }</td>
								<td>${activitys.AHours}</td>
								<td>${activitys.AIntegral }</td>
								<c:if test="${activitys.AState==0 }">
								<td><span class="btn btn-pass btn-xs">招募中</span></td>
								<td>
									<!-- 下拉按钮 -->
									<div class="btn-group ">
										<button type="button" class="btn btn-success dropdown-toggle btn-xs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    操作<span class="caret"></span>
									  </button>
										<ul class="dropdown-menu" style="min-width: 20px;margin-left: -40px;">
											<li>
												<a href="${ctx }/ActivityServlet?action=byAIdgetActmsg&AId=${activitys.AId}"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;修改</a>
											</li>
											<li>
												<a href="${ctx }/ActivityServlet?action=byAIdDelAct&AId=${activitys.AId}" onclick="return confirm('您确认要取消吗？');"><i class="glyphicon glyphicon-trash"></i>&nbsp;&nbsp;取消</a>
											</li>
										</ul>
									</div>
								</td>
								</c:if>
								<c:if test="${activitys.AState==1 }">
								<td><span class="btn btn-godoing btn-xs">进行中</span></td>
								<td>
									
								</td>
								</c:if>
								<c:if test="${activitys.AState==2 }">
								<td><span class="btn btn-end btn-xs">已结束</span></td>
								<td>
									
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
//通过点击的页面跳转
					$(window).attr('location',"${ctx }/ActivityServlet?action=getPageActList&state=${state}&AName=${AName}&page="+page);
				}
			});

		});
	</script>

</html>