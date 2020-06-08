<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/font-awesome.min.css"/>
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
					<h3>志愿者管理</h3>
					<hr />
				</div>

				<div class="row" style="padding: 0;">
					<ul class="nav nav-tabs">
						<li role="presentation"  class="active">
							<a href="admin_org_list.html">志愿者列表</a>
						</li>
					</ul>

				</div>

			<div class="row" style="margin: 0;padding: 5px;">

				
				<div class="col-md-3">

					</div>

					<div class="col-md-9">
						<form action="${ctx }/AdminServlet?action=getAllUserList" method="post" class="navbar-form  ">
							<select name="type" class="form-control input-sm col-md-3 ">
								<option value="UId">志愿者编号</option>
								<option value="UName">姓名</option>
								<option value="UIdCard">身份证</option>
							

							</select>
							<input type="text" class="form-control input-sm" name="txtSearch" placeholder="">
							<button type="submit" class="btn btn-default btn-sm">模糊查询</button>

						</form>
				</div>

				<div class="row" style="margin: 0;padding: 0;">
					<table class="table  table-bordered table-hover table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>编号</th>
								<th>姓名</th>
								<th>邮箱</th>

								<th>手机号</th>
								<th>住址</th>
								<th>性别</th>
								<th>服务时长</th>
								<th>身份证</th>
								<th>信誉度</th>
								<th>账号状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${fn:length(userPageList)==0 }">
							<tr>
								<td colspan="20" style="font-weight: 600;">暂无志愿者信息</td>
							</tr>
						</c:if>
						
						
						<c:if test="${fn:length(userPageList)>0 }">
						<c:forEach items="${userPageList }"  var="a_user" varStatus="sm">
					
						<tr>
								<th scope="row">${sm.index+1 }</th>
								<td>${a_user.UId }</td>
								<td>${a_user.UName }</td>
								<td>${a_user.UEmail }</td>
								<td>${a_user.UPhone }</td>
								<td>${a_user.UAddress }</td>
								<td>${a_user.USex }</td>
								<td>${a_user.UHours }</td>
								<td>${a_user.UIdCard }</td>
								<!-- 信誉度 -->
								<td>
								
								<c:if test="${a_user.UCredit<=0 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star-o" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach>
								
								</c:if>
								
								<c:if test="${a_user.UCredit>0&&a_user.UCredit<6 }">
								<c:forEach begin="0" end="${a_user.UCredit-1 }">
										<i class="fa fa-star" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach> 
								<c:forEach begin="0" end="${5-a_user.UCredit}">
										<i class="fa fa-star-o" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach>
								
								</c:if>
								<c:if test="${a_user.UCredit>=6 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach>
								
								</c:if>
								
								</td>
								<!-- 志愿者状态  1正常2冻结 -->
								<c:if test="${a_user.UState==1 }">
								<td>
								正常
								</td>
								<td>

									<!-- 下拉按钮 -->
									<div class="btn-group ">
										<button type="button" class="btn btn-success dropdown-toggle btn-xs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    操作<span class="caret"></span>
									  </button>
										<ul class="dropdown-menu" style="min-width: 20px;margin-left: -40px;">
											<li>
												<a href="${ctx }/AdminServlet?action=ResetUserPwd&UId=${a_user.UId }" onclick="return confirm('您确认要重置该志愿者密码吗？');">重置密码</a>
											</li>
											<li>
												<a href="${ctx }/AdminServlet?action=DongJUser&UId=${a_user.UId }" onclick="return confirm('您确认要冻结该志愿者吗？');">冻结</a>
											</li>
										</ul>
									</div>

								</td>
								
								</c:if>
								<c:if test="${a_user.UState==2 }">
								<td>
								冻结
								</td>
								
								<td>
									<a  href="${ctx }/AdminServlet?action=JieDUser&UId=${a_user.UId }" class="btn btn-xs btn-danger" onclick="return confirm('您确认要解冻该志愿者吗？');">解冻</a>
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
			$(window).attr('location',"${ctx }/AdminServlet?action=getAllUserList&type=${type}&page="+page);
				

				}
			});

		});
	</script>

</html>