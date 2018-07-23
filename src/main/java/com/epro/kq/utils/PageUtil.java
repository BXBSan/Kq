package com.epro.kq.utils;

import com.epro.kq.common.SystemConstant;

/**
 * Created by Administrator on 2016/6/29.
 */
public class PageUtil {
    // 通过pageNo和pageSize,计算数据库分页 limit 的起始编号
    public static int getLimitStartNum(int pageNo){ // 0-9 10-19 20-29
        pageNo = pageNo <= 0 ? 1 : pageNo;
        return (pageNo-1) * SystemConstant.pageSize;
    }

    // 通过pageNo和pageSize,计算页面分页的 第一个页码(页码显示5个)
    public static int getPageBeginNum(int pageNo, int pageCount){
        int beginNum = 1;
        if(pageNo < 3 || pageCount < 6){
            beginNum = 1;
        }else if(pageCount - pageNo < 2){
            beginNum = pageCount - 4;
        }else{
            beginNum = pageNo - 2;
        }
        return beginNum;
    }

    // 通过pageNo和pageSize,计算页面分页的 最后一个页码(页码显示5个)
    public static int getPageEndNum(int pageNo, int pageCount){
        int endNum = 1;
        if(pageCount < 6 || (pageNo + 2) > pageCount){
            endNum = pageCount;
        }else if(pageNo < 3 && pageCount > 6){
            endNum = 5;
        }else{
            endNum = pageNo + 2;
        }
        return endNum;
    }
}
