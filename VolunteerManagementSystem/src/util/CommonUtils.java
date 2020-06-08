package util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;

public class CommonUtils {

	
	
//  获取6为随机验证码
	public static String getRandomCode() {
		String[] letters = new String[] {
				"q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m",
				"A","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M",
				"0","1","2","3","4","5","6","7","8","9"};//62个
		String code ="";
		for (int i = 0; i < 6; i++) {
			code = code + letters[(int)Math.floor(Math.random()*letters.length)];//Math.floor(Math.random()*62)会对由上面的语句产生的数值（0-62）进行向下取整
		}
		return code;
	}
	//获取当前日期
	public static String getNewDate() {
		 
	      Date dNow = new Date( );
	      SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
	 
	       return ft.format(dNow);
	   }
	
	
	//1.获取当前系统时间格式化后给图片命名 2.yyyyMMddhhmmss
		public static String getDateName(){
			Date t = new Date(System.currentTimeMillis());
			SimpleDateFormat sd = new SimpleDateFormat("yyyyMMddhhmmss");
			String time = sd.format(t);
			return time;
		}
		
		//1.获取当前系统时间格式化 yyyy-MM-dd hh:mm:ss
				public static String getDatetime(){
					Date t = new Date(System.currentTimeMillis());
					SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					String time = sd.format(t);
					return time;
				}
		
		//获取UUID
		public static String getUUID(){
			
			return UUID.randomUUID().toString().replace("-", "");
		}
		//获取当前系统时间进行时间差  小时计算
		public static double gethours(String AStartDate,String AEndDate) throws Exception{
			SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date startDatetime = simpleFormat.parse(AStartDate);
				 Date endDatetime = simpleFormat.parse(AEndDate);  
				    long start = startDatetime.getTime();  
				    long end = endDatetime.getTime();  
				
				    double hours = (double) (1.0*(end - start) / (1000 * 60 * 60));
				    double hoursformat =(double) Math.round(hours* 100) / 100;//结果保留两位小数
				
				return hoursformat;
			
			
		}
		
		//志愿者增加信誉度
				public static int addCredit(int UCredit){
					if (UCredit >= 6) {
						UCredit = 6;

					} else if (UCredit < 6 && UCredit >= 1) {
						UCredit++;

					} else if (UCredit < 1) {

					}
					return UCredit;
				}
				//志愿者减少信誉度
				public static int subCredit(int UCredit){
					if (UCredit >= 6) {
						UCredit= 4;
					} else if (UCredit< 6 && UCredit > 2) {
						UCredit = UCredit - 2;
					} else if (UCredit <= 2) {
						UCredit = UCredit - 2;
					}
					return UCredit;
				}
		
}
