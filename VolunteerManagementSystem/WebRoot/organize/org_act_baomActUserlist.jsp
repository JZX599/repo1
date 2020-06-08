<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

<head>
<meta charset="utf-8" />

<link rel="stylesheet" type="text/css"
	href="${ctx }/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx }/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx }/css/ui/act_list_add_upd.css" />
<title></title>
</head>
<style>
/*-----------分页--------*/
#page li {
	cursor: pointer;
}

#page input {
	width: 20px !important;
	height: 15px !important;
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
					<li role="presentation" class="active"><a href="#">报名人员列表</a>
					</li>

					<li role="presentation">
						<!-- 添加用户弹出模态框按钮 --> <a
						href="${ctx }/ActivityServlet?action=getPageActBaomList&state=showAll&page=1">返回活动列表</a>
					</li>

				</ul>

			</div>

			<div class="row" style="margin: 0;padding: 5px;">

				<!--活动查询表单-->
				<div class="col-md-4">
					<h3>
						活动名称：<span class="" style="font-size: 16px;color: black;">${ActBaommsg.AName }</span>
					</h3>
				</div>
				<div class="col-md-4">
					<c:if test="${ActAState==0 }">
						<h3>
							活动状态：<span class="btn btn-pass btn-xs" style="margin-top: -2px">招募中</span>
						</h3>
					</c:if>
					<c:if test="${ActAState==1 }">
						<h3>
							活动状态：<span class="btn btn-godoing btn-xs"
								style="margin-top: -2px">进行中</span>
						</h3>
					</c:if>
					<c:if test="${ActAState==2 }">
						<h3>
							活动状态：<span class="btn btn-end btn-xs" style="margin-top: -2px">已结束</span>
						</h3>
					</c:if>
				</div>
				<div class="col-md-4">
					
				</div>

			</div>

			<div class="row" style="margin: 0;padding: 0;">
				<table class="table  table-bordered table-hover table-condensed">
					<thead>
						<tr>
							<th>序号</th>
							<th>志愿者编号</th>
							<th>姓名</th>
							<th>手机</th>
							<th>性别</th>
							<th>服务时长(h)</th>
							<th>信誉度</th>

							<th>操作</th>
							<th>评价</th>

						</tr>
					</thead>
					<tbody>
						<c:if test="${empty UserBaomlist }">
							<tr>
								<td colspan="10" style="font-weight: 600;">暂无志愿者报名该活动</td>
							</tr>
						</c:if>

						<c:forEach items="${UserBaomlist }" var="userBaom" varStatus="om">
							<tr>
								<th scope="row">${om.index+1 }</th>
								<th>${userBaom.UId }</th>
								<td>${userBaom.UName }</td>
								<td>${userBaom.UPhone }</td>
								<td>${userBaom.USex }</td>
								<!-- 服务时长 -->
								<td>${userBaom.UHours }</td>
								<!-- 信誉度 -->
								<td>
								<c:if test="${userBaom.UCredit<=0 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star-o" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach>
								
								</c:if>
								
								<c:if test="${userBaom.UCredit>0&&userBaom.UCredit<6 }">
								<c:forEach begin="0" end="${userBaom.UCredit-1 }">
										<i class="fa fa-star" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach> 
								<c:forEach begin="0" end="${6-userBaom.UCredit-1}">
										<i class="fa fa-star-o" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach>
								
								</c:if>
								<c:if test="${userBaom.UCredit>=6 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star" style="color: #F0E50F;"
											aria-hidden="true"></i>
								</c:forEach>
								
								</c:if>
								</td>






								<!-- EState活动报名状态0已报名1已通过2已取消 -->
								<!--EFlag 活动参加确认0未确认1通过2未通过  -->
								<!--  /*活动状态0正在招募1正在进行2已结束*/-->
								<!-- 活动状态是招募中 -->
								<c:if test="${ActAState==0 }">
									<c:if test="${userBaom.EState==0 }">
										<td>
										<a href="${ctx }/ActivityServlet?action=orgisPassUserBaom&isPass=Pass&UId=${userBaom.UId }&AId=${userBaom.AId }"
											onclick="return confirm('要录用该志愿者吗？');"
											class="btn btn-success btn-xs "><i
												class="fa fa-check-circle-o"></i>录用</a>&nbsp;&nbsp; 
										<a href="${ctx }/ActivityServlet?action=orgisPassUserBaom&isPass=notPass&UId=${userBaom.UId }&AId=${userBaom.AId }"
											onclick="return confirm('要拒绝该志愿者吗？');"
											class="btn btn-danger btn-xs "><i class="fa fa-close"></i>拒绝</a>
										</td>
										<td></td>
									</c:if>
									<c:if test="${userBaom.EState==1 }">
										<td><a
											href="${ctx }/ActivityServlet?action=orgisPassUserBaom&isPass=notPass&UId=${userBaom.UId }&AId=${userBaom.AId }"
											onclick="return confirm('要取消录用该志愿者吗？');"
											class="btn btn-danger btn-xs ">取消录用</a></td>
										<td></td>

									</c:if>
									<c:if test="${userBaom.EState==2 }">
										<td><a class="btn btn-end btn-xs ">已拒绝</a></td>
										<td></td>
									</c:if>


								</c:if>

								<!-- 活动状态是进行中 -->
								<c:if test="${ActAState==1 }">
									<c:if test="${userBaom.EState==0 }">
										<td><a href="javascript:void(0)"
											class="btn btn-end btn-xs ">报名未审核</a></td>
										<td></td>
									</c:if>
									<c:if test="${userBaom.EState==1 }">

										<td><a href="javascript:void(0)"
											class="btn btn-end btn-xs ">已通过</a></td>
										<td></td>

									</c:if>
									<c:if test="${userBaom.EState==2 }">
										<td><a href="javascript:void(0)"
											class="btn btn-end btn-xs ">已拒绝</a></td>
										<td></td>
									</c:if>

								</c:if>

								<!-- 活动状态是已结束 -->
								<!--EFlag 活动参加确认0未确认1通过2未通过  -->
								<c:if test="${ActAState==2 }">
									<c:if test="${userBaom.EState==0 }">
										<td><a href="javascript:void(0)"
											class="btn btn-end btn-xs ">报名未审核</a></td>
										<td></td>
									</c:if>
									<c:if test="${userBaom.EState==1 }">
										<!--  参加未确认  -->
										<c:if test="${userBaom.EFlag==0 }">
											<td><a onclick="return confirm('该志愿者已参加活动？');"
												href="${ctx }/ActivityServlet?action=orgUserisJoinAct&isJoin=Pass&UId=${userBaom.UId }&AId=${userBaom.AId }"
												class="btn btn-success btn-xs "><i
													class="fa fa-check-circle-o"></i>已参加</a>&nbsp;&nbsp; <a
												onclick="return confirm('该志愿者未参加活动？');"
												href="${ctx }/ActivityServlet?action=orgUserisJoinAct&isJoin=notPass&UId=${userBaom.UId }&AId=${userBaom.AId }"
												class="btn btn-danger btn-xs "><i class="fa fa-close"></i>未参加</a>
											</td>
											<td></td>
										</c:if>
										<!-- 参加通过 -->
										<c:if test="${userBaom.EFlag==1 }">
											<td><a href="javascript:void(0)"
												class="btn btn-end btn-xs ">已参加</a></td>
											<!-- 评价确认0未评价1已好评2已差评 -->
											<td><c:if test="${userBaom.EAssess==0 }">
													<a
														href="${ctx }/ActivityServlet?action=orgActisPingJUser&isPingJ=Good&UId=${userBaom.UId }&AId=${userBaom.AId }"
														onclick="return confirm('给志愿者好评？');"
														class="btn btn-pass btn-xs ">好评</a>
													<a
														href="${ctx }/ActivityServlet?action=orgActisPingJUser&isPingJ=Common&UId=${userBaom.UId }&AId=${userBaom.AId }"
														onclick="return confirm('给志愿者中评？');"
														class="btn btn-godoing btn-xs ">中评</a>
													<a
														href="${ctx }/ActivityServlet?action=orgActisPingJUser&isPingJ=notGood&UId=${userBaom.UId }&AId=${userBaom.AId }"
														onclick="return confirm('给志愿者差评？');"
														class="btn btn-danger btn-xs ">差评</a>
												</c:if> <c:if test="${userBaom.EAssess==1 }">
													<a href="javascript:void(0)" class="btn btn-end btn-xs ">已好评</a>
												</c:if> <c:if test="${userBaom.EAssess==2 }">
													<a href="javascript:void(0)" class="btn btn-end btn-xs ">已差评</a>
												</c:if> <c:if test="${userBaom.EAssess==3 }">
													<a href="javascript:void(0)" class="btn btn-end btn-xs ">已中评</a>
												</c:if></td>
										</c:if>
										<!-- 参加未通过 -->
										<c:if test="${userBaom.EFlag==2 }">
											<td><a href="javascript:void(0)"
												class="btn btn-end btn-xs ">未参加</a></td>
											<td><c:if test="${userBaom.EAssess==0 }">
													<a
														href="${ctx }/ActivityServlet?action=orgActisPingJUser&isPingJ=Good&UId=${userBaom.UId }&AId=${userBaom.AId }"
														onclick="return confirm('给志愿者好评？');"
														class="btn btn-pass btn-xs ">好评</a>
													<a
														href="${ctx }/ActivityServlet?action=orgActisPingJUser&isPingJ=Common&UId=${userBaom.UId }&AId=${userBaom.AId }"
														onclick="return confirm('给志愿者中评？');"
														class="btn btn-godoing btn-xs ">中评</a>
													<a
														href="${ctx }/ActivityServlet?action=orgActisPingJUser&isPingJ=notGood&UId=${userBaom.UId }&AId=${userBaom.AId }"
														onclick="return confirm('给志愿者差评？');"
														class="btn btn-danger btn-xs ">差评</a>
												</c:if> <c:if test="${userBaom.EAssess==1 }">
													<a href="javascript:void(0)" class="btn btn-end btn-xs ">已好评</a>
												</c:if> <c:if test="${userBaom.EAssess==2 }">
													<a href="javascript:void(0)" class="btn btn-end btn-xs ">已差评</a>
												</c:if> <c:if test="${userBaom.EAssess==3 }">
													<a href="javascript:void(0)" class="btn btn-end btn-xs ">已中评</a>
												</c:if></td>
										</c:if>
									</c:if>
									<c:if test="${userBaom.EState==2 }">
										<td><a href="javascript:void(0)"
											class="btn btn-end btn-xs ">报名已拒绝</a></td>
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
<script src="${ctx }/js/jquery.min.js" type="text/javascript"
	charset="utf-8"></script>
<script src="${ctx }/js/bootstrap.min.js" type="text/javascript"
	charset="utf-8"></script>
<!--分页js-->
<script src="${ctx }/js/bootstrap-paginator.js" type="text/javascript"
	charset="utf-8"></script>
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
						$(window).attr('location',"${ctx }/ActivityServlet?action=getUserBaomList&AState=${ActAState}&AId=${ActBaommsg.AId}&page="+page);
			

				}
			});

		});
	</script>

</html>