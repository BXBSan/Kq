package com.epro.kq.service;

import com.epro.kq.common.BasePage;
import com.epro.kq.common.SystemConstant;
import com.epro.kq.interaction.approve.ApproveListResponse;
import com.epro.kq.interaction.approve.ReportFormsResponse;
import com.epro.kq.mappers.ApproveMapper;
import com.epro.kq.mappers.CheckBillMapper;
import com.epro.kq.mappers.ReportFormMapper;
import com.epro.kq.utils.PageUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/7/5.
 */
@Service
public class ReportFormService {
    @Autowired
    private CheckBillMapper checkBillMapper;


    @Autowired
    private ApproveMapper approveMapper;


    @Autowired
    private ReportFormMapper reportFormMapper;


    public String showReportForm(HttpServletRequest request, HttpServletResponse response,
                                int pageNo1, int pageNo2, String keyWord, String applyType, String tabNum) {
        if(StringUtils.isEmpty(keyWord)){
            keyWord = null;
        }
        Map<String, String> params = new HashMap<String, String>();
        params.put("pageSize", SystemConstant.pageSize + "");
        params.put("limitStart1", PageUtil.getLimitStartNum(pageNo1) + "");
        params.put("limitStart2", PageUtil.getLimitStartNum(pageNo2) + "");
        params.put("keyWord", "%" + keyWord + "%");
        params.put("applyType", applyType);

        // 1.查询未审批列表
        BasePage applyListPage = new BasePage();
        List<ReportFormsResponse> applyList = reportFormMapper.getApplyList(params);
        for (int i=0;i<applyList.size();i++){
            Map<String,Integer> countMap = new HashMap<String,Integer>();
            int leaverCount = getEveryEmpApplyBillCount(applyList.get(i).getEmpId(),"startdate","applybill","1");
            int overtimeCount = getEveryEmpApplyBillCount(applyList.get(i).getEmpId(),"startdate","applybill","2");
            int daysOffBillCount = getEveryEmpApplyBillCount(applyList.get(i).getEmpId(),"startdate","applybill","3");
            applyList.get(i).setLeaveBillCount(leaverCount);
            applyList.get(i).setWorkOverTimeBillCount(overtimeCount);
            applyList.get(i).setDaysOffBillCount(daysOffBillCount);
        }

        int applyCount = reportFormMapper.getApplyCount(params);
        applyListPage.setPageCount((applyCount + SystemConstant.pageSize - 1)/SystemConstant.pageSize);
        applyListPage.setPageNo(pageNo1);
        applyListPage.setTotalCount(applyCount);
        applyListPage.setDataList(applyList);
        request.setAttribute("applyListPage", applyListPage);
        // request.setAttribute("approvedListPage", approvedListPage);
        request.setAttribute("applyType", applyType); // 将类型传回前端
        request.setAttribute("keyWord", keyWord); // 关键字回显
        request.setAttribute("tabNum", tabNum); // 回显是哪个Tab页(tab1或tab2)
        request.setAttribute("pageBeginNum1", PageUtil.getPageBeginNum(pageNo1, applyListPage.getPageCount()));
        request.setAttribute("pageEndNum1", PageUtil.getPageEndNum(pageNo1, applyListPage.getPageCount()));

        return "pages/report/reportForm";
    }


    //获取某个用户申请单数量
    public int getEveryEmpApplyBillCount(String empId,String columnDate,String tableName,String applyType){
        Date date = new Date();
        SimpleDateFormat st = new SimpleDateFormat("yyyy-MM");
        String month = st.format(date);
        Map<String,String> param = new HashMap<String, String>();
        param.put("columnDate",columnDate);
        param.put("month" ,month);
        param.put("tableName" ,tableName);
        param.put("applyType" ,applyType);
        param.put("empId",empId);
        return reportFormMapper.getEveryEmpApplyBillCount(param);
    }

    public List<Integer>  getEveryApplyTypeBillCount(){
        int leaverCount = getEveryApplyTypeBillCount("startdate","applybill","1");
        int overtimeCount = getEveryApplyTypeBillCount("startdate","applybill","2");
        int daysOffBillCount = getEveryApplyTypeBillCount("startdate","applybill","3");
        List<Integer>  everyApplyTypeBillCount = new LinkedList<Integer>();
        everyApplyTypeBillCount.add(leaverCount);
        everyApplyTypeBillCount.add(overtimeCount);
        everyApplyTypeBillCount.add(daysOffBillCount);
        return everyApplyTypeBillCount;
    }

    //获取某个用户申请单数量
    public int getEveryApplyTypeBillCount(String columnDate,String tableName,String applyType){
        Date date = new Date();
        SimpleDateFormat st = new SimpleDateFormat("yyyy-MM");
        String month = st.format(date);
        Map<String,String> param = new HashMap<String, String>();
        param.put("columnDate",columnDate);
        param.put("month" ,month);
        param.put("tableName" ,tableName);
        param.put("applyType" ,applyType);
        return reportFormMapper.getEveryApplyTypeBillCount(param);
    }
}
