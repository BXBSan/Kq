package com.epro.kq.controller;


import com.alibaba.fastjson.JSON;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.AjaxResponse;
import com.epro.kq.interaction.role.Menu_Button;
import com.epro.kq.interaction.role.MyRoleButton;
import com.epro.kq.interaction.role.MyRoleMenu;
import com.epro.kq.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /*@RequestMapping(value = "/rolelist", method = RequestMethod.GET)
    @ResponseBody
    public AjaxResponse getRoleList(HttpServletRequest request,
             @RequestParam(value = "keyWord", required = false) String keyWord) {
        // TODO Ajax方式请求角色列表,此方法未使用
        return roleService.getRoleList(request, keyWord);
    }*/

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse deleteRoleById(//HttpServletRequest request,
            @RequestParam(value ="roleId", required = true) String roleId) {

        return roleService.deleteRoleById(roleId);
    }

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String showRoleList(HttpServletRequest request,
             @RequestParam(value = "keyWord", required = false) String keyWord){

        roleService.getRoleList(request, keyWord);
        return "pages/role/role";
    }

    @RequestMapping("/add")
    public String add(HttpServletRequest request){
        request.setAttribute("allMenuButtonList", roleService.getAllMenuButton());
        return "pages/role/addRole";
    }

    @RequestMapping("/edit")
    public String edit(HttpServletRequest request,
                       String roleId){
        roleService.showEdit(request,roleId);
        return "pages/role/editRole";
    }

    @RequestMapping(value = "/addRole", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse addRole(HttpServletRequest request,
                                      @RequestParam(value="dataJson", required = false) String dataJson,
                                      @RequestParam(value="roleName", required = false) String roleName){
        System.out.println(dataJson);
        List<Menu_Button> menu_buttons = JSON.parseArray(dataJson, Menu_Button.class);
        String uuid = UUID.randomUUID().toString();
        int result = roleService.addRole(uuid,roleName);
        if( result == 1){
            roleService.addPower(uuid,menu_buttons);
        }
        AjaxResponse ajaxResponse = new AjaxResponse();
        //Map<String,String> result = new HashMap<String, String>();
        //result.put("msg","添加成功！");
        ajaxResponse.setMsg("添加成功");
        return ajaxResponse;
    }

    @RequestMapping(value = "/doEdit", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse doEdit(HttpServletRequest request,
                                     @RequestParam(value="dataJson", required = false) String dataJson,
                                     @RequestParam(value="roleName", required = false) String roleName,
                                     @RequestParam(value="roleId", required = false) String roleId){
        List<Menu_Button> menu_buttons = JSON.parseArray(dataJson, Menu_Button.class);
        roleService.doEdit(menu_buttons,roleName,roleId);
        AjaxResponse ajaxResponse = new AjaxResponse();
        //Map<String,String> result = new HashMap<String, String>();
        //result.put("msg","添加成功！");
        ajaxResponse.setMsg(" 修改成功！");

        // 更新session权限
        Employee loginEmp =  (Employee)request.getSession().getAttribute("emp");
        if(loginEmp!=null){
            List<MyRoleMenu> myRoleMenuList = roleService.getMyMenuByRoleId(loginEmp.getRoleId());
            List<MyRoleButton> myRoleButtonList = roleService.getMyButtonByRoleId(loginEmp.getRoleId());
            // 将获取到的权限放入session
            request.getSession().setAttribute("myRoleMenuList", myRoleMenuList);
            request.getSession().setAttribute("myRoleButtonList", myRoleButtonList);
        }

        return ajaxResponse;
    }

    @RequestMapping(value = "/checkRoleName", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResponse checkRoleName(HttpServletRequest request,
                               @RequestParam(value="roleName", required = false) String roleName){
        AjaxResponse ajaxResponse = new AjaxResponse();
        int count = roleService.checkRoleName(roleName);
        if(count > 0){
            ajaxResponse.setMsg("error");
        }else{
            ajaxResponse.setMsg("success");
        }
        return ajaxResponse;
    }
}
