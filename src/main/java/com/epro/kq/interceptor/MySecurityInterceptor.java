package com.epro.kq.interceptor;

import com.epro.kq.domain.Employee;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2016/6/24.
 */
public class MySecurityInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println(request.getRequestURL());
        HttpSession session = request.getSession();
        Employee emp = (Employee)session.getAttribute("emp");

        if(emp == null || emp.getUuid() == null){
            request.getRequestDispatcher("/login.jsp").forward(request,response);
            return false;
        }else{
            return true;
        }

    }


    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }


    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
