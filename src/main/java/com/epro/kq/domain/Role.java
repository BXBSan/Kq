package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/6/24.
 */
public class Role extends BaseDomain {
    private String roleNo;
    private String roleName;

    public String getRoleNo() {
        return roleNo;
    }

    public void setRoleNo(String roleNo) {
        this.roleNo = roleNo;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
