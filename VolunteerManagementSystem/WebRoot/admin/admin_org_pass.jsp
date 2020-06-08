<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
			<link rel="stylesheet" type="text/css" href="${ctx }/css/bootstrap.min.css" />
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
<c:if test="${empty admin }">
	 <c:redirect url="/admin/admin_login.jsp"></c:redirect> 
	</c:if>
		<div class="son_body" style="margin-top: -20px">

			<div class="container-fluid">
				<div class="row" style="padding: 0;">
					<h3>组织管理</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation"  >
							<a href="${ctx }/AdminServlet?action=getAllOrgList&type=showAll">组织列表</a>
						</li>

						<li role="presentation" >
							<a href="${ctx }/AdminServlet?action=getAllWaitOrgList&type=showAll">待审核</a>
						</li>

						<li role="presentation" class="active">
							
							<a href="${ctx }/AdminServlet?action=getAllPassOrgList&type=showAll">已通过</a>
						</li>

						
					</ul>

				</div>

			<div class="row" style="margin: 0;padding: 5px;">

				
				<div class="col-md-3">

					</div>

					<div class="col-md-9">
							<form class="navbar-form  " action="${ctx }/AdminServlet?action=getAllPassOrgList" method="post">
							<select name="type" class="form-control input-sm col-md-3 ">
								<option value="OId">组织编号</option>
								<option value="OName">组织名称</option>
								<option value="OPerson">组织法人</option>
								<option value="OAddress">组织地址</option>
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
								<th>组织编号</th>
								<th>组织名称</th>
								<th>组织法人</th>
								<th>组织邮箱</th>
								<th>注册时间</th>
								<th>组织地址</th>
								<th>发布活动数</th>
								<th>账号状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						
						<c:if test="${fn:length(OrgpageList)==0 }">
						<tr>
								<td colspan="10" style="font-weight: 600;">暂无已审核组织信息</td>
							</tr>
						</c:if>
						<c:if test="${fn:length(OrgpageList)>0 }">
						<c:forEach items="${OrgpageList }"  var="org" varStatus="sm">
						<tr>
								<th scope="row">${sm.index+1 }</th>
								<td>${org.OId }</td>
								<td>${org.OName}</td>
								<td>${org.OPerson }</td>
								
								
								<td>${org.OEmail }</td>
								<td>${org.ODate }</td>
								<td>${org.OAddress }</td>
								<td>${org.OActnum }</td>
								
								<!-- 组织状态0待审核1已通过2限制登录 -->
								
								<c:if test="${org.OState==1 }">
								<td>正常</td>
								
								<td><a href="${ctx }/AdminServlet?action=ResetOrgPwd&OId=${org.OId }&flag=pass" onclick="return confirm('要重置该组织的密码？');" class="btn btn-success btn-xs">重置密码</a>
									<a href="${ctx }/AdminServlet?action=DongJOrg&OId=${org.OId }&flag=pass" onclick="return confirm('要冻结该组织？');" class="btn btn-danger btn-xs">冻结</a>
									
								</td>
								
								</c:if>
								
								<c:if test="${org.OState==2 }">
								<td>冻结</td>
								<td><a href="${ctx }/AdminServlet?action=JieDOrg&OId=${org.OId }&flag=pass" onclick="return confirm('要解除冻结该组织？');" class="btn btn-danger btn-xs">解冻</a>
								</td>
								</c:if>
							</tr>
						</c:forEach>
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
	<!--JQuery   popper   bootstrap-->
	<script src="${ctx }/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<!--下拉提示框使用-->
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
			$(window).attr('location',"${ctx }/AdminServlet?action=getAllPassOrgList&type=${type}&page="+page);
				

				}
			});

		});
	</script>

</html>
