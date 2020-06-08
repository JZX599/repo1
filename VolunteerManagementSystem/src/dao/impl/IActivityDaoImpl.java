package dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import dao.IActivityDao;
import daomain.Activity;
import util.JDBCUtil;

public class IActivityDaoImpl implements IActivityDao {

	QueryRunner qr = new QueryRunner(JDBCUtil.getDataSource());
	private String sql = null;

	// 组织添加活动 不添加活动id让它自动增长
	@Override
	public int orgAddAct(Activity a, int OId) throws SQLException {

		sql = "INSERT INTO activity (AName,OId,AStartDate,AEndDate,APerson,APhone,AEstimate,AIntegral,ASynopsis,AAddress,AHours,AKzTime,CId) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		return qr.update(sql, a.getAName(), OId, a.getAStartDate(), a.getAEndDate(), a.getAPerson(),
				a.getAPhone(), a.getAEstimate(), a.getAIntegral(), a.getASynopsis(),a.getAAddress(),a.getAHours(),a.getAKzTime(),a.getCId());
	}

	@Override // 获取活动列表
	public List<Activity> getAllActs(int OId) throws SQLException {
		sql="SELECT * FROM activity WHERE OId=?";
		return  qr.query(sql,new BeanListHandler<Activity>(Activity.class),OId);
	}

	@Override//获取组织对应的活动总记录数
	public Long getActOrgCount(int OId) throws SQLException {
		sql="select count(*) from activity where OId=?";
		Long OrgActCount =(Long) qr.query(sql, new ScalarHandler(),OId);
		return OrgActCount;
	}

	
	
	//分页查询组织对应活动的每页活动列表
	@Override
	public List<Activity> getOrgPageDate(int OId, int Index, int PageCount) throws SQLException {
			sql="SELECT * FROM activity  WHERE OId =? LIMIT ?,?";
		return qr.query(sql, new BeanListHandler<Activity>(Activity.class),OId,Index,PageCount);
	}

	@Override////通过活动id 和组织id获取组织对应的活动信息
	public Activity getActByAId(int AId,int OId) throws SQLException {
		sql="select * from activity where AId=? and OId=?";
		return qr.query(sql, new BeanHandler<Activity>(Activity.class),AId,OId);
	}

	@Override//通过活动名称模糊查询活动列表 组织
	public List<Activity> getActListbyAname(int OId,String AName) throws SQLException {
		sql="SELECT * FROM activity WHERE OId=? AND AName LIKE ?";
		AName="%"+AName+"%";
		return qr.query(sql, new BeanListHandler<Activity>(Activity.class),OId,AName);
	}

	@Override	//组织更新活动
	public int orgUpdAct(Activity a, int OId) throws SQLException {
		sql="UPDATE activity SET AName=?,AStartDate=?,AEndDate=?,APerson=?,APhone=?,AEstimate=?,AIntegral=?,ASynopsis=?,AAddress=?,AHours=?,AKzTime=? ,CId=? WHERE  AId=? AND OId=? ";
		return qr.update(sql,a.getAName(),a.getAStartDate(),a.getAEndDate(),a.getAPerson(),a.getAPhone(),a.getAEstimate(),a.getAIntegral(),a.getASynopsis(),a.getAAddress(),a.getAHours(),a.getAKzTime(),a.getCId(),a.getAId(),OId);
	}

	@Override//组织删除活动 
	public int orgDelAct(int AId, int OId) throws SQLException {
		sql="delete from activity where AId=? and OId =?";
		return qr.update(sql,AId,OId);
	}
////////////////////////////////////首页实现////////////////////////////////////////////////////////////////////////////
	@Override//获取所有活动
	public List<Activity> getAllActList() throws SQLException {
		sql="select * from activity";
		return qr.query(sql, new BeanListHandler<Activity>(Activity.class));
	}

	@Override//首页通过活动id得到所有活动信息
	public Activity getActmsg(int AId) throws SQLException {
		sql="select * from activity where AId=?";
		return qr.query(sql, new BeanHandler<Activity>(Activity.class),AId);
	}

	@Override
	public List<Activity> searchAct(String type, String value) throws SQLException {
		sql="SELECT * FROM activity WHERE "+type+" LIKE ?";
		value="%"+value+"%";
		return qr.query(sql, new BeanListHandler<Activity>(Activity.class),value);
	}

}
