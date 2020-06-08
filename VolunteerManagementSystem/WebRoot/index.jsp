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
/*志愿者登录的div*/
.content_carousel .user_login {
	border-radius: 10px;
	margin: 15px;
	margin-right: 0px;
	margin-top: 0px;
	padding: 0;
	padding-top: 10px;
	padding-bottom: 8px;
	padding-right: 10px;
	background-color: green;
}
/*组织登录的div*/
.content_carousel .org_login {
	border-radius: 10px;
	margin: 15px;
	margin-right: 0px;
	padding: 0;
	padding-top: 10px;
	padding-bottom: 8px;
	padding-right: 10px;
	background-color: blueviolet;
}
/*查询的div*/
.content_carousel .uo_query {
	border-radius: 10px;
	margin: 15px;
	padding: 0;
	margin-right: 0px;
	padding-top: 10px;
	padding-bottom: 8px;
	padding-right: 10px;
	background-color: orange;
}
/*登录成功div*/
.login_success {
	
}
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
					<li class="active"><a
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
					<li class="dropdown"><a href="#" class="dropdown-toggle"
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
	<!--轮播图-->
	<div class="content_carousel"
		style="background-color: rgba(234, 248, 255, 1)!important;">
		<div class="container my-carousel">
			<!--轮播图加登录入口  body第一行-->
			<div class="row" style="max-height: 382px;overflow: hidden;">
				<div class="col-md-8 col-sm-12" style="padding: 0;">
					<div id="index_img_carousel" class="carousel slide"
						data-ride="carousel">
						<!-- 指标  4个就是4个图-->
						<ol class="carousel-indicators">
							<li data-target="#index_img_carousel" data-slide-to="0"
								class="active"></li>
							<li data-target="#index_img_carousel" data-slide-to="1"></li>
							<li data-target="#index_img_carousel" data-slide-to="2"></li>

						</ol>

						<!-- Wrapper for slides -->
						<div class="carousel-inner" role="listbox">
							<div class="item active">
								<a href="${ctx }/article_01.jsp"> <img src="img/fff.png" alt="..."
									style="display: block;width: 100%;height: 382px;">
									<div class="carousel-caption">

										<p>阻击疫情 志愿同行</p>
									</div>
								</a>
							</div>
							<div class="item">
								<a href="${ctx }/article_03.jsp"> <img src="img/index_ac02.jpg" alt="..."
									style="display: block;width: 100%;height: 382px;">
									<div class="carousel-caption">
										<p>疫情发生后厦门公交“小黄帽”志愿者的“请战”故事</p>
									</div>
								</a>

							</div>
							<div class="item">
								<a href="${ctx }/article_02.jsp"> <img src="img/55.png" alt="..."
									style="display: block;width: 100%;height: 382px;">
									<div class="carousel-caption">
									
										<p>你出征 我守护</p>
									</div>
								</a>

							</div>

						</div>

						<!-- Controls -->
						<a class="left carousel-control" href="#index_img_carousel"
							role="button" data-slide="prev"> <span
							class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">上一个</span>
						</a> <a class="right carousel-control" href="#index_img_carousel"
							role="button" data-slide="next"> <span
							class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							<span class="sr-only">下一个</span>
						</a>
					</div>
				</div>

				<div class="col-md-4 hidden-sm hidden-xs" style="padding: 0; ">

					<c:if test="${empty user &&empty organize }">


						<!--志愿者-->
						<div class="row user_login">
							<div class="col-md-6">
								<span class="fa fa-user "
									style="font-size: 95px; color: white;margin-left: 12px;"></span>
							</div>

							<div class="col-md-6">
								<ul style="list-style: none;padding:15px;">
									<li style="padding-bottom: 5px;padding-top:5px;"><a
										href="${ctx }/user/user_org_login.jsp"
										style="text-decoration: none;color: white;">志愿者登录</a></li>
									<li><a href="${ctx }/user/user_register.jsp"
										style="text-decoration: none;color: white;">志愿者注册</a></li>
								</ul>
							</div>
						</div>

						<!--组织-->
						<div class="row org_login">
							<div class="col-md-6">
								<span class="fa fa-group" style="font-size: 95px; color: white;"></span>
							</div>

							<div class="col-md-6">
								<ul style="list-style: none;padding: 15px;">
									<li style="padding-bottom: 5px;padding-top:5px;"><a
										href="${ctx }/user/user_org_login.jsp"
										style="text-decoration: none;color: white;">组织登录</a></li>
									<li><a href="${ctx }/organize/org_register.jsp"
										style="text-decoration: none;color: white;">组织注册</a></li>

								</ul>
							</div>
						</div>

					</c:if>

					<c:if test="${!empty user && empty organize }">
						<!--登录成功时显示-->
						<div class="row login_success"
							style="border-radius: 10px; margin-left: 15px;  margin-right: 0px; margin-top: 0px;padding-bottom: 30px; background-color:mediumorchid;">
							<div class="row" style="padding: 5px;">
								<img src="img/usertouxiang.png"
									class="img-responsive center-block" />
							</div>

							<div class="row" style="padding: 10px;">
								<h4
									style="text-align: center; margin: 0;padding: 0;color: #F0F0F0;cursor: pointer;">${user.UName}</h4>
							</div>
							<div class="row" style="padding: 5px;">
								<span
									style="display: block; text-align: center;margin: 0 auto; color: white;">
									服务时长：${user.UHours } 小时 </span>
							</div>
							<div class="row" style="padding-top: 10px;">
								<div class="col-xs-3"></div>
								<div class="col-xs-3" style="padding: 0;">
									<a href="${ctx}/user/user_manage.jsp" class="btn btn-success pull-right"
										style="border-radius: 15px; font-size: 14px;margin-right: 5px;">个人中心</a>
								</div>
								<div class="col-xs-3" style="padding: 0;">
									<a href="${ctx }/UserServlet?action=Logout"
										onclick="return confirm('您确认要退出吗？');" class="btn btn-success"
										style="border-radius: 15px;font-size: 14px;margin-left: 5px;">退出登录</a>
								</div>
								<div class="col-xs-3"></div>
							</div>
						</div>
					</c:if>

					<c:if test="${empty user && !empty organize }">
						<!--登录成功时显示-->
						<div class="row login_success"
							style="border-radius: 10px; margin-left: 15px;  margin-right: 0px; margin-top: 0px;padding-bottom: 30px; background-color:mediumorchid;">
							<div class="row" style="padding: 5px;">
								<img src="img/usertouxiang.png"
									class="img-responsive center-block" />
							</div>

							<div class="row" style="padding: 10px;">
								<h4
									style="text-align: center; margin: 0;padding: 0;color: #F0F0F0;cursor: pointer;">${organize.OName}</h4>
							</div>
							<div class="row" style="padding: 5px;">
								<span
									style="display: block; text-align: center;margin: 0 auto; color: white;">
									  </span><br/>
							</div>
							<div class="row" style="padding-top: 10px;">
								<div class="col-xs-3"></div>
								<div class="col-xs-3" style="padding: 0;">
									<a href="${ctx}/organize/org_manage.jsp"
										class="btn btn-success pull-right" style="border-radius: 15px; font-size: 14px;margin-right: 5px;">组织中心</a>
										
								</div>
								<div class="col-xs-3" style="padding: 0;">
										<a
										href="${ctx}/OrganizeServlet?action=Logout"
										onclick="return confirm('您确认要退出吗？');" class="btn btn-success"
										style="border-radius: 15px; font-size: 14px;margin-left: 5px;">退出登录</a>
								</div>
								<div class="col-xs-3"></div>
							</div>
						</div>
					</c:if>
					<!--查询-->
					<div class="row  uo_query">
						<div class="col-md-6">
							<span class="fa fa-search"
								style="font-size: 95px;color: white;margin-left: 12px;"></span>

						</div>

						<div class="col-md-6">
							<ul style="list-style: none;padding: 10px;">
								<li style="padding-bottom: 5px;padding-top: 5px;"><a
									href="" style="text-decoration: none;color: white;">志愿者查询</a></li>
								<li style="padding-bottom: 5px;"><a href="${ctx }/IndexServlet?action=getAllPageActList&type=showAll"
									style="text-decoration: none;color: white;">志愿活动查询</a></li>
								<li><a href="${ctx }/IndexServlet?action=getAllPageOrgList&type=showAll" style="text-decoration: none;color: white;">志愿者组织查询</a>
								</li>
							</ul>
						</div>

					</div>

				</div>

			</div>
			<!--最新活动  body第二行-->
			<div class="row" style="margin-top: 5px;">
				<div class="panel  panel-info">
					<div class="panel-heading" style="position: relative;">
						<h3 class="panel-title" style="font-weight: bold;">最新活动</h3>
						<a href="${ctx }/IndexServlet?action=getAllPageActList&type=showAll"
							style="position: absolute; right: 15px;top: 5px;font-size: 12px;padding: 5px;text-decoration: none;">查看更多</a>
					</div>
					<div class="panel-body" style="padding-top: 0px;">

						<div class="row" style="margin-top: 5px;">
							<div class="list-group " style="">

								<c:if test="${empty IndexActList}">
									<c:redirect url="IndexServlet?action=getAllActList"></c:redirect>
								</c:if>




