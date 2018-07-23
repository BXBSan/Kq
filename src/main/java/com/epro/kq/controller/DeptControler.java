package com.epro.kq.controller;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Dept;
import com.epro.kq.interaction.dept.DeptInfo;
import com.epro.kq.mappers.DeptMapper;
import com.epro.kq.service.interfaces.DepService;
import com.epro.kq.utils.ExcelServlet;
import com.epro.kq.utils.deptExcel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/6/27.
 */
@Controller
@RequestMapping("/dept")
public class DeptControler {
    @Autowired
    private DepService service;

    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request) {
        String integer = request.getParameter("showPage");
        if (integer == null) {
            integer = "1";
        }
        int showPage = Integer.parseInt(integer);
        int count = service.getCount();
        System.out.println(count);
        int pageSize = SystemConstant.pageSize;
        int pageCount = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize + 1);

        //List<Dept> depts = service.deptAll((showPage-1)*pageSize,pageSize);
        List<DeptInfo> deptList = service.getDeptList((showPage - 1) * pageSize, pageSize);

        request.setAttribute("showPage", showPage);
        request.setAttribute("pageCount", pageCount);
        //request.setAttribute("depts",depts);
        request.setAttribute("depts", deptList);
        return "pages/dept/dept";
    }

    @RequestMapping("/findByNo")
    public String findByName(HttpServletRequest request) {
        String deptNo = request.getParameter("deptNo");
        Dept dept = service.findByDeptNo(deptNo);
        List<Dept> depts = new ArrayList<Dept>();
        depts.add(dept);
        request.setAttribute("depts", depts);
        return "pages/dept/dept";
    }

    @RequestMapping("/toAdd")
    public String toAdd(HttpServletRequest request) {
        service.toAdd(request);

        return "pages/dept/addDept";
    }

    @RequestMapping("/addDept")
    public String addDept(HttpServletRequest request, Dept dept) {
        System.out.println("666:"+dept);
        return service.insert(request, dept);
    }

    @RequestMapping("/load")
    public String load(HttpServletRequest request) {
        //String deptNo=request.getParameter("deptNo");
        //Dept dept=service.findByDeptNo(deptNo);

        String deptId = request.getParameter("deptId");
        return service.findDeptById(request, deptId);
    }

    @RequestMapping("/update")
    public String updateDept(HttpServletRequest request, Dept dept) {
        return service.updateDept(request, dept);
    }

    @RequestMapping("/delete")
    public String deleteDept(HttpServletRequest request) {
//        String deptNo=request.getParameter("deptNo");
//        service.deleteDept(deptNo);

        String deptId = request.getParameter("deptId");
        service.deleteDeptById(deptId);
        return "redirect:getAll";
    }

    @RequestMapping("/export")
    public String export(HttpServletRequest request, HttpServletResponse response) {
        int count = service.getCount();
        List<Dept> detp2 = service.deptAll(0, count - 1);
        deptExcel excel = new deptExcel();
        assert excel != null;
        excel.OutputExcel((ArrayList) detp2, "C://Users/Administrator/Desktop/dept.xls");
        ExcelServlet servlet = new ExcelServlet();
        servlet.download("C://Users/Administrator/Desktop/dept.xls", response);
        return "redirect:getAll";
    }

}
