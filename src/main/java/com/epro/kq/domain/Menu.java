package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/6/24.
 */
public class Menu extends BaseDomain {
    private String menuId;
    private String menuType;
    
    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }

    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }
}
