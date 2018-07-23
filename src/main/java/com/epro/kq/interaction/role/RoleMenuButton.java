package com.epro.kq.interaction.role;

import com.epro.kq.domain.Button;

import java.util.List;

/**
 * 在权限配置页,查询显示所有菜单和按钮 以列表显示用
 */
public class RoleMenuButton {
    private String menuId;
    private String menuNo;
    private String menuType;
    private String createTime;
    private String updateTime;
    private List<SubButton> buttonList;

    public List<SubButton> getButtonList() {
        return buttonList;
    }

    public void setButtonList(List<SubButton> buttonList) {
        this.buttonList = buttonList;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

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

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }
}
