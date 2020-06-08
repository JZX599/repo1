package dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import dao.IOrganizeDao;
import daomain.Organize;

import util.JDBCUtil;


//组织 实现类
public class IOrganizeDaoImpl implements IOrganizeDao {
	
	QueryRunner qr = new QueryRunner(JDBCUtil.getDataSource());
	//添加组织     成功执行
	//INSERT INTO organize (OId,OName,OPerson,OPassword,OEmail,ODate,OAddress,OState,OIdCard) VALUES (12,'哈哈','哈哈',123456,'5@qq.com','2019-5-9','厦门市湖里区',1,'35069485851546')  
	//INSERT INTO organize (OName,OPerson,OPassword,OEmail,ODate,OAddress,OIdCard) VALUES ('哈哈','哈哈',123456,'5@qq.com','2019-5-9','厦门市湖里区','35069485851546')  
	
	String sql=null;
		
		public int addOrg(Organize organize) throws SQLException {
			sql="INSERT INTO organize (OName,OPerson,OPassword,OEmail,ODate,OAddress,OIdCard) VALUES (?,?,?,?,?,?,?)";
			return qr.update(sql,organize.getOName(),organize.getOPerson(),
					organize.getOPassword(),organize.getOEmail(),organize.getODate(),
					organize.getOAddress(),organize.getOIdCard());
			
			
		}
		//1.查询组织邮箱是否唯一    通过获取到的邮箱查询    //2.通过组织邮箱查找组织信息
		
