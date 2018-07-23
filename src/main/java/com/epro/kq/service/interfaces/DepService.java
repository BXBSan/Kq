package com.epro.kq.service.interfaces;

import com.epro.kq.domain.Dept;
import com.epro.kq.interaction.dept.DeptInfo;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/6/28.
 */
@Service
public interface DepService {
    public List<Dept> deptAll(int showPage,int pageSize);
    public String insert(HttpServletRequest request, Dept dept);
    Dept findByDeptNo(String deptNo);
    String updateDept(HttpServletRequest request, Dept dept);
    void deleteDept(String deptNo);

    int getCount();

    void toAdd(HttpServletRequest request);

    String findDeptById(HttpServletRequest request, String deptId);

    void deleteDeptById(String deptId);

    List<DeptInfo> getDeptList(int startNo, int pageSize);
}
