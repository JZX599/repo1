package daomain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter@ToString
public class Activity {
	//12个
	private int AId;
	private int OId;//组织id
	private int CId;//分类id
	private Category category;//分类对象
	private String AName;//活动名称
	private String AStartDate;//开始进行时间
	private String AEndDate;//结束时间
	private String APerson;//活动联系人
	private String APhone;//手机
	private int AEstimate;//预计招募人数
	private int AIntegral;//活动积分
	
	private String ASynopsis;//活动简介
	private int AState;//活动状态      数据库中不存储/*活动状态0正在招募1正在进行2已结束*/
	
	private double AHours;//活动小时数
	private String AAddress;//地址
	
	private String AKzTime;//开始招募时间 AKzTime
	private int EBaom;//已报名人数
	private int ETong;//已通过人数
	private Organize organize;
}
