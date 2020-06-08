package test;

import java.util.ArrayList;
import java.util.List;
public class page<E> {
	private int currentPage = 1;// 当前页
	private int totalCount = 0;// 总记录数
	private int pageCount = 10;// 每页多少数据
	private int totalPage = 1;// 总页数
	private int Index = 0;// 角标
	private List<E> list = null;

	public page(List<E> list, int currentPage, int pageCount) {
		this.list = list;
		this.currentPage = currentPage;// 当前页
		this.totalCount = list.size();// 取得列表的长度 就是总记录数
		this.pageCount = pageCount;// 取得每页展示记录数 一般为10
		Index = (currentPage - 1) * pageCount;// 通过当前页 与每页的展示记录数 取得角标
		if (totalCount != 0) {
			totalPage = (int) Math.ceil(1.0 * totalCount / pageCount);
		} else {
			totalPage = 1;
		}
	}

	
	//使用说明： 1 2 6 为必须获取存值session   4总记录数可以根据实际需求
	// 1.获取总页数
	public int getTotalPage() {
		return totalPage;
	}

	// 2.获取当前页
	public int getCurrentPage() {
		return currentPage;
	}
	// 3.获取角标 1.当前页 2.每页多少数据

	public int getIndex() {
		return Index;
	}

	// 4.获取总记录数
	public int getTotalCount() {
		return totalCount;
	}

	// 5.页面传入的活动列表   无作用测试
	public List getPageList1() {
		return list;
	}

	// 6.页面传入的活动列表升级 通过角标取得列表
	public List<E> getPageList() {
		List<E> actlist = new ArrayList();//当前第3页
		for (int i = Index; i < Index+pageCount; i++) {//pageCount每页展示几个数据
				if(i<totalCount){
					actlist.add(list.get(i));
				}else{
					break;
					}
		}
		return actlist;
	}

}
