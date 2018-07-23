package com.epro.kq.interaction.dept;

import java.util.List;

/**
 * Created by asus2218 on 2016/7/21.
 */
public class DeptTree {
    private String deptName;
    private String employeeId;
    private String deptNo;
    private String roleId;
    private String uuid;
    private String parentId;
    private List<DeptTree> sdept;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getDeptNo() {
        return deptNo;
    }

    public void setDeptNo(String deptNo) {
        this.deptNo = deptNo;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public List<DeptTree> getSdept() {
        return sdept;
    }

    public void setSdept(List<DeptTree> sdept) {
        this.sdept = sdept;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }


}
