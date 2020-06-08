package util;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import javax.sql.DataSource;
import com.alibaba.druid.pool.DruidDataSourceFactory;
public class JDBCUtil {
	public static DataSource ds=null;
	
	static {
		try {
			Properties p = new Properties();
			String path =JDBCUtil.class.getClassLoader().getResource("db.properties").getPath();
			FileInputStream in = new FileInputStream(path);// 通过打开一个到实际文件的连接来创建一个 FileInputStream，该文件通过文件系统中的路径名 path 指定。
			p.load(in);	//从输入流中读取属性列表（键和元素对）。
			// 1.加载驱动
			// 2.获取连接对象 连接数据库
			ds =DruidDataSourceFactory.createDataSource(p);//德鲁伊
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
//方法1.初始化加载驱动连接数据库
	public static Connection getConn() {
		try {
			
			return ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
//方法3.获取数据源
		public static DataSource  getDataSource() {
			return ds;
		}
//方法2.关闭资源（3个）
	public static void close(ResultSet rs,Statement st ,Connection conn) {
		// 5.释放资源
					if (st != null) {
						try {
							st.close();
						} catch (SQLException e) {

							e.printStackTrace();
						}

					}

					if (conn != null) {
						try {
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}

					}
	}
	
}
