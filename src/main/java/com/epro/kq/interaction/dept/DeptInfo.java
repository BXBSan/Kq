package com.epro.kq.interaction.dept;

import com.epro.kq.domain.BaseDomain;
import com.epro.kq.domain.Dept;

/**
 * Created by Administrator on 2016/7/22.
 */
public class DeptInfo extends Dept {
    private String empName;
    private String empCount;

    public String getEmpCount() {
        return empCount;
    }

    public void setEmpCount(String empCount) {
        this.empCount = empCount;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }
}
