package dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import dao.IEnlistDao;
import daomain.Activity;
import daomain.Enlist;
import daomain.User;
import util.JDBCUtil;
//报名表 实现类
public class IEnlistDaoImpl implements IEnlistDao {

	QueryRunner qr = new QueryRunner(JDBCUtil.getDataSource());
	String sql=null;
	@Override//查询活动报名表信息   活动报名总人数    通过活动id查询 AND EState<>3表示查询活动报名状态已报名人数  状态3为取消报名
	public Long getEBaomcountbyAId(int AId) throws SQLException {
		sql="SELECT COUNT(*) AS EBaom FROM enlist WHERE AId=? AND EState<>3";
		return (Long) qr.query(sql, new ScalarHandler(),AId);
	}

	@Override//活动报名通过总人数  通过活动id查询
	public Long getETongcountbyAId(int AId) throws SQLException {
		sql="SELECT COUNT(*) AS ETong FROM enlist WHERE AId=? AND EState=1";
		return (Long) qr.query(sql, new ScalarHandler(),AId);
	}

	@Override////添加志愿者报名信息   通过活动id和志愿者id （报名表id设置自动增长   报名状态默认已报名0  参加状态默认未参加0）
	public int addBaommsg(int AId, int UId) throws SQLException {
		sql="INSERT INTO enlist (AId,UId) VALUES (?,?)";
		return qr.update(sql,AId,UId);
	}

	@Override//先判断该用户是否已经当前报名活动select * from enlist where AId=35 AND UId = 1
	public Enlist isUserBaom(int AId, int UId) throws SQLException {
		sql="select * from enlist where AId=? AND UId = ?";
		return qr.query(sql, new BeanHandler<Enlist>(Enlist.class),AId,UId);
	}

	@Override//获取用户报名表信息   志愿者用户集合SELECT  SELECT UName,USex,UPhone,UCredit,UHours,enlist.* FROM enlist ,activity ,user WHERE enlist.AId=activity.AId AND  enlist.UId = user.UId  AND enlist.AId =612 AND EState<>3
	public List<Enlist> getUserBaommsg(int AId) throws SQLException {
		
		sql="SELECT UName,USex,UPhone,UCredit,UHours,enlist.* FROM enlist ,activity ,user WHERE enlist.AId=activity.AId AND  enlist.UId = user.UId  AND enlist.AId =? AND EState<>3";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),AId);
	}

	@Override//获取用户报名表信息   志愿者用户通过活动的集合
	public List<Enlist> getUserBaomPassmsg(int AId) throws SQLException {
		sql="SELECT  UName,USex,UPhone,UCredit,UHours,enlist.* FROM enlist ,activity ,user WHERE enlist.AId=activity.AId AND  enlist.UId = user.UId  AND enlist.EState=1 AND enlist.AId =?";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),AId);
	}

	@Override//组织确认录用志愿者
	public int PassUserBaom(int AId, int UId) throws SQLException {
		sql="UPDATE enlist SET EState=1 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
	}
	
	
	@Override//组织拒绝录用志愿者
	public int notPassUserBaom(int AId, int UId)throws SQLException {
		sql="UPDATE enlist SET EState=2 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
	}

	@Override//确认参与
	public int PassUserJoin(int AId, int UId) throws SQLException {
		sql="UPDATE enlist SET EFlag=1 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
		
	}

	@Override//确认未参与
	public int notPassUserJoin(int AId, int UId) throws SQLException {
		sql="UPDATE enlist SET EFlag=2 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
	}
///////////////////////////////////志愿者////////////////////////////////////////////////////
	
	@Override//志愿者获取报名活动信息
	public List<Enlist> getBaomListbyUId(int UId) throws SQLException {
		sql="SELECT enlist.*,AName,AStartDate,AEndDate,AAddress,AHours FROM enlist,activity WHERE enlist.AId = activity.AId AND enlist.UId = ?";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),UId);
	}

	@Override
	public List<Enlist> getEnmsgbyUIdAName(int UId, String AName) throws SQLException {
		sql="SELECT enlist.*,AName,AStartDate,AEndDate,AAddress,AHours FROM enlist,activity WHERE enlist.AId = activity.AId AND enlist.UId = ? AND AName LIKE ?";
		
		AName="%"+AName+"%";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),UId,AName);
	}

	@Override//通过用户id得到用户参加活动表	
	public List<Enlist> getCanActList(int UId) throws SQLException {
		sql="SELECT enlist.*,AName,AAddress,AHours,AIntegral,organize.OId,organize.OName FROM enlist,activity,organize WHERE enlist.AId = activity.AId AND activity.OId=organize.OId AND enlist.UId = ? AND EState=1";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),UId);
	}

	@Override
	public List<Enlist> getCanActListbyType(int uId, String type, String value) throws SQLException {
		sql="SELECT enlist.*,AName,AAddress,AHours,AIntegral,organize.OId,organize.OName FROM enlist,activity,organize WHERE enlist.AId = activity.AId AND activity.OId=organize.OId AND enlist.UId = ? AND EState=1 AND "+type+" LIKE ?";
		value="%"+value+"%";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),uId,value);
	}

	
	@Override//好评
	public int PingJUserGood(int AId, int UId) throws SQLException {
		sql="UPDATE enlist SET EAssess=1 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
		
	}

	@Override//差评
	public int PingJUserNotGood(int AId, int UId) throws SQLException {
		sql="UPDATE enlist SET EAssess=2 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
	}

	@Override//中评
	public int PingJUserCom(int AId, int UId) throws SQLException {
		sql="UPDATE enlist SET EAssess=3 WHERE AId =? AND UId=?";
		return qr.update(sql,AId,UId);
	}

	@Override//志愿者取消报名活动
	public int userQXBaom(int UId, int AId) throws SQLException {
		sql="UPDATE enlist SET enlist.EState=3  WHERE enlist.AId=? AND enlist.UId=?";
		return qr.update(sql,AId,UId);
	}
	
	
	
	/*@Override//通过用户id得到用户报名表	
	public List<Enlist> getbaomListbyUId(int UId) throws SQLException {
		sql="SELECT * from enlist where UId=?";
		return qr.query(sql, new BeanListHandler<Enlist>(Enlist.class),UId);
	}

	@Override
	public Activity byEIdgetAct(int eId) throws SQLException {
		sql="select activity.* from enlist ,activity where enlist.AId=activity.AId AND EId=?";
		return qr.query(sql, new BeanHandler<Activity>(Activity.class),eId);
	}*/
	

	
	
}
