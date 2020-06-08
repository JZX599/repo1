	
	$(document).ready(function() {
		/////////////////////////////////////志愿者信息修改/////////////////////////////////////////////////////////////////
				$('#user_info_from').bootstrapValidator({
					message: '此值无效',
					excluded: ':disabled',
					feedbackIcons: {
						valid: 'glyphicon glyphicon-ok',
						invalid: 'glyphicon glyphicon-remove',
						validating: 'glyphicon glyphicon-refresh'
					},
					fields: {

						UName: {
							
							validators: {
								notEmpty: {
									message: '姓名不能为空'
								},

								regexp: {
									regexp: /^[\u4e00-\u9fa5]{2,4}$/,
									/*匹配2-4个中文*/
									message: '姓名只能由2-4个中文组成'
								}
							}
						},
						UIdCard: {
							validators: {
								notEmpty: {
									message: '身份证不能为空'
								},
								regexp: {
									regexp: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
									/*匹配2-4个中文*/
									message: '身份证格式有误'
								}
							}
						},
						UPhone: {
							validators: {
								notEmpty: {
									message: '手机号不能为空'
								},
								regexp: {
									regexp: /^1[34578]\d{9}$/,
									/*匹配2-4个中文*/
									message: '手机号格式有误'
								}
							}
						},
						UAddress: {
							validators: {
								notEmpty: {
									message: '地址不能为空'
								}
							}
						}
					}
				});


/////////////////////////////////////组织信息修改/////////////////////////////////////////////////////////////////

				$('#org_info_from').bootstrapValidator({
					message: '此值无效',
					excluded: ':disabled',
					feedbackIcons: {
						valid: 'glyphicon glyphicon-ok',
						invalid: 'glyphicon glyphicon-remove',
						validating: 'glyphicon glyphicon-refresh'
					},
					fields: {

						OName: {
							message: 'The username is not valid',
							validators: {
								notEmpty: {
									message: '组织名称不能为空'
								}
							}
						},
						OIdCard: {
							validators: {
								notEmpty: {
									message: '法人身份证不能为空'
								},
								regexp: {
									regexp: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
									
									message: '身份证格式有误'
								}
							}
						},
						OPerson: {
							validators: {
								notEmpty: {
									message: '法人姓名不能为空'
								},regexp: {
									regexp: /^[\u4e00-\u9fa5]{2,4}$/,
									/*匹配2-4个中文*/
									message: '法人姓名只能由2-4个中文组成'
								
								}
							}
						},
						OAddress: {
							validators: {
								notEmpty: {
									message: '组织地址不能为空'
								}
							}
						}
					}
				});
					
				
				
				
				
			});