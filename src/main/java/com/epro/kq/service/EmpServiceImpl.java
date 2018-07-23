package com.epro.kq.service;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Dept;
import com.epro.kq.domain.Employee;
import com.epro.kq.domain.Role;
import com.epro.kq.domain.TolReport;
import com.epro.kq.interaction.emp.EmpInfo;
import com.epro.kq.mappers.DeptMapper;
import com.epro.kq.mappers.EmpMapper;
import com.epro.kq.mappers.ReportMapper;
import com.epro.kq.mappers.RoleMapper;
import com.epro.kq.service.interfaces.EmpService;
import com.epro.kq.utils.DesUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2016/6/27.
 */
@Component
public class EmpServiceImpl implements EmpService {
    @Autowired
    private EmpMapper empMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private DeptMapper deptMapper;
    @Autowired
    private  ReportMapper reportMapper;

    //修改密码方法
    public void updatePsd(Map map){
        empMapper.updatePsd(map);
    }
	
    public void loadEmpInfo(HttpServletRequest request, String empId) {
        EmpInfo empInfo = empMapper.findEmpById(empId);
        Map<String,String> params=new HashMap<String,String>();
        params.put("uuid",empId);
        Date date=new Date();
        SimpleDateFormat sd=new SimpleDateFormat("yyyy-MM");
        String nowDate=sd.format(date);
        params.put("nowDate",nowDate);
        params.put("depts","");

        TolReport tolReport=reportMapper.getTolReport(params);

        if(empInfo == null){
            request.setAttribute("msg", "未找到该员工信息!");
        }else{
            request.setAttribute("updatedEmp", empInfo);

            List<Role> roleList = roleMapper.getRoleList(null);
            List<Dept> deptList = deptMapper.findAll(0, 0);
            request.setAttribute("roleList", roleList);
            request.setAttribute("deptList", deptList);
            request.setAttribute("tolRepot",tolReport);
        }
    }

    public List<Employee> empAll(int showPage,int pageSize) {
        List<Employee> emps=new ArrayList<Employee>();
        emps=empMapper.findAll(showPage,pageSize);
        return emps;
    }


  

    public String insert(HttpServletRequest request, Employee emp) {
        // 字段非空校验
        System.out.println(emp);
        if(emp.getEmpName().isEmpty()
                || emp.getDeptId().isEmpty()
                || emp.getEmpNo().isEmpty()
                || emp.getHireDate().isEmpty()
                || emp.getPhoneNo().isEmpty()
                || emp.getSex().isEmpty()
                || emp.getPassWord().isEmpty()){
//            List<Role> roleList = roleMapper.getRoleList(null);
            List<Dept> deptList = deptMapper.findAll(0, 0);

//            request.setAttribute("roleList", roleList);
            request.setAttribute("deptList", deptList);

            request.setAttribute("newEmp", emp);
            request.setAttribute("msg", "添加失败!请重新输入!");
            return "pages/employee/addEmp";
        }

        // 检查phoneNo是否注册过(用于登录,校验唯一)
        if(checkPhoneNoExist(emp.getPhoneNo())){
//            List<Role> roleList = roleMapper.getRoleList(null);
            List<Dept> deptList = deptMapper.findAll(0, 0);
//            request.setAttribute("roleList", roleList);
            request.setAttribute("deptList", deptList);

            request.setAttribute("newEmp", emp);
            request.setAttribute("msg", "添加失败!该号码已经被注册!");
            return "pages/employee/addEmp";
        }

        //密码加密
        SecureRandom sr = new SecureRandom();
        String salt=sr.nextInt(10)+"";
        try{
            emp.setPassWord(DesUtils.encode(SystemConstant.DES_PASSWORD,emp.getPassWord(),salt));
            emp.setSalt(salt);
        }catch (Exception e){
            e.printStackTrace();
        }
        emp.setRoleId(deptMapper.findRoleId(emp.getDeptId()));
        emp.setCreateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        emp.setUpdateTime(emp.getCreateTime());

        empMapper.addEmp(emp);

        return "redirect:getAll";
    }

    // 校验phone是否被注册, 已存在返回true
    private boolean checkPhoneNoExist(String phoneNo) {
        int count = empMapper.countEmpByPhoneNo(phoneNo);
        if(count >= 1){
            return true;
        }
        return false;
    }

    public Employee findByEmpNo(String empNo) {
        return empMapper.findByEmpNo(empNo);
    }

    public void updateEmp(Employee emp) {
        emp.setRoleId(deptMapper.findRoleId(emp.getDeptId()));
        empMapper.updateEmp(emp);
    }

   

    public void deleteEmp(String empId) {
        empMapper.deleteEmp(empId);

        // 删除员工后,以该员工为部门管理员的部门,设置管理员为超级管理员
        int result = deptMapper.updateDeptManager(empId, SystemConstant.DEFAULT_EMPID_ADMIN);

    }



    public int getCount() {
        return empMapper.getCount();
    }

    public void goAddEmp(HttpServletRequest request) {
        List<Role> roleList = roleMapper.getRoleList(null);
        List<Dept> deptList = deptMapper.findAll(0, 0);

        request.setAttribute("roleList", roleList);
        request.setAttribute("deptList", deptList);
    }


}
