package dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import dao.IUserDao;

import daomain.User;
import util.JDBCUtil;
//用户实现类
public class IUserDaoImpl implements IUserDao {
	QueryRunner qr = new QueryRunner(JDBCUtil.getDataSource());
	String sql=null;
	
			//1.查询志愿者邮箱是否唯一    通过获取到的邮箱查询    //2.通过志愿者邮箱查找志愿者信息
			public User byEmailgetUser(String UEmail) throws SQLException {
				sql="select * from user where UEmail=?";
				return qr.query(sql, new BeanHandler<User>(User.class),UEmail);
			}
			
			//添加用户
			//注册时不设置UId,UState使用数据库默认UState为1时账户正常为2时账户限制登录
			//INSERT INTO user (UName,UPassword,UEmail,UPhone,UAddress,USex,UIdCard) VALUES ('ww','ee','ww','ee','33','23','11')
			@Override
			public int addUser(User user) throws SQLException {
				sql="INSERT INTO user (UName,UPassword,UEmail,UPhone,UAddress,USex,UIdCard,UDate) VALUES (?,?,?,?,?,?,?,?)";
				return qr.update(sql,user.getUName(),user.getUPassword()
						,user.getUEmail(),user.getUPhone(),user.getUAddress()
						,user.getUSex(),user.getUIdCard(),user.getUDate());
			}
	
	
	
	@Override//身份证查找user
	public User byIdCardgetUser(String UIdCard) throws SQLException {
		sql="select * FROM user where UIdCard=?";
		return qr.query(sql, new BeanHandler<User>(User.class),UIdCard);
	}

	@Override//通过邮箱和身份证查询志愿者信息
	public User byEmailIdCardgetUser(String forget_Email, String forget_IdCard) throws SQLException {
		sql = "select * from user where UEmail=? and UIdCard=?";
		return qr.query(sql, new BeanHandler<User>(User.class),forget_Email,forget_IdCard);
	
	}

	@Override//通过id修改用户密码
	public int byIdUpdUserPass(int uId, String forget_password) throws SQLException {

		sql="update user set UPassword =? where UId=?";
		return qr.update(sql,forget_password,uId);
	
	}

	@Override//用户登录
	public User userLogin(String ID, String password) throws SQLException {
		//SELECT * from user WHERE UId = '1' or UEmail = '59948023@qq.com' AND UPassword = '222';
		sql="SELECT * from user WHERE UId = ? AND UPassword = ?";
		return qr.query(sql, new BeanHandler<User>(User.class),ID,password);
	}

	@Override//通过uid去查询志愿者信息
	public User getUserbyUId(int UId) throws SQLException {
		sql="select * from user where UId=?";
		return qr.query(sql, new BeanHandler<User>(User.class),UId);
	}

	@Override//通过用户的id  旧密码去修改新密码
	public int updPwd(int UId, String oldpwd, String newpwd) throws SQLException {
		sql=" UPDATE user SET UPassword=? WHERE UPassword=? AND UId=?";
		return qr.update(sql,newpwd,oldpwd,UId);
	}

	@Override//通过邮箱查询志愿者    邮箱是否被使用判断
	public User getUserbyOEmail(String newEmail) throws SQLException {
		sql=" select * from user where UEmail=?";
		
		return qr.query(sql, new BeanHandler<User>(User.class),newEmail);
	}

	@Override	//通过志愿者id和新旧邮箱去更新邮箱
	public int updEmail(int UId, String oldEmail, String newEmail) throws SQLException {
		sql="UPDATE user SET UEmail=? WHERE UEmail=? AND UId=?";
		return qr.update(sql,newEmail,oldEmail,UId);
	}

	@Override//查询用户时长列表  按时长大于0降序排列 信誉值必须大于0
	public List<User> getUserListbyUHours() throws SQLException {
		sql="SELECT * FROM user WHERE UHours>0 AND UCredit>0 GROUP BY UHours DESC";
		return qr.query(sql, new BeanListHandler<User>(User.class));
	}

	@Override//查询用户积分列表  按积分大于0降序排列   信誉值必须大于0
	public List<User> getUserListbyUIntegral() throws SQLException {
		sql="SELECT * FROM user WHERE UIntegral>0 AND UCredit>0 GROUP BY UIntegral DESC";
		return qr.query(sql, new BeanListHandler<User>(User.class));
	}

	@Override
	public int addUserInHours(double AHours, int AIntegral,  int UId) throws SQLException {
		sql="UPDATE user SET UHours = UHours+"+AHours+",UIntegral=UIntegral+"+AIntegral+" WHERE UId = ?";
		return qr.update(sql,UId);
		
		
	}

	@Override//通过志愿者id设置信誉度  增加减少
	public int updUCredit(int UCredit, int UId) throws SQLException {
		sql="UPDATE user SET UCredit=? WHERE UId=?";
		return qr.update(sql,UCredit,UId);
	}

	@Override///限制志愿者登录  通过uid
	public int XianZUser(int UId) throws SQLException {
		sql="UPDATE user SET UState=2 WHERE UId=?";
		return qr.update(sql,UId);
	}

	@Override//查询所有志愿者列表
	public List<User> getUserList() throws SQLException {
		sql="select * from user";
		return qr.query(sql, new BeanListHandler<User>(User.class));
	}

	@Override//通过类型模糊查询志愿者列表 select * from user where UId like '%1%'
	public List<User> getUserListByTypeValue(String type, String value) throws SQLException {
		sql="select * from user where "+type+" like ?";
		value="%"+value+"%";
		return qr.query(sql, new BeanListHandler<User>(User.class),value);
	}

	@Override//管理员重置志愿者密码 
	public int resetUserPwd(int UId, String UPassword) throws SQLException {
		sql="UPDATE  user SET UPassword = ? WHERE UId = ?";
		
		return qr.update(sql,UPassword,UId);
		
	}

	@Override//管理员冻结志愿者
	public int dongJieUser(int UId) throws SQLException {
		sql="UPDATE  user SET UState = 2 WHERE UId =?";
		return qr.update(sql,UId);
	}

	@Override//管理员重置志愿者信誉值为1
	public int restUCredit(int UId) throws SQLException {
		sql="UPDATE  user SET UCredit = 1 WHERE UId = ?";
		return qr.update(sql,UId);
	}

	@Override
	public int jieDongUser(int UId) throws SQLException {
		sql="UPDATE  user SET UState = 1 WHERE UId =?";
		return qr.update(sql,UId);
	}

	@Override//志愿者信息更新修改
	public int updInfo(int UId, User u) throws SQLException {
		sql="UPDATE user SET UName =?,UPhone=?,USex=?,UIdCard=?,UAddress=? WHERE UId =?";
		return qr.update(sql,u.getUName(),u.getUPhone(),u.getUSex(),u.getUIdCard(),u.getUAddress(),UId);
	}

	
	
	
	
	
	
	
	
//通过邮件链接调用dao执行UCode查询    查询到有值就修改用户状态码为可以登录状态
	/*public User UcodeQuery(String ucode) throws SQLException {
		// TODO Auto-generated method stub
		
		sql="SELECT * FROM user where ucode =?";
		
		
		return qr.query(sql, new BeanHandler<User>(User.class),ucode);
	}
	
	
	@Override//修改状态码  激活码
	public int upStatusandUcode(User user) throws SQLException {
		sql="UPDATE user SET ustatus=?,ucode=?where uid=?";
		
		return qr.update(sql,user.getUstatus(),user.getUcode(),user.getUid());
	}
*/
	
	
	
}
