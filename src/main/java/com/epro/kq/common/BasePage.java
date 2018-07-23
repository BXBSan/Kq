package com.epro.kq.common;

import java.util.List;

/**
 * Created by Administrator on 2016/6/24.
 */
public class BasePage {
    private Integer pageCount;   // 一共多少页
    //private Integer pageSize;    // 每页多少条数据
    private Integer pageNo;      // 页码
    private Integer totalCount;  // 总数据数
    private Object dataList;

    public Object getDataList() {
        return dataList;
    }

    public void setDataList(Object dataList) {
        this.dataList = dataList;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
}
