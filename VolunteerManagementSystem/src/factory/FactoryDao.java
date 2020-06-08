package factory;


import dao.IActivityDao;
import dao.IAdminDao;
import dao.ICategoryDao;
import dao.IEnlistDao;
import dao.IOrganizeDao;
import dao.IUserDao;
import dao.impl.IActivityDaoImpl;
import dao.impl.IAdminDaoImpl;
import dao.impl.ICategoryDaoImpl;
import dao.impl.IEnlistDaoImpl;
import dao.impl.IOrganizeDaoImpl;
import dao.impl.IUserDaoImpl;

public class FactoryDao {
	
	//志愿者用户表
	public static IUserDao getUserDaoInstance() {
		return new IUserDaoImpl();
	}
	
	//管理员表
	public static IAdminDao getIAdminDaoInstance() {
		return new IAdminDaoImpl();
	}
	//组织表
	public static IOrganizeDao getIOrganizeDaoInstance() {
		return new IOrganizeDaoImpl();
	}
	//活动表
	public static IActivityDao getIActivityDaoInstance() {
		return new IActivityDaoImpl();
	}
	//报名表
	public static IEnlistDao getIEnlistDaoInstance() {
		return new IEnlistDaoImpl();
	}
	
	//分类表
		public static ICategoryDao getICategoryDaoInstance() {
			return new ICategoryDaoImpl();
		}
}
