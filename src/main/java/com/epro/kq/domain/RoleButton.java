package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/6/24.
 */
public class RoleButton extends BaseDomain {
    private String roleId;
    private String buttonId;
    private String avaliable;

    public String getAvaliable() {
        return avaliable;
    }

    public void setAvaliable(String avaliable) {
        this.avaliable = avaliable;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getButtonId() {
        return buttonId;
    }

    public void setButtonId(String buttonId) {
        this.buttonId = buttonId;
    }
}
