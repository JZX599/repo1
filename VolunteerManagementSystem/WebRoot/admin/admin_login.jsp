<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%String ctx=request.getContextPath();
pageContext.setAttribute("ctx", ctx);
%>
<html dir="ltr" lang="en-US">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<title>志愿者后台管理系统</title>
		
	<link rel="stylesheet" href="${ctx}/css/style.css" type="text/css" />

	</head>

	<body>
		<div id="container">
			<form action="${ctx}/AdminServlet?action=admin_login" method="post">
				<div class="login">志愿者后台管理系统 </div>
				<div class="username-text">账号:</div>
				<div class="password-text">密码:</div>
				<div class="username-field">
					<input type="text" name="AId" value="${cookie.admin_id.value }" />
				</div>
				<div class="password-field">
					<input type="password" name="APwd" />
				</div>
				<input type="checkbox" name="remember-me" id="remember-me" value="yes"/><label for="remember-me">记住用户名</label>
				<div class="forgot-usr-pwd"><a href="${ctx }/IndexServlet?action=getAllActList">返回系统主页</a></div>
				<input type="submit" value="GO" />
			</form>
		</div>
	
	</body>



</html>
