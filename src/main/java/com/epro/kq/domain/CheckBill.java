package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/6/28.
 */
public class CheckBill extends BaseDomain{
    private String empId;
    private String checkTime;
    private String checkDate;

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
    }

    public String getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(String checkDate) {
        this.checkDate = checkDate;
    }
}
