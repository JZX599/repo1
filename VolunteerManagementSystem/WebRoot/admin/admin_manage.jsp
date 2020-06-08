<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>

		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_manage.css" />
	</head>

	<body>
		<c:if test="${empty admin }">
	 <c:redirect url="/admin/admin_login.jsp"></c:redirect> 
	</c:if>
		<header>
			<div class="header_left">
				<h1 style="font-size: 26px;">管理员中心</h1>
			</div>
			<div class="header_right">
				<div class="user_span_left">
					<span id="user_span"></span>&nbsp;<span id="user_name_span">${admin.AName }</span>
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
								<a href="${ctx }/AdminServlet?action=getAllOrgList&type=showAll" target="content"><span class="span6"></span>组织管理</a>
							</li>

							<li>
								<a href="${ctx }/AdminServlet?action=getAllUserList&type=showAll" target="content"><span class="span8"></span>志愿者管理</a>
							</li>
							<li>
								<a href="${ctx }/AdminServlet?action=getAllCateList" target="content"><span class="span9"></span>分类管理</a>
							</li>
							<li>
								<a href="${ctx }/AdminServlet?action=getAllAdminList&type=showAll" target="content"><span class="span7"></span>系统管理</a>
							</li>
							
							<li>
								<a href="${ctx }/AdminServlet?action=adminQuit" onclick="return confirm('您确认要退出吗？');"><span class="span5"></span>退出</a>
							</li>

						</ul>
					</div>
				</div>
				<!--iframe视图显示div-->
				<div class="user_manage_view">
					<iframe id="" name="content" src="${ctx }/AdminServlet?action=getAllOrgList&type=showAll" frameborder="0" height="580px" width="100%" scrolling="no"> </iframe>
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