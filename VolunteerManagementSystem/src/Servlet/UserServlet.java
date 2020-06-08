package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import daomain.Activity;
import daomain.Enlist;
import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.CommonUtils;
import util.Constant;
import util.MD5Utils;
import util.PageUtils;

/**
 * 志愿者UserServlet?action=
 */
@WebServlet("/UserServlet")
public class UserServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";

	// 志愿者退出登录
	public void Logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者的servlet访问成功");
		request.getSession().removeAttribute("user");
		response.getWriter().write("<script>alert('退出登录成功');</script>");
		response.setHeader("refresh", "1;url=" + contextPath + "/index.jsp");
	}

	// 志愿者报名首页最新活动
	public void BaomAct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("志愿者执行报名活动操作");
			String AId = request.getParameter("AId");
			String UId = request.getParameter("UId");
			System.out.println("报名活动id" + AId + "报名志愿者id" + UId);
			if (UId.equals("")) {
				response.getWriter().write("<script>alert('请您先登录！');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else if (AId.equals("")) {
				response.getWriter().write("<script>alert('获取活动信息失败！请重试');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/index.jsp");
			} else {
				// 先判断该用户是否已经当前报名活动
				Enlist enlist = FactoryDao.getIEnlistDaoInstance().isUserBaom(Integer.parseInt(AId),
						Integer.parseInt(UId));

				if (enlist == null) {
					// 添加志愿者报名信息
					int i = FactoryDao.getIEnlistDaoInstance().addBaommsg(Integer.parseInt(AId), Integer.parseInt(UId));
					if (i == 1) {
						// 报名成功
						response.getWriter().write("<script>alert('报名成功！');</script>");
						int indexEBaom = FactoryDao.getIEnlistDaoInstance().getEBaomcountbyAId(Integer.parseInt(AId))
								.intValue();
						int indexETong = FactoryDao.getIEnlistDaoInstance().getETongcountbyAId(Integer.parseInt(AId))
								.intValue();
						request.getSession().setAttribute("indexEBaom", indexEBaom);
						request.getSession().setAttribute("indexETong", indexETong);
						response.setHeader("refresh", "1;url=" + contextPath + "/act_info.jsp");

					} else {
						// SQL执行失败
						System.out.println("sql内部错误，添加报名信息失败");
						response.getWriter().write("<script>alert('sql内部错误，添加报名信息失败');</script>");
						response.setHeader("refresh", "1;url=" + contextPath + "/index.jsp");
					}
				} else {
					response.getWriter().write("<script>alert('您已过报名该活动！无法再次报名');</script>");
					response.setHeader("refresh", "1;url=" + contextPath + "/act_info.jsp");
				}

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	/////////////// 志愿者个人中心的活动管理///////////////////////
	public void getUPageBamList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者执行报名活动操作");

		User user = (User) request.getSession().getAttribute("user");

		if (user != null) {
			// 判断用户不为空时执行以下操作
			try {
				String page = request.getParameter("page");

				String usState = request.getParameter("usState");

				// 如果状态值为空就去session找
				if (usState == null) {
					usState = (String) request.getSession().getAttribute("usState");
					if (usState == null) {
						usState = "showAll";
					}
				}
				String newtime = CommonUtils.getDatetime();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				List<Enlist> userEnlist = null;
				if (usState.equals("showAll")) {
					userEnlist = FactoryDao.getIEnlistDaoInstance().getBaomListbyUId(user.getUId());
				} else if (usState.equals("actname")) {
					String AName = request.getParameter("AName");
					userEnlist = FactoryDao.getIEnlistDaoInstance().getEnmsgbyUIdAName(user.getUId(), AName);
					request.getSession().setAttribute("AName", AName);
					System.out.println("---------" + request.getSession().getAttribute("AName"));
				}
				Collections.reverse(userEnlist);// 集合反转
				for (Enlist en : userEnlist) {
					if (dateFormat.parse(newtime).before(dateFormat.parse(en.getAStartDate()))) {
						en.setAState(Constant.Act_State_Pass);
					} else if (dateFormat.parse(newtime).after(dateFormat.parse(en.getAStartDate()))
							&& dateFormat.parse(newtime).before(dateFormat.parse(en.getAEndDate()))) {
						en.setAState(Constant.Act_State_GoDoing);
					} else {
						en.setAState(Constant.Act_State_End);
					}

				}

				PageUtils<Enlist> p = new PageUtils<Enlist>(userEnlist, Integer.parseInt(page), 10); // 分页工具类
				List<Enlist> userPageEnlist = p.getPageList();
				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPages", p.getTotalPage());
				request.getSession().setAttribute("userPageEnlist", userPageEnlist);// 通过分页工具类的角标算法取得分页的活动集合
																					// 存值
				request.getSession().setAttribute("usState", usState);// 状态存值
				response.setHeader("refresh", "0;url=" + contextPath + "/user/user_act_baomActlist.jsp");

			} catch (Exception e) {

				e.printStackTrace();
			}

		} else {
			// 判断用户为空时跳转登录页面
			response.getWriter().write("<script>alert('志愿者未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		}
	}

	// 志愿者取消报名活动
	public void userQXBaom(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("志愿者取消报名活动");
			User user = (User) request.getSession().getAttribute("user");
			if (user == null) {
				// 判断用户为空时跳转登录页面
				response.getWriter().write("<script>alert('志愿者未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else {
				String AId = request.getParameter("AId");
				System.out.println("前端页面获取取消活动id为" + AId);

				int i = FactoryDao.getIEnlistDaoInstance().userQXBaom(user.getUId(), Integer.parseInt(AId));
				if (i == 1) {
					response.getWriter().write("<script>alert('活动取消报名成功！');</script>");
					response.setHeader("refresh",
							"0;url=" + contextPath + "/UserServlet?action=getUPageBamList&usState=showAll&page=1");

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 志愿者得到活动参加列表
	public void getUPageCanList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者参加活动列表");
		User user = (User) request.getSession().getAttribute("user");
		if (user != null) {
			// 判断用户不为空时执行以下操作
			try {
				List<Enlist> en = new ArrayList<Enlist>();
				String currentPage = request.getParameter("page");
				String value = request.getParameter("txtSearch");// 查询的文本内容
				if (currentPage == null) {
					currentPage = "1";
				}
				String type = request.getParameter("type");
				if (type == null) {
					type = (String) request.getSession().getAttribute("type");
					if (type == null) {
						type = "showAll";
					}
				}
				if (value == null) {
					value = (String) request.getSession().getAttribute("value");
				}
				if (type != null && !type.equals("showAll")) {
					en = FactoryDao.getIEnlistDaoInstance().getCanActListbyType(user.getUId(), type, value);
				} else {
					en = FactoryDao.getIEnlistDaoInstance().getCanActList(user.getUId());
				}

				PageUtils<Enlist> p = new PageUtils<Enlist>(en, Integer.parseInt(currentPage), 10);
				List<Enlist> enpageList = p.getPageList();
				request.getSession().setAttribute("type", type);// 选择查询类型
				request.getSession().setAttribute("value", value);// 文本框输入内容
				request.getSession().setAttribute("enpageList", enpageList);
				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPages", p.getTotalPage());
				System.out.println(en.toString() + "5555555555555555555" + enpageList.toString());
				response.setHeader("refresh", "0;url=" + contextPath + "/user/user_act_canActList.jsp");
			} catch (SQLException e) {

				e.printStackTrace();
			}

		} else {
			// 判断用户为空时跳转登录页面
			response.getWriter().write("<script>alert('志愿者未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		}
	}

	// 通过志愿者id获取志愿者信息
	public void getUserMsg(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者的servlet访问成功");
		User user1 = null;
		user1 = (User) request.getSession().getAttribute("user");
		try {
			User user = FactoryDao.getUserDaoInstance().getUserbyUId(user1.getUId());

			request.getSession().setAttribute("user", user);
			response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 志愿者修改信息
	public void userupdinfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			User user;
			int i = 0;
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("志愿者修改信息");
			user = (User) request.getSession().getAttribute("user");
			if (user == null) {
				// 判断用户为空时跳转登录页面
				response.getWriter().write("<script>alert('志愿者未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else {
				Map<String, String[]> map = request.getParameterMap();
				User u = new User();
				BeanUtils.populate(u, map);
				System.out.println("页面取得要更新的值-------" + u.toString());

				if (u.getUIdCard().equals(user.getUIdCard())) {
					i = FactoryDao.getUserDaoInstance().updInfo(user.getUId(), u);
				} else {
					User user2 = FactoryDao.getUserDaoInstance().byIdCardgetUser(u.getUIdCard());
					if (user2 != null) {
						response.getWriter().write("<script>alert('身份证已被其他用户绑定,信息修改失败！');</script>");
						response.setHeader("refresh", "0;url=" + contextPath + "/user/user_info_upd.jsp");
					} else {
						i = FactoryDao.getUserDaoInstance().updInfo(user.getUId(), u);

					}
				}
				user = FactoryDao.getUserDaoInstance().getUserbyUId(user.getUId());
				request.getSession().setAttribute("user", user);

				if (i == 1) {
					response.getWriter().write("<script>alert('信息修改成功');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/user/user_info_upd.jsp");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 志愿者修改密码
	public void userupdPassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者修改密码");
		User user = (User) request.getSession().getAttribute("user");

		try {
			String oldpwd = request.getParameter("oldpwd");
			String newpwd = request.getParameter("newpwd");
			System.out.println(oldpwd + "-------" + newpwd);
			int i = FactoryDao.getUserDaoInstance().updPwd(user.getUId(), MD5Utils.getMD5Code(oldpwd),
					MD5Utils.getMD5Code(newpwd));
			if (i == 1) {
				response.getWriter().write("<script>alert('密码修改成功');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
			} else {
				response.getWriter().write("<script>alert('旧密码错误，请重新输入');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 志愿者修改邮箱
	public void userupdEmail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("志愿者修改邮箱");
			User user = (User) request.getSession().getAttribute("user");
			String oldEmail = request.getParameter("oldemail");
			String newEmail = request.getParameter("newemail");// 页面传入的邮箱
			System.out.println("志愿者id" + user.getUId() + "新邮箱" + newEmail + "jiu邮箱" + oldEmail);
			String user_updemail_code = request.getParameter("user_updemail_code");// 页面传入的邮箱验证码
			String UserUpdEmail = (String) request.getSession().getAttribute("UserUpdEmail");// 更换的邮箱
			String UserUpdEmailCode = (String) request.getSession().getAttribute("UserUpdEmailCode");// 邮箱验证码
			// 新旧邮箱判断 不一样执行底下操作
			if (!oldEmail.equals(newEmail)) {

				// 验证邮箱前后输入
				if (UserUpdEmail.equals(newEmail)) {
					// 验证邮箱验证码
					if (UserUpdEmailCode.toLowerCase().equals(user_updemail_code.toLowerCase())) {
						// 验证组织邮箱是否已被注册
						User u = FactoryDao.getUserDaoInstance().getUserbyOEmail(newEmail);
						if (u == null) {
							if (FactoryDao.getUserDaoInstance().updEmail(user.getUId(), oldEmail, newEmail) == 1) {

								response.getWriter().write("<script>alert('邮箱修改成功');</script>");
								getUserMsg(request, response);

								response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
							} else {
								response.getWriter().write("<script>alert('邮箱修改失败，请重试');</script>");
								response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
							}
						} else {
							response.getWriter().write("<script>alert('邮箱修改失败，新邮箱已绑定其他志愿者');</script>");
							response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");

						}
					} else {
						response.getWriter().write("<script>alert('邮箱验证码输入错误，请重新输入');</script>");
						response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");

					}
				} else {
					response.getWriter().write("<script>alert('邮箱前后输入错误，请重新输入');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
				}
			} else {
				response.getWriter().write("<script>alert('输入的新邮箱与旧邮箱一致无需更换');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/user/user_safe.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 获取荣耀榜数据
	public void getUserHonList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("荣耀榜");
			List<User> userListbyUHours = FactoryDao.getUserDaoInstance().getUserListbyUHours();
			List<User> userListbyUIntegral = FactoryDao.getUserDaoInstance().getUserListbyUIntegral();

			request.getSession().setAttribute("userListbyUHours", userListbyUHours);
			request.getSession().setAttribute("userListbyUIntegral", userListbyUIntegral);
			response.setHeader("refresh", "0;url=" + contextPath + "/honour_list.jsp");
		} catch (Exception e) {

		}

	}

}
