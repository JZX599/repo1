<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
		
<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_manage.css"/>
	</head>


	<body>
	<c:if test="${empty organize }">
	 <c:redirect url="/user/user_org_login.jsp"></c:redirect> 
	</c:if>
		<header>
			<div class="header_left">
				<h1>组织中心</h1>
			</div>
			<div class="header_right">
				<div class="user_span_left">
					<span id="user_span"></span>&nbsp;<span id="user_name_span">${organize.OName }</span>
				</div>
				<div class="user_span_right">
					<a id="user_name_a" href="${ctx }/IndexServlet?action=getAllActList"><span id="return_span"></span>&nbsp;返回网站首页</a>
				</div>
			</div>
		</header>
		<!--中部-->
		<article id="article">
			<!--用户管理 主体div-->
			<div class="user_manage_article">
				<!--ul列表div-->
				<div class="user_manage_list">

					<div class="list_content">
						<ul>
							<li>
								<a   href="${ctx }/ActivityServlet?action=getPageActList&state=showAll&page=1" target="content"><span class="span1"></span>活动管理</a>
							</li>
							
							<li>
								<a href="${ctx }/ActivityServlet?action=getPageActBaomList&state=showAll&page=1" target="content"><span class="span2"></span>报名管理</a>
							</li>

							<li>
								<a href="${ctx }/organize/org_info_upd.jsp" target="content"><span class="span3"></span>组织信息</a>
							</li>
							<li>
								<a href="${ctx }/OrganizeServlet?action=getOrgMsg" target="content"><span class="span4"></span>账号安全</a>
							</li>
							<li>
								<a href="${ctx}/OrganizeServlet?action=Logout"  onclick="return confirm('您确认要退出吗？');"><span class="span5"></span>退出</a>
							</li>

						</ul>
					</div>
				</div>
				<!--iframe视图显示div-->
				<div class="user_manage_view" >
					<iframe id="" name="content" src="${ctx }/ActivityServlet?action=getPageActList&state=showAll&page=1" frameborder="0" height="580px" width="100%" scrolling="no" > </iframe>
				</div>
			</div>

		</article>

		<!--尾部-->
		<footer id="footer">
			<span>Copyright © 2019 版权所有 志愿者网站！ 闽ICP备190606号-1 本站总浏览量:</span><span id="local_num" class="fanke_span"></span><span>次</span>
		</footer>
	</body>
<script src="${ctx }/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctx }/js/ui/footer.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	$("ul li").click( 
    function() {
        $(this).css("background","#3E9EA5").siblings().css("background","#ffffff");
       $(this).children("a").css("color","#ffffff");
       $(this).siblings().children("a").css("color","#6C6C6C");
     
    });
</script>
</html>