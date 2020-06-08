package daomain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter@ToString
public class User {
	private int UId;
	private String UName;
	private String UPassword;
	private String UEmail;
	private String UPhone;
	private String UAddress;
	private String USex;
	private int UState;
	private String UIdCard;
	private int UIntegral;//志愿者积分
	private double UHours;//志愿者活动小时数
	private int UCredit;//志愿者信誉度
	private String UDate;//成立时间
}
