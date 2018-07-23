package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/7/22.
 */
public class ApproveProcess extends BaseDomain {
    private String applyId;
    private String approverId1;
    private String approveTime1;
    private String approveRemark1;
    private String result1;
    private String approverId2;
    private String approveTime2;
    private String approveRemark2;
    private String result2;

    public String getApplyId() {
        return applyId;
    }

    public void setApplyId(String applyId) {
        this.applyId = applyId;
    }

    public String getApproveRemark1() {
        return approveRemark1;
    }

    public void setApproveRemark1(String approveRemark1) {
        this.approveRemark1 = approveRemark1;
    }

    public String getApproveRemark2() {
        return approveRemark2;
    }

    public void setApproveRemark2(String approveRemark2) {
        this.approveRemark2 = approveRemark2;
    }

    public String getApproverId1() {
        return approverId1;
    }

    public void setApproverId1(String approverId1) {
        this.approverId1 = approverId1;
    }

    public String getApproverId2() {
        return approverId2;
    }

    public void setApproverId2(String approverId2) {
        this.approverId2 = approverId2;
    }

    public String getApproveTime1() {
        return approveTime1;
    }

    public void setApproveTime1(String approveTime1) {
        this.approveTime1 = approveTime1;
    }

    public String getApproveTime2() {
        return approveTime2;
    }

    public void setApproveTime2(String approveTime2) {
        this.approveTime2 = approveTime2;
    }

    public String getResult1() {
        return result1;
    }

    public void setResult1(String result1) {
        this.result1 = result1;
    }

    public String getResult2() {
        return result2;
    }

    public void setResult2(String result2) {
        this.result2 = result2;
    }
}
