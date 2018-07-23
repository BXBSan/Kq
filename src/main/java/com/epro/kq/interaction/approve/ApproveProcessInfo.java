package com.epro.kq.interaction.approve;

import com.epro.kq.domain.ApproveProcess;

/**
 * 审批流程单详情
 * Created by Administrator on 2016/7/22.
 */
public class ApproveProcessInfo extends ApproveProcess {
    private String approverName1;
    private String approverName2;

    public String getApproverName1() {
        return approverName1;
    }

    public void setApproverName1(String approverName1) {
        this.approverName1 = approverName1;
    }

    public String getApproverName2() {
        return approverName2;
    }

    public void setApproverName2(String approverName2) {
        this.approverName2 = approverName2;
    }
}
