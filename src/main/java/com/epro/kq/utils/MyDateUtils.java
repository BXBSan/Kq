package com.epro.kq.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2016/7/6.
 */
public class MyDateUtils {
    /*
	 * simplely check String "yyyy-MM-dd"
	 */
    public static boolean checkStrYYYY_MM_DD(String dateStr) {
        String eL = "^([0-9]{4})-([0][1-9]|[1][0-2])-([0][1-9]|[1-2][0-9]|[3][0-1])$";//yyyy-MM-dd

        Pattern p = Pattern.compile(eL);
        Matcher m = p.matcher(dateStr);
        if (!m.matches()) {
            return false;
        } else {
            return true;
        }
    }

    /*
	 * check String "HH:mm:ss"
	 */
    public static boolean checkStrHHmmss(String dateStr) {
        String eL = "^([0-1][0-9]|[2][0-3]):([0-5][0-9]):([0-5][0-9])$";//HH:mm:ss

        Pattern p = Pattern.compile(eL);
        Matcher m = p.matcher(dateStr);
        if (!m.matches()) {
            return false;
        } else {
            return true;
        }
    }

}
