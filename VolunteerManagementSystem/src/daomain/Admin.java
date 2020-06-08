package daomain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Admin {
	
	private int AId;	
	private String  AName;	
	private String APwd;
	private int APower;//0为普通1为超级
}
