package com.epro.kq.utils;

import com.epro.kq.domain.Dept;
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

public class deptExcel{
    WritableWorkbook book=null;
    public void OutputExcel(ArrayList arlist,String Path){
        try{
            book = Workbook.createWorkbook(new File(Path));
            WritableSheet sheet = book.createSheet("部门信息",0);
            Label labe1 = new Label(0, 0, "部门名" );
            Label labe2 = new Label(1, 0, "部门号");
            Label labe3 = new Label(2, 0, "管理ID");
            Label labe4 = new Label(3, 0, "创建时间");
            Label labe5 = new Label(4, 0, "更新时间");
            sheet.addCell(labe1);
            sheet.addCell(labe2);
            sheet.addCell(labe3);
            sheet.addCell(labe4);
            sheet.addCell(labe5);
            Iterator it = arlist.iterator();
            int i = 1;
            while(it.hasNext()){Dept dept = (Dept)it.next();
                Label label1=new Label(0,i,dept.getDeptName());
                Label label2=new Label(1,i,dept.getDeptNo());
                Label label3=new Label(2,i,dept.getEmployeeId());
                Label label4=new Label(3,i,dept.getCreateTime());
                Label label5=new Label(4,i,dept.getUpdateTime());
                sheet.addCell(label1);
                sheet.addCell(label2);
                sheet.addCell(label3);
                sheet.addCell(label4);
                sheet.addCell(label5);
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