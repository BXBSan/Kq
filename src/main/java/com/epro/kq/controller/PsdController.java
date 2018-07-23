package com.epro.kq.controller;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Employee;
import com.epro.kq.service.EmpServiceImpl;
import com.epro.kq.service.LoginService;
import com.epro.kq.service.interfaces.EmpService;
import com.epro.kq.utils.DesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/13.
 */
@Controller
@RequestMapping(value = "/psd")
public class PsdController {

    @Autowired
    public EmpService empService;


    @Autowired
    public LoginService loginService;

    @RequestMapping(value = "/password")
    public String toPsd(HttpServletRequest request){
        return "pages/password/pass";
    }

    @RequestMapping(value = "/show")
    public String show(HttpServletRequest request){
        return "pages/password/show";
    }
    @RequestMapping(value = "/get")
    @ResponseBody
    public Map get(HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        String username=request.getParameter("username");
        String userno=request.getParameter("userno");
        String phoneno=request.getParameter("phoneno");
        Employee emp=loginService.select(phoneno);
        if(emp!=null){
            if(emp.getEmpName().equals(username)&&emp.getEmpNo().equals(userno)){
                try{
                    String password=DesUtils.decodeValue(SystemConstant.DES_PASSWORD,emp.getPassWord(),emp.getSalt());
                    map.put("result",password);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }

        return map;
    }


    /**
     * 修改密码
     * @param request
     * @return
     */
    @RequestMapping(value = "/modify")
    @ResponseBody
    public Map<String, String> modifyPsd(HttpServletRequest request){
        Map<String,String> map=new HashMap();
        String psd=request.getParameter("psd");
        String newpsd=request.getParameter("newpsd");
        String repsd=request.getParameter("repsd");
        System.out.println(psd+""+newpsd+""+repsd);
        Employee emp=(Employee)request.getSession().getAttribute("emp");
        String uuid=emp.getUuid();
        String password=emp.getPassWord();
        String encodepsd=null;
        try{
            encodepsd=DesUtils.encode(SystemConstant.DES_PASSWORD,psd,emp.getSalt());
            if(password.equals(encodepsd)){
                String encodenewpsd=null;
                encodenewpsd=DesUtils.encode(SystemConstant.DES_PASSWORD,newpsd,emp.getSalt());
                map.put("uuid",uuid);
                map.put("encodenewpsd",encodenewpsd);
                map.put("result","密码修改成功");
                empService.updatePsd(map);
            }else {
                map.put("result","原密码不正确，请重新输入！");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }
}
