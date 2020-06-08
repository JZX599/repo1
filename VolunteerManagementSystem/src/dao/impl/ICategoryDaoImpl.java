package dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import dao.ICategoryDao;
import daomain.Category;

import util.JDBCUtil;

public class ICategoryDaoImpl implements ICategoryDao {

	
	QueryRunner qr = new QueryRunner(JDBCUtil.getDataSource());
	private String sql = null;
	
	@Override//获取所有分类信息
	public List<Category> getAllCate() throws SQLException {
		sql="select * from category";
		return qr.query(sql, new BeanListHandler<Category>(Category.class));
	}

	@Override//通过活动获取单个分类信息
	public Category getCatebyAId(int AId) throws SQLException {
		sql="select category.* from activity, category where activity.CId=category.CId AND activity.AId=?";
		return qr.query(sql, new BeanHandler<Category>(Category.class),AId);
	}

	//通过分类名称查询分类是否存在
	@Override
	public Category getCateByCName(String CName) throws SQLException {
		sql="select * from category where CName=?";
		return qr.query(sql, new BeanHandler<Category>(Category.class),CName);
	}

	@Override	//通过页面传值进行添加分类 
	public int addCate(Category c) throws SQLException {
		sql="INSERT INTO category (CName) VALUES (?)";
		return qr.update(sql,c.getCName());
	}

	@Override//通过页面传值进行修改分类 
	public int updCate(Category c) throws SQLException {
		sql="UPDATE category SET CName=? WHERE  CId=? ";
		return qr.update(sql,c.getCName(),c.getCId());
	}

	@Override//通过页面传分类id进行删除分类
	public int delCate(int CId) throws SQLException {
		sql="delete from category where CId=?";
		return qr.update(sql,CId);
	}

}
