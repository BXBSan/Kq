package com.epro.kq.service;

import com.epro.kq.common.BasePage;
import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Apply;
import com.epro.kq.domain.Dept;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.approve.ApproveListResponse;
import com.epro.kq.interaction.approve.ApproveProcessInfo;
import com.epro.kq.interaction.approve.ReportFormsResponse;
import com.epro.kq.interaction.emp.EmpInfo;
import com.epro.kq.mappers.ApproveMapper;
import com.epro.kq.mappers.CheckBillMapper;
import com.epro.kq.mappers.DeptMapper;
import com.epro.kq.mappers.EmpMapper;
import com.epro.kq.utils.PageUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ApproveService {
    @Autowired
    private ApproveMapper approveMapper;

    @Autowired
    private CheckBillMapper checkBillMapper;

    @Autowired
    private EmpMapper empMapper;

    @Autowired
    private DeptMapper deptMapper;

    public String show(HttpServletRequest request, HttpServletResponse response,
                       int pageNo1, int pageNo2, String keyWord, String applyType, String tabNum, String sort) {
        //int pageNo = 1; //(Integer)request.getAttribute("pageNo");
        // 查询条件
        if(StringUtils.isEmpty(keyWord)){
            keyWord = null;
        }
        Map<String, String> params = new HashMap<String, String>();
        params.put("pageSize", SystemConstant.pageSize + "");
        params.put("limitStart1", PageUtil.getLimitStartNum(pageNo1) + "");
        params.put("limitStart2", PageUtil.getLimitStartNum(pageNo2) + "");
        params.put("keyWord", "%" + keyWord + "%"); // 拼接模糊查询
        params.put("applyType", applyType);
        params.put("sort", sort); // 排序
        // 以当前登录人为审批人的申请单
        params.put("approverId", ((Employee)request.getSession().getAttribute("emp")).getUuid());

        // 1.查询未审批列表(以我为审批人)
        BasePage unapprovedListPage = new BasePage();

        List<ApproveListResponse> unapprovedList = approveMapper.getUnapprovedList(params);
        int unapprovedCount = approveMapper.getUnapprovedCount(params);

        unapprovedListPage.setPageCount((unapprovedCount + SystemConstant.pageSize - 1)/SystemConstant.pageSize);
        unapprovedListPage.setPageNo(pageNo1);
        unapprovedListPage.setTotalCount(unapprovedCount);
        unapprovedListPage.setDataList(unapprovedList);

        // 2.查询已审批列表(以我为审批人)
        BasePage approvedListPage = new BasePage();
        List<ApproveListResponse> approvedList = approveMapper.getApprovedList(params);
        int approvedCount = approveMapper.getApprovedCount(params);

        approvedListPage.setPageCount((approvedCount + SystemConstant.pageSize - 1)/SystemConstant.pageSize);
        approvedListPage.setPageNo(pageNo2);
        approvedListPage.setTotalCount(approvedCount);
        approvedListPage.setDataList(approvedList);

        // 传未审批和已审批 数据到前端
        request.setAttribute("unapprovedListPage", unapprovedListPage);
        request.setAttribute("approvedListPage", approvedListPage);
        request.setAttribute("applyType", applyType); // 将类型传回前端
        request.setAttribute("keyWord", keyWord); // 关键字回显
        request.setAttribute("tabNum", tabNum); // 回显是哪个Tab页(tab1或tab2)
        request.setAttribute("newSort", sort.equals("DESC") ? "ASC" : "DESC");
        request.setAttribute("sort", sort);

        // 待批/已批的分页页码
        request.setAttribute("pageBeginNum1", PageUtil.getPageBeginNum(pageNo1, unapprovedListPage.getPageCount()));
        request.setAttribute("pageEndNum1", PageUtil.getPageEndNum(pageNo1, unapprovedListPage.getPageCount()));
        request.setAttribute("pageBeginNum2", PageUtil.getPageBeginNum(pageNo2, approvedListPage.getPageCount()));
        request.setAttribute("pageEndNum2", PageUtil.getPageEndNum(pageNo2, approvedListPage.getPageCount()));

        return "pages/approve/approveList";
    }






    // 审批
    public void approve(String applyId, String flag, String approverId, String approveRemark, String approveTime) {
        Apply findApply = approveMapper.getApplyById(applyId);
        if(findApply == null){
            System.out.println("这里应该抛个异常...");
            return;
        }

        EmpInfo loginEmp = empMapper.findEmpById(approverId);

        // 装配更新数据
        Map<String, String > datas = new HashMap<String, String>();

        // 先判断是否是几级审批(目前根据state判断:1级 0, 2级 3)
        if(SystemConstant.APPLY_STATE_WAIT.equals(findApply.getState())){
            // 进行1级审批
            if(SystemConstant.APPLY_STATE_REFUSE.equals(flag)){
                // 不通过
                datas.put("approverId", approverId);
                datas.put("flag", SystemConstant.APPLY_STATE_REFUSE); // 审批flag 1:同意 2不同意

            }else if(SystemConstant.APPLY_STATE_THROUGH.equals(flag)){
                // 通过,则判断是否需要2级审批(是否有上级部门[上级部门主管])
                //Dept parentDept = deptMapper.findParentDept(loginEmp.getDeptId());
                Employee parentDeptManager = empMapper.findParentDeptManager(loginEmp.getDeptId());
                if(parentDeptManager != null){
                    // 有上级部门,需要进入2进审批,置state为 second_level:3
                    datas.put("approverId", parentDeptManager.getUuid());
                    datas.put("flag", SystemConstant.APPLY_STATE_SECOND_LEVEL); // 审批flag 1:同意 2不同意
                }
            }
            datas.put("applyId", applyId);
            datas.put("approveRemark", approveRemark);
            datas.put("approveTime", approveTime);
            int result = approveMapper.approve(datas); // 1级审批

            // 写1级审批流程
            Map<String, String> params1 = new HashMap<String, String>();
            params1.put("applyId", applyId);
            params1.put("approverId1", loginEmp.getUuid());
            params1.put("approveTime1", approveTime);
            params1.put("result1", flag);
            params1.put("approveRemark1", approveRemark);

            approveMapper.firstLevelApprove(params1);  // 记录1级流程
        } else if(SystemConstant.APPLY_STATE_SECOND_LEVEL.equals(findApply.getState())){
            // 是2级审批,直接审批结束
            datas.put("approverId", approverId);
            datas.put("flag", flag); // 审批flag 1:同意 2不同意

            datas.put("applyId", applyId);
            datas.put("approveRemark", approveRemark);
            datas.put("approveTime", approveTime);
            int result = approveMapper.approve(datas); // 2级审批

            // 写2级审批流程
            Map<String, String> params2 = new HashMap<String, String>();
            params2.put("applyId", applyId);
            params2.put("approverId2", loginEmp.getUuid());
            params2.put("approveTime2", approveTime);
            params2.put("result2", flag);
            params2.put("approveRemark2", approveRemark);

            approveMapper.secondLevelApprove(params2); // 记录2级流程
        }

    }

    // 获取审批单详情
    public String showApplyDetails(HttpServletRequest request, String applyId, String state) {
        ApproveListResponse response = new ApproveListResponse();

        // 判断是否待批,执行不同的Sql,获取申请单详情
        if(SystemConstant.APPLY_STATE_WAIT.equals(state)){
            response = approveMapper.getUnapprovedDetailById(applyId);
        }else{
            response = approveMapper.getApprovedDetailById(applyId);
        }

        if(response == null) {
            System.out.println("这里应该抛个异常...找不到该申请单.");
            return null;
        }

        // 获取该申请单的审批流程
        ApproveProcessInfo processInfo = approveMapper.getProcessInfoByApplyId(applyId);

        // 返回数据
        request.setAttribute("approveDetails", response);
        request.setAttribute("processInfo", processInfo);
        return "pages/apply/applyDetail";
    }
}
