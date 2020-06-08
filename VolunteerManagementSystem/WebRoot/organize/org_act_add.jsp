<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/act_list_add_upd.css" />
		<title></title>
	</head>

	<body>
<c:if test="${empty organize }">
	 <c:redirect url="/user/user_org_login.jsp"></c:redirect> 
	</c:if>
		<div class="son_body">
			<div class="container-fluid">
				<div class="row">
					<h3>活动管理</h3>
					<hr />
				</div>

				<!--选项卡标题-->

				<div class="row">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" >
							<a href="${ctx }/organize/org_act_list.jsp">活动列表</a>
						</li>
						<li role="presentation" class="active">
							<!-- 添加用户弹出模态框按钮 -->
							<a href="${ctx }/organize/org_act_add.jsp">发布活动</a>
						</li>
					</ul>
				</div>

				<!-- 选项卡  页面 -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="home">

						<form action="${ctx }/ActivityServlet?action=addAct" class="form-horizontal" style="padding: 30px;" id="add_act_form" method="post">

							<div class="form-group col-xs-6">
								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动名称</label>
									<div class="col-xs-6 " id="AName_input">
										<input type="text" class="form-control  input-sm" id="AName" name="AName" placeholder="不能为空">
									</div>
									<div class="col-xs-3">

									</div>
								</div>

								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动开始时间</label>
									<div class="col-xs-6" id="AStartDate_input">
										<div class="form-group" style="padding: 0;margin: 0;">
											<div class='input-group date' id='datetimepicker1'>
												<input type='text' class="form-control input-sm" id="AStartDate" name="AStartDate" placeholder="请选择活动开始时间" />
												<span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>
									</div>
									<div class="col-xs-3">

									</div>
								</div>

								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">联系人手机号</label>
									<div class="col-xs-6" id="APhone_input">
										<input type="text" class="form-control  input-sm" id="APhone" name="APhone" placeholder="请输入手机号码">
									</div>
									<div class="col-xs-3">

									</div>
								</div>

								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">预计招募人数</label>
									<div class="col-xs-6" id="ANumber_input">
										<input type="text" class="form-control  input-sm" id="ANumber" name="AEstimate" placeholder="请输入整数，例如50">
									</div>
									<div class="col-xs-3">

									</div>
								</div>

						
								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动类别:</label>
									<div class="col-xs-6">
									<div class="col-xs-12" style="padding: 0;">
											<select name="CId" id="category_sel" class="form-control input-sm">
											<c:forEach items="${allCateList }" var="cate">
											<option value="${cate.CId }">${cate.CName }</option>
											</c:forEach>
												
											</select>
									</div>
									</div>
									<div class="col-xs-3">

									</div>
								</div>



							</div>

							<div class="form-group col-xs-6">
								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动联系人</label>
									<div class="col-xs-6" id="APerson_input">
										<input type="text" class="form-control  input-sm" id="APerson" name="APerson" placeholder="请输入2-4位中文">
									</div>
									<div class="col-xs-3">

									</div>
								</div>
								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动结束时间</label>
									<div class="col-xs-6" id="AEndDate_input">
										<div class="form-group" style="padding: 0;margin: 0;">
											<div class='input-group date' id='datetimepicker2'>
												<input type='text' class="form-control input-sm" id="AEndDate" name="AEndDate" placeholder="请选择活动结束时间" />
												<span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
												</span>
											</div>
										</div>

									</div>
									<div class="col-xs-3">

									</div>
								</div>
							<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动地点</label>
									<div class="col-xs-6 " id="AAddress_input">
										<input type="text" class="form-control  input-sm" id="AAddress" name="AAddress" placeholder="请填写活动地址">
									</div>
									<div class="col-xs-3">

									</div>
								</div>

								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动积分</label>
									<div class="col-xs-6" id="AIntegral_input">
										<input type="text" class="form-control  input-sm" id="AIntegral" name="AIntegral" placeholder="请输入整数，例如50">
									</div>
									<div class="col-xs-3">

									</div>
								</div>

								<div class="row" style="padding: 10px;">
									<label class="col-xs-3 control-label ">活动简介:</label>
									<div class="col-xs-6">
										<textarea class="form-control input-sm" id="ASynopsis" name="ASynopsis"></textarea>
									</div>
									<div class="col-xs-3">

									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-4">

								</div>
								<div class="col-xs-3">

									<input type="reset" name="" id="btn_res" value="重置" class="btn btn-warning btn-sm" />
									<input type="button" name="" id="add_act_sub" value="发布" class="btn btn-success btn-sm" />
								</div>
								<div class="col-xs-5">

								</div>
							</div>
						</form>

					</div>

				</div>

			</div>
		</div>

	</body>
	<script src="${ctx }/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/moment-with-locales.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/bootstrap-datetimepicker.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/ui/act_add_upd.js" type="text/javascript" charset="utf-8"></script>

</html>