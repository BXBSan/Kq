package com.epro.kq.service;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Apply;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.approve.ApproveListResponse;
import com.epro.kq.interaction.approve.ApproveProcessInfo;
import com.epro.kq.mappers.ApplyMapper;
import com.epro.kq.mappers.ApproveMapper;
import com.epro.kq.mappers.EmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by asus2218 on 2016/6/25.
 */
@Service
public class ApplyService {
    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private ApproveMapper approveMapper;
    @Autowired
    private EmpMapper empMapper;

    public ModelAndView add(Apply apply) {
        ModelAndView mov = new ModelAndView("pages/apply/writeApply");
        String[] starts = apply.getStartDate().split(",");
        String[] ends = apply.getEndDate().split(",");
        apply.setStartDate(starts[1]);
        apply.setStartTime(starts[3]);
        apply.setEndDate(ends[1]);
        apply.setEndTime(ends[3]);
        apply.setState(SystemConstant.APPLY_STATE_WAIT);

        // (0720add)查找该员工所在部门的部门主管,设置为一级审批人
        Employee deptManager = empMapper.findDeptManager(apply.getEmpId());
        apply.setApproverId(deptManager.getUuid());

        try {
            applyMapper.add(apply);
            mov.setViewName("redirect:/apply/show");
            mov.addObject("msg", "申请成功！");
        } catch (Exception e) {
            e.printStackTrace();
            mov.addObject("msg", "申请失败！");
        }

        return mov;
    }

    public void deleteApply(String id) {
        try {
            applyMapper.delete(id);
            //mov.addObject("msg","删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            // mov.addObject("msg","删除失败！");
        }
    }

    public ModelAndView show(Map<String, Object> param) {
        ModelAndView mov = new ModelAndView("pages/apply/addApply");
        if (!param.get("id").equals("")) {
            try {
                applyMapper.delete((String) param.get("id"));
                mov.addObject("msg", "删除成功！");
            } catch (Exception e) {
                e.printStackTrace();
                mov.addObject("msg", "删除失败！");
            }
        }
//        param.put("state", "state = '0'");
        param.put("state", "state in ('0','3')");
        param.put("start", (((Integer) param.get("applyPageNo")) - 1) * SystemConstant.pageSize);
        System.out.println((String) param.get("startDate") + param.get("applyType"));
        int totalApply = applyMapper.getPage(param);
        System.out.println(param.get("start"));
        List<Apply> applyList = applyMapper.getApplyList(param);
        param.put("state", "state in ('1','2')");
        param.put("start", (((Integer) param.get("appliedPageNo")) - 1) * SystemConstant.pageSize);
        int totalApplied = applyMapper.getPage(param);
        List<Apply> appliedList = applyMapper.getApplyList(param);
        int pageCount = totalApply % SystemConstant.pageSize > 0 ? (totalApply / SystemConstant.pageSize + 1) : totalApply / SystemConstant.pageSize;
        int appliedPageCount = totalApplied % SystemConstant.pageSize > 0 ? (totalApplied / SystemConstant.pageSize + 1) : totalApplied / SystemConstant.pageSize;
        int applyPageNo = (Integer) param.get("applyPageNo");
        int appliedPageNo = (Integer) param.get("appliedPageNo");
        mov.addObject("applyType", param.get("applyType"));
        mov.addObject("startDate", param.get("startDate") != null ? param.get("startDate") : "");
        mov.addObject("applyList", applyList);
        mov.addObject("totalApply", totalApply);
        mov.addObject("totalApplied", totalApplied);
        mov.addObject("pageCount", pageCount);
        mov.addObject("appliedPageCount", appliedPageCount);
        mov.addObject("appliedList", appliedList);
        mov.addObject("applyPageNo", applyPageNo);
        mov.addObject("appliedPageNo", appliedPageNo);
        mov.addObject("applyPageMap", startAndEndPage(applyPageNo, pageCount));
        mov.addObject("appliedPageMap", startAndEndPage(appliedPageNo, appliedPageCount));
        mov.addObject("order", ((String) param.get("order")).equals("order by startdate DESC") ? "order by startdate ASC" : "order by startdate DESC");
        mov.addObject("thisOrder", param.get("order"));
        return mov;
    }

    private Map<String, Integer> startAndEndPage(int pageNo, int pageCount) {
        Map<String, Integer> map = new HashMap<String, Integer>();
        if (pageNo + 2 < pageCount) {
            if (pageNo >= 3) {
                map.put("startPage", pageNo - 2);
                map.put("endPage", pageNo + 2);
            } else {
                map.put("startPage", 1);
                map.put("endPage", 5);
            }
        } else {
            if (pageCount < 5) {
                map.put("startPage", 1);
            } else {
                map.put("startPage", pageCount - 4);
            }
            map.put("endPage", pageCount);
        }
        return map;
    }

    public ModelAndView details(String applyId, String state, String flag) {
        ModelAndView mov = new ModelAndView("pages/apply/applyDetail");
        ApproveListResponse approveDetails = new ApproveListResponse();

        // 判断是否待批,执行不同的Sql
        if (SystemConstant.APPLY_STATE_WAIT.equals(state)) {
            approveDetails = approveMapper.getUnapprovedDetailById(applyId);
        } else {
            approveDetails = approveMapper.getApprovedDetailById(applyId);
        }
        mov.addObject("approveDetails", approveDetails);
        mov.addObject("flag", flag);

        // 审批流程
        ApproveProcessInfo processInfo = approveMapper.getProcessInfoByApplyId(applyId);
        mov.addObject("processInfo", processInfo);
        return mov;
    }

    public List<Employee> getEmpList() {
        return applyMapper.getEmpList();
    }
}