		public Organize byEmailgetOrg(String OEmail) throws SQLException {
			sql="select * from organize where OEmail=?";
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),OEmail);
		}
		//通过邮箱和身份证号查询组织信息  单个 select * from organize where OEmail='1072766478@qq.com' and OIdCard='350681199611027010'
		@Override
		public Organize byEmailIdCardgetOrg(String forget_Email, String forget_IdCard) throws SQLException {
		
			sql = "select * from organize where OEmail=? and OIdCard=?";
			
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),forget_Email,forget_IdCard);
		}

		
		//通过id修改组织密码
		@Override
		public int byIdUpdOrgPass(int OId, String password) throws SQLException {
//update organize set OPassword =6883880 where OId=10006
			sql="update organize set OPassword =? where OId=?";
			return qr.update(sql,password,OId);
		}

		@Override
		public Organize byIdCardgetOrg(String OIdCard) throws SQLException {
			sql="select * FROM organize where OIdCard=?";
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),OIdCard);
		}

		@Override//组织登录
		public Organize orgLogin(String loginID, String login_password) throws SQLException {
			sql="SELECT * from organize WHERE OId = ? AND OPassword = ?";
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),loginID,login_password);
		}

		@Override//通过组织id获取组织信息
		public Organize getOrgbyOId(int OId) throws SQLException {
			sql="select * from organize where OId=?";
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),OId);
		}

		@Override//UPDATE organize SET OEmail='599955@qq.com' WHERE OEmail='66' AND OId=1
		public int updEmail(int oId, String oldEmail, String newEmail) throws SQLException {
			sql="UPDATE organize SET OEmail=? WHERE OEmail=? AND OId=?";
			return qr.update(sql,newEmail,oldEmail,oId);
		}

		@Override
		public int updPwd(int OId, String oldpwd, String newpwd) throws SQLException {
			sql="UPDATE organize SET OPassword=? WHERE OPassword=? AND OId=?";
			return qr.update(sql,newpwd,oldpwd,OId);
		}

		@Override//组织修改邮箱的邮箱验证是否已被使用
		public Organize getOrgbyOEmail(String newEmail) throws SQLException {
			sql="select * from organize where OEmail=?";
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),newEmail);
		}

		@Override//通过活动id取得组织信息
		public Organize getOrgbyAId(int AId) throws SQLException {
			sql="select organize.* from activity, organize where activity.OId=organize.OId AND activity.AId=?";
			return qr.query(sql, new BeanHandler<Organize>(Organize.class),AId);
		}

		@Override//管理员查询所有组织信息
		public List<Organize> getOrgList() throws SQLException {
			sql="select * FROM organize";
			return qr.query(sql,new BeanListHandler<Organize>(Organize.class));
		}

		@Override	//管理员通过类型模糊查询组织列表信息
		public List<Organize> getOrgListbyTypeValue(String type, String value) throws SQLException {
			sql="select * FROM organize where "+type+" LIKE ?";
			value="%"+value+"%";
			return qr.query(sql, new BeanListHandler<Organize>(Organize.class),value);
		}

		@Override	//通过组织id查询组织发布的活动总数
		public Long getOrgActnum(int OId) throws SQLException {
			sql="select COUNT(*) FROM organize ,activity WHERE organize.OId = activity.OId AND organize.OId=?";
			return (Long) qr.query(sql, new ScalarHandler(),OId);
		}

		@Override//管理员查询所有待审核组织信息
		public List<Organize> getOrgWaitList() throws SQLException {
			sql="select * FROM organize WHERE OState = 0";
			return qr.query(sql,new BeanListHandler<Organize>(Organize.class));
		}

		@Override//管理员通过类型模糊查询待审核组织列表信息
		public List<Organize> getOrgWaitListbyTypeValue(String type, String value) throws SQLException {
			sql="select * FROM organize where "+type+" LIKE ? AND OState = 0";
			value="%"+value+"%";
			return qr.query(sql, new BeanListHandler<Organize>(Organize.class),value);
		}

		@Override//管理员查询 已审核组织信息  正常冻结状态的所有组织信息
		public List<Organize> getOrgPassList() throws SQLException {
			sql="select * FROM organize where  OState !=0";
			return qr.query(sql,new BeanListHandler<Organize>(Organize.class));
		}

		@Override//管理员模糊查询 已审核组织信息
		public List<Organize> getOrgPassListbyTypeValue(String type, String value) throws SQLException {
			sql="select * FROM organize where "+type+" LIKE ? AND OState != 0";
			value="%"+value+"%";
			return qr.query(sql, new BeanListHandler<Organize>(Organize.class),value);
		}

		@Override//管理员进行组织审核  通过执行
		public int PassOrgregist(int OId) throws SQLException {
			sql="UPDATE  organize SET OState = 1 WHERE organize.OId =?";
			return qr.update(sql,OId);
		}

		@Override//管理员进行组织审核  不通过执行
		public int notPassOrgregist(int OId) throws SQLException {
			sql="DELETE FROM organize WHERE OId = ?";
			return qr.update(sql,OId);
		}

		@Override//组织冻结
		public int dongJieOrg(int OId) throws SQLException {
			sql="UPDATE  organize SET OState = 2 WHERE organize.OId =?";
			return qr.update(sql,OId);
		}

		@Override//组织解冻
		public int jieDongOrg(int OId) throws SQLException {
			sql="UPDATE  organize SET OState = 1 WHERE organize.OId =?";
			return qr.update(sql,OId);
		}

		@Override//管理员进行组织重置密码
		public int resetOrgPwd(int OId, String OPassword) throws SQLException {
			sql="UPDATE  organize SET OPassword = ? WHERE OId = ?";
			
			return qr.update(sql,OPassword,OId);
		}

		
		@Override//主页查询所有组织信息
		public List<Organize> getIndexOrgList() throws SQLException {
			sql="select * FROM organize";
			return qr.query(sql,new BeanListHandler<Organize>(Organize.class));
		}

		@Override//主页查询键值模糊搜索组织列表信息
		public List<Organize> getIndexOrgListbyTypeValue(String type, String value) throws SQLException {
			sql="select * FROM organize where "+type+" LIKE ?";
			value="%"+value+"%";
			return qr.query(sql, new BeanListHandler<Organize>(Organize.class),value);
		}

		@Override//组织修改信息
		public int updOrgInfo(int OId, Organize org) throws SQLException {
			sql="UPDATE organize SET OName =?,OPerson=?,OIdCard=?,OAddress=?,OSynopsis=? WHERE OId =?";
			return qr.update(sql,org.getOName(),org.getOPerson(),org.getOIdCard(),org.getOAddress(),org.getOSynopsis(),OId);
		}

		
		
		

}
