package com.epro.kq.utils;

import com.epro.kq.domain.TolReport;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

public class TolRExcel{
    WritableWorkbook book=null;
    public void OutputExcel(ArrayList arlist,String Path){
        try{
            book = Workbook.createWorkbook(new File(Path));
            WritableSheet sheet = book.createSheet("总报表",0);
            Label labe1 = new Label(0, 0, "员工号" );
            Label labe2 = new Label(1, 0, "员工姓名" );
            Label labe3 = new Label(2, 0, "打卡次数");
            Label labe4 = new Label(3, 0, "请假次数");
            Label labe5 = new Label(4, 0, "加班次数");
            Label labe6 = new Label(5, 0, "调休次数");
            sheet.addCell(labe1);
            sheet.addCell(labe2);
            sheet.addCell(labe3);
            sheet.addCell(labe4);
            sheet.addCell(labe5);
            sheet.addCell(labe6);
            Iterator it = arlist.iterator();
            int i = 1;
            while(it.hasNext()){TolReport tolReport = (TolReport )it.next();
                Label label1=new Label(0,i,tolReport.getEmpNo());
                Label label2=new Label(1,i,tolReport.getEmpName());
                Label label3=new Label(2,i,Integer.toString(tolReport.getClockNum()));
                Label label4=new Label(3,i,Integer.toString(tolReport.getLeaveNum()));
                Label label5=new Label(4,i,Integer.toString(tolReport.getOverTime()));
                Label label6=new Label(5,i,Integer.toString(tolReport.getOffNum()));
                sheet.addCell(label1);
                sheet.addCell(label2);
                sheet.addCell(label3);
                sheet.addCell(label4);
                sheet.addCell(label5);
                sheet.addCell(label6);
                i++;
            }
            book.write();
            book.close();
        } catch (RowsExceededException e) {
            e.printStackTrace();
        } catch (WriteException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally{
            try{
                if(book!=null)book.close();
            }catch(Exception e){
                System.out.println("exception when closing Connection in finally");
                System.out.println(e.getMessage().toString());
            }
        }
    }


}