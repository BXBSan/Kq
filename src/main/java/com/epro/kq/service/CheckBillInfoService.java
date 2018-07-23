package com.epro.kq.service;

import com.epro.kq.domain.Apply;
import com.epro.kq.domain.CheckBill;
import com.epro.kq.mappers.CheckBillInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/29.
 */
@Service
public class CheckBillInfoService {
    @Autowired
    private CheckBillInfoMapper checkBillInfoMapper;
    public List<CheckBill> getCheckBillInfo(Map map){
        List<CheckBill> list=checkBillInfoMapper.getCheckBillInfo(map);
        return list;
    }

    public ModelAndView getApplyInfo(String applyType, String empId) {
        ModelAndView mov = new ModelAndView("pages/index");
        Date date = new Date();
        SimpleDateFormat st = new SimpleDateFormat("yyyy-MM");
        String month = st.format(date);
        Map<String,String> param = new HashMap<String, String>();
        param.put("applyType" , applyType);
        param.put("month" , month);
        param.put("empId" ,empId);
        List<Apply> applyInfo = checkBillInfoMapper.getApplyInfo(param);
        mov.addObject("applyInfo",applyInfo);
        return mov;
    }
}
