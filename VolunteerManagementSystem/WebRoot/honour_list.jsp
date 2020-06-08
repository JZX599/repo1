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
	/*---------------------以下是光荣榜的css-----------------------------------------*/
		
		thead {
			background-color: #E5E5E5;
		}
		
		th {
			text-align: center;
			font-size: 18px;
		}
		td {
			text-align: center;
			font-size: 16px;
		}
		
		a {
			color: black;
			text-decoration: none;
		}
		/*a标签按下胶囊按钮样式*/
		
		.nav-pills>li.active>a,
		.nav-pills>li.active>a:focus,
		.nav-pills>li.active>a:hover {
			color: #fff;
			background-color: #71D0E0;
		}
		/*a标签鼠标悬浮文字颜色*/
		
		a:hover {
			color: white;
			text-decoration: underline;
		}
		/*a标签悬浮胶囊按钮背景*/
		
		.nav>li>a:focus,
		.nav>li>a:hover {
			text-decoration: none;
			background-color: #D4D4D4;
		}
		/*---------------------以上是光荣榜的css-----------------------------------------*/
</style>

<body style="margin-top: -20px">
<c:if test="${empty userListbyUHours||empty userListbyUIntegral}">
	<c:redirect url="UserServlet?action=getUserHonList"></c:redirect>
</c:if>


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
					<li class="active"><a href="${ctx }/UserServlet?action=getUserHonList">光荣榜</a></li>

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
  
  <div class="my-carousel" style="background-color: rgba(234, 248, 255, 1)!important;padding-bottom: 10px;">
			<div class="container">
				<div class="row" style="margin: 0;margin-left: -15px;margin-right: -15px;">
					<ol class="breadcrumb" style=" background-color: #D5AED8; margin: 0;padding: 0;margin-top: 5px; line-height: 35px;border-bottom-left-radius: 0px;border-bottom-right-radius: 0px; ">
						<li>&nbsp;<i class="glyphicon glyphicon-home" style="color:white"></i>
							<a href="${ctx }/IndexServlet?action=getAllActList" style="color:white;"> 首页</a>
						</li>

						<li class="active">光荣榜</li>
					</ol>
				</div>
			</div>

			<div class="container" style="border: 1px solid #D4D4D4; background-color: white;">

				<div class="row" style=" padding-top: 5px;">
					<div class="col-md-2 hidden-sm hidden-xs">

					</div>
					<div class="col-md-8 col-sm-12 col-xs-12" style=" background:url(img/24.png) no-repeat center;background-size:cover;min-height: 200px;max-height: 250px; padding-top: 5px;border: 1px solid #ECECEC;border-bottom: none;">

					</div>
					<div class="col-md-2 hidden-sm hidden-xs">

					</div>
				</div>

				<div class="row" style="margin-top: 5px; margin-top: 0;">
					<div class="col-md-2  hidden-sm hidden-xs">

					</div>
					<div class="col-md-8 col-sm-12 col-xs-12" style=" padding: 1px;border: 1px solid #ECECEC;border-top: none;border-bottom: none;">

						<!-- 标签页导航 -->
						<ul class="nav nav-pills col-xs-offset-5 " role="tablist">
							<li role="presentation" class="active">
								<a href="#user" aria-controls="home" role="tab" data-toggle="tab">时长榜</a>
							</li>
							<li role="presentation">
								<a href="#org" aria-controls="profile" role="tab" data-toggle="tab">积分榜</a>
							</li>

						</ul>

					</div>
					<div class="col-md-2  hidden-sm hidden-xs">

					</div>
				</div>
				<div class="row" style="margin-top: 0px;">
					<div class="col-md-2">

					</div>
					<div class="col-md-8" style="padding: 0;">
						<!-- 标签页内容 -->
						<div class="tab-content">
							<!--时长排行榜-->
							<div role="tabpanel" class="tab-pane active" id="user">
								<div class="row" style="margin: 0;padding: 0;border: 1px solid #ECECEC;border-top: none;margin-bottom: 10px;">
									<div style="padding: 5px;min-height: 500px;">
										<table class="table  table-bordered table-hover table-condensed">
											<thead>
												<tr>
													<th>排名</th>
													<th>姓名</th>
													<th>志愿者编号</th>
													<th>服务时长(h)</th>
													<th>信誉值</th>
													<th>所属区域</th>
												</tr>
											</thead>
											<tbody>
										
