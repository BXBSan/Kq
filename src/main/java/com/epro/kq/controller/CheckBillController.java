package com.epro.kq.controller;

import com.epro.kq.domain.CheckBill;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.AjaxResponse;
import com.epro.kq.service.CheckBillService;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/28.
 */
@Controller
@RequestMapping(value = "/check")
public class CheckBillController {
    @Autowired
    private CheckBillService checkBillService;

    @ResponseBody
    @RequestMapping(value = "checkbill",method = RequestMethod.POST)
    public Map responseclock(HttpServletRequest request){
        Map<String,String> map=new HashMap();
        Employee emp=(Employee)request.getSession().getAttribute("emp");
        String empid=emp.getUuid();
        Date date=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
        SimpleDateFormat dftt=new SimpleDateFormat("HH:mm:ss");
        String nowdate=dft.format(date);
        String checkTime=dftt.format(date);// new Date()为获取当前系统时间
        String nowTime=df.format(date);
        CheckBill checkBill=new CheckBill();
        checkBill.setCheckDate(nowdate);
        checkBill.setCheckTime(checkTime);
        checkBill.setEmpId(empid);
        checkBill.setCreateTime(nowTime);
        checkBill.setUpdateTime(nowTime);
        Map<String,String> map1=new HashMap<String,String>();
        map1.put("checktime",checkTime);
        map1.put("updatetime",nowTime);
        map1.put("empId", checkBill.getEmpId());
        map1.put("checkDate", checkBill.getCheckDate());
        boolean flag=checkBillService.insertCheckBill(checkBill,nowdate,map1);
        if(flag){
            map.put("result","打卡成功");
        }else {
            map.put("result","打卡失败");
        }
        return map;
    }

    @RequestMapping(value = "/goupload", method = RequestMethod.GET)
    public String goUploadPage(){
        return "pages/checkbill/uploadCheckBill";
    }

    @RequestMapping(value = "/doupload", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse doUpload(HttpServletRequest request,
                           //@RequestParam(value = "fileName", required = true) String fileName,
                           @RequestParam(value = "excelFile", required = true) MultipartFile excelFile) {
        //System.out.println("读取到的文件-fileName:" + excelFile.getOriginalFilename());

        // 上传
        AjaxResponse ajaxResponse = checkBillService.doUpload(excelFile);

        // ajax返回
        return ajaxResponse;
    }
}
