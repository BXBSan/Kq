package com.epro.kq.interaction.approve;

/**
 * Created by Administrator on 2016/7/10.
 */
public class ReportFormsResponse {

    //申请人Id
    private String empId;

    //申请人
    private   String empName;

    //请假单条数
    private  int leaveBillCount;

    //加班单条数
    private  int workOverTimeBillCount;

    //调休单条数
    private  int daysOffBillCount;


    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public int getLeaveBillCount(){
        return leaveBillCount;
    }

    public void setLeaveBillCount(int leaveBillCount){
        this.leaveBillCount = leaveBillCount;
    }

    public int getWorkOverTimeBillCount(){
        return workOverTimeBillCount;
    }

    public void setWorkOverTimeBillCount(int workOverTimeBillCount){
        this.workOverTimeBillCount = workOverTimeBillCount;
    }

    public int getDaysOffBillCount(){
        return daysOffBillCount;
    }

    public void setDaysOffBillCount(int daysOffBillCount ){
        this.daysOffBillCount=daysOffBillCount;
    }


    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }
}
