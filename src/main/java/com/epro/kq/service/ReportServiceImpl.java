package com.epro.kq.service;

import com.epro.kq.domain.Employee;
import com.epro.kq.domain.TolReport;
import com.epro.kq.interaction.apply.ApplyDetail;
import com.epro.kq.interaction.dept.DeptTree;
import com.epro.kq.interaction.report.CheckRoportRespose;
import com.epro.kq.mappers.ApplyMapper;
import com.epro.kq.mappers.EmpMapper;
import com.epro.kq.mappers.ReportMapper;
import com.epro.kq.service.interfaces.ReportService;
import com.epro.kq.utils.ApplyDetailExcel;
import com.epro.kq.utils.DateUtils;
import com.epro.kq.utils.ExcelServlet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/7/18.
 */
@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private ReportMapper mapper;
    @Autowired
    private ApplyMapper applyMapper;
    @Autowired
    private EmpMapper empMapper;

    public String getParam(String[] arr,String name){
        String param = "";
        if(arr.length > 0 ) {
            param = name+" in (";
            for(int i = 0;i < arr.length;i ++){
                if (i > 0){
                    param += ",";
                }
                param += "'"+ arr[i] + "'";
            }
            param += ")";
        }
        return param;
    }
    public List<TolReport> getTolReport(String nowDate, String[] dept, String[] emp) {
        Map<String,String> params=new HashMap<String,String>();
        String depts = getParam(dept,"deptid");
        String emps = getParam(emp,"uuid");
        params.put("nowDate",nowDate);
        System.out.println(depts);
        params.put("depts" ,depts);
        params.put("emps",emps);
        List<Employee> emp2 =empMapper.findEmpByDept(params);
        System.out.println("emp2"+emp2);
        List<TolReport> tolreports=new ArrayList<TolReport>();
        for(int i=0;i<emp2.size();i++){
            params.put("uuid",emp2.get(i).getUuid());
            TolReport tolreport=mapper.getTolReport(params);
            tolreports.add(tolreport);
        }
        return tolreports;
    }


    public void getCheckReport(HttpServletRequest request, String month, String[] dept) {
        String date=null;
        if(month==null) {
            date = new SimpleDateFormat("yyyy-MM").format(new Date());
        }else{
            date=month;
        }
        Map<String,Integer> map= DateUtils.getdays();
        List<CheckRoportRespose> laterCounts = mapper.getLaterCounts(date);
        List<CheckRoportRespose> earlyCounts = mapper.getEarlyCounts(date);
        //一月中各用户打卡两次(打卡通过)的天数统计
        List<CheckRoportRespose> passCounts=mapper.getPassCounts(date);
        List<CheckRoportRespose> allCounts = null;
        for(CheckRoportRespose laterCount:laterCounts){
            Iterator<CheckRoportRespose> it = earlyCounts.iterator();
            while (it.hasNext()){
                CheckRoportRespose earlyCount = it.next();
                if(laterCount.getEmpName().equals(earlyCount.getEmpName())){
                    laterCount.setEarlyCount(earlyCount.getEarlyCount());
                    it.remove();
                }
            }
        }
        allCounts = laterCounts;
        if(earlyCounts.size() > 0){
            for(CheckRoportRespose earlyCount:earlyCounts){
                allCounts.add(earlyCount);
            }
        }

        Map<String,String> param = new HashMap<String, String>();
        param.put("dept", getParam(dept,"deptid"));
        List<CheckRoportRespose> empCounts = mapper.getEmpCounts(param);
        for(CheckRoportRespose empCount:empCounts){
            for( CheckRoportRespose allCount:allCounts){
                if(empCount.getEmpName().equals(allCount.getEmpName())){
                    empCount.setEarlyCount(allCount.getEarlyCount());
                    empCount.setLaterCount(allCount.getLaterCount());
                }
            }
        }
        for(CheckRoportRespose empCount:empCounts){
            for(CheckRoportRespose passCount:passCounts){
                if(empCount.getEmpName().equals(passCount.getEmpName())){
                    empCount.setTwoCounts(passCount.getTwoCounts());
                    empCount.setNullCounts(map.get("date")-passCount.getTwoCounts()-map.get("counts"));
                }
            }
        }
        for(CheckRoportRespose empCount:empCounts){
            if(map.get("date")>1&&empCount.getTwoCounts()==0){
                empCount.setNullCounts(map.get("date")-map.get("counts"));
            }
        }

        request.getSession().setAttribute("allCounts" ,empCounts);
    }


    public void exCheckReport(HttpServletRequest request, ServletContext servletContext, HttpServletResponse response) throws IOException {
        List<CheckRoportRespose> allCounts = (ArrayList<CheckRoportRespose>)request.getSession().getAttribute("allCounts");

        //新建一个excel文档
        String path = servletContext.getRealPath("/report/");
        File dirs = new File(path);
        if(!dirs.exists()){
            dirs.mkdirs();
        }
        String fileName = new Date().getTime()+".xls" ;
        File file = new File(path,fileName);
        WritableWorkbook book=null;
        try {
            book = Workbook.createWorkbook(file);
            WritableSheet sheet = book.createSheet("考勤报表",0);
            Label labe1 = new Label(0, 0, "员工号" );
            Label labe2 = new Label(1, 0, "员工姓名" );
            Label labe3 = new Label(2, 0, "迟到次数");
            Label labe4 = new Label(3, 0, "早退次数");
            Label labe5 = new Label(3, 0, "旷工次数");
            sheet.addCell(labe1);
            sheet.addCell(labe2);
            sheet.addCell(labe3);
            sheet.addCell(labe4);
            sheet.addCell(labe5);
            for(int i = 0;i < allCounts.size();i++){
                sheet.addCell(new Label(0, i+1, allCounts.get(i).getEmpNo()));
                sheet.addCell(new Label(1, i+1, allCounts.get(i).getEmpName()));
                sheet.addCell(new Label(2, i+1, String.valueOf(allCounts.get(i).getLaterCount())));
                sheet.addCell(new Label(3, i+1, String.valueOf(allCounts.get(i).getEarlyCount())));
                sheet.addCell(new Label(4, i+1, String.valueOf(allCounts.get(i).getNullCounts())));
            }
            book.write();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                if( book != null){
                    book.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            } catch (WriteException e) {
                e.printStackTrace();
            }
        }

        //下载文件
        ExcelServlet excelServlet = new ExcelServlet();
        excelServlet.download(path +"/"+ fileName, response);
    }


    public List<ApplyDetail> getApplyDetail(String empId, String type, String nowDate) {
        Map<String,String> param = new HashMap<String, String>();
        param.put("empId",empId);
        param.put("type" ,type);
        param.put("date",nowDate);
        List<ApplyDetail> applyDetails = applyMapper.getApplyDetail(param);
        return applyDetails;
    }


    public void exApplyReport(String empId, HttpServletResponse response, ServletContext servletContext, String nowDate) throws IOException {
        List<ApplyDetail> leaveDetails = getApplyDetail(empId,"1", nowDate);
        List<ApplyDetail> overDetails = getApplyDetail(empId,"2", nowDate);
        List<ApplyDetail> takeDetails = getApplyDetail(empId,"3", nowDate);
        //新建一个excel文档
        ApplyDetailExcel applyDetailExcel = new ApplyDetailExcel(servletContext.getRealPath("/report/"));
        applyDetailExcel.addSheet("请假",0,leaveDetails);
        applyDetailExcel.addSheet("加班",1,overDetails);
        applyDetailExcel.addSheet("调休",2,takeDetails);
        File outfile = applyDetailExcel.wirite();

        //下载文件
        ExcelServlet excelServlet = new ExcelServlet();
        System.out.println(outfile.getPath());
        excelServlet.download(outfile.getPath(), response);
    }

    private DeptTree rootDept = null;
    private DeptTree nowDept = null;
    public DeptTree getDeptTree() {
        List<DeptTree> rootDepts = mapper.getDeptTree("-1");
        rootDept = rootDepts.get(0);
        nowDept = rootDept;
        makeDeptTrees(rootDept.getUuid());
        return rootDept;
    }

    private void makeDeptTrees(String uuid){
        List<DeptTree> sdept = mapper.getDeptTree(uuid);
        if(sdept != null) {
            nowDept.setSdept(sdept);
            Iterator<DeptTree> it = sdept.iterator();
            while (it.hasNext()) {
                DeptTree dt = it.next();
                nowDept = dt;
                makeDeptTrees(dt.getUuid());
            }
        }else{
            return;
        }
    }


}
