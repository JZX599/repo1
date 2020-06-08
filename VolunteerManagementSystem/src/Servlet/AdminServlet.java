package Servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.Gson;

import daomain.Admin;
import daomain.Category;
import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.Constant;
import util.EmailUtils;
import util.MD5Utils;
import util.PageUtils;

/**
 * /AdminServlet?action=
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends BaseServlet {

	String contextPath = "";

	// 管理员登录
	public void admin_login(HttpServletRequest request, HttpServletResponse response) {
		try {
			Map<String, String[]> map = request.getParameterMap();
			Admin a = new Admin();
			String remember = request.getParameter("remember-me");
			BeanUtils.populate(a, map);
			a.setAPwd(MD5Utils.getMD5Code(a.getAPwd()));
			Admin admin = FactoryDao.getIAdminDaoInstance().login(a);

			if (admin != null) {
				Cookie cookie = new Cookie("admin_id", String.valueOf(admin.getAId()));
				if (remember != null && remember.equals("yes")) {
					cookie.setMaxAge(60 * 60 * 24 * 7);
					response.addCookie(cookie);
				} else {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}

				// 保存信息到Session域中
				response.getWriter().write("<script>alert('登录成功,正在跳转到后台主页');</script>");//
				request.getSession().setAttribute("admin", admin);
				response.setHeader("refresh", "1;url=" + request.getContextPath() + "/admin/admin_manage.jsp");

			} else {
				response.getWriter().write("<script>alert('账号或密码错误，请重新登录');</script>");//

				response.setHeader("refresh", "1;url=" + request.getContextPath() + "/admin/admin_login.jsp");
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	
	// 设置超级管理员
		public void upSadmin(HttpServletRequest request, HttpServletResponse response) {
			try {
				contextPath = request.getContextPath();// 获得项目路径名
				System.out.println("设置超级管理员Servlet");
				Admin admin = (Admin) request.getSession().getAttribute("admin");
				System.out.println("admin为" + admin);
				if (admin == null) {
					response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
					response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
				} else {
					String AId = request.getParameter("AId");
					int i = FactoryDao.getIAdminDaoInstance().upSadmin(Integer.parseInt(AId));
					response.getWriter().write("<script>alert('设置超级管理员成功');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
					
				}
			} catch (Exception e) {

				e.printStackTrace();
			}

		}

		// 设置普通管理员
				public void dropSadmin(HttpServletRequest request, HttpServletResponse response) {
					try {
						contextPath = request.getContextPath();// 获得项目路径名
						System.out.println("设置普通管理员Servlet");
						Admin admin = (Admin) request.getSession().getAttribute("admin");
						System.out.println("admin为" + admin);
						if (admin == null) {
							response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
						} else {
							String AId = request.getParameter("AId");
							int i = FactoryDao.getIAdminDaoInstance().dropSadmin(Integer.parseInt(AId));
							response.getWriter().write("<script>alert('设置普通管理员成功');</script>");
							response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
							
						}
					} catch (Exception e) {

						e.printStackTrace();
					}

				}
	
	
	
	// 查询所有分类列表
	public void getAllCateList(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("管理员查询所有分类列表Servlet");
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				String currentPage = request.getParameter("page");// 当前页
				List<Category> AdmingetallCateList = FactoryDao.getICategoryDaoInstance().getAllCate();
				if (currentPage == null) {
					currentPage = "1";
				}
				System.out.println("所有分类列表数据：	" + AdmingetallCateList);
				PageUtils<Category> p = new PageUtils<Category>(AdmingetallCateList, Integer.parseInt(currentPage), 10);
				List<Category> adminCatePageList = p.getPageList();
				request.getSession().setAttribute("adminCatePageList", adminCatePageList);
				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPages", p.getTotalPage());
				response.setHeader("refresh", "0;url=" + contextPath + "/admin/admin_act_category.jsp");
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 添加分类信息
	public void addCate(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名

			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				Map<String, String[]> map = request.getParameterMap();
				Category c = new Category();
				BeanUtils.populate(c, map);
				Category cate = FactoryDao.getICategoryDaoInstance().getCateByCName(c.getCName());
				if (cate != null) {
					response.getWriter().write("<script>alert('该分类已存在，添加分类失败！');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllCateList");

				} else {
					int i = FactoryDao.getICategoryDaoInstance().addCate(c);

					response.getWriter().write("<script>alert('添加分类成功！');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllCateList");

				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 修改分类信息
	public void updCate(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名

			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				Map<String, String[]> map = request.getParameterMap();
				Category c = new Category();
				BeanUtils.populate(c, map);
				Category cate = FactoryDao.getICategoryDaoInstance().getCateByCName(c.getCName());
				if (cate != null) {
					response.getWriter().write("<script>alert('该分类已存在，修改分类失败！');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllCateList");
				} else {
					int i = FactoryDao.getICategoryDaoInstance().updCate(c);
					response.getWriter().write("<script>alert('修改分类成功！');</script>");

					response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllCateList");

				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 删除分类信息
	public void delCate(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				String CId = request.getParameter("CId");
				int i = FactoryDao.getICategoryDaoInstance().delCate(Integer.parseInt(CId));
				response.getWriter().write("<script>alert('删除分类成功！');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllCateList");

			}
		} catch (Exception e) {
			try {
				response.getWriter().write("<script>alert('删除分类失败！该分类下已有活动');</script>");
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			response.setHeader("refresh", "0;url=" + contextPath + "/AdminServlet?action=getAllCateList");

		}

	}

	// 查询所有管理员列表
	public void getAllAdminList(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("管理员的志愿者管理Servlet");
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {

				List<Admin> adminList = null;
				String currentPage = request.getParameter("page");// 当前页
				String type = request.getParameter("type");// 选择查询类型
				String value = request.getParameter("txtSearch");// 查询的文本内容
				System.out.println("选择查询类型" + type + "文本内容" + value);
				if (currentPage == null) {
					currentPage = "1";
				}

				if (value == null) {
					value = (String) request.getSession().getAttribute("value");
				}

				if (type == null) {
					type = (String) request.getSession().getAttribute("type");
					if (type == null) {
						type = "showAll";
					}
				}
				if (type.equals("showAll")) {
					// 得到所有管理员列表
					adminList = FactoryDao.getIAdminDaoInstance().getAdminList();
				} else {
					// 根据类型及对应搜索的值取得管理员列表
					adminList = FactoryDao.getIAdminDaoInstance().getAdminListByTypeValue(type, value);
				}

				System.out.println("所有管理员列表数据：	" + adminList);

				PageUtils<Admin> p = new PageUtils<Admin>(adminList, Integer.parseInt(currentPage), 10);
				List<Admin> adminPageList = p.getPageList();
				request.getSession().setAttribute("adminPageList", adminPageList);
				request.getSession().setAttribute("type", type);// 选择查询类型
				request.getSession().setAttribute("value", value);// 文本框输入内容

				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPages", p.getTotalPage());
				response.setHeader("refresh", "0;url=" + contextPath + "/admin/admin_list.jsp");

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 添加管理员
	public void addAdmin(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名

			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				Map<String, String[]> map = request.getParameterMap();
				Admin a = new Admin();
				BeanUtils.populate(a, map);
				a.setAPwd(MD5Utils.getMD5Code(a.getAPwd()));
				int i = FactoryDao.getIAdminDaoInstance().addAdmin(a);
				if (i == 1) {
					response.getWriter().write("<script>alert('添加管理员成功！');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
				} else {
					response.getWriter().write("<script>alert('添加管理员失败，请重试');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
				}

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 修改管理员
	public void updAdmin(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名

			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				Map<String, String[]> map = request.getParameterMap();
				Admin a = new Admin();
				BeanUtils.populate(a, map);
				a.setAPwd(MD5Utils.getMD5Code(a.getAPwd()));
				System.out.println("前端获取管理员信息" + a.toString());
				int i = FactoryDao.getIAdminDaoInstance().updAdmin(a);
				if (i == 1) {
					response.getWriter().write("<script>alert('修改管理员成功！');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
				} else {
					response.getWriter().write("<script>alert('修改管理员失败，请重试');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
				}

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 删除管理员
	public void delAdmin(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名

			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				String AId = request.getParameter("AId");
				int i = FactoryDao.getIAdminDaoInstance().delAdmin(Integer.parseInt(AId));

				if (i == 1) {
					response.getWriter().write("<script>alert('删除管理员成功！');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
				} else {
					response.getWriter().write("<script>alert('删除管理员失败，请重试');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/AdminServlet?action=getAllAdminList&type=showAll");
				}

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 管理员退出
	public void adminQuit(HttpServletRequest request, HttpServletResponse response) {
		// System.out.println("想获取项目名为："+request.getContextPath());
		request.getSession().removeAttribute("admin");
		response.setHeader("refresh", "1;url=" + request.getContextPath() + "/admin/admin_login.jsp");
		// return "/admin/admin_login.jsp";
	}

	// 查询所有志愿者列表
	public void getAllUserList(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("管理员的志愿者管理Servlet");
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {

				List<User> userList = null;
				String currentPage = request.getParameter("page");// 当前页
				String type = request.getParameter("type");// 选择查询类型
				String value = request.getParameter("txtSearch");// 查询的文本内容
				System.out.println("选择查询类型" + type + "文本内容" + value);
				if (currentPage == null) {
					currentPage = "1";
				}

				if (value == null) {
					value = (String) request.getSession().getAttribute("value");
				}

				if (type == null) {
					type = (String) request.getSession().getAttribute("type");
					if (type == null) {
						type = "showAll";
					}
				}
				if (type.equals("showAll")) {
					// 得到所有志愿者列表
					userList = FactoryDao.getUserDaoInstance().getUserList();
				} else {
					// 根据类型及对应搜索的值取得志愿者列表
					userList = FactoryDao.getUserDaoInstance().getUserListByTypeValue(type, value);
				}

				System.out.println("所有志愿者列表数据：	" + userList);

				PageUtils<User> p = new PageUtils<User>(userList, Integer.parseInt(currentPage), 10);
				List<User> userPageList = p.getPageList();
				request.getSession().setAttribute("userPageList", userPageList);
				request.getSession().setAttribute("type", type);// 选择查询类型
				request.getSession().setAttribute("value", value);// 文本框输入内容

				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPages", p.getTotalPage());
				response.setHeader("refresh", "0;url=" + contextPath + "/admin/admin_user_list.jsp");

			}
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 志愿者重置密码
	public void ResetUserPwd(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("管理员的志愿者管理Servlet");
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				String UId = request.getParameter("UId");
				User user = FactoryDao.getUserDaoInstance().getUserbyUId(Integer.parseInt(UId));
				String uIdCard = user.getUIdCard();
				// 通过组织id进行组织重置密码为法人身份证号码后6位
				int i = FactoryDao.getUserDaoInstance().resetUserPwd(user.getUId(),
						MD5Utils.getMD5Code(uIdCard.substring(12, 18)));

				// 获取组织邮箱 调用邮件服务 通知组织密码已重置为法人身份证号码后6位

				Session session = EmailUtils.getSession();
				MimeMessage mimeMessage;
				// 调用邮件服务通知组织重置密码
				mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, user.getUEmail(),
						Constant.User_Mesg, "<br/>尊敬的i志愿用户，您的密码已被管理员重置，新密码为身份证号码后六位。");
				// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
				EmailUtils.getTransport(session, mimeMessage);
				System.out.println("志愿者重置密码发送邮件");

				// 如果标记是全部就查询全部列表 返回全部列表

				response.setHeader("refresh",
						"0;url=" + contextPath + "/AdminServlet?action=getAllUserList&type=showAll");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 冻结志愿者
	public void DongJUser(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("管理员的志愿者管理Servlet");
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				String UId = request.getParameter("UId");
				User user = FactoryDao.getUserDaoInstance().getUserbyUId(Integer.parseInt(UId));
				// 通过志愿者id进行组织冻结
				if (user != null) {
					int i = FactoryDao.getUserDaoInstance().dongJieUser(user.getUId());
					// 获取志愿者邮箱 调用邮件服务 通知志愿者被冻结
					Session session = EmailUtils.getSession();
					MimeMessage mimeMessage;
					// 调用邮件服务通知志愿者被冻结
					mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, user.getUEmail(),
							Constant.User_Mesg, "<br/>尊敬的i志愿用户，您已被管理员限制登录，若有疑问请联系i志愿。");
					// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
					EmailUtils.getTransport(session, mimeMessage);
					System.out.println("志愿者被冻结发送邮件");
					// 如果标记是全部就查询全部列表 返回全部列表
					response.setHeader("refresh",
							"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllUserList&type=showAll");
				} else {
					response.getWriter().write("<script>alert('执行失败，找不到该志愿者');</script>");
					response.setHeader("refresh",
							"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllUserList&type=showAll");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 解冻志愿者 如果星级低于1设置星级为1 避免出错
	public void JieDUser(HttpServletRequest request, HttpServletResponse response) {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("管理员的志愿者管理Servlet");
			Admin admin = (Admin) request.getSession().getAttribute("admin");
			System.out.println("admin为" + admin);
			if (admin == null) {
				response.getWriter().write("<script>alert('管理员未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/admin/admin_login.jsp");
			} else {
				String UId = request.getParameter("UId");
				User user = FactoryDao.getUserDaoInstance().getUserbyUId(Integer.parseInt(UId));
				if (user != null) {

					if (user.getUCredit() < 1) {
						int i = FactoryDao.getUserDaoInstance().restUCredit(Integer.parseInt(UId));
					}
					// 通过志愿者id进行组织解冻 当志愿者星级小于一时设置志愿者星级为1
					int i = FactoryDao.getUserDaoInstance().jieDongUser(user.getUId());
					// 获取组织邮箱 调用邮件服务 通知组织已解冻
					Session session = EmailUtils.getSession();
					MimeMessage mimeMessage;
					// 调用邮件服务通知组织解冻
					mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, user.getUEmail(),
							Constant.User_Mesg, "<br/>尊敬的i志愿用户，您的账号已解除登陆限制。");
					// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
					EmailUtils.getTransport(session, mimeMessage);
					System.out.println("志愿者解冻发送邮件");

					// 如果标记是全部就查询全部列表 返回全部列表

					response.setHeader("refresh",
							"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllUserList&type=showAll");
				} else {
					response.getWriter().write("<script>alert('执行失败，找不到该志愿者');</script>");
					response.setHeader("refresh",
							"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllUserList&type=showAll");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 查询所有组织
	public void getAllOrgList(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("所有组织Servlet");

			List<Organize> orgList = null;

			String currentPage = request.getParameter("page");// 当前页
			String type = request.getParameter("type");// 选择查询类型
			String value = request.getParameter("txtSearch");// 查询的文本内容
			System.out.println("选择查询类型" + type + "文本内容" + value);
			if (currentPage == null) {
				currentPage = "1";
			}

			if (value == null) {
				value = (String) request.getSession().getAttribute("value");
			}

			if (type == null) {
				type = (String) request.getSession().getAttribute("type");
				if (type == null) {
					type = "showAll";
				}
			}
			if (type.equals("showAll")) {
				orgList = FactoryDao.getIOrganizeDaoInstance().getOrgList();
			} else {
				orgList = FactoryDao.getIOrganizeDaoInstance().getOrgListbyTypeValue(type, value);

			}
			System.out.println("所有组织列表" + orgList);
			PageUtils<Organize> p = new PageUtils<Organize>(orgList, Integer.parseInt(currentPage), 10);
			List<Organize> OrgpageList = p.getPageList();
			for (Organize organize : OrgpageList) {
				int OActnum = FactoryDao.getIOrganizeDaoInstance().getOrgActnum(organize.getOId()).intValue();
				organize.setOActnum(OActnum);
			}
			System.out.println("所有当页组织列表" + orgList);
			request.getSession().setAttribute("type", type);// 选择查询类型
			request.getSession().setAttribute("value", value);// 文本框输入内容
			request.getSession().setAttribute("OrgpageList", OrgpageList);
			request.getSession().setAttribute("currentPage", p.getCurrentPage());
			request.getSession().setAttribute("totalPages", p.getTotalPage());
			response.setHeader("refresh", "0;url=" + request.getContextPath() + "/admin/admin_org_list.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 审核通过组织
	public void passOrgregist(HttpServletRequest request, HttpServletResponse response) {
		try {
			String flag = request.getParameter("flag");
			String OId = request.getParameter("OId");
			Organize organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(Integer.parseInt(OId));
			// 通过组织id进行组织通过
			int i = FactoryDao.getIOrganizeDaoInstance().PassOrgregist(organize.getOId());
			// 获取组织邮箱 调用邮件服务 通知审核已通过

			Session session = EmailUtils.getSession();
			MimeMessage mimeMessage;
			// 调用邮件服务通知组织审核已通过
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, organize.getOEmail(),
					Constant.Org_ShenhPass, "<br/>恭喜您，您注册的“" + organize.getOName() + "”组织审核已通过。");
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			System.out.println("组织审核通过发送邮件");

			// 如果标记是全部就查询全部列表 返回全部列表
			if (flag.equals("all")) {
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllOrgList&type=showAll");
			} else if (flag.equals("wait")) {
				// 如果标记是待审核就查询待审核列表 返回待审核列表
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllWaitOrgList&type=showAll");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 审核未通过组织
	public void notpassOrgregist(HttpServletRequest request, HttpServletResponse response) {
		try {
			String flag = request.getParameter("flag");
			String OId = request.getParameter("OId");
			Organize organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(Integer.parseInt(OId));
			// 通过组织id进行组织通过
			int i = FactoryDao.getIOrganizeDaoInstance().notPassOrgregist(organize.getOId());
			// 获取组织邮箱 调用邮件服务 通知审核未通过

			Session session = EmailUtils.getSession();
			MimeMessage mimeMessage;
			// 调用邮件服务通知组织审核已通过
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, organize.getOEmail(),
					Constant.Org_ShenhPass, "<br/>很遗憾，您注册的“" + organize.getOName() + "”组织审核未通过，您可以提供更加完善的材料再次进行注册。");
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			System.out.println("组织审核未通过发送邮件");

			// 如果标记是全部就查询全部列表 返回全部列表
			if (flag.equals("all")) {
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllOrgList&type=showAll");
			} else if (flag.equals("wait")) {
				// 如果标记是待审核就查询待审核列表 返回待审核列表
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllWaitOrgList&type=showAll");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 冻结组织
	public void DongJOrg(HttpServletRequest request, HttpServletResponse response) {
		try {
			String flag = request.getParameter("flag");
			String OId = request.getParameter("OId");
			Organize organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(Integer.parseInt(OId));
			// 通过组织id进行组织冻结
			int i = FactoryDao.getIOrganizeDaoInstance().dongJieOrg(organize.getOId());
			// 获取组织邮箱 调用邮件服务 通知组织被冻结
			Session session = EmailUtils.getSession();
			MimeMessage mimeMessage;
			// 调用邮件服务通知组织被冻结
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, organize.getOEmail(),
					Constant.Org_ShenhPass, "<br/>您的“" + organize.getOName() + "”组织已被限制登录，若有疑问请联系i志愿。");
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			System.out.println("组织被冻结发送邮件");

			// 如果标记是全部就查询全部列表 返回全部列表
			if (flag.equals("all")) {
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllOrgList&type=showAll");
			} else if (flag.equals("pass")) {
				// 如果标记是待审核就查询已审核列表 返回已审核列表
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllPassOrgList&type=showAll");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 解冻组织
	public void JieDOrg(HttpServletRequest request, HttpServletResponse response) {
		try {
			String flag = request.getParameter("flag");
			String OId = request.getParameter("OId");
			Organize organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(Integer.parseInt(OId));
			// 通过组织id进行组织解冻
			int i = FactoryDao.getIOrganizeDaoInstance().jieDongOrg(organize.getOId());
			// 获取组织邮箱 调用邮件服务 通知组织已解冻
			Session session = EmailUtils.getSession();
			MimeMessage mimeMessage;
			// 调用邮件服务通知组织解冻
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, organize.getOEmail(),
					Constant.Org_ShenhPass, "<br/>您的“" + organize.getOName() + "”组织已解除登陆限制成功。");
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			System.out.println("组织解冻发送邮件");

			// 如果标记是全部就查询全部列表 返回全部列表
			if (flag.equals("all")) {
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllOrgList&type=showAll");
			} else if (flag.equals("pass")) {
				// 如果标记是待审核就查询已审核列表 返回已审核列表
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllPassOrgList&type=showAll");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 组织重置密码
	public void ResetOrgPwd(HttpServletRequest request, HttpServletResponse response) {
		try {
			String flag = request.getParameter("flag");
			String OId = request.getParameter("OId");
			Organize organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(Integer.parseInt(OId));
			// 通过组织id进行组织重置密码为法人身份证号码后6位
			String oIdCard = organize.getOIdCard();
			int i = FactoryDao.getIOrganizeDaoInstance().resetOrgPwd(organize.getOId(),
					MD5Utils.getMD5Code(oIdCard.substring(12, 18)));
			// 获取组织邮箱 调用邮件服务 通知组织密码已重置为法人身份证号码后6位

			Session session = EmailUtils.getSession();
			MimeMessage mimeMessage;
			// 调用邮件服务通知组织重置密码
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, organize.getOEmail(),
					Constant.Org_ShenhPass, "<br/>您的“" + organize.getOName() + "”组织已重置密码，新密码为法人身份证号码后六位。");
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			System.out.println("组织重置密码发送邮件");

			// 如果标记是全部就查询全部列表 返回全部列表
			if (flag.equals("all")) {
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllOrgList&type=showAll");
			} else if (flag.equals("pass")) {
				// 如果标记是待审核就查询已审核列表 返回已审核列表
				response.setHeader("refresh",
						"0;url=" + request.getContextPath() + "/AdminServlet?action=getAllPassOrgList&type=showAll");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 查询所有待审核组织
	public void getAllWaitOrgList(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("待审核组织Servlet");

			List<Organize> orgList = null;

			String currentPage = request.getParameter("page");// 当前页
			String type = request.getParameter("type");// 选择查询类型
			String value = request.getParameter("txtSearch");// 查询的文本内容
			System.out.println("选择查询类型" + type + "文本内容" + value);
			if (currentPage == null) {
				currentPage = "1";
			}

			if (value == null) {
				value = (String) request.getSession().getAttribute("value");
			}

			if (type == null) {
				type = (String) request.getSession().getAttribute("type");
				if (type == null) {
					type = "showAll";
				}
			}
			if (type.equals("showAll")) {
				orgList = FactoryDao.getIOrganizeDaoInstance().getOrgWaitList();
			} else {
				orgList = FactoryDao.getIOrganizeDaoInstance().getOrgWaitListbyTypeValue(type, value);
			}
			System.out.println("所有组织列表" + orgList);
			PageUtils<Organize> p = new PageUtils<Organize>(orgList, Integer.parseInt(currentPage), 10);
			List<Organize> OrgpageList = p.getPageList();

			System.out.println("所有当页组织列表" + orgList);
			request.getSession().setAttribute("type", type);// 选择查询类型
			request.getSession().setAttribute("value", value);// 文本框输入内容
			request.getSession().setAttribute("OrgpageList", OrgpageList);
			request.getSession().setAttribute("currentPage", p.getCurrentPage());
			request.getSession().setAttribute("totalPages", p.getTotalPage());
			response.setHeader("refresh", "0;url=" + request.getContextPath() + "/admin/admin_org_wait.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 查询所有已审核组织
	public void getAllPassOrgList(HttpServletRequest request, HttpServletResponse response) {
		try {
			System.out.println("后台管理员Servlet");

			List<Organize> orgList = null;

			String currentPage = request.getParameter("page");// 当前页
			String type = request.getParameter("type");// 选择查询类型
			String value = request.getParameter("txtSearch");// 查询的文本内容
			System.out.println("选择查询类型" + type + "文本内容" + value);
			if (currentPage == null) {
				currentPage = "1";
			}

			if (value == null) {
				value = (String) request.getSession().getAttribute("value");
			}

			if (type == null) {
				type = (String) request.getSession().getAttribute("type");
				if (type == null) {
					type = "showAll";
				}
			}
			if (type.equals("showAll")) {
				orgList = FactoryDao.getIOrganizeDaoInstance().getOrgPassList();
			} else {
				orgList = FactoryDao.getIOrganizeDaoInstance().getOrgPassListbyTypeValue(type, value);
			}
			System.out.println("所有组织列表" + orgList);
			PageUtils<Organize> p = new PageUtils<Organize>(orgList, Integer.parseInt(currentPage), 10);
			List<Organize> OrgpageList = p.getPageList();
			for (Organize organize : OrgpageList) {
				int OActnum = FactoryDao.getIOrganizeDaoInstance().getOrgActnum(organize.getOId()).intValue();
				organize.setOActnum(OActnum);
			}
			System.out.println("所有当页组织列表" + orgList);
			request.getSession().setAttribute("type", type);// 选择查询类型
			request.getSession().setAttribute("value", value);// 文本框输入内容
			request.getSession().setAttribute("OrgpageList", OrgpageList);
			request.getSession().setAttribute("currentPage", p.getCurrentPage());
			request.getSession().setAttribute("totalPages", p.getTotalPage());
			response.setHeader("refresh", "0;url=" + request.getContextPath() + "/admin/admin_org_pass.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
