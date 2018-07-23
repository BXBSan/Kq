package com.epro.kq.interaction.role;

/**
 * 根据不同的roleid,查询获取到的有权限的menu信息
 * Created by Administrator on 2016/6/30.
 */
public class MyRoleMenu {
    private String menuId;
    private String menuNo;
    private String menuType;

    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public String getMenuNo() {
        return menuNo;
    }

    public void setMenuNo(String menuNo) {
        this.menuNo = menuNo;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }
}
