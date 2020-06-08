package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daomain.Activity;
import daomain.Category;
import daomain.Organize;
import factory.FactoryDao;
import test.page;
import util.CommonUtils;
import util.Constant;
import util.PageUtils;

/**
 * 主页IndexServlet
 */
@WebServlet("/IndexServlet")
public class IndexServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;
	String contextPath = "";

	// 首页的最新活动
	public void getAllActList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			List<Activity> alist = FactoryDao.getIActivityDaoInstance().getAllActList();
			Collections.reverse(alist);// 集合反转
			String newtime = CommonUtils.getDatetime();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (Activity a : alist) {
				Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(a.getAId());
				if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
					a.setAState(Constant.Act_State_Pass);
				} else if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
						&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
					a.setAState(Constant.Act_State_GoDoing);
				} else {
					a.setAState(Constant.Act_State_End);
				}
				a.setOrganize(o);
			}

			request.getSession().setAttribute("IndexActList", alist);
			response.setHeader("refresh", "0;url=" + contextPath + "/index.jsp");

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	// 首页的活动查询
	public void getAllPageActList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("执行到我了2");
			List<Activity> allact = new ArrayList();
			List<Activity> act = new ArrayList();
			String currentPage = request.getParameter("page");// 当前页
			String type = request.getParameter("type");// 选择查询类型
			String value = request.getParameter("txtSearch");// 查询的文本内容
			if (currentPage == null) {
				currentPage = "1";
			}

			if (value == null) {
				value = (String) request.getSession().getAttribute("value");
			}

			if (type == null) {
				type = (String) request.getSession().getAttribute("type");
			}
			String newtime = CommonUtils.getDatetime();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			System.out.println("page" + currentPage + "当前值" + value + "当前类型" + type);

			if (type.equals("AName") || type.equals("AAddress")) {
				System.out.println("执行到我了1");
				allact = FactoryDao.getIActivityDaoInstance().searchAct(type, value);
				for (Activity a : allact) {
					Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(a.getAId());
					if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
						a.setAState(Constant.Act_State_Pass);
					} else if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
							&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
						a.setAState(Constant.Act_State_GoDoing);
					} else {
						a.setAState(Constant.Act_State_End);
					}
					a.setOrganize(o);
					act.add(a);
				}
				System.out.println(act.toString());
			} else {
				System.out.println("执行到我了2");
				allact = FactoryDao.getIActivityDaoInstance().getAllActList();
			}

			if (type.equals("showAll")) {

				for (Activity a : allact) {
					Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(a.getAId());
					if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
						a.setAState(Constant.Act_State_Pass);
					} else if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
							&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
						a.setAState(Constant.Act_State_GoDoing);
					} else {
						a.setAState(Constant.Act_State_End);
					}
					a.setOrganize(o);
					act.add(a);
				}
				System.out.println("全部活动" + act.toString());
			} else if (type.equals("end")) {
				for (Activity a : allact) {

					if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAEndDate()))) {
						a.setAState(Constant.Act_State_End);
						Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(a.getAId());
						a.setOrganize(o);
						act.add(a);
					}

				}
				System.out.println("已结束活动" + act.toString());
			} else if (type.equals("pass")) {
				for (Activity a : allact) {

					if (dateFormat.parse(newtime).before(dateFormat.parse(a.getAStartDate()))) {
						a.setAState(Constant.Act_State_Pass);
						Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(a.getAId());
						a.setOrganize(o);
						act.add(a);
					}

				}
				System.out.println("招募中活动" + act.toString());
			} else if (type.equals("godoing")) {

				for (Activity a : allact) {

					if (dateFormat.parse(newtime).after(dateFormat.parse(a.getAStartDate()))
							&& dateFormat.parse(newtime).before(dateFormat.parse(a.getAEndDate()))) {
						a.setAState(Constant.Act_State_GoDoing);
						Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(a.getAId());
						a.setOrganize(o);
						act.add(a);

					}
				}
				System.out.println("进行中活动" + act.toString());
			}

			Collections.reverse(act);// 集合反转
			PageUtils<Activity> p = new PageUtils<Activity>(act, Integer.parseInt(currentPage), 9);// act为要分页的活动对象列表
																									// 9为每页展示数据
			List<Activity> ActpageList = p.getPageList();
			request.getSession().setAttribute("type", type);// 选择查询类型
			request.getSession().setAttribute("value", value);// 文本框输入内容
			request.getSession().setAttribute("IndexPageActList", ActpageList);
			request.getSession().setAttribute("currentPage", p.getCurrentPage());
			request.getSession().setAttribute("totalPages", p.getTotalPage());
			response.setHeader("refresh", "0;url=" + contextPath + "/act_list.jsp");

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	// 得到活动信息详情
	public void getActInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			String AId = request.getParameter("AId");
			Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyAId(Integer.parseInt(AId));
			Category c = FactoryDao.getICategoryDaoInstance().getCatebyAId(Integer.parseInt(AId));
			Activity indexActInfo = FactoryDao.getIActivityDaoInstance().getActmsg(Integer.parseInt(AId));
			// 设置活动状态 通过活动开始时间和结束时间
			String newtime = CommonUtils.getDatetime();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (dateFormat.parse(newtime).before(dateFormat.parse(indexActInfo.getAStartDate()))) {
				indexActInfo.setAState(Constant.Act_State_Pass);
			} else if (dateFormat.parse(newtime).after(dateFormat.parse(indexActInfo.getAStartDate()))
					&& dateFormat.parse(newtime).before(dateFormat.parse(indexActInfo.getAEndDate()))) {
				indexActInfo.setAState(Constant.Act_State_GoDoing);
			} else {
				indexActInfo.setAState(Constant.Act_State_End);
			}
			indexActInfo.setOrganize(o);
			indexActInfo.setCategory(c);
			// 查询活动报名表信息 活动报名总人数 活动报名通过总人数
			int indexEBaom = FactoryDao.getIEnlistDaoInstance().getEBaomcountbyAId(Integer.parseInt(AId)).intValue();
			int indexETong = FactoryDao.getIEnlistDaoInstance().getETongcountbyAId(Integer.parseInt(AId)).intValue();
			request.getSession().setAttribute("indexEBaom", indexEBaom);
			request.getSession().setAttribute("indexETong", indexETong);
			request.getSession().setAttribute("indexActInfo", indexActInfo);
			System.out.println("s首页活动详情的活动信息" + indexActInfo);
			request.getRequestDispatcher("/act_info.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 首页组织列表
	public void getAllPageOrgList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			List<Organize> indexOrgList = new ArrayList();

			String currentPage = request.getParameter("page");// 当前页
			String type = request.getParameter("type");// 选择查询类型
			String value = request.getParameter("txtSearch");// 查询的文本内容

			if (currentPage == null) {
				currentPage = "1";
			}

			if (value == null) {
				value = (String) request.getSession().getAttribute("value");
			}

			if (type == null) {
				type = (String) request.getSession().getAttribute("type");
			}

			if (type.equals("showAll")) {
				indexOrgList = FactoryDao.getIOrganizeDaoInstance().getIndexOrgList();
			} else {

				indexOrgList = FactoryDao.getIOrganizeDaoInstance().getIndexOrgListbyTypeValue(type, value);
			}

			PageUtils<Organize> p = new PageUtils<Organize>(indexOrgList, Integer.parseInt(currentPage), 9);
			List<Organize> OrgpageList = p.getPageList();
			request.getSession().setAttribute("type", type);// 选择查询类型
			request.getSession().setAttribute("value", value);// 文本框输入内容
			request.getSession().setAttribute("OrgpageList", OrgpageList);
			request.getSession().setAttribute("currentPage", p.getCurrentPage());
			request.getSession().setAttribute("totalPages", p.getTotalPage());
			System.out.println("page" + currentPage + "当前值" + value + "当前类型" + type);
			System.out.println("主页组织列表" + indexOrgList.toString() + "当前组织列表" + OrgpageList + "当前页" + p.getCurrentPage()
					+ "总页数" + p.getTotalPage());
			response.setHeader("refresh", "0;url=" + contextPath + "/org_list.jsp");

		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 首页组织详情

	public void getOrgInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			String OId = request.getParameter("OId");
			Organize indexorg = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(Integer.parseInt(OId));
			int orgactnum = FactoryDao.getIActivityDaoInstance().getActOrgCount(Integer.parseInt(OId)).intValue();

			request.getSession().setAttribute("indexorg", indexorg);
			request.getSession().setAttribute("orgactnum", orgactnum);

			response.setHeader("refresh", "0;url=" + contextPath + "/org_info.jsp");
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

}
