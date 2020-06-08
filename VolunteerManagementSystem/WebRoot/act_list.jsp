<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
</head>
<style type="text/css">
.header {
	background-color: rgba(234, 248, 255, 1) !important;
	margin: 0 auto;
}

.navbar {
	margin: 0;
}

.my-nav {
	background-color: #D8E0F0;
	color: #6C6C6C;
}

.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.active>a:focus,
	.navbar-default .navbar-nav>.active>a:hover {
	color: #FFFFFF;
	font-weight: bold;
	background-color: #C0D0F0;
}
/*导航条通用a样式*/
.navbar-default .navbar-nav>li>a {
	/*font-family:STXinwei;*/
	color: #252E30;
}
/*导航条通用li鼠标悬浮背景样式*/
.navbar-default .navbar-nav li:hover {
	background-color: #C0D0F0;
	transition: all 0.5s ease;
}

.navbar-default .navbar-nav li {
	transition: all 0.5s ease;
}
/*鼠标悬浮 a通用颜色*/
.navbar-default .navbar-nav>li>a:hover {
	color: white;
	background-color: transparent;
}
/*我要查询按钮  按下样式*/
.navbar-default .navbar-nav>.open>a, .navbar-default .navbar-nav>.open>a:focus,
	.navbar-default .navbar-nav>.open>a:hover {
	color: white;
	background-color: #C0D0F0;
}

.my-carousel {
	padding: 0px;
	padding-top: 5px;
}
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

<body style="margin-top: -20px">
	<!--头部-->
	<div class="header">
		<div class="container" style="padding: 0;">
			<img src="img/last.png"
				class="img-responsive center-block hidden-xs hidden-sm" />
		</div>
	</div>
	<!--导航-->
	<div class="head_nav">
		<!--导航条-->
		<nav class="navbar navbar-default my-nav">
		<div class="container" style="padding: 0; ">
			<!-- 导航条按钮 -->
			<div class="navbar-header" style="margin-left: -15px;">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#index_btn1"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!--i志愿-->
				<span class="navbar-brand"
					style="cursor: pointer; background-image: url(img/nav_log2.png) ;background-position: center 48%; background-size: cover; display: block; width: 80px;"></span>
			</div>

			<!-- 导航条ul -->
			<div class="collapse navbar-collapse" id="index_btn1">
				<ul class="nav navbar-nav">
					<li ><a
						href="${ctx }/IndexServlet?action=getAllActList">网站首页</a></li>
					<li><a href="${ctx }/UserServlet?action=getUserHonList">光荣榜</a></li>

				</ul>

				<ul class="nav navbar-nav navbar-right">
					<c:if test="${empty user && empty organize }">
						<li class="hidden-lg hidden-md"><a
							href="${ctx }/user/user_org_login.jsp">登录</a></li>
						<li class="hidden-lg hidden-md"><a
							href="${ctx }/user/user_register.jsp">注册</a></li>
					</c:if>

					<c:if test="${!empty user && empty organize}">
						<li class="hidden-lg hidden-md"><a href="${ctx}/user/user_manage.jsp">${user.UName}</a>
						</li>
						<li class="hidden-lg hidden-md"><a
							href="${ctx }/UserServlet?action=Logout"
							onclick="return confirm('您确认要退出吗？');">退出</a></li>
					</c:if>
					<c:if test="${empty user && !empty organize}">
						<li class="hidden-lg hidden-md"><a href="${ctx}/organize/org_manage.jsp">${organize.OName}</a>
						</li>
						<li class="hidden-lg hidden-md"><a
							href="${ctx }/OrganizeServlet?action=Logout"
							onclick="return confirm('您确认要退出吗？');">退出</a></li>
					</c:if>
					<li><a href="#">关于我们</a></li>
					<li class="dropdown active"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">我要查询<span class="caret"></span></a>
						<ul class="dropdown-menu my-nav">
							<li><a href="#">志愿者查询</a></li>
							<li><a href="${ctx }/IndexServlet?action=getAllPageOrgList&type=showAll">组织查询</a></li>
							<li><a href="${ctx }/IndexServlet?action=getAllPageActList&type=showAll">活动查询</a></li>

						</ul></li>
				</ul>
			</div>
		</div>
		</nav>
	</div>
	
	
	
		<!--中部-->

		<div id="my-carousel" style="background-color: rgba(234, 248, 255, 1)!important;">

			<div class="container" style="">
				<!--最新活动  body第二行-->
				<div class="row" style="margin-top: 5px;">
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3 class="panel-title" style="font-weight: bold;"><i class="glyphicon glyphicon-flag"></i>志愿服务活动查询</h3>
						</div>
						<div class="panel-body" style="padding-top: 0px;min-height: 500px;">

							<div class="row" style="margin: 0;padding: 5px;">

								<!--活动查询表单-->
								<div class="col-md-2 hidden-sm hidden-xs">

								</div>

								<div class="col-md-9 col-sm-12 ">
									<form class="navbar-form  " action="${ctx }/IndexServlet?action=getAllPageActList" method="post">
										<select name="type" class="form-control input-sm col-md-3 ">
											<option value="AName"><span>活动名称</span></option>
											<option value="AAddress">活动地点</option>

										</select>
										<input type="text" class="form-control input-sm" name="txtSearch" >
										<button type="submit" class="btn btn-default btn-sm">模糊查询</button>

										<a href="${ctx }/IndexServlet?action=getAllPageActList&type=pass" class="btn btn-pass btn-sm">招募中</a>
										<a href="${ctx }/IndexServlet?action=getAllPageActList&type=godoing" class="btn btn-godoing btn-sm">进行中</a>
										<a href="${ctx }/IndexServlet?action=getAllPageActList&type=end" class="btn btn-danger btn-sm">已结束</a>
										<a href="${ctx }/IndexServlet?action=getAllPageActList&type=showAll" class="btn btn-info btn-sm">全部活动</a>
									</form>
								</div>

								<div class="col-md-1 hidden-sm hidden-xs">

								</div>
							</div>
							<div class="row" style="margin-top: 5px;">
								<div class="list-group " style="">
									

								




