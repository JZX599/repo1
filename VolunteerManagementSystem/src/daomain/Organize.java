package daomain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter@ToString
public class Organize {

	//11个
		private int OId;//组织编号
		private String OName;
		private String OPerson;
		private String OPassword;
		private String OEmail;
		private String ODate;//成立时间
		private String OAddress;
		private String OIdCard;
		private int OState;//组织状态
		private int OActnum;//组织发布活动数量
		private String OSynopsis;//组织简介
}
