package test;
import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.junit.Test;

import daomain.User;
import util.CommonUtils;

public class Junit {
//  获取6为随机验证码
	@Test
	public void test() throws Exception {
		System.out.println(CommonUtils.getRandomCode());
	}
	

	@Test
	public void test2() throws Exception {
		int i =Integer.valueOf(CommonUtils.getDateName()).intValue();

		System.out.println(i);
	}
	
	@Test//测试分页工具类
	public void test3() throws Exception {
		List<User> m=new ArrayList();
		User u = new User();
		User u1 = new User();
		User u2 = new User();
		User u3 = new User();
		User u4 = new User();
		User u5 = new User();
		
		m.add(u1);
		m.add(u3);
		m.add(u4);
		m.add(u5);
		m.add(u2);
		page p=new page(m, 3, 2);

		System.out.println(p.getCurrentPage()+"当前页--总页数"+p.getTotalPage()+"获取角标"+p.getIndex()+"获取的分类用户数据"+p.getPageList()+"lis的"+p.getPageList1());
	}
	
	@Test//测试小时差工具类
	public void test4() throws Exception {
		double gethours = CommonUtils.gethours("2020-02-28 10:00:00", "2020-02-28 12:00:00");
System.out.println(gethours);
			}
}
