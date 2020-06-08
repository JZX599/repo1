package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import daomain.Activity;
import daomain.Category;
import daomain.Enlist;
import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.CommonUtils;
import util.Constant;
import util.EmailUtils;
import util.PageUtils;

/**
 * 活动 ActivityServlet?action=
 */
@WebServlet("/ActivityServlet")
public class ActivityServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";
	Session session = EmailUtils.getSession();
	MimeMessage mimeMessage;

	////////////////////////// 组织的活动///////////////////////////////////////////
	// 添加活动
	public void addAct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("活动的servlet访问成功");
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			try {

				Map<String, String[]> actmap = request.getParameterMap();
				String AStartDate = request.getParameter("AStartDate");
				String AEndDate = request.getParameter("AEndDate");
				Activity act = new Activity();
				act.setAHours(CommonUtils.gethours(AStartDate, AEndDate));// 工具类将活动结束时间与开始进行时间进行比较得出差值设置活动时长
				act.setAKzTime(CommonUtils.getDatetime());// 工具类获取当前系统时间格式化
															// 设置为活动开始招募时间

				BeanUtils.populate(act, actmap);
				int i = FactoryDao.getIActivityDaoInstance().orgAddAct(act, organize.getOId());
				if (i != 1) {
					response.getWriter().write("<script>alert('sql内部错误，添加失败');</script>");
					response.setHeader("refresh", "1;url=" + contextPath + "/organize/org_act_list.jsp");
				} else {
					response.getWriter().write("<script>alert('活动添加成功');</script>");
					response.setHeader("refresh",
							"1;url=" + contextPath + "/ActivityServlet?action=getPageActList&state=showAll&page=1");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// 得到分页中的总活动列表 //改进思路存state为session 为空就去取session值
	public void getPageActList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			try {
				PageUtils p = null;
				List<Activity> act = new ArrayList();
				String currentPage = request.getParameter("page");// 通过页面传递当前页数
				String state = request.getParameter("state");
				List<Activity> orgPageDate = FactoryDao.getIActivityDaoInstance().getAllActs(organize.getOId());
				Collections.reverse(orgPageDate);// 集合反转
				String newtime = CommonUtils.getDatetime();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (state == null) {
					state = "showAll";
				}
				if (state.equals("showAll")) {
					for (Activity a : orgPageDate) {
						if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
							a.setAState(Constant.Act_State_Pass);
						} else if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
								&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
							a.setAState(Constant.Act_State_GoDoing);
						} else {
							a.setAState(Constant.Act_State_End);
						}
						act.add(a);
					}

				} else if (state.equals("pass")) {

					for (Activity a : orgPageDate) {
						if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
							a.setAState(Constant.Act_State_Pass);
							act.add(a);
						}
					}

				} else if (state.equals("godoing")) {

					for (Activity a : orgPageDate) {
						if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
								&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
							a.setAState(Constant.Act_State_GoDoing);
							act.add(a);
						}
					}

				} else if (state.equals("end")) {

					for (Activity a : orgPageDate) {
						if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAEndDate()))) {
							a.setAState(Constant.Act_State_End);
							act.add(a);
						}
					}

				} else if (state.equals("byName")) {

					String AName = request.getParameter("AName");

					if (!AName.equals("")) {
						System.out.println("AName--" + AName + "--");
						List<Activity> alist = FactoryDao.getIActivityDaoInstance().getActListbyAname(organize.getOId(),
								AName);

						Collections.reverse(alist);// 集合反转
						for (Activity a : alist) {
							if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
								a.setAState(Constant.Act_State_Pass);
							} else if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
									&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
								a.setAState(Constant.Act_State_GoDoing);
							} else {
								a.setAState(Constant.Act_State_End);
							}
							act.add(a);
						}

					}
					request.getSession().setAttribute("AName", AName);
				}
				p = new PageUtils<Activity>(act, Integer.parseInt(currentPage), 5);
				List<Activity> ActPagelist = p.getPageList();
				request.getSession().setAttribute("state", state);
				request.getSession().setAttribute("ActPagelist", ActPagelist);
				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPage", p.getTotalPage());
				System.out.println("当前页：" + p.getCurrentPage() + "当前页的活动列表" + ActPagelist + "总页数" + p.getTotalPage());
				request.getRequestDispatcher("/organize/org_act_list.jsp").forward(request, response);
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
	}

	// 添加活动时跳转添加活动页面 必须传入session 分类数据
	// 修改活动
	public void jumpAddActPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			Organize organize = (Organize) request.getSession().getAttribute("organize");
			if (organize == null) {
				response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else {
				// 查询所有分类 存值session
				List<Category> allCateList = FactoryDao.getICategoryDaoInstance().getAllCate();

				request.getSession().setAttribute("allCateList", allCateList);
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_add.jsp");
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	// 修改活动
	public void updAct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			// 获取活动id
			String AId = request.getParameter("AId");
			if (AId != null) {
				try {
					Map<String, String[]> updactmap = request.getParameterMap();

					String AStartDate = request.getParameter("AStartDate");
					String AEndDate = request.getParameter("AEndDate");
					Activity act = new Activity();
					act.setAHours(CommonUtils.gethours(AStartDate, AEndDate));// 工具类将活动结束时间与开始进行时间进行比较得出差值设置活动时长
					act.setAKzTime(CommonUtils.getDatetime());// 工具类获取当前系统时间格式化
																// 设置为活动开始招募时间

					BeanUtils.populate(act, updactmap);
					int i = FactoryDao.getIActivityDaoInstance().orgUpdAct(act, organize.getOId());// 通过组织和活动id更新活动
					System.out.println("修改成功---------" + i);
					response.getWriter().write("<script>alert('修改成功');</script>");
					byAIdgetActmsg(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				response.getWriter().write("<script>alert('未知活动，请检查命令是否正确');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			}
		}
	}

	// 修改活动按钮点击跳转到修改活动信息页面 并传递活动值
	public void byAIdgetActmsg(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			try {
				// 获取活动id
				String AId = request.getParameter("AId");
				if (AId != null) {

					Activity updActivity = FactoryDao.getIActivityDaoInstance().getActByAId(Integer.parseInt(AId),
							organize.getOId());
					// activity存在request域
					// 取得所有类别存值session
					List<Category> allCateList = FactoryDao.getICategoryDaoInstance().getAllCate();
					request.getSession().setAttribute("updActivity", updActivity);
					request.getSession().setAttribute("allCateList", allCateList);
					System.out.println("updActivity" + updActivity.toString());
					System.out.println("allCateList" + allCateList.toString());

					response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_upd.jsp");
				} else {
					response.getWriter().write("<script>alert('未知活动，请检查命令是否正确');</script>");
					response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// 通过组织和活动id删除活动
	public void byAIdDelAct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			try {
				String AId = request.getParameter("AId");
				if (AId != null) {
					int i = FactoryDao.getIActivityDaoInstance().orgDelAct(Integer.parseInt(AId), organize.getOId());
					if (i == 1) {
						response.getWriter().write("<script>alert('活动取消成功');</script>");

						response.setHeader("refresh",
								"0;url=" + contextPath + "/ActivityServlet?action=getPageActList&state=showAll&page=1");
					} else {
						response.getWriter().write("<script>alert('取消失败，请重试');</script>");
						response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_list.jsp");
					}
				} else {
					response.getWriter().write("<script>alert('未知活动，请检查命令是否正确');</script>");
					response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// 活动报名表 活动列表
	public void getPageActBaomList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			Organize organize = (Organize) request.getSession().getAttribute("organize");

			if (organize == null) {
				response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else {

				List<Activity> orgPageActList = FactoryDao.getIActivityDaoInstance().getAllActs(organize.getOId());
				Collections.reverse(orgPageActList);// 集合反转
				String currentPage = request.getParameter("page");
				PageUtils p = null;
				String actState = request.getParameter("state");
				List<Activity> act = new ArrayList();
				// 如果状态值为空就去session找
				if (actState == null) {
					actState = (String) request.getSession().getAttribute("actState");
					if (actState == null) {
						actState = "showAll";
					}
				}
				String newtime = CommonUtils.getDatetime();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (actState.equals("showAll")) {

					for (Activity a : orgPageActList) {
						int Tonggcount = FactoryDao.getIEnlistDaoInstance().getETongcountbyAId(a.getAId()).intValue();
						int Baomcount = FactoryDao.getIEnlistDaoInstance().getEBaomcountbyAId(a.getAId()).intValue();
						a.setEBaom(Baomcount);// 报名表报名人数
						a.setETong(Tonggcount);// 报名表通过人数
						if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
							a.setAState(Constant.Act_State_Pass);
						} else if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
								&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
							a.setAState(Constant.Act_State_GoDoing);
						} else {
							a.setAState(Constant.Act_State_End);
						}
						act.add(a);
					}
				} else if (actState.equals("pass")) {

					for (Activity a : orgPageActList) {
						int Tonggcount = FactoryDao.getIEnlistDaoInstance().getETongcountbyAId(a.getAId()).intValue();
						int Baomcount = FactoryDao.getIEnlistDaoInstance().getEBaomcountbyAId(a.getAId()).intValue();
						a.setEBaom(Baomcount);// 报名表报名人数
						a.setETong(Tonggcount);// 报名表通过人数
						if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
							a.setAState(Constant.Act_State_Pass);
							act.add(a);
						}
					}

				} else if (actState.equals("godoing")) {

					for (Activity a : orgPageActList) {
						int Tonggcount = FactoryDao.getIEnlistDaoInstance().getETongcountbyAId(a.getAId()).intValue();
						int Baomcount = FactoryDao.getIEnlistDaoInstance().getEBaomcountbyAId(a.getAId()).intValue();
						a.setEBaom(Baomcount);// 报名表报名人数
						a.setETong(Tonggcount);// 报名表通过人数
						if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
								&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
							a.setAState(Constant.Act_State_GoDoing);
							act.add(a);
						}
					}

				} else if (actState.equals("end")) {

					for (Activity a : orgPageActList) {
						int Tonggcount = FactoryDao.getIEnlistDaoInstance().getETongcountbyAId(a.getAId()).intValue();
						int Baomcount = FactoryDao.getIEnlistDaoInstance().getEBaomcountbyAId(a.getAId()).intValue();
						a.setEBaom(Baomcount);// 报名表报名人数
						a.setETong(Tonggcount);// 报名表通过人数
						if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAEndDate()))) {
							a.setAState(Constant.Act_State_End);
							act.add(a);
						}
					}

				}
				p = new PageUtils<Activity>(act, Integer.parseInt(currentPage), 10);
				List<Activity> baomActpageList = p.getPageList();

				request.getSession().setAttribute("actState", actState);// 状态存值
																		// 全部
																		// 招募中
																		// 进行中
																		// 已结束
				request.getSession().setAttribute("baomActpageList", baomActpageList);// 通过分页工具类的角标算法取得分页的活动集合
																						// 存值
				request.getSession().setAttribute("currentPage", p.getCurrentPage());
				request.getSession().setAttribute("totalPage", p.getTotalPage());
				System.out
						.println("当前页：" + p.getCurrentPage() + "当前页的活动列表" + baomActpageList + "总页数" + p.getTotalPage());
				// request.getRequestDispatcher("/organize/org_act_baomActlist.jsp").forward(request,
				// response);
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_baomActlist.jsp");

			}
			/*
			 * request.getSession().setAttribute("orgPageActList",
			 * orgPageActList);
			 */
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 活动报名表 活动对应的用户报名列表
	public void getUserBaomList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获取项目名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		String AId = request.getParameter("AId");// 从页面传来当前活动id
		String AState = request.getParameter("AState");// 从页面传来当前活动状态
		String page = request.getParameter("page");// 从页面传来当前页

		PageUtils p = null;

		// 查询 组织下的活动 报名表信息 报名表信息是用户信息加用户报名是否通过 是否参与
		try {
			Activity ActBaommsg = FactoryDao.getIActivityDaoInstance().getActmsg(Integer.parseInt(AId));
			List<Enlist> UserBaomlist1 = FactoryDao.getIEnlistDaoInstance().getUserBaommsg(Integer.parseInt(AId));
			p = new PageUtils<Enlist>(UserBaomlist1, Integer.parseInt(page), 10);
			List<Enlist> UserBaomlist = p.getPageList();

			request.getSession().setAttribute("UserBaomlist", UserBaomlist);// 当前页报名表列表
			request.getSession().setAttribute("currentPage", p.getCurrentPage());// 当前页
			request.getSession().setAttribute("totalPage", p.getTotalPage());// 总页数
			System.out.println("当前页：" + p.getCurrentPage() + "当前页的活动列表" + UserBaomlist + "总页数" + p.getTotalPage());

			System.out.println(UserBaomlist.toString());

			request.getSession().setAttribute("ActBaommsg", ActBaommsg);// 单独的一个活动类
			request.getSession().setAttribute("ActAState", Integer.parseInt(AState));// 活动状态

			response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_baomActUserlist.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 组织通过活动取得报名该活动的集合 组织通过志愿者报名的活动 报名确认
	public void orgisPassUserBaom(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			contextPath = request.getContextPath();// 获取项目名
			Organize organize = (Organize) request.getSession().getAttribute("organize");
			if (organize == null) {
				response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else {

				String AId = request.getParameter("AId");// 从页面传来当前活动id
				String UId = request.getParameter("UId");
				String isPass = request.getParameter("isPass");
				Activity activity = FactoryDao.getIActivityDaoInstance().getActmsg(Integer.parseInt(AId));
				User user = FactoryDao.getUserDaoInstance().getUserbyUId(Integer.parseInt(UId));
				int i = -1;
				if (isPass.equals("notPass")) {
					i = FactoryDao.getIEnlistDaoInstance().notPassUserBaom(Integer.parseInt(AId),
							Integer.parseInt(UId));
					if (i != 0) {
						// 调用邮件服务通知用户未被录用
						mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress,
								user.getUEmail(), Constant.Act_BaomNotPass,
								"<br/>很遗憾，您报名的" + activity.getAName() + "活动未通过。");
						// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
						EmailUtils.getTransport(session, mimeMessage);
						System.out.println("报名未通过发送邮件");
					}

				} else if (isPass.equals("Pass")) {
					i = FactoryDao.getIEnlistDaoInstance().PassUserBaom(Integer.parseInt(AId), Integer.parseInt(UId));
					if (i != 0) {
						// 调用邮件服务通知用户被录用
						mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress,
								user.getUEmail(), Constant.Act_BaomPass,
								"<br/>恭喜您，您报名的" + activity.getAName() + "活动已通过。<br/>活动地点：" + activity.getAAddress()
										+ "<br/>活动开始时间：" + activity.getAStartDate() + "至" + activity.getAEndDate()
										+ "<br/>请及时参加活动。");
						// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
						EmailUtils.getTransport(session, mimeMessage);
						System.out.println("报名通过发送邮件");
					}
				}
				/* 组织通过用户报名 */
				int page = (int) request.getSession().getAttribute("currentPage");
				PageUtils<Enlist> p = null;
				List<Enlist> UserBaomlist1 = FactoryDao.getIEnlistDaoInstance().getUserBaommsg(Integer.parseInt(AId));
				p = new PageUtils<Enlist>(UserBaomlist1, page, 10);
				List<Enlist> UserBaomlist = p.getPageList();
				request.getSession().setAttribute("UserBaomlist", UserBaomlist);// 当前页报名表列表
				request.getSession().setAttribute("currentPage", p.getCurrentPage());// 当前页
				request.getSession().setAttribute("totalPage", p.getTotalPage());// 总页数
				System.out.println("当前页：" + p.getCurrentPage() + "当前页的活动列表" + UserBaomlist + "总页数" + p.getTotalPage());
				System.out.println(UserBaomlist.toString());
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_baomActUserlist.jsp");

			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	// 组织通过活动取得报名该活动的集合 组织通过志愿者报名的活动 参与确认
	public void orgUserisJoinAct(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获取项目名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			try {
				String AId = request.getParameter("AId");// 从页面传来当前活动id
				String UId = request.getParameter("UId");
				int i = 0;
				String isJoin = request.getParameter("isJoin");
				if (isJoin.equals("Pass")) {
					// 组织确认用户参加活动 添加活动服务时长和积分到志愿者信息
					i = FactoryDao.getIEnlistDaoInstance().PassUserJoin(Integer.parseInt(AId), Integer.parseInt(UId));
					Activity activity = FactoryDao.getIActivityDaoInstance().getActmsg(Integer.parseInt(AId));
					// 活动服务时长
					// 活动积分
					System.out.println("确认参与i为" + i);
					if (i != 0) {
						System.out.println("当前参加的活动信息11111" + activity);
						int j = FactoryDao.getUserDaoInstance().addUserInHours(activity.getAHours(),
								activity.getAIntegral(), Integer.parseInt(UId));
						System.out.println(j + "执行用户积分累加次数+111111111111111");
					}
				} else if (isJoin.equals("notPass")) {
					// 组织确认用户未参加活动
					i = FactoryDao.getIEnlistDaoInstance().notPassUserJoin(Integer.parseInt(AId),
							Integer.parseInt(UId));

				}

				int page = (int) request.getSession().getAttribute("currentPage");
				PageUtils<Enlist> p = null;
				List<Enlist> UserBaomlist1 = FactoryDao.getIEnlistDaoInstance().getUserBaommsg(Integer.parseInt(AId));
				p = new PageUtils<Enlist>(UserBaomlist1, page, 10);
				List<Enlist> UserBaomlist = p.getPageList();

				request.getSession().setAttribute("UserBaomlist", UserBaomlist);// 当前页报名表列表
				request.getSession().setAttribute("currentPage", p.getCurrentPage());// 当前页
				request.getSession().setAttribute("totalPage", p.getTotalPage());// 总页数
				System.out.println("当前页：" + p.getCurrentPage() + "当前页的活动列表" + UserBaomlist + "总页数" + p.getTotalPage());
				System.out.println(UserBaomlist.toString());
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_baomActUserlist.jsp");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// 组织通过活动取得参加该活动的集合 组织通过志愿者参加的活动 评价志愿者
	public void orgActisPingJUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获取项目名
		Organize organize = (Organize) request.getSession().getAttribute("organize");
		if (organize == null) {
			response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
			response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
		} else {
			try {
				String AId = request.getParameter("AId");// 从页面传来当前活动id
				String UId = request.getParameter("UId");

				int i = -1;
				String isPingJ = request.getParameter("isPingJ");
				if (isPingJ.equals("Good")) {
					// 组织评价志愿者 好评 志愿者信誉度加1 如果志愿者信誉度大于等于6或者信誉度为0就不进行增加
					// 1.好评修改状态 已好评
					i = FactoryDao.getIEnlistDaoInstance().PingJUserGood(Integer.parseInt(AId), Integer.parseInt(UId));
					System.out.println("好评添加信誉值i为" + i);
					if (i != 0) {
						User user = FactoryDao.getUserDaoInstance().getUserbyUId(Integer.parseInt(UId));

						int UCredit = CommonUtils.addCredit(user.getUCredit());// 志愿者信誉值传入工具类计算信誉值

						int f = FactoryDao.getUserDaoInstance().updUCredit(UCredit, user.getUId());// 修改信誉值
						System.out.println("好评添加信誉值为-----------" + UCredit);
					}

				} else if (isPingJ.equals("notGood")) {
					// 组织评价志愿者 差评 志愿者信誉度减2 如果志愿者信誉度小于等于0就限制志愿者登录
					// 1.差评修改状态 已差评
					i = FactoryDao.getIEnlistDaoInstance().PingJUserNotGood(Integer.parseInt(AId),
							Integer.parseInt(UId));
					System.out.println("ca拼添加信誉值i为" + i);
					if (i != 0) {
						User user = FactoryDao.getUserDaoInstance().getUserbyUId(Integer.parseInt(UId));
						Activity act = FactoryDao.getIActivityDaoInstance().getActmsg(Integer.parseInt(AId));
						int UCredit = CommonUtils.subCredit(user.getUCredit());// 志愿者信誉值传入工具类计算信誉值
						int f = FactoryDao.getUserDaoInstance().updUCredit(UCredit, user.getUId());// 修改信誉值
						if (UCredit < 1) {
							// 信誉值小于一进行限制志愿者登录
							int xianz = FactoryDao.getUserDaoInstance().XianZUser(user.getUId());
							System.out.println("执行志愿者限制登录！！！");
						}
						mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress,
								user.getUEmail(), Constant.Act_UserCaPing, "<br/>尊敬的i志愿用户：<br/>您在“" + act.getAName()
										+ "”志愿者活动中表现不佳已被差评，请积极参与志愿活动，注意信誉分值过低时您将无法使用i志愿");
						// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
						EmailUtils.getTransport(session, mimeMessage);
						System.out.println("差评发送邮件减少信誉值为-----------" + UCredit);
					}

				} else if (isPingJ.equals("Common")) {
					// 组织评价志愿者 中评 修改评价标志
					// 1.中评修改状态 已中评
					i = FactoryDao.getIEnlistDaoInstance().PingJUserCom(Integer.parseInt(AId), Integer.parseInt(UId));
					System.out.println("中评修改评价状态");
				}

				int page = (int) request.getSession().getAttribute("currentPage");
				PageUtils<Enlist> p = null;
				List<Enlist> UserBaomlist1 = FactoryDao.getIEnlistDaoInstance().getUserBaommsg(Integer.parseInt(AId));
				p = new PageUtils<Enlist>(UserBaomlist1, page, 10);
				List<Enlist> UserBaomlist = p.getPageList();

				request.getSession().setAttribute("UserBaomlist", UserBaomlist);// 当前页报名表列表
				request.getSession().setAttribute("currentPage", p.getCurrentPage());// 当前页
				request.getSession().setAttribute("totalPage", p.getTotalPage());// 总页数
				System.out.println("当前页：" + p.getCurrentPage() + "当前页的活动列表" + UserBaomlist + "总页数" + p.getTotalPage());

				System.out.println(UserBaomlist.toString());

				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_act_baomActUserlist.jsp");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
