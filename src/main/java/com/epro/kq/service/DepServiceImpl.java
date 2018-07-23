package com.epro.kq.service;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.Dept;
import com.epro.kq.domain.Employee;
import com.epro.kq.domain.Role;
import com.epro.kq.interaction.dept.DeptInfo;
import com.epro.kq.interaction.dept.DeptTree;
import com.epro.kq.mappers.ApplyMapper;
import com.epro.kq.mappers.DeptMapper;
import com.epro.kq.mappers.EmpMapper;
import com.epro.kq.mappers.RoleMapper;
import com.epro.kq.service.interfaces.DepService;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


/**
 * Created by Administrator on 2016/6/28.
 */
@Component
public class DepServiceImpl implements DepService {
    @Autowired
    private DeptMapper  deptMapper;

    @Autowired
    private ApplyMapper applyMapper;

    @Autowired
    private EmpMapper empMapper;

    @Autowired
    private RoleMapper roleMapper;

    public List<Dept> deptAll(int showPage,int pageSize) {
        List<Dept> depts = deptMapper.findAll(showPage,pageSize);
        return depts;
    }

    public String insert(HttpServletRequest request, Dept dept) {

        System.out.println(dept);
        if(dept.getEmployeeId().isEmpty()
                || dept.getDeptName().isEmpty()
                || dept.getDeptNo().isEmpty()
                || dept.getRoleId().isEmpty()
                || dept.getParentId().isEmpty()){
            request.setAttribute("msg", "添加部门失败!请完善信息!");
            return "redirect:toAdd";
        }

        dept.setCreateTime(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
        dept.setUpdateTime(dept.getCreateTime());
        // 新增部门
        deptMapper.addDept(dept);

        // TODO 将部门主管的roleid指定为该部门的roleid ? 现在是一部门一角色,一部门多角色?
        Map<String, String> params = new HashMap<String, String>();
        params.put("empId", dept.getEmployeeId());
        params.put("roleId", dept.getRoleId());
        empMapper.updateEmpRole(params);

        return "redirect:getAll";
    }

    public Dept findByDeptNo(String deptNo) {
        return deptMapper.findByNo(deptNo);
    }

    public String updateDept(HttpServletRequest request, Dept dept) {
        if(dept.getEmployeeId().isEmpty()
                || dept.getDeptName().isEmpty()
                || dept.getDeptNo().isEmpty()
                || dept.getRoleId().isEmpty()
                || dept.getParentId().isEmpty()){
            // 数据回显(用ajax就没这么麻烦...)
            List<Employee> empList = applyMapper.getEmpList();
            List<Role> roleList = roleMapper.getRoleList(null);
            List<Dept> deptList = deptMapper.findAll(0, 0);
            request.setAttribute("roleList", roleList);
            request.setAttribute("deptList", deptList);
            request.setAttribute("leaderList", empList);
            request.setAttribute("dept", dept);

            request.setAttribute("msg", "修改失败!请完善信息!");
            return "pages/dept/updateDept";
        }
        deptMapper.updateDept(dept);

        return "redirect:getAll";
    }

    public void deleteDept(String deptNo) {
        //deptMapper.deleteDept(deptNo);
    }
    public int getCount() {
        return deptMapper.getCount();
    }

    @Override
    public void toAdd(HttpServletRequest request) {
        // 获取员工信息
        List<Employee> empList = applyMapper.getEmpList();
        List<Role> roleList = roleMapper.getRoleList(null);
        List<Dept> deptList = deptMapper.findAll(0, 0);

        request.setAttribute("roleList", roleList);
        request.setAttribute("deptList", deptList);
        request.setAttribute("leaderList", empList);
    }

    @Override
    public String findDeptById(HttpServletRequest request, String deptId) {
        Dept findDept = deptMapper.findDeptById(deptId);
        // 获取员工信息
        List<Employee> empList = applyMapper.getEmpList();
        List<Role> roleList = roleMapper.getRoleList(null);
        List<Dept> deptList = deptMapper.findAll(0, 0);
        // 获取部门下所有员工列表
        List<Employee> deptEmps = empMapper.getDeptEmps(deptId);

        request.setAttribute("roleList", roleList);
        request.setAttribute("deptList", deptList);
        request.setAttribute("leaderList", empList);
        request.setAttribute("dept", findDept);
        request.setAttribute("deptEmps", deptEmps);

        return "pages/dept/updateDept";
    }

    @Override
    public void deleteDeptById(String deptId) {
        deptMapper.deleteDeptById(deptId);

        // 删除部门后,将以该部门为默认部门的员工的deptId改为默认部门id(公司)
        int result = empMapper.updateEmpToDefaultDept(deptId, SystemConstant.DEFAULT_DEPTID_COMPANY);
    }

    @Override
    public List<DeptInfo> getDeptList(int startNo, int pageSize) {
        List<DeptInfo> deptList = deptMapper.getDeptList(startNo, pageSize);

        // TODO test
        DeptTree rootDept = new DeptTree();
        Dept root = deptMapper.getRootDept(); // 获取根部门
        rootDept.setUuid(root.getUuid());
        rootDept.setDeptNo(root.getDeptNo());
        rootDept.setDeptName(root.getDeptName());
        rootDept.setEmployeeId(root.getEmployeeId());
        rootDept.setParentId(root.getParentId());
        rootDept.setRoleId(root.getRoleId());

        //DeptTree finalRoot = getSubDept(rootDept, deptList);

        // test

        return deptList;
    }

    // TODO test
    private DeptTree getSubDept(DeptTree rootDept, List<DeptInfo> deptList){
        List<DeptTree> subDeptList = new ArrayList<DeptTree>(); // 子部门列表
        for(DeptInfo dept : deptList){
            if(dept.getParentId().equals(rootDept.getUuid())){
                DeptTree subDept = new DeptTree(); // 子部门
                subDept.setDeptName(dept.getDeptName());
                subDept.setUuid(dept.getUuid());
                subDept.setDeptNo(dept.getDeptNo());
                subDeptList.add(subDept);
                deptList.remove(dept); // 从列表中删除

                getSubDept(subDept, deptList);
            }
        }
        rootDept.setSdept(subDeptList);

        return rootDept;
    }

}
