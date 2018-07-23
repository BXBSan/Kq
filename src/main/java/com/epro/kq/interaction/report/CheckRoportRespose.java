package com.epro.kq.interaction.report;

/**
 * Created by asus2218 on 2016/7/13.
 */
public class CheckRoportRespose {
    private String empNo;
    private String empName;
    private int laterCount;
    private int earlyCount;
    private String uuid;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public int getTwoCounts() {
        return twoCounts;
    }

    public void setTwoCounts(int twoCounts) {
        this.twoCounts = twoCounts;
    }

    public int getNullCounts() {
        return nullCounts;
    }

    public void setNullCounts(int nullCounts) {
        this.nullCounts = nullCounts;
    }

    private int twoCounts;
    private int nullCounts;

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

    public int getLaterCount() {
        return laterCount;
    }

    public void setLaterCount(int laterCount) {
        this.laterCount = laterCount;
    }

    public int getEarlyCount() {
        return earlyCount;
    }

    public void setEarlyCount(int earlyCount) {
        this.earlyCount = earlyCount;
    }
}
