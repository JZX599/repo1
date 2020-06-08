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
			<h2>助力疫情防控 厦门青年志愿者参与志愿服务活动2万人次</h2>
		</header>
		<hr />

		<!--导航条-->
		<nav class="container">
			<blockquote>
				<small>发表时间：2020-04-09&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cite title="Source Title">来源：厦门文明网</cite></small>
			</blockquote>
		</nav>
		<br />
		<!--中部-->
		<article class="container">

			<section>

				<!--导航-->
				<p class="text">青春，就是要到党和人民最需要的地方燃放生命之光。疫情发生以来，厦门市青年志愿者积极响应“爱心厦门助力战疫”倡议，在疫情防控的各领域奉献青春正能量。</p>
				<div class="text-center">
					<img src="img/ui/article01.jpg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">厦门大学青年志愿者为援鄂医务人员子女提供学习帮助 厦门团市委 供图</font>
				</div>
				<p class="text">“帮助援鄂医生子女辅导课业，寓教于乐的厦门大学志愿者是新时代最美大学生！”近日，援鄂医生家属郎桂斌向厦大送来一封特别的感谢信。在他的爱人赴鄂支援，他忙于照顾两个孩子之际，是厦大的青年志愿者为他的孩子辅导功课，解了他的燃眉之急。这场“战疫无忧”云辅导爱心行动由厦门大学团委组织开展，得到众多学生响应参与。他们查资料、备课、做PPT，积极为厦门大学附属第一医院杏林分院等一线医护人员的子女提供学业辅导、心理疏导等线上志愿服务。</p>
				<div class="text-center">
					<img src="img/ui/article02.jpg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">厦门光明志愿服务联盟的青年志愿者们给独居老人送上粮油、米面、蔬菜水果等生活物资 厦门团市委 供图</font>

				</div>
				<p class="text">翔安大嶝街道的青年志愿者以敲锣、喊麦、广播车的形式，提倡居民少出门、戴口罩；厦门光明志愿服务联盟的青年志愿者为独居老人送上生活必需品和口罩、消毒酒精等防疫用品；华侨大学、厦门医学院、厦门城市职业学院等高校的学子采用充满创意的“以艺战疫”方式，将防疫知识做成漫画、动画、表情包、海报等，在网上广泛传播。</p>
				<div class="text-center">
					<img src="img/ui/article05.jpg" style="width: 30%;height: 30%;" class="img-responsive center-block" />
					<img src="img/ui/article03.jpg" style="width: 30%;height: 30%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">厦门城市职业学院青年志愿者绘制防疫科普系列漫画 厦门团市委 供图</font>

				</div>
				<div class="text-center">
					<img src="img/ui/article04.jpg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">厦门青年外语志愿服务队伍用专业技能援助厦门机场入境分流点 厦门团市委 供图</font>

				</div>
				<p class="text">为争取广大市民包括在厦外籍人士的理解，共同支持做好疫情防控工作，一支特殊的志愿者队伍在疫情防控期间成立。“厦门青年外语志愿服务队伍”由团市委联合市委文明办、市委外办等组建，队伍包含102名青年志愿者，其中不乏精通英、法、德、日等外语的人才。穿上防护装备，踏入厦门机场，集美大学外国语学院英语系的专任教师陈晓铃接待了七八名国外友人。“他们都很友好，积极配合信息核对和隔离等工作。”陈晓铃说，用自己的专业技能服务社会，这是青年的责任。</p>

				<p class="text">　截至目前，厦门市共青团组织已动员2000余名青年志愿者，参与志愿服务活动2万人次，在疫情防护宣传、推动复工复产、政策措施解读、稳定社会情绪等多个领域奉献青春的光与热。（厦门日报记者卫琳）</p>
				<hr />

				<blockquote class="blockquote-reverse">

					<small>责任编辑：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong title="Source Title">苏文彬 张殊凡</strong></small>
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