<c:if test="${fn:length(IndexActList)>0 }">
				<c:forEach items="${IndexActList }" begin="0" end="5" var="act">
										<!--一个活动-->
										<div class="col-md-4 col-sm-6 col-xs-12"
											style="margin-top: 15px;padding-left:8px;padding-right:8px; padding-top: 4px">
		<a href="${ctx }/IndexServlet?action=getActInfo&AId=${act.AId}"
		class="list-group-item list-group-item-success">
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
														style="font-size: 12px;">活动时间${act.AStartDate}至${act.AEndDate }</span>
													<c:if test="${act.AState==0}">
														<span class="btn btn-pass btn-sm"
															style="font-size: 12px;margin-left: 5px;line-height: 12px;">招募中</span>
													</c:if>
													<c:if test="${act.AState==1}">
														<span class="btn btn-godoing btn-sm"
															style="font-size: 12px;margin-left: 5px;line-height: 12px;">进行中</span>
													</c:if>
													<c:if test="${act.AState==2}">
														<span class="btn btn-end btn-sm"
															style="font-size: 12px;margin-left: 5px;line-height: 12px;">已结束</span>
													</c:if>
												</div>
											</a>
										</div>
				</c:forEach>
</c:if>

								<c:if test="${fn:length(IndexActList)==0 }">
									<div class="col-md-12" style="margin-top: 15px;">
										<h4 class="text-center">暂无活动信息</h4>
									</div>
								</c:if>


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
<script src="${ctx }/js/ui/footer.js" type="text/javascript" charset="utf-8"></script>

</html>