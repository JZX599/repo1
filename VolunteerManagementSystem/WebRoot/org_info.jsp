<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
	<style type="text/css">
		/*-------------------头部导航样式-------------------------------------------*/
		
		.header {
			background-color: rgba(234, 248, 255, 1)!important;
			margin: 0 auto;
		}
		
		.navbar {
			margin: 0;
		}
		
		.my-nav {
			background-color: #D8E0F0;
			color: #6C6C6C;
		}
		
		.navbar-default .navbar-nav>.active>a,
		.navbar-default .navbar-nav>.active>a:focus,
		.navbar-default .navbar-nav>.active>a:hover {
			color: #FFFFFF;
			font-weight: bold;
			background-color: #C0D0F0;
		}
		/*导航条通用a样式*/
		
		.navbar-default .navbar-nav>li>a {
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
		
		.navbar-default .navbar-nav>.open>a,
		.navbar-default .navbar-nav>.open>a:focus,
		.navbar-default .navbar-nav>.open>a:hover {
			color: white;
			background-color: #C0D0F0;
		}
		
		.my-carousel {
			padding: 0px;
			padding-top: 5px;
		}
		/*---------------------以下是活动详情页的css-----------------------------------------*/
		
		.activity_header {
			margin: 0 auto;
		}
		
		.m-5 {
			margin-left: 5px;
		}
		
		.col-md-6 span {
			line-height: 38px;
			font-size: 15px;
		}
		
		.col-md-12,
		.col-md-4 {
			padding-right: 0px;
		}
		/*---------------------以上是活动详情页的css-----------------------------------------*/
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
					<li class="dropdown  active"><a href="#" class="dropdown-toggle"
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


<!-- 中部 -->
	<div class="content_carousel" style="background-color: rgba(234, 248, 255, 1)!important;padding-bottom: 10px;">
	


		<div class="container" >
			<div class="row" style="margin: 0;margin-left: -15px;margin-right: -15px;">
				<ol class="breadcrumb" style=" background-color: #D5AED8; margin: 0;padding: 0;margin-top: 5px; line-height: 35px;border-bottom-left-radius: 0px;border-bottom-right-radius: 0px; ">
					<li>&nbsp;<i class="glyphicon glyphicon-home" style="color:white"></i>
						<a href="${ctx }/IndexServlet?action=getAllActList" style="color:white;"> 首页</a>
					</li>
					<li>
						<a href="${ctx }/IndexServlet?action=getAllPageOrgList&type=showAll" style="color: white;">组织查询</a>
					</li>
					<li class="active">厦门公益组织</li>
				</ol>
			</div>
		</div>

		<div class="container" style="border: 1px solid #D4D4D4; background-color: white;">

			<div class="row" style=" padding-top: 20px;padding-left: 15px;padding-right: 15px;">

				<div class="col-md-12" style="background-color: #06BB7A;color: white;border-radius: 5px;padding-top: 5px;">
					<img src="img/usertouxiang.png" class="img-responsive center-block" />
					<h3 style="text-align: center;">${indexorg.OName }</h3>
					<div class="row" style="padding: 15px;">
						<div class="col-md-4" style="margin-bottom: 25px; ">
							<i class="fa fa-newspaper-o" aria-hidden="true"></i> <span>组织编号：</span>
							<span>${indexorg.OId }</span>
						</div>
						
						<div class="col-md-4" style="margin-bottom: 25px; ">
							<i class="glyphicon glyphicon-user"></i> <span>法人：</span>
							<span>${indexorg.OPerson }</span>
						</div>
						<div class="col-md-4 " style="margin-bottom: 25px;">
							<i class="glyphicon glyphicon-envelope"></i> <span>组织邮箱：</span>
							<span>${indexorg.OEmail }</span>
						</div>
						<div class="col-md-4" style="margin-bottom: 25px;">
							<i class="glyphicon glyphicon-time"></i> <span>注册日期：</span>
							<span>${indexorg.ODate }</span>
						</div>
						<div class="col-md-4" style="margin-bottom: 25px;">
							<i class="glyphicon glyphicon-map-marker"></i> <span>地址：</span>
							<span>${indexorg.OAddress }</span>
						</div>

						<div class="col-md-4" style="margin-bottom: 25px;">
							<i class="fa fa-database" aria-hidden="true"></i> <span>活动数量：</span>
							<span>${orgactnum }</span>
						</div>
					</div>

				</div>

			</div>
			<div class="row" style="margin-top: 5px;padding-left: 15px;padding-right: 15px;">

				<div class="col-md-12" style="padding: 0;">
					<div class="col-md-6" style="padding: 0;padding-right: 30px;">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title" style="font-weight: 600;">组织简介</h3>
							</div>
							<div class="panel-body" style="min-height: 150px;">
								<span>
	${indexorg.OSynopsis }
</span>
							</div>
						</div>
					</div>
					<div class="col-md-6" style="padding: 0;">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title" style="font-weight: 600;">公告</h3>
							</div>
							<div class="panel-body" style="min-height: 150px;">
								<span>
	公告内容
</span>
							</div>
						</div>
					</div>
				</div>

			</div>

			<div class="row" style="padding-bottom: 70px;padding-left: 15px;padding-right: 15px;">

				<div class="col-md-12" style="background-color:#F5F5F5;margin: 0;padding: 0;">
					<span class="btn" style="border-radius: 0px; vertical-align: middle;background-color: #09CA85;color: white;font-weight: 600;">组织活动</span>
					<span class=" btn pull-right">更多+</span>
				</div>

			</div>
		</div>
		</div>
		<!--尾部-->
		<footer style="text-align: center;padding: 20px;background-color: white; ">
			<div class="container">

				<div class="row">
					<div class="col-md-4 hidden-sm hidden-xs">
						<h4 style="text-align: center;color: #ea7716;">Copyright</h4>
						<hr style="color: #36241b;margin: 0 auto; width: 90%;" />
						<div class="p">

							<p>凡注明本站原创文章、作品，未经本人许可，任何人或机构不得以任何形式对本站内容进行复制作商业用途.</p>

							<img src="img/ui/index_email.png" width="12px" height="12px" style="margin-right: 5px;" /><span>邮箱：59948023@qq.com</span>
						</div>
					</div>
					<div class="col-md-4 hidden-sm hidden-xs">

					</div>
					<div class="col-md-4 hidden-sm hidden-xs" style="padding: 5px;">
						<h4 style="text-align: center;color: #ea7716;">About</h4>
						<hr style="color: #36241b;margin: 0 auto; width: 90%;" />
						<div class="p">

							<p>本站部分文章、资源来自互联网，版权归原作者及网站所有，如果侵犯了您的权利，请及时致信告知我站</p>

							<img src="img/ui/index_adderss.png" width="14px" height="14px" style="margin-right: 5px;" /><span>地址：福建省厦门市</span><img src="img/ui/index_phone.png" width="12px" height="12px" style="margin-right: 5px;margin-left: 5px;" /><span data-toggle="tooltip" data-placement="left" title="18650170313" style="cursor:pointer;">联系我们</span>

						</div>
					</div>
				</div>
				<div class="row">

					<span>Copyright © 2019 版权所有 志愿者网站！ 闽ICP备190606号-1 本站总浏览量:</span><span id="local_num" class="fanke_span"></span><span>次</span>

				</div>
			</div>
		</footer>
	</body>
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/ui/footer.js" type="text/javascript" charset="utf-8"></script>

</html>