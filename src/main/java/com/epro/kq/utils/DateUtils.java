package com.epro.kq.utils;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/7/25.
 */
public class DateUtils {
    public static void main(String[] args) {
        Calendar cal=Calendar.getInstance();
        Date date=new Date();
        int days=date.getDate();

        System.out.println(days);

        //获取第一天
        cal.set(GregorianCalendar.DAY_OF_MONTH, 1);
        Date firstDay = cal.getTime(); // 本月第一天
        firstDay.setMinutes(0);
        firstDay.setHours(0);
        firstDay.setSeconds(0);
        //firstDay.setSeconds(new Date(firstDay.getTime()+*1000*60*60*24).toLocaleString());
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        //更新加班和调休
        StringBuffer result = new StringBuffer();
        Date currentDate = null;
        int counts=0;
        for (int i = 0; i < days; i++) {
            currentDate = new Date(firstDay.getTime() + (i * 1000 * 60 * 60 * 24l));
            if (currentDate.getDay() == 0 || currentDate.getDay() == 6) {
                counts++;
            }
        }
        System.out.println(counts);

    }
    public static Map getdays(){
        Map<String,Integer> map=new HashMap<String, Integer>();
        Calendar cal=Calendar.getInstance();
        Date date=new Date();
        int days=date.getDate();

        System.out.println(days);

        //获取第一天
        cal.set(GregorianCalendar.DAY_OF_MONTH, 1);
        Date firstDay = cal.getTime(); // 本月第一天
        firstDay.setMinutes(0);
        firstDay.setHours(0);
        firstDay.setSeconds(0);
        //firstDay.setSeconds(new Date(firstDay.getTime()+*1000*60*60*24).toLocaleString());
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        //更新加班和调休
        StringBuffer result = new StringBuffer();
        Date currentDate = null;
        int counts=0;
        for (int i = 0; i < days; i++) {
            currentDate = new Date(firstDay.getTime() + (i * 1000 * 60 * 60 * 24l));
            if (currentDate.getDay() == 0 || currentDate.getDay() == 6) {
                counts++;
            }
        }
        System.out.println(counts);
        map.put("date",days);
        map.put("counts",counts);

        return map;
    }

}
