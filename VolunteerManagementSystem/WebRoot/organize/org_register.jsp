<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%String ctx=request.getContextPath();
pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta charset="UTF-8">
		<title></title>
	<!-- 	<link rel="stylesheet" type="text/css" href="../css/ui/footer.css" /> -->
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_register.css"/>
	</head>
	<style type="text/css">
		
	</style>

	<body>
		<!--头部-->
		<header></header>
		<!--中部-->
		<article>
			<!--头部提示注册页面-->
			<div class="user_register_top">
				<h1>组织注册</h1>
			</div>
			
			<!--中部from表单提交注册-->
			<form id="org_regist_form" action="${ctx}/RegistServlet?action=orgRegist" method="post">
				<div class="user_register_body">
					
					<div class="user_register_username">
						<span></span>
						<input type="text" name="OPerson" id="org_person" value="" placeholder="法人" />
					<label  id="hint_org_person"></label>
					</div>
					<div class="user_register_orgname">
						<span></span>
						<input type="text" name="OName" id="org_name" value="" placeholder="组织名称" />
					<label id="hint_org_name"></label>
					</div>
					<div class="user_register_password">
						<span></span>
						<input type="password" name="OPassword" id="org_password" value="" placeholder="密码" />
					<label id="hint_org_password"></label>
					</div>
						<div class="user_register_password">
						<span></span>
						<input type="password"  id="org_repassword" value="" placeholder="再次输入密码" />
					<label id="hint_org_repassword"></label>
					</div>
					
					<div class="user_register_idcard">
						<span></span>
						<input type="text" name="OIdCard" id="org_idCard" value="" placeholder="法人身份证号" />
						<label id="hint_org_idCard"></label>
					</div>
					
					<div class="user_register_email">
						<span></span>
						<input type="text" id="org_email" name="OEmail" value="" placeholder="邮箱" />
						<input type="button" class="" id="btn_resend_email" onclick="checkemail();" value="发送验证码" />
					</div>
					<div class="user_register_code">
						<span></span>
						<input type="text" name="org_regist_code" id="org_regist_code" value="" placeholder="验证码" />
						<label id="hint_org_regist_code"></label>
					</div>
					<div class="user_register_address">
						<label>组织地址：</label>
						<select id="city" name="OCity" >
							<option value="">选择市</option>
						</select>
						<select id="county" name="OCounty">
							<option value="">选择区</option>
						</select>
				
					</div>
					
					</span>
					<div class="user_register_btn">
						<input type="button" id="org_regist_sumbit" value="注册" />
					</div>


			</form>
			
			<!--尾部 跳转注册 登录 页面-->
					<div class="login_bottom">
						<div class="a_jump">
							<a href="${ctx }/user/user_org_login.jsp">登录页面</a><span>|</span>
							<a href="${ctx }/user/user_register.jsp">志愿者注册</a>
						</div>
					</div>
				</div>
		</article>
		
		<!--尾部-->
		<%@include file="../user/footer.jsp" %>
	</body>
	<script type="text/javascript" src="${ctx }/js/jquery.min.js"></script>
	<!-- <script src="../js/ui/footer.js" type="text/javascript" charset="utf-8"></script> -->
	<script src="${ctx }/js/ui/org_register.js" type="text/javascript" charset="utf-8"></script>
</html>