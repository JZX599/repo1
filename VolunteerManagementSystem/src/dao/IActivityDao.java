package dao;

import java.sql.SQLException;
import java.util.List;

import daomain.Activity;
import daomain.PageBean;

public interface IActivityDao {
	/*INSERT INTO activity (AName,OId,AStartDate,AEndDate,AAddress,APerson,APhone,AEstimate,AIntegral,ASynopsis)
	 * 
	 *VALUES('ww',1,'2020-03-19 13:41:43','2020-03-19 13:41:43','福建','江智鑫','186','33','22','')*/
		
	//组织添加活动
	public int orgAddAct(Activity activity, int OId) throws SQLException;
	
	
	/*SELECT * FROM activity WHERE OId=1*/
	//获取活动列表
	public List<Activity> getAllActs(int OId) throws SQLException;
	
	//获取组织对应的活动总记录数  long类型     select count(*) from activity where OId=1
	public Long getActOrgCount(int OId) throws SQLException;
	
	
	
	//通过设置每页展示数据查询每页的活动集合  条件1组织id  2每页展示记录数
	//SELECT * FROM activity  WHERE OId =2 LIMIT 0,3组织    必须要插入3个参数
	//SELECT * FROM activity LIMIT 0,3管理员  必须要插入2个参数
	//1.一个组织id （通过组织id查询组织对应的活动列表）  2.一个角标（通过查询总记录数减一乘以传入的页面展示多少数据） 3.一个页面展示多少数据
	public List<Activity> getOrgPageDate(int OId,int Index,int PageCount) throws SQLException;

//通过活动id获取活动信息
	public Activity getActByAId(int AId,int OId)throws SQLException;
	
	
	//通过活动名称模糊查询得到活动列表 SELECT * FROM activity WHERE AName LIKE '%1%'  
	public List<Activity> getActListbyAname(int OId ,String AName) throws SQLException;

	
	//组织更新活动
	//UPDATE activity SET AName='爱心早餐',AStartDate='2020-03-24 15:35:20',AEndDate='2020-03-26 15:35:20',AAddress='福建厦门',
	//APerson='江智鑫',APhone='186',AEstimate=5,AIntegral=6,ASynopsis='哈哈' WHERE  AId=111 AND OId=2
		public int orgUpdAct(Activity activity, int OId) throws SQLException;

//组织删除活动 delete from activity where AId=89 and OId = 1
		public int orgDelAct(int AId, int OId)throws SQLException;

/////////////////////////////////// 首页实现//////////////////////////////////////////////////////////////////////////////
		//得到所有活动信息
		public List<Activity> getAllActList()throws SQLException;


		//首页通过活动id得到所有活动信息
		public Activity getActmsg(int AId)throws  SQLException;


		//通过活动类型与值模糊搜索活动列表 
		//SELECT * FROM activity WHERE AName LIKE '%毒%' 
		public List<Activity> searchAct(String type, String value)throws  SQLException;
	
}
