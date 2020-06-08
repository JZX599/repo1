package util;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
 
public class MD5Utils {
	
	//鍙傛暟1:杈撳叆鏄庢枃瀵嗙爜
	public static String  getMD5Code(String password){
		StringBuilder sb = null;
		try {
			//鍒涘缓鍔犲瘑瀵硅薄
			//鍙傛暟1: 绠楁硶鍚嶅瓧
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			//杩涜鍔犲瘑  杩斿洖鍔犲瘑涔嬪悗缁撴灉涔熸槸瀛楄妭
			byte[] digest = messageDigest.digest(password.getBytes());
			sb = new StringBuilder();
			for (byte b : digest) {
				//浣嶈繍绠�
				int len = b & 0xff;    //0  0x0 0x1 0x2 0x3 0x4 0x9  10  0xa   15  0xf  16 0x10 170x11
				if(len<=15){
					sb.append("0");
				}
				sb.append(Integer.toHexString(len));
			}
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
		
	//鐢熸垚闅忔満鐨勯獙璇佺爜
	public static  String  getSalt(int n){
		char[] code =  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < n; i++) {
			sb.append(code[new Random().nextInt(code.length)]);
		}
		return sb.toString();
	}
	
	//娴嬭瘯
	public static void main(String[] args) throws NoSuchAlgorithmException {
		
	/*	String salt = getSalt(8);
		System.out.println(salt);*/
		String md5Code = getMD5Code("aaa");
		System.out.println(md5Code);
		
		/*//娴嬭瘯spring妗嗘灦灏佽鐨凪d5 
		String md5DigestAsHex = DigestUtils.md5DigestAsHex("111111".getBytes());
		System.out.println(md5DigestAsHex);*/
	}
	


}
