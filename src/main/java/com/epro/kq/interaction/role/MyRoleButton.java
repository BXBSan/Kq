package com.epro.kq.interaction.role;

/**
 * 不同权限下,根据roleid查询获取到的 button的详细信息
 * Created by Administrator on 2016/6/30.
 */
public class MyRoleButton {
    private String buttonId;
    private String menuType;
    private String menuNo;
    private String buttonType;
    private String buttonNo;
    private String avaliable;

    public String getButtonId() {
        return buttonId;
    }

    public void setButtonId(String buttonId) {
        this.buttonId = buttonId;
    }

    public String getAvaliable() {
        return avaliable;
    }

    public void setAvaliable(String avaliable) {
        this.avaliable = avaliable;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }

    public String getMenuNo() {
        return menuNo;
    }

    public void setMenuNo(String menuNo) {
        this.menuNo = menuNo;
    }

    public String getButtonType() {
        return buttonType;
    }

    public void setButtonType(String buttonType) {
        this.buttonType = buttonType;
    }

    public String getButtonNo() {
        return buttonNo;
    }

    public void setButtonNo(String buttonNo) {
        this.buttonNo = buttonNo;
    }
}
