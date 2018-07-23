package com.epro.kq.service;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Button;
import com.epro.kq.domain.Employee;
import com.epro.kq.domain.Role;
import com.epro.kq.interaction.AjaxResponse;
import com.epro.kq.interaction.role.*;
import com.epro.kq.mappers.EmpMapper;
import com.epro.kq.mappers.RoleMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/30.
 */
@Service
public class RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private EmpMapper empMapper;

    public List<MyRoleMenu> getMyMenuByRoleId(String roleId){
        // 校验roleId
        checkRoleId(roleId);

        return roleMapper.getMyMenu(roleId);
    }

    public List<MyRoleButton> getMyButtonByRoleId(String roleId){
        // 校验roleId
        checkRoleId(roleId);

        return roleMapper.getMyButton(roleId);
    }

    // 判断传入的roleId是否为空,和相应role是否存在
    private void checkRoleId(String roleId){
        if(StringUtils.isEmpty(roleId)){
            System.out.println("这里应该报异常,roleId为空");
            // 校验role是否存在
            Role findRole = roleMapper.getRoleById(roleId);
            if(findRole == null || StringUtils.isEmpty(findRole.getRoleName())){
                System.out.println("这里应该报异常,根据roleId无法查询相应的role");
            }
        }
    }

    public AjaxResponse getRoleList(HttpServletRequest request, String keyWord) {
        Map<String, String> params = new HashMap<String, String>();
        params.put("keyWord", keyWord);

        List<Role> roleList = roleMapper.getRoleList(params);
        if(roleList.isEmpty()){ // 若查不到,处理null
            roleList = new ArrayList<Role>();
        }

        // 返回数据到页面
        request.setAttribute("roleList", roleList);
        request.setAttribute("roleCount", roleList.size());
        request.setAttribute("keyWord", keyWord);

//        // Ajax请求的东西
//        AjaxResponse ajaxResponse = new AjaxResponse();
//        ajaxResponse.setState(SystemConstant.AJAX_STATE_SUCCESS);
//        ajaxResponse.setMsg("查询成功!");
//        ajaxResponse.setData(roleList); // 将数据回传到前端

        return null;
    }

    public AjaxResponse deleteRoleById(String roleId) {
        AjaxResponse ajaxResponse = new AjaxResponse();

        // 1.删除Role
        int result = roleMapper.deleteRoleById(roleId);
        if(result == 1){
            ajaxResponse.setState(SystemConstant.AJAX_STATE_SUCCESS);
            ajaxResponse.setMsg("删除成功!");
        }else{
            ajaxResponse.setState(SystemConstant.AJAX_STATE_ERROR);
            ajaxResponse.setMsg("删除失败!请重试!");
        }

        // 2.在role_menu表里删除roleid对应的权限控制
        roleMapper.deleteButtonByRoleId(roleId);
        roleMapper.deleteMenuByRoleId(roleId);

        // 3.查找Emp表里,以该属性roleid为删除role的员工们
        List<Employee> findEmpList = empMapper.findEmpByRoleId(roleId);

        // 如果有该角色的员工,修改这些员工的角色为默认角色
        if(!findEmpList.isEmpty()){
            // 查找默认roleId
            Map<String, String> defaultRole = new HashMap<String, String>();
            defaultRole.put("defaultRoleName", SystemConstant.DEFAULT_ROLE_NAME); // 被删除的roleId
            defaultRole.put("defaultRoleNo", SystemConstant.DEFAULT_ROLE_NO);
            Role findRole = roleMapper.getDefalulRole(defaultRole);
            String defaultRoleId = null; // 若没有默认Role,则Employee的roleid改为null
            if(findRole != null){
                defaultRoleId = findRole.getUuid();
            }

            Map<String, String> params = new HashMap<String, String>();
            params.put("deletedRoleId", roleId); // 被删除的roleId
            params.put("defaultRoleId", defaultRoleId); // 待设置的默认roleId
            empMapper.updateEmpToDefultRole(params);
        }

        return ajaxResponse;
    }

    public List<RoleMenuButton> getAllMenuButton() {
        List<RoleMenuButton> roleMenuButtons = roleMapper.getAllMenuButton();
        return roleMenuButtons;
    }

    public int addRole(String uuid, String roleName) {
        Role role = new Role();
        role.setRoleName(roleName);
        role.setUuid(uuid);
        return roleMapper.addRole(role);
    }

    public void addPower(String uuid, List<Menu_Button> menu_buttons) {
        List<RoleMenuButton> allMenuButtons =  getAllMenuButton();
        for (RoleMenuButton omb: allMenuButtons){
            for(SubButton sb:omb.getButtonList()){
                Map<String,String> param =new HashMap<String, String>();
                param.put("roleId",uuid);
                param.put("buttonId" ,sb.getButtonId());
                roleMapper.addRoleButton(param);
            }
        }
        for(Menu_Button mb:menu_buttons){
            Map<String,String> param =new HashMap<String, String>();
            param.put("roleId",uuid);
            param.put("menuId" ,mb.getMenu());
            roleMapper.addRoleMenu(param);
            for(String buttonId:mb.getButtonList()){
                param.put("buttonId",buttonId);
                roleMapper.updateRoleButton(param);
            }
        }
    }

    public void showEdit(HttpServletRequest request, String roleId) {
        request.setAttribute("allMenuButtonList", getAllMenuButton());
        Role role = roleMapper.getRoleById(roleId);
       // roleMapper.getMyMenuButtonById(roleId);
        //List<RoleMenuButton> myMenuButtons = new ArrayList<RoleMenuButton>();
        List<MyRoleButton> myRoleButtons = roleMapper.getMyButton(roleId);
        List<MyRoleMenu> myRoleMenus = roleMapper.getMyMenu(roleId);
       /* for(MyRoleMenu menu:myRoleMenus){
            RoleMenuButton roleMenuButton = new RoleMenuButton();
            roleMenuButton.setMenuId(menu.getMenuId());
            roleMenuButton.setMenuType(menu.getMenuType());
            List<SubButton> subButtonList = new ArrayList<SubButton>();
            for(MyRoleButton button:myRoleButtons){
                if(button.getMenuNo().equals(menu.getMenuNo()) && button.getMenuType().equals(menu.getMenuType())){
                    SubButton subButton = new SubButton();
                    subButton.setButtonId(button.getButtonId());
                    subButton.setButtonType(button.getButtonType());
                    subButton.setAvaliable(button.getAvaliable());
                    subButtonList.add(subButton);
                }
            }
            roleMenuButton.setButtonList(subButtonList);
            myMenuButtons.add(roleMenuButton);
        }*/
        //request.setAttribute("myMenuButtons" ,myMenuButtons);
        request.setAttribute("myRoleButtons",myRoleButtons);
        request.setAttribute("myRoleMenus",myRoleMenus);
        request.setAttribute("role" ,role);
    }

    public void doEdit(List<Menu_Button> menu_buttons, String roleName, String roleId) {
        Role role = new Role();
        role.setUuid(roleId);
        role.setRoleName(roleName);
        List<MyRoleButton> myRoleButtons = roleMapper.getMyButton(roleId);
        List<String> buttonIdList = new ArrayList<String>();
        for(MyRoleButton mrb:myRoleButtons){
            buttonIdList.add(mrb.getButtonId());
        }
        List<Button> buttons = roleMapper.getAllButton();
        int result = roleMapper.editRole(role);
        if(result > 0){
            if(roleMapper.deleteMenuByRoleId(roleId) > 0) {
                for (Menu_Button mb : menu_buttons) {
                    Map<String, String> param = new HashMap<String, String>();
                    param.put("roleId", roleId);
                    param.put("menuId", mb.getMenu());
                    roleMapper.addRoleMenu(param);
                }
            }
            Map<String,String> param = new HashMap<String, String>();
            param.put("roleId" ,roleId);
            for(Button bu : buttons){
                int flag = 0;
                param.put("buttonId" ,bu.getUuid());
                for(Menu_Button mb : menu_buttons){
                    if(mb.getButtonList().contains(bu.getUuid())){
                        flag = 1;
                    }
                }
                if(flag == 1){
                    if(buttonIdList.contains(bu.getUuid())){
                        roleMapper.updateRoleButton(param);
                    }else{
                        roleMapper.addNewRoleButton(param);
                    }

                }else{
                    if(buttonIdList.contains(bu.getUuid())) {
                        roleMapper.updateAvaliable(param);
                    }else{
                        roleMapper.addRoleButton(param);
                    }
                }
            }
        }
    }

    public int checkRoleName(String roleName) {
        return roleMapper.checkRoleName(roleName);
    }
}
