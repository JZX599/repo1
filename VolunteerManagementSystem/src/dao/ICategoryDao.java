package dao;

import java.sql.SQLException;
import java.util.List;

import daomain.Category;


public interface ICategoryDao {

	
	//查询所有分类
	public List<Category> getAllCate() throws SQLException;

	//查询对应活动分类信息 使用多表联查   select category.* from activity, category where activity.CId=category.CId AND activity.AId=90
	public Category getCatebyAId(int AId)throws SQLException;

	
	//通过分类名称查询分类是否存在 select * from category where CName='法律咨询'
	public Category getCateByCName(String CName)throws SQLException;

	//通过页面传值进行添加分类 INSERT INTO category (CName) VALUES ('哈哈')
	public int addCate(Category c)throws SQLException;
	//通过页面传值进行修改分类 UPDATE category SET CName='666' WHERE  CId=18 
	public int updCate(Category c)throws SQLException;
	//通过页面传分类id进行删除分类 delete from category where CId=17
	public int delCate(int CId)throws SQLException;
	
	
}
