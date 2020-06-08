package daomain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//活动报名表
@Getter@Setter@ToString
public class Enlist {

	private int EId;//报名表id
	private int AId;//活动id
	private int UId;//志愿者id
	private int EState;//活动报名状态0已报名1已通过2已取消
	private int EFlag;//活动参加确认0未确认1通过2未通过
	private int EAssess;//评价确认0未评价1已好评2已差评
//组织
	private String UName;//志愿者名称
	private String USex;//志愿者性别
	private String UPhone;//志愿者手机
	private int UCredit;//志愿者信誉度
	private double UHours;//志愿者活动小时数
	private int AIntegral;//活动积分
	
	
//志愿者
	private String AName;//活动名称
	private String AStartDate;//开始进行时间
	private String AEndDate;//结束时间
	private double AHours;//活动小时数
	private String AAddress;//活动地址
	private int AState;//活动状态
	
	//组织
	private int OId;//组织编号
	private String OName;
	
	/*private int EBaom;//已报名人数
	private int ETong;//已通过人数
*/	
}
