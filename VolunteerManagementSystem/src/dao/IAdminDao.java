package dao;

import java.sql.SQLException;
import java.util.List;

import daomain.Admin;
//管理员接口
public interface IAdminDao {
	/*管理员登录*/
	public Admin login(Admin admin) throws SQLException;
	/*管理员信息修改*/
	public int updAdmin(Admin admin)throws Exception;
	//管理员获取所有管理员列表
	public List<Admin> getAdminList()throws Exception;
	//管理员模糊查询类型值获取所有管理员列表select * from admin where AId like '%1%'
	public List<Admin> getAdminListByTypeValue(String type, String value)throws Exception;
	//添加普通管理员
	public int addAdmin(Admin admin)throws Exception;
	//删除管理员
	public int delAdmin(int AId)throws Exception;
	// 设置超级管理员
	public int upSadmin(int AId)throws Exception;
	// 设置普通管理员
	public int dropSadmin(int AId)throws Exception;
	
	
}
