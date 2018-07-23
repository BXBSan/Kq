package com.epro.kq.controller;

import com.epro.kq.domain.Apply;
import com.epro.kq.domain.Employee;
import com.epro.kq.service.ApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by asus2218 on 2016/6/25.
 */
@Controller
@RequestMapping("/apply")
public class ApplyControler {
    @Autowired
    private ApplyService applyService;

    @RequestMapping("/showWrite")
    public String showWrite(HttpSession session) {
        String roleId = ((Employee) session.getAttribute("emp")).getRoleId();
        List<Employee> empList = null;
        if (roleId.equals("d16249e8-8cf0-1034-a809-c1a90b3d119b")) {
            empList = applyService.getEmpList();
        }
        session.setAttribute("empList", empList);
        return "pages/apply/writeApply";
    }

    @RequestMapping("/delete")
    public ModelAndView deleteApply(String id) {
        applyService.deleteApply(id);
        return new ModelAndView();
    }

    @RequestMapping("/show")
    public ModelAndView show(HttpServletRequest request,
            @RequestParam(value = "applyPageNo", defaultValue = "1", required = false) int applyPageNo,
            @RequestParam(value = "appliedPageNo", defaultValue = "1", required = false) int appliedPageNo,
            @RequestParam(value = "startDate", defaultValue = "", required = false) String startDate,
            @RequestParam(value = "applyType", defaultValue = "all", required = false) String applyType,
            @RequestParam(value = "table", defaultValue = "table1", required = false) String table,
            @RequestParam(value = "id", defaultValue = "", required = false) String id,
            @RequestParam(value = "order", defaultValue = "", required = false) String order) {
        Employee loginEmp = (Employee)request.getSession().getAttribute("emp");

        Map<String, Object> param = new HashMap();
        param.put("empId", loginEmp.getUuid());
        param.put("applyPageNo", applyPageNo);
        param.put("appliedPageNo", appliedPageNo);
        param.put("startDate", startDate.equals("") ? null : startDate);
        param.put("applyType", applyType);
        param.put("id", id); // applyId,删除时才有值
        param.put("order", order.equals("") ? "order by createtime desc" : order);
        System.out.println(startDate + applyType);
        ModelAndView mov = applyService.show(param);
        mov.addObject("table", table);
        System.out.println(mov.getModel().get("pageCount"));
        System.out.println(((List) mov.getModel().get("applyList")).size());
        return mov;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView add(Apply apply, HttpServletRequest request) {

        return applyService.add(apply);
    }

    @RequestMapping("/details")
    public ModelAndView details(String id, String state, String flag) {
        return applyService.details(id, state, flag);
    }


}
