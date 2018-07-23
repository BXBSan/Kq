package com.epro.kq.mappers;

import com.epro.kq.domain.*;
import com.epro.kq.interaction.role.MyRoleButton;
import com.epro.kq.interaction.role.MyRoleMenu;
import com.epro.kq.interaction.role.RoleMenuButton;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/30.
 */
@Repository
public interface RoleMapper {
    // 根据roleid,查询有权限的menu的详细信息
    List<MyRoleMenu> getMyMenu(String roleId);

    // 根据roleid,查询有权限的button的详细信息
    List<MyRoleButton> getMyButton(String roleId);

    // 根据id,获取Role
    Role getRoleById(String roleId);

    // 以下为配置权限新增...2016.07.08
    // 获取角色Role列表
    List<Role> getRoleList(Map<String, String> params);

    // 删除role
    int deleteRoleById(String roleId);

    // 新增role
    int addRole(Role role);

    // 配权限菜单
    int addRoleMenu(Map<String, String> roleMenu);

    // 配权限按钮
    int addRoleButton(Map<String, String> roleButton);

    // 删除权限后,删除roleid对应的所有role_menu
    int deleteMenuByRoleId(String roleId);

    // 删除权限后,删除roleid对应的所有role_button
    int deleteButtonByRoleId(String roleId);

    // 权限配置页获取所有 菜单按钮列表
    List<RoleMenuButton> getAllMenuButton();

    void updateRoleButton(Map<String, String> param);


    void getMyMenuButtonById(String roleId);

    int editRole(Role role);

    void updateAvaliable(Map<String, String> param);


    Role getDefalulRole(Map<String, String> defaultRole); // 查找默认role(roleName = 普通员工, roleNo = 1)

    List<Button> getAllButton();

    void addNewRoleButton(Map<String, String> param);

    int checkRoleName(String roleName);


    // 查询所有菜单
//    List<Menu> getMenuList();

    // 查询所有按钮
//    List<Button> getButtonList();

}
