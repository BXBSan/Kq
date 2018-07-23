package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/7/11.
 */
public class TolReport {
    //员工表uuid
    String uuid;
    String empName;
    String empNo;
    Integer clockNum;
    Integer leaveNum;
    Integer overTime;
    Integer offNum;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public Integer getClockNum() {
        return clockNum;
    }

    public void setClockNum(Integer clockNum) {
        this.clockNum = clockNum;
    }

    public Integer getLeaveNum() {
        return leaveNum;
    }

    public void setLeaveNum(Integer leaveNum) {
        this.leaveNum = leaveNum;
    }

    public Integer getOverTime() {
        return overTime;
    }

    public void setOverTime(Integer overTime) {
        this.overTime = overTime;
    }

    public Integer getOffNum() {
        return offNum;
    }

    public void setOffNum(Integer offNum) {
        this.offNum = offNum;
    }

    @Override
    public String toString() {
        return "TolReport{" +
                "empName='" + empName + '\'' +
                ", empNo='" + empNo + '\'' +
                ", clockNum=" + clockNum +
                ", leaveNum=" + leaveNum +
                ", overTime=" + overTime +
                ", offNum=" + offNum +
                '}';
    }
}