<c:if test="${fn:length(userListbyUHours)>0 }">
						<c:forEach items="${userListbyUHours }" begin="0" end="20" var="u" varStatus="om">
											
												<tr>
													<td >
												<c:if test="${om.index+1==1 }">
													<img src="img/one.png" style="width: 16px;height:20px;"/>
													</c:if>
													<c:if test="${om.index+1==2 }">
													<img src="img/two.png" style="width: 16px;height:20px;"/>
													</c:if>
													<c:if test="${om.index+1==3 }">
													<img src="img/three.png" style="width: 16px;height:20px;"/>
													</c:if>
													<c:if test="${om.index+1!=3&&om.index+1!=2&&om.index+1!=1 }">
													${om.index+1 }
													</c:if>
													</td>
													<td>${u.UName }</td>
													<td>${u.UId }</td>
													<td>${u.UHours }</td>
													
													<td>
														<c:if test="${u.UCredit<=0 }">
						<c:forEach begin="0" end="5">
							<i class="fa fa-star-o" style="color: #F0E50F;font-size: 14px" aria-hidden="true"></i>
						</c:forEach>
					</c:if>
								
					<c:if test="${u.UCredit>0&&u.UCredit<6 }">
						<c:forEach begin="0" end="${u.UCredit-1 }">
								<i class="fa fa-star" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
						</c:forEach> 
						<c:forEach begin="0" end="${6-u.UCredit-1}">
								<i class="fa fa-star-o" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
						</c:forEach>
					</c:if>
					<c:if test="${u.UCredit>=6 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
								</c:forEach>
					</c:if>
													
													
													
													</td>
													<td>${u.UAddress }</td>
												</tr>
											
					</c:forEach>

</c:if>

<c:if test="${fn:length(userListbyUHours)==0 }">
									<tr>
								<td colspan="10" style="font-weight: 600;">暂无排行榜信息</td>
							</tr>
</c:if>
											</tbody>
										</table>
									</div>

								</div>

							</div>

							<!--积分排行榜-->
							<div role="tabpanel" class="tab-pane" id="org">

								<div class="row" style="margin: 0;padding: 0;border: 1px solid #ECECEC;border-top: none;margin-bottom: 10px;">
									<div style="padding: 5px;min-height: 500px;">
										<table class="table  table-bordered table-hover table-condensed">
											<thead>
												<tr>
													<th>排名</th>
													<th>姓名</th>
													<th>志愿者编号</th>
													<th>志愿者积分</th>
													<th>信誉值</th>
													<th>所属区域</th>
												</tr>
											</thead>
											<tbody>

<c:if test="${fn:length(userListbyUIntegral)>0 }">
						<c:forEach items="${userListbyUIntegral }" begin="0" end="20" var="ui" varStatus="om">
											
												<tr>
													<td >
													<c:if test="${om.index+1==1 }">
													<img src="img/one.png" style="width: 16px;height:20px;"/>
													</c:if>
													<c:if test="${om.index+1==2 }">
													<img src="img/two.png" style="width: 16px;height:20px;"/>
													</c:if>
													<c:if test="${om.index+1==3 }">
													<img src="img/three.png" style="width: 16px;height:20px;"/>
													</c:if>
													<c:if test="${om.index+1!=3&&om.index+1!=2&&om.index+1!=1 }">
													${om.index+1 }
													</c:if>
													</td>
													<td>${ui.UName }</td>
													<td>${ui.UId }</td>
													<td>${ui.UIntegral }</td>
													
													
													<td>
													
					<c:if test="${ui.UCredit<=0 }">
						<c:forEach begin="0" end="5">
							<i class="fa fa-star-o" style="color: #F0E50F;font-size: 14px" aria-hidden="true"></i>
						</c:forEach>
					</c:if>
								
					<c:if test="${ui.UCredit>0&&ui.UCredit<6 }">
						<c:forEach begin="0" end="${ui.UCredit-1 }">
								<i class="fa fa-star" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
						</c:forEach> 
						<c:forEach begin="0" end="${6-ui.UCredit-1}">
								<i class="fa fa-star-o" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
						</c:forEach>
					</c:if>
					<c:if test="${ui.UCredit>=6 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
								</c:forEach>
					</c:if>
								
													
													
													
													</td>
													<td>${ui.UAddress }</td>
												</tr>
											
					</c:forEach>

</c:if>

<c:if test="${fn:length(userListbyUIntegral)==0 }">
									<tr>
								<td colspan="10" style="font-weight: 600;">暂无排行榜信息</td>
							</tr>
</c:if>
											</tbody>
										</table>
									</div>
								</div>
							</div>

						</div>

					</div>

					<div class="col-md-2">

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