<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%String ctx=request.getContextPath();
pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_regist_success.css" />
	</head>
	<body>
		<!--头部-->
		<header></header>
		<!--中部-->
		<article>
			<!--头部提示注册页面-->
			<div class="user_register_top">
				<h1>信息提示</h1>
			</div>
			
			<!--中部from表单提交注册-->
	
				<div class="user_register_body">
								
					
					<h3>${RegistMsg}</h3>
					<br />
					<h2>${RegistID}</h2>
					<br />
					<h4>请牢记编号，使用编号进行登录！</h4>
					<h5><span style="color: red;font-size: 15px;">注意：</span>组织注册请等待管理员审核通过后即可登录</h5>
				</div>
			
			<!--尾部 跳转注册 登录 页面-->
					<div class="login_bottom">
						
						<div class="a_jump">
							<a href="${ctx }/user/user_org_login.jsp">返回登录页面</a><span>|</span>
							<a href="${ctx }/index.jsp">返回首页</a>
						</div>
					</div>
				</div>
		</article>
		
		<%@include file="footer.jsp" %>

		
	</body>
	

	
</html>