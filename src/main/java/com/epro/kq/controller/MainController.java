package com.epro.kq.controller;

import com.epro.kq.domain.CheckBill;
import com.epro.kq.domain.Employee;
import com.epro.kq.mappers.RoleMapper;

import com.epro.kq.service.CheckBillInfoService;
import com.epro.kq.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/5/9.
 */
@Controller
@RequestMapping("/main")
public class  MainController {
    @Autowired
    private CheckBillInfoService checkBillInfoService;

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpServletRequest request) {
        loginService.updateSessionValue(request);
        return "pages/index";
    }

    @RequestMapping(value="/checkinfo")
    public String getCheckList(HttpServletRequest request) {
        Map<String,String> map=new HashMap<String, String>();
        Date date=new Date();
        SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM");
        String nowDate=sd.format(date);
        Employee emp=(Employee) request.getSession().getAttribute("emp");
        String uuid=emp.getUuid();
        map.put("nowDate",nowDate);
        map.put("empid",uuid);
        List<CheckBill> info= checkBillInfoService.getCheckBillInfo(map);
        request.setAttribute("CheckList" ,info);

        return "pages/index";
    }

    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String goErrorPage() {
        return "errorPage";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logOut(HttpServletRequest request){
        Enumeration enumeration = request.getSession().getAttributeNames();
        while(enumeration.hasMoreElements()){
            request.getSession().removeAttribute(enumeration.nextElement().toString());
        }
        return "redirect:/login.jsp";
}

    @RequestMapping("/getApplyInfo")
    public ModelAndView getApplyInfo(HttpServletRequest request,String applyType){
        String empId = ((Employee)request.getSession().getAttribute("emp")).getUuid();
        return checkBillInfoService.getApplyInfo(applyType,empId);
    }


}
