package dao;

import java.sql.SQLException;
import java.util.List;

import daomain.Activity;
import daomain.Enlist;
import daomain.User;

//报名表  接口
public interface IEnlistDao {
	//查询活动报名表信息   活动报名总人数    通过活动id查询  SELECT COUNT(*) AS EBaom FROM enlist WHERE AId=18 AND EState=1
	public Long getEBaomcountbyAId(int AId)throws SQLException;
//活动报名通过总人数  通过活动id查询 SELECT COUNT(*) AS EBaom FROM enlist WHERE AId=19 AND EState=77
	public Long getETongcountbyAId(int AId)throws SQLException;
	
	
	//添加志愿者报名信息   通过活动id和志愿者id
	public int addBaommsg(int AId, int UId)throws SQLException;
	//先判断该用户是否已经当前报名活动select * from enlist where AId=35 AND UId = 1
	public Enlist isUserBaom(int AId, int UId)throws SQLException;
	
	
	//获取用户报名表信息   志愿者用户集合
	// SELECT   UName,USex,UPhone,enlist.* FROM enlist ,activity ,user WHERE enlist.AId=activity.AId AND  enlist.UId = `user`.UId  AND enlist.AId =556
	public List<Enlist> getUserBaommsg( int AId)throws SQLException;
	
	
	//获取用户报名表信息   志愿者用户通过活动的集合
	//SELECT  UName,USex,UPhone,enlist.* FROM enlist ,activity ,user WHERE enlist.AId=activity.AId AND  enlist.UId = `user`.UId  AND enlist.EState=1 AND enlist.AId =556 
	public List<Enlist> getUserBaomPassmsg( int AId)throws SQLException;
	
	
	
	/*------------------------组织方---------------------------*/
	//五个状态   录用  拒绝录用   取消录用   参与确认   未参与确认
	
	//组织确认录用志愿者  UPDATE enlist SET EState=1 WHERE AId =557 AND UId=1
	// 录用
	public int PassUserBaom(int AId, int UId)throws SQLException;
	// 拒绝录用
	public int notPassUserBaom(int AId, int UId)throws SQLException;
	
	//确认参与
	public int PassUserJoin(int AId, int UId)throws SQLException;
	//确认未参与
	public int notPassUserJoin(int AId, int UId)throws SQLException;
	
	////////////////志愿者///////////////////////////志愿者///////////////
	
	
	
	//通过用户id得到用户报名表	SELECT enlist.*,AName,AStartDate,AEndDate,ACity,ACounty,AHours FROM enlist,activity WHERE enlist.AId = activity.AId AND enlist.UId = 5 
	public List<Enlist> getBaomListbyUId(int UId)throws SQLException;
	
	/*//通过用户id得到用户报名表
	public List<Enlist> getbaomListbyUId(int UId)throws SQLException;*/
	
	//通过用户id得到用户参加活动表	
	public List<Enlist> getCanActList(int UId)throws SQLException;
	//模糊搜索 通过用户id和活动名模糊搜索活动报名表信息SELECT enlist.*,AName,AStartDate,AEndDate,ACity,ACounty,AHours FROM enlist,activity WHERE enlist.AId = activity.AId AND enlist.UId = 5 AND AName LIKE '%海%'
	public List<Enlist> getEnmsgbyUIdAName(int UId, String AName)throws SQLException;
	/*//通过报名表id得到活动信息
	public Activity byEIdgetAct(int eId)throws SQLException;*/
	
	//通过查询类型值查询活动参加列表
	public List<Enlist> getCanActListbyType(int uId, String type, String value)throws SQLException;
	//组织通过活动参与评价志愿者  好评
	public int PingJUserGood(int AId, int UId)throws SQLException;
	//组织通过活动参与评价志愿者  差评
	public int PingJUserNotGood(int AId, int UId)throws SQLException;
	//组织通过活动参与评价志愿者  中评
	public int PingJUserCom(int AId, int UId)throws SQLException;
	
	//志愿者取消报名活动UPDATE enlist SET enlist.EState=3  WHERE enlist.AId=611 AND enlist.UId=1
	public int userQXBaom( int UId,int AId)throws SQLException;
	
	
	
	
	////////////////志愿者///////////////////////////志愿者///////////////
	
}
