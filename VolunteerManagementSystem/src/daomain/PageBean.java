package daomain;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter@Setter@ToString
public class PageBean<T> {

	
	
	
	//当前是哪一页
	private int currentPage;
	
	//共多少页
	private int totalPage;
	
	//共多少条记录
	private int totalCount;
	
	
	//当前页活动
	
	private List<T> list=new ArrayList<>();
	
	
}
