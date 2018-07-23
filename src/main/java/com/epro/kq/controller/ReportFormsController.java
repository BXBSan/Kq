package com.epro.kq.controller;

import com.epro.kq.service.ApproveService;
import com.epro.kq.service.ReportFormService;
import com.epro.kq.service.interfaces.EmpService;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;

/**
 * Created by Administrator on 2016/7/5.
 */

@Controller
@RequestMapping("/reportform")
public class ReportFormsController {
    @Autowired
    private ReportFormService reportFormService;

    @Autowired
    private EmpService service;


    @Autowired
    private ApproveService approveService;


    @RequestMapping(value = "/showReportForm", method = RequestMethod.GET)
    public String showReportForm(HttpServletRequest request, HttpServletResponse response,
                        @RequestParam(value = "keyWord", required = false) String keyWord,
                        @RequestParam(value = "pageNo1", defaultValue = "1", required = false) int pageNo1,
                        @RequestParam(value = "pageNo2", defaultValue = "1", required = false) int pageNo2,
                        @RequestParam(value = "applyType", defaultValue = "All", required = true) String applyType,
                        @RequestParam(value = "tabNum", defaultValue = "tab1", required = false) String tabNum) {
        return reportFormService.showReportForm(request, response, pageNo1, pageNo2, keyWord, applyType, tabNum);
    }


    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
        String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/pages/download/sss.xlsx";

        //创建一个Excel文件
        try {
            File file = new File(path);
            OutputStream out = new FileOutputStream(file);
            //创建工作薄
            WritableWorkbook workbook = Workbook.createWorkbook(out);
            WritableSheet sheet = workbook.createSheet("当月申请单统计", 0);
            List<Integer> everyApplyTypeBillCountList = reportFormService.getEveryApplyTypeBillCount();
            Label leaverLabel = new Label(0, 0, "调休次数");
            Label overtimeLabel = new Label(1, 0, "加班次数");
            Label daysOffBillLabel = new Label(2, 0, "请假次数");
            sheet.addCell(leaverLabel);
            sheet.addCell(overtimeLabel);
            sheet.addCell(daysOffBillLabel);

            for (int i = 0; i < everyApplyTypeBillCountList.size(); i++) {
                Label label = new Label(i, 1, String.valueOf(everyApplyTypeBillCountList.get(i)));
                sheet.addCell(label);
            }
            workbook.write();
            workbook.close();
            out.close();

            response.setContentType("application/msexcel");// 定义输出类型
            response.setHeader("Content-Disposition", "attachment;filename=sss.xlsx");
            FileInputStream inputStream = new FileInputStream(file);
            out = response.getOutputStream();
            int b = 0;
            byte[] buffer = new byte[512];
            while (b != -1) {
                b = inputStream.read(buffer);
                out.write(buffer, 0, b);
            }
            inputStream.close();
            out.close();
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


