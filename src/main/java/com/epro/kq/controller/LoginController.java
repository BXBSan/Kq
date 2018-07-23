package com.epro.kq.controller;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.role.MyRoleButton;
import com.epro.kq.interaction.role.MyRoleMenu;
import com.epro.kq.service.LoginService;
import com.epro.kq.service.RoleService;
import com.epro.kq.utils.DesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/28.
 */
@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    private LoginService loginService;

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "/log")
    @ResponseBody
    public Map<String, String> select(HttpServletRequest request, HttpServletResponse response) {
        Map<String, String> map = new HashMap<String, String>();
        ModelAndView modelAndView = null;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String flag = request.getParameter("flag"); // 客户端是否记住密码

        map = loginService.getEmp(request, username, password);

        // 登录成功后,获取权限
        Employee loginEmp = (Employee) request.getSession().getAttribute("emp");

        if (loginEmp != null) {
            // 设置Cookie
            Cookie cookie = null;
            Cookie cookie1 = null;
            Cookie cookie2=null;
            if ("1".equals(flag)) {
                //将账号密码放入到cookie中
                cookie = new Cookie("username", username);
                try {
                    //密码加密
                    SecureRandom sr = new SecureRandom();
                    String salt=sr.nextInt(10)+"";
                    cookie2 = new Cookie("salt",salt);
                    cookie1 = new Cookie("password", DesUtils.encode(SystemConstant.DES_PASSWORD,(password+salt).getBytes()));

                } catch (Exception e) {
                    e.printStackTrace();
                }

                //设置cookies的保存时间:30天
                cookie.setMaxAge(60 * 60 * 24 * 30);
                cookie.setPath("/");
                cookie1.setMaxAge(60 * 60 * 24 * 30);
                cookie1.setPath("/");
                cookie2.setMaxAge(60 * 60 * 24 * 30);
                cookie2.setPath("/");
                response.addCookie(cookie);
                response.addCookie(cookie1);
                response.addCookie(cookie2);
            } else if ("0".equals(flag)) {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (int i = 0; i < cookies.length; i++) {
                        if (cookies[i].getName().equals("username") || cookies[i].getName().equals("password")) {
                            cookies[i].setPath("/");
                            cookies[i].setMaxAge(0);
                            response.addCookie(cookies[i]);
                        }
                    }
                }
            }

            List<MyRoleMenu> myRoleMenuList = roleService.getMyMenuByRoleId(loginEmp.getRoleId());
            List<MyRoleButton> myRoleButtonList = roleService.getMyButtonByRoleId(loginEmp.getRoleId());
            // 将获取到的权限放入session
            request.getSession().setAttribute("myRoleMenuList", myRoleMenuList);
            request.getSession().setAttribute("myRoleButtonList", myRoleButtonList);
        }
        return map;
    }
}
