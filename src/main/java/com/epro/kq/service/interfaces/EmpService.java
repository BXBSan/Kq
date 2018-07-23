package com.epro.kq.service.interfaces;

import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.emp.EmpInfo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/27.
 */
@Service
public interface EmpService {
    public List<Employee> empAll(int showPage,int pageSize);
    public String insert(HttpServletRequest request, Employee emp);
    public Employee findByEmpNo(String empNo); // 改
    public void updateEmp(Employee emp);
    void deleteEmp(String empId); // 改
    int getCount();
    void goAddEmp(HttpServletRequest request);
    void updatePsd(Map map);

    // 根据Id查Emp
    void loadEmpInfo(HttpServletRequest request, String empId);
}
