package Servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.CommonUtils;
import util.Constant;
import util.MD5Utils;

/**
 * 志愿者和组织注册的servlet
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";

	public void orgRegist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("组织注册的servlet访问成功");
		String OEmail = request.getParameter("OEmail");// 6.组织邮箱
		String OIdCard = request.getParameter("OIdCard");// 6.组织身份证
		String org_regist_code = request.getParameter("org_regist_code");// 邮箱验证码
		String OrgRegEmail = (String) request.getSession().getAttribute("OrgRegEmail");
		String OrgRegistCode = (String) request.getSession().getAttribute("OrgRegistCode");
		System.out.println("OrgRegEmail：" + OrgRegEmail + "页面获取的邮想地址：" + OEmail);
		System.out.println("OrgRegistCode：" + OrgRegistCode + "前端页面获取的验证码：" + org_regist_code);
		if (request.getSession().getAttribute("OrgRegEmail").equals(OEmail)) {
			System.out.println("系统判断邮箱成功可以进行下一步的验证码验证");
			// 不区分大小写比较
			if (OrgRegistCode.equalsIgnoreCase(org_regist_code)) {
				System.out.println("系统判断邮箱验证码成功可以进行注册用户");
				// 1.邮箱唯一验证 通过查询邮箱是否唯一
				try {
					// 通过邮箱查找组织信息 空就是邮箱未被使用 可以执行注册操作
					if (FactoryDao.getIOrganizeDaoInstance().byEmailgetOrg(OEmail) == null) {
						if (FactoryDao.getIOrganizeDaoInstance().byIdCardgetOrg(OIdCard) == null) {
							Map<String, String[]> Orgmap = request.getParameterMap();
							String OCity = request.getParameter("OCity");
							String OCounty = request.getParameter("OCounty");
							String OAddress = OCity + OCounty;// 5.组织地址
							Organize org = new Organize();
							BeanUtils.populate(org, Orgmap);
							org.setOEmail(OEmail);
							org.setODate(CommonUtils.getNewDate());
							org.setOAddress(OAddress);
							// 密码加密
							org.setOPassword(MD5Utils.getMD5Code(org.getOPassword()));
							if (FactoryDao.getIOrganizeDaoInstance().addOrg(org) == 1) {
								// 通过邮箱查找组织信息，获取组织id
								Organize org1 = FactoryDao.getIOrganizeDaoInstance().byEmailgetOrg(OEmail);
								if (org1 != null) {
									request.getSession().setAttribute("RegistMsg", "恭喜您注册成功，您的组织编号是：");
									request.getSession().setAttribute("RegistID", org1.getOId());
									System.out.println("恭喜您注册成功" + org1.getOId());
									/*
									 * request.getRequestDispatcher(
									 * "/user/user_org_regist_success.jsp").
									 * forward(request, response);
									 */
									response.setHeader("refresh",
											"0.5;url=" + contextPath + "/user/user_org_regist_success.jsp");
								} else {
									System.out.println("执行通过邮箱检测组织id失败");
								}
							} else {
								response.getWriter().write("<script>alert('注册失败,内部错误');</script>");
								response.setHeader("refresh", "1;url=" + contextPath + "/organize/org_register.jsp");

							}
						} else {
							// 检验到身份证不为空 不可以执行注册
							response.getWriter().write("<script>alert('该身份证已经注册过,正在跳转回注册页面,若忘记密码请通过邮件找回');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/organize/org_register.jsp");
							System.out.println("系统判断身份证已经注册过");
						}
					} else {
						// 检验到邮箱不为空 不可以执行注册
						response.getWriter().write("<script>alert('该邮箱已经注册过,正在跳转回注册页面,若忘记密码请通过邮件找回');</script>");
						response.setHeader("refresh", "1;url=" + contextPath + "/organize/org_register.jsp");
						System.out.println("系统判断邮箱已经注册过");

					}
				} catch (Exception e) {

					e.printStackTrace();
				}

				// 是注册成功 否注册失败 2.注册时组织编号 由

			} else {
				response.getWriter().write("<script>alert('邮箱验证码输入错误或者验证码已经过时,正在跳转回注册页面');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/organize/org_register.jsp");
				System.out.println("系统判断邮箱验证码失败提交信息有误或者session邮箱验证码保存失败,过时验证码");
			}
		} else {
			response.getWriter().write("<script>alert('邮箱前后输入错误或者会话已经过时,正在跳转回注册页面');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/organize/org_register.jsp");
			System.out.println("系统判断邮箱错误，邮箱提交信息有误或者session邮箱保存失败，过时验证码邮箱也过时");
		}

	}

	public void userRegist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者注册的servlet访问成功");
		String UIdCard = request.getParameter("UIdCard");
		String UEmail = request.getParameter("UEmail");
		String user_regist_code = request.getParameter("user_regist_code");
		String UserRegEmail = (String) request.getSession().getAttribute("UserRegEmail");// session
		String UserRegistCode = (String) request.getSession().getAttribute("UserRegistCode");// session

		// 判断session邮箱与页面邮箱是否一致
		if (UserRegEmail.equals(UEmail)) {
			System.out.println("系统判断邮箱成功可以进行下一步的验证码验证");
			// 邮箱一致
			// 判断session验证码与页面验证码是否一致 不区分大小写比较
			if (UserRegistCode.equalsIgnoreCase(user_regist_code)) {
				// 验证码一致
				System.out.println("系统判断邮箱验证码成功可以进行下一步的验证码验证");
				try {
					// 通过邮箱查询用户信息 空可以注册 邮箱未使用
					if (FactoryDao.getUserDaoInstance().byEmailgetUser(UEmail) == null) {
						if (FactoryDao.getUserDaoInstance().byIdCardgetUser(UIdCard) == null) {
							// 数据获取并封装
							System.out.println("user准备执行数据封装");
							Map<String, String[]> Usermap = request.getParameterMap();
							User user = new User();
							BeanUtils.populate(user, Usermap);
							// MD5加密
							user.setUPassword(MD5Utils.getMD5Code(user.getUPassword()));
							user.setUDate(CommonUtils.getNewDate());
							// 判断是否注册成功
							if (FactoryDao.getUserDaoInstance().addUser(user) == 1) {
								// 注册成功
								// 执行通过邮箱
								User u = FactoryDao.getUserDaoInstance().byEmailgetUser(UEmail);
								if (u != null) {
									request.getSession().setAttribute("RegistMsg", "恭喜您注册成功，您的志愿者编号是：");
									request.getSession().setAttribute("RegistID", u.getUId());
									System.out.println("恭喜您注册成功" + u.getUId());

									response.setHeader("refresh",
											"0.5;url=" + contextPath + "/user/user_org_regist_success.jsp");

								} else {

									System.out.println("执行通过邮箱检测组织id失败");
								}
							} else {
								response.getWriter().write("<script>alert('注册失败,内部错误');</script>");
								response.setHeader("refresh", "1;url=" + contextPath + "/user/user_register.jsp");

							}
						} else {
							// 身份证已被使用
							response.getWriter().write("<script>alert('该身份证已经注册过,正在跳转回注册页面,若忘记密码请通过邮件找回');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/user/user_register.jsp");
							System.out.println("系统判断身份证已经注册过");
						}
					} else {
						// 邮箱已被使用
						response.getWriter().write("<script>alert('该邮箱已经注册过,正在跳转回注册页面,若忘记密码请通过邮件找回');</script>");
						response.setHeader("refresh", "1;url=" + contextPath + "/user/user_register.jsp");
						System.out.println("系统判断邮箱已经注册过");
					}
				} catch (Exception e) {

					e.printStackTrace();
				}

			} else {
				response.getWriter().write("<script>alert('邮箱验证码输入错误或者验证码已经过时,正在跳转回注册页面');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_register.jsp");
				System.out.println("系统判断邮箱验证码失败提交信息有误或者session邮箱验证码保存失败,过时验证码");
			}
		} else {
			// 邮箱不一致
			response.getWriter().write("<script>alert('邮箱前后输入错误或者会话已经过时,正在跳转回注册页面');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_register.jsp");
			System.out.println("系统判断邮箱错误，邮箱提交信息有误或者session邮箱保存失败，过时验证码邮箱也过时");

		}

	}
}
