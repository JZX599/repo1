package dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import dao.IAdminDao;
import daomain.Admin;
import util.JDBCUtil;


//管理员  实现类
public class IAdminDaoImpl implements IAdminDao{

	QueryRunner qr = new QueryRunner(JDBCUtil.getDataSource());
	private String sql=null;
//	登录
	@Override
	public Admin login(Admin admin) throws SQLException {
		// TODO Auto-generated method stub
		sql="select * from admin where AId=? and APwd=?";
		return qr.query(sql, new BeanHandler<Admin>(Admin.class),admin.getAId(),admin.getAPwd());
		
	}
//修改信息 UPDATE admin SET AName='超级管理员1', APwd='666666' WHERE AId=1
	@Override
	public int updAdmin(Admin admin) throws Exception {
		sql=" UPDATE admin SET AName=?, APwd=? WHERE AId=?";
		return qr.update(sql,admin.getAName(),admin.getAPwd(),admin.getAId());
	}
	
	@Override//管理员获取所有管理员信息列表
	public List<Admin> getAdminList() throws Exception {
		sql="select * from admin";
		return qr.query(sql,new BeanListHandler<Admin>(Admin.class));
	}
	@Override//	管理员模糊查询类型值获取所有管理员列表select * from admin where AId like '%1%'
	public List<Admin> getAdminListByTypeValue(String type, String value) throws Exception {
		sql="select * from admin where "+type+" like ?";
		value="%"+value+"%";
		return qr.query(sql,new BeanListHandler<Admin>(Admin.class),value);
	}
	@Override//添加管理员
	public int addAdmin(Admin admin) throws Exception {
		sql="INSERT INTO admin (AName,APwd) VALUES (?,?)";
		return qr.update(sql,admin.getAName(),admin.getAPwd());
	}
	@Override//删除管理员
	public int delAdmin(int AId) throws Exception {
		sql="delete  from admin where AId=?";
		return qr.update(sql,AId);
	}
	@Override // 设置超级管理员
	public int upSadmin(int AId) throws Exception {
		sql="update admin set APower =1 where AId=?";
		return qr.update(sql,AId);
	}
	@Override // 设置普通管理员
	public int dropSadmin(int AId) throws Exception {
		sql="update admin set APower =0 where AId=?";
		return qr.update(sql,AId);
	}
	

	
	
	
	
}