<c:if test="${fn:length(IndexPageActList)>0 }">
				<c:forEach items="${IndexPageActList }"  var="act">
										<!--一个活动-->
										<div class="col-md-4 col-sm-6 col-xs-12"
											style="margin-top: 15px;padding-left:8px;padding-right:8px; padding-top: 4px">
		<a href="${ctx }/IndexServlet?action=getActInfo&AId=${act.AId}"
		class="list-group-item list-group-item-warning">
												<div class="row" style="padding: 8px;">
													<span style="font-size: 18px; font-weight: 400;">${act.AName }</span>
												</div>
												<div class="row" style="padding: 5px;">
													<i class="glyphicon glyphicon-flag"></i> <span
														style="font-size: 12px;">${act.organize.OName }</span> <i
														class="glyphicon glyphicon-map-marker"></i> <span
														style="font-size: 12px; ">${act.AAddress }</span>
												</div>
												<div class="row" style="padding: 5px;">
													<i class="glyphicon glyphicon-time"></i> <span
														style="font-size: 12px;">${act.AStartDate}至${act.AEndDate }</span>
													<c:if test="${act.AState==0}">
														<span class="btn btn-pass btn-sm pull-right"
															style="font-size: 12px;margin-left: 5px;line-height: 12px;">招募中</span>
													</c:if>
													<c:if test="${act.AState==1}">
														<span class="btn btn-godoing btn-sm pull-right"
															style="font-size: 12px;margin-left: 5px;line-height: 12px;">进行中</span>
													</c:if>
													<c:if test="${act.AState==2}">
														<span class="btn btn-end btn-sm pull-right"
															style="font-size: 12px;margin-left: 5px;line-height: 12px;">已结束</span>
													</c:if>
												</div>
											</a>
										</div>
				</c:forEach>
</c:if>

								<c:if test="${fn:length(IndexPageActList)==0 }">
									<div class="col-md-12" style="margin-top: 15px;">
										<h4 class="text-center">暂无活动信息</h4>
									</div>
								</c:if>
									
									
								</div>
							</div>
							
							
						
						</div>
						<!--分页-->
							<div class="row" style="margin: 0;padding: 0;">

								
									<ul id="page" style="font-size: 12px;float: right;margin-right: 10px!important;"></ul>
								
							</div>
					</div>
				</div>

			</div>
		</div>
		</div>
	
	
	
	<!--尾部-->
		<footer
			style="text-align: center;padding: 20px;background-color: white; ">
		<div class="container">

			<div class="row">
				<div class="col-md-4 hidden-sm hidden-xs">
					<h4 style="text-align: center;color: #ea7716;">Copyright</h4>
					<hr style="color: #36241b;margin: 0 auto; width: 90%;" />
					<div class="p">

						<p>凡注明本站原创文章、作品，未经本人许可，任何人或机构不得以任何形式对本站内容进行复制作商业用途.</p>

						<img src="img/ui/index_email.png" width="12px" height="12px"
							style="margin-right: 5px;" /><span>邮箱：59948023@qq.com</span>
					</div>
				</div>
				<div class="col-md-4 hidden-sm hidden-xs"></div>
				<div class="col-md-4 hidden-sm hidden-xs" style="padding: 5px;">
					<h4 style="text-align: center;color: #ea7716;">About</h4>
					<hr style="color: #36241b;margin: 0 auto; width: 90%;" />
					<div class="p">

						<p>本站部分文章、资源来自互联网，版权归原作者及网站所有，如果侵犯了您的权利，请及时致信告知我站</p>

						<img src="img/ui/index_adderss.png" width="14px" height="14px"
							style="margin-right: 5px;" /><span>地址：福建省厦门市</span><img
							src="img/ui/index_phone.png" width="12px" height="12px"
							style="margin-right: 5px;margin-left: 5px;" /><span
							data-toggle="tooltip" data-placement="left" title="18650170313"
							style="cursor:pointer;">联系我们</span>

					</div>
				</div>
			</div>
			<div class="row">

				<span>Copyright © 2019 版权所有 志愿者网站！ 闽ICP备190606号-1 本站总浏览量:</span><span
					id="local_num" class="fanke_span"></span><span>次</span>

			</div>
		</div>
		</footer>
</body>
<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
<!--分页js-->
	<script src="js/bootstrap-paginator.js" type="text/javascript" charset="utf-8"></script>
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
			$(window).attr('location',"${ctx }/IndexServlet?action=getAllPageActList&type=${type}&page="+page);
				

				}
			});

		});
		
		/*网站访问次数*/
		function saveLocalStorage() {

		}

		function loadLocalStorage() {

		}

		var local_num = localStorage.getItem('NVaule') ? localStorage.getItem('NVaule') : 0;
		document.getElementById("local_num").innerHTML = local_num;
		localStorage.setItem('NVaule', +local_num + 1);
	</script>

</html>