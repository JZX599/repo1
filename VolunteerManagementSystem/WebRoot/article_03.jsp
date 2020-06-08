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
			<h2>疫情发生后厦门公交“小黄帽”志愿者的“请战”故事</h2>
		</header>
		<hr />

		<!--导航条-->
		<nav class="container">
			<blockquote>
				<small>日期：2020-02-21&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cite title="Source Title">来源：海西晨报</cite></small>
			</blockquote>
		</nav>
		<br />
		<!--中部-->
		<article class="container">

			<section>

				<!--导航-->
				<p class="text">一场突如其来的疫情，让城市陷入了短暂的沉寂，街道空了，路上人少了，灯光黯淡了。</p>
				<p class="text">你所不知的角落里，却比往日里还要喧嚣：小区门口24小时的防疫点、高速公路路口的防疫站、火车站前驻守的保障车队、一趟趟不停歇公交车、一个个头戴“小黄帽”的身影……</p>

				<p class="text">无需过多言语，温暖依旧顺着每一条街道流动，流向每一个细微之处———我们看到，一些人为它挺身而出，一些人将它坚定守护……无法冲上一线，他们依然用着自己的方式铸就“爱心厦门”。</p>
				<p class="text">因为有了他们，这座城市不会失去温度。</p>
				<p class="text">所有的暖意正在汇聚，等待着春天来临的那一刻。</p>
				<p class="text text-danger">镜头一</p>
				<p class="text text-danger">劝别人少出门</p>
				<p class="text text-danger">自己却“闲不住”</p>
				<div class="text-center">
					<img src="img/ui/article08.jpg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">叶拥军在检查来往车辆的后备厢。</font>
				</div>
				<p class="text">每日清晨，129路公交司机、小黄帽志愿者叶拥军吃过早饭后，就匆匆出门了。这天，他又来到厦港街道博物馆附近驻点，为来往的市民测量体温、做登记。</p>
				<p class="text">虽然劝别人少出门，但叶拥军自己却“闲不住”———上午做志愿，下午到晚上做本职工作。十多天来，几乎每个上午他都“泡”在社区里。午饭后，他又马不停蹄地赶往五通泥金公交场站发车，一直忙碌到晚上12点，到家已接近凌晨1点。</p>
				<p class="text">“老叶，你一天到晚的，不累吗?”得知叶拥军的本职工作是公交驾驶员，社区人员都有些意外。“不累、不累，习惯了。”叶拥军总是笑笑，并不多言。鲜有人知道，他是志愿达人，曾登上过厦门小黄帽文明交通志愿服务联盟的积分榜榜首。家人评价他：不是在工作的路上，就是在做志愿的路上。</p>
				<p class="text">“疫情发生之后，我想着我也能做些什么就好了。”在社区做防疫，叶拥军觉得这是他力所能及的事情。</p>
				<p class="text">几天前，发生了一件令他感到后怕的事情。当时，叶拥军为一辆微型货车的驾驶员进行体温检测，按照规定，要检查后备箱，然而当他示意对方打开时，司机却称后备厢没有人，拒绝打开。在叶拥军坚持下，司机只能妥协，可后备厢打开的一瞬间，所有人都吃了一惊———车内竟藏着一男一女。</p>

				<p class="text">“我做了登记，核实了两人的身份信息，并把情况上报给社区。”叶拥军说，还好最后是虚惊一场，对方并非来自疫区。不过此事过后，叶拥军更谨慎了，“别看测体温是件小事，不能放过一丝一毫的细节，否则有可能会有漏网之鱼”。</p>
				<p class="text text-danger">镜头二</p>
				<p class="text text-danger">“我退休了，派我去吧!”</p>

				<p class="text">19日上午，在厦门高速路口，小黄帽志愿者汪巧云扶了扶口罩。这几天，天气有些寒冷，她穿了5件衣服依然瑟瑟发抖。</p>
				<div class="text-center">
					<img src="img/ui/article09.jpg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">汪巧云在高速公路口执勤。左林 摄</font>
				</div>
				<p class="text">为了支援高速公路口的防疫工作，这周起，20多名“小黄帽党员青年突击队”队员被分配在厦门、同安、翔安、杏林4个高速路口，因为路途遥远，大多数人清晨6点就要出发集合，赶在8点前“上岗”，每天轮班8个小时。</p>
				<p class="text">“我已经退休了，时间比较多，派我去吧!”上周，看到群里征集支援高速公路口的消息后，汪巧云毫不犹豫报名。30多名报名者中，20多名入选，汪巧云就是其中之一，她曾是海沧公交807路公交驾驶员，去年8月正式退休。虽然离开了岗位，她依然对公交行业恋恋不舍，身为小黄帽的一员，时常一起参与志愿。</p>
				<p class="text">到达现场后，高速公路的防疫任务比汪巧云想象中更重。在各个高速路口，志愿者和执法单位各有分工，有人负责拦车，有人负责引导车流，有人负责测体温，还有人负责指导在i厦门上登记信息。随着复工潮到来，车流量明显增多，工作量也与日俱增。</p>
				<p class="text">为了让车辆尽快通关，除去吃饭、喝水、上厕所的时间，志愿者们几乎一步也走不开。</p>
				<p class="text">“讲实话，真的累，但是我们的到来，减轻了交通执法人员的工作压力。”做志愿忙碌，汪巧云却感觉到踏实和快乐。每次执勤完后，大家坐在返程的车内，往往禁不住困意，摇头晃脑沉沉睡去。</p>
				<p class="text">得知她在高速公路口执勤，家人虽然有些担心，但依然支持她的决定，时不时提醒她注意交通安全和自我防护。</p>
				<p class="text text-danger">镜头三</p>
				<p class="text text-danger">任务一发布收到6则“请战书”</p>
				<div class="text-center">
					<img src="img/ui/article10.jpg" style="width: 50%;height: 50%;" class="img-responsive center-block" />
					<br />
					<font class="text-primary" face="楷体,楷体_GB2312" style="line-height: 2em;font-size: 16px;">黄云长在做运输保障任务。</font>
				</div>
				<p class="text">“队长，我报名参加!”2月初，集美公交驾驶员、小黄帽志愿者黄云长的一则“请战书”，令队长兰金辉感动不已。几分钟前，他才把湖北籍旅客应急输运任务发到群里，不到1分钟，已经有五六名驾驶员报名了。</p>
				<p class="text">经过挑选，包括黄云长在内的8名驾驶员、3台公交车承担厦门北站的运输任务，并成立了以党员和小黄帽为骨干力量的疫情防控应急保障突击队。</p>
				<p class="text">随着一些人员陆续返厦，只要发现湖北籍乘客、发热乘客及密切接触者等人员出站，现场疫情防控工作人员就会引导到公交车上，由他们送至指定隔离酒店，交由专业人员进一步处置。</p>
				<p class="text">黄云长所要做的，就是和同事们一起驻守在厦门北站，直到最后一班列车结束，护送最后一名旅客离开。有时，任务何时结束也不太确定，大伙需要24小时待命，有任务就出发。</p>
				<p class="text">为了方便人员及时到位，在分配任务时，黄云长将家远的、没有私家车的驾驶员安排在白天，把自己和其他家住得较近的驾驶员安排在夜间。</p>
				<p class="text">“疫情发生以来，看着医务人员往一线冲，我们也帮不上什么忙，所以看到这个任务，就接下来了。”黄云长说，虽然可能承担更多风险，但他并不害怕。</p>
				<p class="text">“为了保障我们安全，单位已经做了很多准备。”记者了解到，厦门公交集团将公交车进行专业的隔离改造，把车厢分为前后两部分，并用透明隔膜隔开，引导乘客只从后门上车。</p>
				<p class="text">每一名驾驶员也“全副武装”，除了戴手套、护目镜、口罩外，还穿了一次性雨衣作为“防护服”。自2月3日开始至2月20日，疫情防控转运专线应急保障突击队已运行215个班次，输运868名湖北籍、发热乘客及密切接触者等人员。(记者 雷妤)</p>

				<hr />

				<blockquote class="blockquote-reverse">

					<small>责任编辑：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong title="Source Title">海西晨报</strong></small>
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