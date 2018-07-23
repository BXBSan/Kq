package com.epro.kq.controller;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Employee;
import com.epro.kq.service.interfaces.EmpService;
import com.epro.kq.utils.ExcelServlet;
import com.epro.kq.utils.empExcel;
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2016/6/27.
 */
@Controller
@RequestMapping("/emp")
public class EmpControler {
    @Autowired
    private EmpService service;


    /**
     * 带分页查询员工
     */
    @RequestMapping("/getAll")
    public String getAll(HttpServletRequest request) {
        String integer = request.getParameter("showPage");
        if (integer == null) {
            integer = "1";
        }
        int showPage = Integer.parseInt(integer);
        int Count = service.getCount();
        int pageSize = SystemConstant.pageSize;
        int pageCount = (Count % pageSize == 0) ? (Count / pageSize) : (Count / pageSize + 1);
        System.out.println((showPage - 1) * pageSize + 1);
        System.out.println(pageSize);
        System.out.println(pageCount);
        List<Employee> emps = service.empAll((showPage - 1) * pageSize, pageSize);
        request.setAttribute("showPage", showPage);
        request.setAttribute("pageCount", pageCount);
        System.out.println(emps.toString());
        request.setAttribute("emps", emps);
        return "pages/employee/employee";

    }

    //跳转到新增页面
    @RequestMapping("/toAdd")
    public String toAdd(HttpServletRequest request) {
        System.out.println("此处应有掌声" + request.getSession().getServletContext().getRealPath("/"));
        service.goAddEmp(request);
        return "pages/employee/addEmp";
    }

    /**
     * 新增员工
     *
     * @param emp
     * @return
     */
    @RequestMapping("/addEmp")
    public String addEmp(HttpServletRequest request, Employee emp) {
        System.out.println("666:" + emp);
        return service.insert(request, emp);
    }

    @RequestMapping("/load")
    public String load(HttpServletRequest request) {
        /*String empNo = request.getParameter("empNo");
        Employee emp = service.findByEmpNo(empNo);*/

        // 改为根据Id查
        String empId = request.getParameter("empId");

        service.loadEmpInfo(request, empId);

        return "pages/employee/updateEmp";
    }

    /**
     * 修改员工信息
     *
     * @param emp
     * @return
     */
    @RequestMapping("/update")
    public String updateEmp(Employee emp) {
        service.updateEmp(emp);
        System.out.println(emp.getUuid());
        System.out.println(emp.toString());
        return "redirect:getAll";
    }

    /**
     * 删除员工
     *
     * @param request
     * @return
     */
    @RequestMapping("/delete")
    public String deleteEmp(HttpServletRequest request) {
        String empId = request.getParameter("empId");
        service.deleteEmp(empId);
        return "redirect:getAll";
    }

    /**
     * 根据员工编号查
     *
     * @param request
     * @return
     */
    @RequestMapping("/findByNo")
    public String findByNo(HttpServletRequest request) {
        String empNo = request.getParameter("empNo");
        Employee emp = service.findByEmpNo(empNo);
        List<Employee> emps = new ArrayList<Employee>();
        emps.add(emp);
        request.setAttribute("emps", emps);
        return "pages/employee/employee";
    }

    @RequestMapping("/export")
    public String export(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int count = service.getCount();
        List<Employee> emp2 = service.empAll(0, count - 1);
        empExcel empExcel = new empExcel();
        assert empExcel != null;
        empExcel.OutputExcel((ArrayList) emp2, "C://Users/Administrator/Desktop/employee.xls");
        ExcelServlet servlet = new ExcelServlet();
        servlet.download("C://Users/Administrator/Desktop/employee.xls", response);
        return "redirect:getAll";
    }

    @RequestMapping("/upload")
    public String upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=GB2312");
        PrintWriter out = response.getWriter();
        try {
            DiskFileUpload fu = new DiskFileUpload();
            // 设置允许用户上传文件大小,单位:字节，这里设为2m
            fu.setSizeMax(2 * 1024 * 1024);
            // 设置最多只允许在内存中存储的数据,单位:字节
            fu.setSizeThreshold(4096);
            // 设置一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录
            fu.setRepositoryPath("c://windows//temp");
            //开始读取上传信息
            List fileItems = fu.parseRequest(request);
            // 依次处理每个上传的文件
            Iterator iter = fileItems.iterator();

            //正则匹配，过滤路径取文件名
            String regExp = ".+////(.+)$";

            //过滤掉的文件类型
            String[] errorType = {".exe", ".com", ".cgi", ".asp"};
            Pattern p = Pattern.compile(regExp);
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                //忽略其他不是文件域的所有表单信息
                if (!item.isFormField()) {
                    String name = item.getName();
                    long size = item.getSize();
                    if ((name == null || name.equals("")) && size == 0)
                        continue;
                    Matcher m = p.matcher(name);
                    boolean result = m.find();
                    if (result) {
                        for (int temp = 0; temp < errorType.length; temp++) {
                            if (m.group(1).endsWith(errorType[temp])) {
                                throw new IOException(name + ": wrong type");
                            }
                        }
                        try {

                            //保存上传的文件到指定的目录

                            //在下文中上传文件至数据库时，将对这里改写
                            item.write(new File("d://" + m.group(1)));

                            out.print(name + "  " + size + "");
                        } catch (Exception e) {
                            out.println(e);
                        }

                    } else {
                        throw new IOException("fail to upload");
                    }
                }
            }
        } catch (IOException e) {
            out.println(e);
        } catch (FileUploadException e) {
            out.println(e);
        }
        return "redirect:getAll";
    }

    @RequestMapping(value = "/photo_upload", method = RequestMethod.POST)
    public @ResponseBody Map uploadEmpPhoto(HttpServletRequest request, HttpServletResponse response,
                              @RequestParam(value = "empPhoto", required = true) MultipartFile empPhoto) throws Exception {
        Map resultMap = new HashMap();
        System.out.println("haha:" + empPhoto.getOriginalFilename());

        resultMap.put("info", "成功!");
        return resultMap;
    }


}
