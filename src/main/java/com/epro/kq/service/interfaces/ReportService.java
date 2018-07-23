package com.epro.kq.service.interfaces;

import com.epro.kq.domain.TolReport;
import com.epro.kq.interaction.apply.ApplyDetail;
import com.epro.kq.interaction.dept.DeptTree;
import com.epro.kq.interaction.report.CheckBillDetail;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/11.
 */
public interface ReportService {
    List<TolReport> getTolReport(String nowDate, String[] dept, String[] emp);


    void getCheckReport(HttpServletRequest request, String month, String[] dept);

    void exCheckReport(HttpServletRequest request, ServletContext servletContext, HttpServletResponse response) throws IOException;


    List<ApplyDetail> getApplyDetail(String empId, String type, String nowDate);

    void exApplyReport(String empId, HttpServletResponse response, ServletContext servletContext, String nowDate) throws IOException;

    DeptTree getDeptTree();

}
