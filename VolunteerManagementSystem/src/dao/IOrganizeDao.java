package dao;

import java.sql.SQLException;
import java.util.List;

import daomain.Organize;

//组织  接口
public interface IOrganizeDao {

	//添加组织
	public int addOrg(Organize organize) throws SQLException;
	//添加组织时检查邮箱是否唯一
	public Organize byEmailgetOrg(String OEmail) throws SQLException;
	//通过邮箱和身份证号查询组织信息  单个
	public Organize byEmailIdCardgetOrg(String forget_Email, String forget_IdCard) throws SQLException;
	//通过id修改组织密码
	public int byIdUpdOrgPass(int OId,String password)throws SQLException;
	

	//通过身份证查找组织
		public Organize byIdCardgetOrg(String OIdCard)throws SQLException;
		
		//组织登录  通过id 
		public Organize orgLogin(String loginID, String login_password)throws SQLException;
		
		//通过组织id获取组织信息
		public Organize getOrgbyOId(int OId)throws SQLException;
		
		//通过组织id组织旧邮箱修改 新邮箱
		public int updEmail(int OId, String oldEmail, String newEmail)throws SQLException;
		
		//组织修改密码  通过组织id和旧密码修改
		public int updPwd(int OId, String oldpwd, String newpwd)throws SQLException;
		//组织修改邮箱的邮箱验证是否已被使用
		public Organize getOrgbyOEmail(String newEmail)throws SQLException;
		//通过活动id得到组织信息
		public Organize getOrgbyAId(int AId)throws SQLException;
		//管理员查询所有组织信息
		public List<Organize> getOrgList()throws SQLException;
		
		//管理员通过类型模糊查询组织列表信息select * FROM organize where OName LIKE '%1%'
		public List<Organize> getOrgListbyTypeValue(String type ,String value)throws SQLException;
		//通过组织id查询组织发布的活动总数
		public Long getOrgActnum(int OId)throws SQLException;
		
		//管理员查询所有待审核组织信息select * FROM organize where  OState =0
		 
		public List<Organize> getOrgWaitList()throws SQLException;
		
		//管理员通过类型模糊查询待审核组织列表信息select * FROM organize where OName LIKE '%会%' AND OState = 0
		public List<Organize> getOrgWaitListbyTypeValue(String type, String value)throws SQLException;
		
		//管理员查询所有已审核组织信息（包括正常，冻结）select * FROM organize where  OState !=0
		public List<Organize> getOrgPassList()throws SQLException;
		
		//管理员通过类型模糊查询已审核组织列表信息select * FROM organize where OName LIKE '%会%' AND OState != 0
		public List<Organize> getOrgPassListbyTypeValue(String type, String value)throws SQLException;
		
		//管理员进行组织审核  通过执行
		public int PassOrgregist(int OId)throws SQLException;
		
		//管理员进行组织审核  不通过执行
		public int notPassOrgregist(int OId)throws SQLException;
		
		//组织冻结  通过组织id
		public int dongJieOrg (int OId)throws SQLException;
		//组织解冻  通过组织id
		public int jieDongOrg(int OId)throws SQLException;
		
		//管理员进行组织重置密码
		public int resetOrgPwd(int OId, String OPassword)throws SQLException;
		
		//首页执行所有组织列表查询
		public List<Organize> getIndexOrgList() throws SQLException;
		
		public List<Organize> getIndexOrgListbyTypeValue(String type, String value)throws SQLException;
		//组织修改信息UPDATE organize SET OName =?,OPerson=?,OIdCard=?,OAddress=? WHERE OId =?
		public int updOrgInfo(int OId, Organize org)throws SQLException;
		
}
