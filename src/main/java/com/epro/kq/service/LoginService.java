package com.epro.kq.service;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Employee;
import com.epro.kq.mappers.CheckBillMapper;
import com.epro.kq.mappers.LoginMapper;
import com.epro.kq.utils.DesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/24.
 */
@Service
public class LoginService {
    @Autowired
    public LoginMapper loginMapper;
    @Autowired
    public CheckBillMapper checkBillMapper;

    public Employee select(String phoneno){
        Employee emp = loginMapper.select(phoneno);
        return emp;
    }
    public Map<String,String> getEmp(HttpServletRequest request, String username,String password){

        //Student s=studentService.student(username);
        Employee emp= select(username);
        String salt=emp.getSalt();
        String psd=null;
        try{
            psd= DesUtils.encode(SystemConstant.DES_PASSWORD,password,salt);
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,String> map=new HashMap();;
        if(emp!=null) {
            boolean flag = psd.equals(emp.getPassWord());
            if (flag) {
                request.getSession().setAttribute("emp", emp);
                map.put("result","登录成功");
                updateSessionValue(request); // 在session中,将 请假 加班 调休 签卡次数 数据更新
            }else{
                map.put("result","账号或密码错误1");
            }
            //return map;
        }else{
            // zhaobud
            map.put("result","账号或密码错误2");
            //return map;
        }
        return map;
//        modelAndView=new ModelAndView("redirect:/login.jsp");
//       // request.setAttribute("error","账号或密码错误");
//        //modelAndView.addObject("msg","账号或密码错误");
//        request.getSession().setAttribute("error","账号或密码错误");
//        return modelAndView;

    }

    public int getCount(String columnDate, String tableName, String applyType, HttpServletRequest request){
        Date date = new Date();
        SimpleDateFormat st = new SimpleDateFormat("yyyy-MM");
        String month = st.format(date);
        Map<String,String> param = new HashMap<String, String>();
        param.put("columnDate",columnDate);
        param.put("month" ,month);
        param.put("tableName" ,tableName);
        param.put("applyType" ,applyType);
        param.put("empId", ((Employee)request.getSession().getAttribute("emp")).getUuid());
        return checkBillMapper.getCount(param);
    }

    public void updateSessionValue(HttpServletRequest request){
        Map<String,Integer> countMap = new HashMap<String,Integer>();
        int checkCount = getCount("checkdate","checkbill","",request);
        int leaverCount = getCount("startdate","applybill","1",request);
        int overtimeCount = getCount("startdate","applybill","2",request);
        int restCount = getCount("startdate","applybill","3",request);
        countMap.put("checkCount" ,checkCount);
        countMap.put("leaveCount" ,leaverCount);
        countMap.put("overtimeCount" ,overtimeCount);
        countMap.put("restCount" ,restCount);
        request.getSession().setAttribute("countMap" ,countMap);
    }

}
