package com.epro.kq.utils;


import org.springframework.security.crypto.codec.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.security.Key;
import java.security.SecureRandom;
import java.security.spec.AlgorithmParameterSpec;

/**
 * Created by Administrator on 2016/7/11.
 */
public class DesUtils {
    public static final String ALGORITHM_DES = "DES/CBC/PKCS5Padding";
    //private static Log log = LogFactory.getLog(Des.class);
    /**
     * DES算法，加密
     *
     * @param data 待加密字符串
     * @param key  加密私钥，长度不能够小于8位
     * @return 加密后的字节数组，一般结合Base64编码使用
     * @throws Exception 异常
     */
    public static String encode(String key,String data,String salt) throws Exception
    {
        return encode(key, (data+salt).getBytes());
    }
    /**
     * DES算法，加密
     *
     * @param data 待加密字符串
     * @param key  加密私钥，长度不能够小于8位
     * @return 加密后的字节数组，一般结合Base64编码使用
//     * @throws CryptException 异常
     */
    public static String encode(String key,byte[] data) throws Exception
    {
        try
        {
            // 设置密钥参数
            DESKeySpec dks = new DESKeySpec(key.getBytes());
            //获取密钥工厂对象
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //key的长度不能够小于8位字节，获取密钥对象
            Key secretKey = keyFactory.generateSecret(dks);
            //Cipher对象实际完成加密操作
            Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
            IvParameterSpec iv = new IvParameterSpec("********".getBytes());
            AlgorithmParameterSpec paramSpec = iv;
            //用密匙初始化Cipher对象
            cipher.init(Cipher.ENCRYPT_MODE, secretKey,paramSpec);

            byte[] bytes = cipher.doFinal(data);
            return new String(Base64.encode(bytes));
        } catch (Exception e)
        {
            throw new Exception(e);
        }
    }
    /**
     * DES算法，解密
     *
     * @param data 待解密字符串
     * @param key  解密私钥，长度不能够小于8位
     * @return 解密后的字节数组
     * @throws Exception 异常
     */
    public static byte[] decode(String key,byte[] data,String salt) throws Exception
    {
        try
        {
//            SecureRandom sr = new SecureRandom();
//            int salt=sr.nextInt(10);
            //System.out.println(salt);
            DESKeySpec dks = new DESKeySpec(key.getBytes());
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //key的长度不能够小于8位字节
            Key secretKey = keyFactory.generateSecret(dks);
            Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
            IvParameterSpec iv = new IvParameterSpec("********".getBytes());
            AlgorithmParameterSpec paramSpec = iv;
            cipher.init(Cipher.DECRYPT_MODE, secretKey,paramSpec);
            return cipher.doFinal(data);
        } catch (Exception e)
        {
//         e.printStackTrace();
            throw new Exception(e);
        }
    }

    /**
     * 获取编码后的值
     * @param key
     * @param data
     * @return
     * @throws Exception
     * @throws Exception
     */
    public static String decodeValue(String key,String data,String salt) throws Exception
    {
        byte[] datas;
        String value = null;
       // String data1=data.substring(0,data.length()-1);

        datas = decode(key, Base64.decode(data.getBytes()),salt);

        value = new String(datas);
        if (value.equals("")){
            throw new Exception();
        }
        return value.substring(0,value.length()-1);
    }


    //测试代码？   ？？、
    public static void main(String[] args) throws Exception{
        SecureRandom sr = new SecureRandom();
        String  salt=sr.nextInt(10)+"";
        System.out.println(salt);
        String key="12345678";
        System.out.println(key.length());
        String data="123456";
        String d=encode(key,data,salt);
        System.out.println(d);
        System.out.println(decodeValue(key,d,salt));


    }



}
