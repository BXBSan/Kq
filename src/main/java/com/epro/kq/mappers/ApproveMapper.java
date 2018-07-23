package com.epro.kq.mappers;

import com.epro.kq.domain.Apply;
import com.epro.kq.interaction.approve.ApproveListResponse;
import com.epro.kq.interaction.approve.ApproveProcessInfo;
import com.epro.kq.interaction.approve.ReportFormsResponse;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/24.
 */
@Repository
public interface ApproveMapper {
    List<ApproveListResponse> getUnapprovedList(Map<String, String> params);

    List<ApproveListResponse> getApprovedList(Map<String, String> params);

    int getUnapprovedCount(Map<String, String> params);

    int getApprovedCount(Map<String, String> params);

    Apply getApplyById(String applyId);

    int approve(Map<String, String> datas);

    // 审批单(申请单)详情 (不同状态 sql语句有区别)
    ApproveListResponse getUnapprovedDetailById(String applyId); // 待批
    ApproveListResponse getApprovedDetailById(String applyId); // 已批

    // 写审批流程approveProcess表
    int firstLevelApprove(Map<String, String> params1);
    int secondLevelApprove(Map<String, String> params2);

    // 获取审批流程详情
    ApproveProcessInfo getProcessInfoByApplyId(String applyId);
}
