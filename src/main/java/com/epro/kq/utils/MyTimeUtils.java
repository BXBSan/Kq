package com.epro.kq.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Administrator on 2016/7/27.
 */
public class MyTimeUtils {
    public static long getCheckTime(String start,String end){
        Calendar cal=Calendar.getInstance();
        SimpleDateFormat sd=new SimpleDateFormat("HH:mm:ss");
        long l=0;
        long time=0;
        try {


            cal.setTime(sd.parse(start));
            Date s=cal.getTime();
            cal.setTime(sd.parse(end));
            Date e=cal.getTime();
            System.out.println(s);
            System.out.println(e);
            l=e.getTime()-s.getTime();
            time = 1000*3600;
            System.out.println(l);
            System.out.println(l/time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return l/time;
    }
}
