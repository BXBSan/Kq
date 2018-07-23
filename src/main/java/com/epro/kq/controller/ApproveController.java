package com.epro.kq.controller;

import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.approve.ApproveListResponse;
import com.epro.kq.service.ApproveService;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

@Controller
@RequestMapping("/approve")
public class ApproveController {
    @Autowired
    private ApproveService approveService;

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String show(HttpServletRequest request, HttpServletResponse response,
                       @RequestParam(value = "keyWord", required = false) String keyWord,
                       @RequestParam(value = "pageNo1", defaultValue = "1", required = false) int pageNo1,
                       @RequestParam(value = "pageNo2", defaultValue = "1", required = false) int pageNo2,
                       @RequestParam(value = "applyType", defaultValue = "All", required = true) String applyType,
                       @RequestParam(value = "tabNum", defaultValue = "tab1", required = false) String tabNum,
                       @RequestParam(value = "sort", defaultValue = "DESC", required = false) String sort){
        return approveService.show(request, response, pageNo1, pageNo2, keyWord, applyType, tabNum, sort);
    }

    @RequestMapping(value = "/doapprove", method = RequestMethod.GET)
    public String approve(@RequestParam(value = "applyId", required = true) String applyId,
                          //@RequestParam(value = "approverId", required = true) String approverId,
                          @RequestParam(value = "approveRemark", required = false, defaultValue = "无") String approveRemark,
                          @RequestParam(value = "flag", required = true) String flag,
                          HttpServletRequest request){ // 审批flag 1:同意 2不同意
        //System.out.println("........");
        //AjaxResponse ajaxResponse = new AjaxResponse();

        // 获取当前登录员工信息
        Employee currentEmp = (Employee)request.getSession().getAttribute("emp");

        String approveTime = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");

        approveService.approve(applyId, flag, currentEmp.getUuid(), approveRemark, approveTime);

        return "redirect:/approve/show";
    }

    @RequestMapping(value = "/details", method = RequestMethod.GET)
    public String showApplyDetails(HttpServletRequest request,
            @RequestParam(value = "applyId", required = true) String applyId,
            @RequestParam(value = "state", required = true) String state){
        // state: 0待批 1已批
        return approveService.showApplyDetails(request, applyId, state);
    }

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String test(){
        return "index";
    }
}
