package dao;

import java.sql.SQLException;
import java.util.List;

import daomain.Organize;
import daomain.User;


//用户接口
public interface IUserDao {
//添加用户
	public int addUser(User user)throws SQLException;
	
	//将执行功能    通过邮箱或者志愿者编号进行登录
	//SELECT * from user WHERE UId = '1' or UEmail = '59948023@qq.com' AND UPassword = '222';

//	通过id登录             id可以是志愿者编号 可以是身份证号  可以是邮箱
	public User userLogin(String ID ,String password) throws SQLException;
	
	//通过邮件获取user对象
	public User byEmailgetUser(String UEmail) throws SQLException ;
	
	//通过身份证查找user
	public User byIdCardgetUser(String UIdCard)throws SQLException;
	
	
	
	//通过邮箱和身份证号查询组织信息  单个
	public User byEmailIdCardgetUser(String forget_Email, String forget_IdCard) throws SQLException;

	public int byIdUpdUserPass(int uId, String forget_password)throws SQLException;

	//通过用户id去获取用户信息
	public User getUserbyUId(int UId)throws SQLException;

	//通过用户的id  旧密码去修改新密码 
	public int updPwd(int UId, String oldpwd, String newpwd)throws SQLException;

	//通过邮箱查询志愿者    邮箱是否被使用判断 select * from user where UEmail='1072766478@qq.com'
	public User getUserbyOEmail(String newEmail)throws SQLException;
	//通过志愿者id和新旧邮箱去更新邮箱UPDATE user SET UEmail='599955@qq.com' WHERE UEmail='333' AND UId=1
	public int updEmail(int UId, String oldEmail, String newEmail)throws SQLException;

	//查询用户时长列表  按时长大于0降序排列  SELECT * FROM user WHERE UHours>0 AND UCredit>0 GROUP BY UHours DESC
	public List<User> getUserListbyUHours()throws SQLException;
	//查询用户积分列表 信誉值大于0  按积分大于0降序排列  SELECT * FROM user WHERE UIntegral>0 AND UCredit>0 GROUP BY UIntegral DESC
		public List<User> getUserListbyUIntegral()throws SQLException;

		//志愿者参加活动成功  修改志愿者服务时长与积分
		//UPDATE `user` SET UHours = UHours+5.0,UIntegral=UIntegral+10 WHERE UId = 5
		public int addUserInHours(double AHours, int AIntegral,  int UId)throws SQLException;

		//志愿者信誉度  增加减少
		
		public int updUCredit(int UCredit,int UId)throws SQLException;

		///限制志愿者登录  通过uid
		public int XianZUser(int UId)throws SQLException;

		//管理员查询所有志愿者列表
		public List<User> getUserList()throws SQLException;

		//管理员通过类型进行模糊搜索志愿者select * from user where UId like '%1%'
		public List<User> getUserListByTypeValue(String type, String value)throws SQLException;

		//管理员重置志愿者密码   UPDATE  user SET UPassword = ? WHERE UId = ?
		public int resetUserPwd(int UId, String UPassword)throws SQLException;

		//管理员冻结志愿者   UPDATE  user SET UState = 2 WHERE UId =?
		public int dongJieUser(int UId)throws SQLException;

		//管理员重置志愿者信誉值为1   UPDATE  user SET UCredit = 1 WHERE UId = ?
		public int restUCredit(int UId)throws SQLException;

		//解冻志愿者用户
		public int jieDongUser(int UId)throws SQLException;

		
		//更新志愿者信息UPDATE user SET UName = '哈哈',UPhone='11',USex='女',UIdCard='33242',UAddress='项目' WHERE UId =1
		public int updInfo(int UId, User u)throws SQLException;
		
		
}
