package util;

import javax.servlet.jsp.PageContext;

public class Constant {
//邮件激活码类型值   通过该值获取对应的邮件内容
	
	public static final int Org_Regist_Code=1;//组织注册时发送验证码消息内容
	public static final int Forget_Code=2;//组织和志愿者时发送验证码消息内容
	public static final int User_Regist_Code=3;//志愿者注册时发送验证码消息内容
	
	public static final int Org_UpdEmail_Code=4;//组织更换验证码
	public static final int User_UpdEmail_Code=5;//志愿者更换验证码
	//活动报名  通过  未通过  提醒用户的验证码
	public static final int Act_BaomNotPass=6;

	public static final int Act_BaomPass=7;
	//用户被差评提醒邮件
	public static final int Act_UserCaPing=8;
	//组织审核通过   解冻  冻结 审核未通过   重置密码
	public static final int Org_ShenhPass=9;
	
	//志愿者 重置密码   的验证码
	public static final int User_Mesg=10;
	
	
//设置组织注册时的状态码 （0待审核  不可登录 1 审核通过 可登陆）OState
	
	public static final int Org_State_Wait=0;//组织待审核 注册时数据库默认设置  系统未使用
	
	public static final int Org_State_Pass=1;//组织审核通过 
	public static final int Org_State_Restrict=2;//组织限制登录
	//UState为1时账户正常为2时账户限制登录
	
	public static final int User_State_Pass=1;//志愿者账号正常   注册时数据库默认设置  系统未使用
	public static final int User_State_Restrict=2;//志愿者账户限制登录
	
	/*活动状态0正在招募1正在进行2已结束*/
	
	public static final int Act_State_Pass=0;
	
	public static final int Act_State_GoDoing=1;
	
	public static final int Act_State_End=2;
	
	
		
}
