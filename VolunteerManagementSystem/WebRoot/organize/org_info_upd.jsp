<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/ui/act_list_add_upd.css" />
		<link rel="stylesheet" type="text/css" href="../css/bootstrapValidator.css"/>
		<title></title>
		<style type="text/css">
			* {
				box-sizing: border-box;
				padding: 0px;
				margin: 0px;
				list-style: none;
				text-decoration: none;
			}
			
			.info_a {
				font-size: 14px;
				font-weight: bold;
			}
			
			th {
				background-color: #F0F0F0;
				/*text-align: center;*/
			}
			.form-group{
				padding-top: 5px;
			}
		</style>
	</head>

	<body>

		<div class="son_body" style="margin-top: -20px">
			<div class="container-fluid">
				<div class="row">
					<h3>组织信息</h3>
					<hr />
				</div>

				<div class="container">
					<div class="row">
						<div class="col-lg-10 col-lg-offset-1">

							<form id="org_info_from" method="post" class="form-horizontal" action="${ctx }/OrganizeServlet?action=orgupdinfo">
								<div class="panel-group" id="steps">
									<!-- 查看信息 -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title"><a class="info_a" data-toggle="collapse" data-parent="#steps" href="#stepOne">基本信息</a></h4>
										</div>
										<div id="stepOne" class="panel-collapse collapse in">
											<div class="panel-body">
															<table class="table table-bordered" border="" cellspacing="" cellpadding="">
													<tr>
														<th>组织编号</th>
														<td>${organize.OId }</td>
														<th>组织名称</th>
														<td>${organize.OName }</td>
													</tr>
													<tr>
														<th>法人代表</th>
														<td>${organize.OPerson }</td>
														<th>法人身份证</th>
														<td>${organize.OIdCard }</td>
													</tr>
													
													
													<tr>
														<th>组织邮箱</th>
														<td>${organize.OEmail }</td>
														<th>注册时间</th>
														<td>${organize.ODate }</td>
														
													</tr>
													<tr>
														<th>组织地址</th>
														<td>${organize.OAddress }</td>
														<th>组织状态</th>
														<td>
														<c:if test="${organize.OState ==0 }">待审核</c:if>
														<c:if test="${organize.OState ==1 }">正常</c:if>
														<c:if test="${organize.OState ==2 }">冻结</c:if>
														</td>
													</tr>
													
													
													
												</table>
											</div>
										</div>
									</div>

									<!-- 修改信息 -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title"><a class="info_a" data-toggle="collapse" data-parent="#steps" href="#stepTwo">修改信息</a></h4>
										</div>
										<div id="stepTwo" class="panel-collapse collapse ">
											<div class="panel-body">
												<div class="form-group">
													<label class="col-xs-3 control-label">组织名称</label>
													<div class="col-xs-5">
														<input type="text" class="form-control" name="OName" value="${organize.OName }" />
													</div>
												</div>

												<div class="form-group">
													<label class="col-xs-3 control-label">法人代表</label>
													<div class="col-xs-5">
														<input type="text" class="form-control" name="OPerson" value="${organize.OPerson }"/>
													</div>
												</div>

											<div class="form-group" >
													<label class="col-xs-3 control-label">法人身份证</label>
													<div class="col-xs-5">
														<input type="text" class="form-control input-sm" name="OIdCard" value="${organize.OIdCard }"/>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-xs-3 control-label">组织地址</label>
													<div class="col-xs-5">
														<input type="text" class="form-control" name="OAddress" value="${organize.OAddress }"/>
													</div>
												</div>
												
											<div class="form-group">
													<label class="col-xs-3 control-label">组织简介</label>
													<div class="col-xs-5">
														<textarea class="form-control input-sm"  name="OSynopsis">${organize.OSynopsis }</textarea>
													</div>
												</div>
												
												

												<div class="form-group">

													<div class="col-xs-9 col-xs-offset-4">
														<button type="reset" class="btn btn-primary">重置</button>
														<button type="submit" class="btn btn-primary " >修改</button>
													</div>
												</div>

											</div>
										</div>
									</div>

								
								</div>
							</form>
						</div>
					</div>

				</div>

			</div>
		</div>
		
		
	</body>
	<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/ui/user_org_infoupd.js" type="text/javascript" charset="utf-8"></script>

</html>