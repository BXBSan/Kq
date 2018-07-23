package com.epro.kq.utils;

import com.epro.kq.interaction.apply.ApplyDetail;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by asus2218 on 2016/7/20.
 */
public class ApplyDetailExcel {
    private  WritableWorkbook book=null;
    private File file = null;
    public ApplyDetailExcel(String path) throws IOException {
        File dirs = new File(path);
        if(!dirs.exists()){
            dirs.mkdirs();
        }
        String fileName = new SimpleDateFormat("yyyyMM").format(new Date())+".xls";
        file = new File(path,fileName);
        book = Workbook.createWorkbook(file);
    }
    public File wirite(){
        try {
            if( book != null) {
                book.write();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                book.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return file;
    }
    public void addSheet(String sheetName,int index,List<ApplyDetail> applyDetails){
        try {
            WritableSheet sheet = book.createSheet(sheetName,index);
            Label labe1 = new Label(0, 0, "员工号" );
            Label labe2 = new Label(1, 0, "申请人" );
            Label labe3 = new Label(2, 0, "类别");
            Label labe4 = new Label(3, 0, "开始日期");
            Label labe5 = new Label(4, 0, "结束日期");
            Label labe6 = new Label(5, 0, "审批人");
            sheet.addCell(labe1);
            sheet.addCell(labe2);
            sheet.addCell(labe3);
            sheet.addCell(labe4);
            sheet.addCell(labe5);
            sheet.addCell(labe6);
            if(applyDetails.size() > 0) {
                for (int i = 0; i < applyDetails.size(); i++) {
                    String type = "";
                    if (applyDetails.get(i).getApplyType().equals("1")) {
                        type = "请假";
                    } else if (applyDetails.get(i).getApplyType().equals("2")) {
                        type = "加班";
                    } else {
                        type = "调休";
                    }
                    sheet.addCell(new Label(0, i + 1, applyDetails.get(i).getEmpNo()));
                    sheet.addCell(new Label(1, i + 1, applyDetails.get(i).getApplyName()));
                    sheet.addCell(new Label(2, i + 1, type));
                    sheet.addCell(new Label(3, i + 1, applyDetails.get(i).getStartDate()));
                    sheet.addCell(new Label(4, i + 1, applyDetails.get(i).getEndDate()));
                    sheet.addCell(new Label(5, i + 1, applyDetails.get(i).getApproveName()));
                }
            }else{
                sheet.addCell(new Label(0,1,"该员工在该月未申请"+sheetName));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
