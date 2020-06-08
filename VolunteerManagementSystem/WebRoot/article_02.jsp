<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>

		<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />

	</head>

	<style type="text/css">
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
		
		.text {
			font-size: 18px;
			text-indent: 2em;
			line-height: 2em;
			font-family: "Songti SC";
		}
	</style>

	<body>
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
	
	<!--头部-->
		<header class="container">

			<br />
			<h2>你出征 我守护 爱心车队、志愿服务队全方位做好志愿服务</h2>
		</header>
		<hr />

		<!--导航条-->
		<nav class="container">
			<blockquote>
				<small>发表日期：2020-03-03&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cite title="Source Title">来源：大冶要闻</cite></small>
			</blockquote>
		</nav>
		<br />
		<!--中部-->
		<article class="container">

			<section>

				<!--导航-->
				<p class="text">抗击疫情时，人间有大爱。你是冲锋在前的“白衣战士”，无畏艰险，逆行向前。我是温暖人心的“红马甲”，倾情守护，温暖人间。自2月26日起，为及时帮助群众解决急难事急用车问题，我市“大冶抗疫爱心车队”、“结对帮助医护家庭志愿者”服务项目正式启动。</p>

				<p class="text">3月2日上午，一辆辆“大冶抗疫爱心车队”车辆停靠在市新时代文明实践中心门口，志愿者陈惠群正把大一早去超市代买的新鲜蔬菜装进车后备箱内，车内还装满了一袋袋“光荣包”，它们将被送到抗疫一线医护工作人员家属手中。</p>
				<div class="text-center">
					<img src="img/ui/article06.jpeg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />

				</div>
				<p class="text">下午1点，记者看到志愿者们刚刚吃完饭就匆匆赶往下一个地点。天公不作美，突然下起倾盆大雨，泥泞的弯曲小道更加不好走。但是这些并没有打击到我们志愿者们的热情，哪怕导航导错了路，志愿者们毫不气馁，坚持把东西安全送达家属手中。“今天下这么大的雨，她们风雨无阻来给我们送东西，帮了我们大忙。我心里非常感动。”家住水南湾的曹志强说道。</p>

				<div class="text-center">
					<img src="img/ui/article07.jpeg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />

				</div>
				<p class="text">“这些医护人员他们都是英雄，我们发自内心地佩服他们，他们一直都没有出仓，一个月没有回过家里。”志愿者柯桂英说道，“我们这个志愿服务队24小时为医护人员家庭解决一切困难，只有让我们的医护人员无后顾之忧，才能够为我们的社会带来健康保障。”</p>

				<p class="text">截至目前，我市结对帮助医护家庭志愿服务队已经与451户医护家庭实现精准对接，梳理出需求信息96条，已落实70余条，其他困难和问题正在协调解决中。（记者 张蕾）</p>
				<hr />

				<blockquote class="blockquote-reverse">

					<small>责任编辑：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong title="Source Title">刘琪</strong></small>
				</blockquote>
			</section>

		</article>
		<hr />
		<br />
		<br />
		<!--尾部-->
		<footer class="container">
			<p class="text-center">Copyright © 2019 版权所有 志愿者网站！ 闽ICP备190606号-1</p>
		</footer>
	</body>
	<script src="js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>

</html>