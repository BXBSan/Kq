package com.epro.kq.controller;

import com.alibaba.fastjson.JSON;
import com.epro.kq.domain.TolReport;
import com.epro.kq.interaction.AjaxResponse;
import com.epro.kq.interaction.apply.ApplyDetail;
import com.epro.kq.interaction.dept.DeptTree;
import com.epro.kq.interaction.report.CheckBillDetail;
import com.epro.kq.mappers.CheckBillInfoMapper;
import com.epro.kq.service.interfaces.ReportService;
import com.epro.kq.utils.ExcelServlet;
import com.epro.kq.utils.MyTimeUtils;
import com.epro.kq.utils.TolRExcel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/7/11.
 */
@Controller
@RequestMapping("report")
public class ReportController {
    @Autowired
    private CheckBillInfoMapper checkBillInfoMapper;
    @Autowired
    private ReportService service;
    @RequestMapping("toReport")
    public String toReport(HttpServletRequest request){
        DeptTree deptTree = service.getDeptTree();
        request.getSession().setAttribute("deptTree" , JSON.toJSONString(deptTree));
        return "pages/report/tolReport";
    }
    @RequestMapping("getAll")
    public String getAll(HttpServletRequest request,
                         @RequestParam(value = "date", defaultValue = "", required = false) String nowDate,
                         @RequestParam(value = "dept", defaultValue = "", required = false) String[] dept,
                         @RequestParam(value = "emp", defaultValue = "", required = false) String[] emp){
        if("".equals(nowDate)) {
            Date date = new Date();
            SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM");
            nowDate = sd.format(date);
        }
        List<TolReport> tolReports= service.getTolReport(nowDate,dept, emp);
        System.out.println("woquuuquuqu"+tolReports);
        request.setAttribute("dept",JSON.toJSONString(dept));
        request.setAttribute("tolReports" ,tolReports);
        request.setAttribute("nowDate" ,nowDate);

        return "pages/report/tolReport";
    }

    @RequestMapping("/export")
    public void export(HttpServletRequest request,HttpServletResponse response,
                         @RequestParam(value = "nowDate", defaultValue = "", required = false) String nowDate,
                         @RequestParam(value = "dept", defaultValue = "", required = false) String[] dept,
                         @RequestParam(value = "emp", defaultValue = "", required = false) String[] emp){
        if("".equals(nowDate)) {
            Date date = new Date();
            SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM");
            nowDate = sd.format(date);
        }
        List<TolReport> tolReports= service.getTolReport(nowDate, dept,emp);
        TolRExcel excel = new TolRExcel();
        assert excel != null;
        String path = servletContext.getRealPath("/report/tolReport.xls");
        excel.OutputExcel((ArrayList) tolReports,path);
        ExcelServlet servlet=new ExcelServlet();
        servlet.download(path,response);
    }

    @RequestMapping("/getCheckReport")
    public String getCheckReport(HttpServletRequest request,
                                 @RequestParam(value = "dept", defaultValue = "", required = false) String[] dept){
        String month=request.getParameter("hiredate");
        if(month!=null){
            request.getSession().setAttribute("month",month);
        }
        service.getCheckReport(request,month,dept);
        DeptTree deptTree = service.getDeptTree();
        request.getSession().setAttribute("deptTree" , JSON.toJSONString(deptTree));
        request.setAttribute("dept",JSON.toJSONString(dept));
        return "pages/report/checkReport";
    }
    @Autowired
    private ServletContext servletContext;
    @RequestMapping("/exCheckReport")
    @ResponseBody
    public void exCheckReport(HttpServletRequest request,HttpServletResponse response){
        AjaxResponse ajaxResponse = new AjaxResponse();
        try {
            service.exCheckReport(request,servletContext,response);
        } catch (IOException e) {
            e.printStackTrace();
        }
        ajaxResponse.setMsg("导出成功！");
    }

    @RequestMapping("/getApplyDetail")
    public String getApplyDetail(String empId,HttpServletRequest request,String nowDate){
        System.out.println(empId);
        List<ApplyDetail> leaveDetails = service.getApplyDetail(empId,"1",nowDate);
        List<ApplyDetail> overDetails = service.getApplyDetail(empId,"2",nowDate);
        List<ApplyDetail> takeDetails = service.getApplyDetail(empId,"3",nowDate);
        request.setAttribute("leaveDetails" , leaveDetails);
        request.setAttribute("overDetails" , overDetails);
        request.setAttribute("takeDetails" , takeDetails);
        request.setAttribute("empId" ,empId);
        request.setAttribute("nowDate" ,nowDate);
        return "pages/report/applyDetail";
    }
    @RequestMapping("/exApplyReport")
    public void exApplyReport(String empId,HttpServletResponse response,String nowDate){
        try {
            service.exApplyReport(empId,response,servletContext,nowDate);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getCheckBill")
    public String getCheckBill(String empId,HttpServletRequest request,String nowDate){
        Map<String,String> map=new HashMap<String, String>();

        if(nowDate==null||nowDate==""){
            Date date = new Date();
            SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM");
            nowDate = sd.format(date);
        }
        map.put("nowDate",nowDate);
        map.put("empId",empId);
        List<CheckBillDetail> CheckList=checkBillInfoMapper.getCheckBill(map);
        for(CheckBillDetail checkList:CheckList){
            checkList.setWorkTime(MyTimeUtils.getCheckTime(checkList.getCheckTime(),checkList.getEndTime()));
        }
        request.getSession().setAttribute("CheckList",CheckList);
        return "/pages/report/checkDetail";
    }

}
