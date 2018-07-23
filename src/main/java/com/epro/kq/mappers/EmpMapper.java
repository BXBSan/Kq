package com.epro.kq.mappers;

import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.emp.EmpInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/27.
 */
@Repository
public interface EmpMapper {
    List<Employee> findAll(int showPage,int pageSize);
    void addEmp(Employee emp);
    Employee findByEmpNo(String empNo);
    void updateEmp(Employee emp);

    void deleteEmp(String empId);
    int getCount();

    // 根据empName,empNo,phoneNo查找员工信息
    Employee findEmpByNoPhoneName(Map<String, String> params);

    //修改密码
    void updatePsd(Map map);

    // 根据roleid查找员工
    List<Employee> findEmpByRoleId(String roleId);

    // 将员工roleid设置为默认的roleId(传入currentRoleId,和查询到的defaultRoleId,批量修改)
    void updateEmpToDefultRole(Map<String, String> params);

    // id查emp
    EmpInfo findEmpById(String empId);

    // 删除部门后,将以该部门为默认部门的员工的deptId改为默认部门id(公司)
    int updateEmpToDefaultDept(@Param("deletedDeptId")String deletedDeptId, @Param("defaultDeptid")String defaultDeptid);

    // 新增员工时,看手机号是否存在
    int countEmpByPhoneNo(String phoneNo);

    // 更新员工roleid
    int updateEmpRole(Map<String, String> params);

    // 获取本部门下所有员工列表
    List<Employee> getDeptEmps(String deptId);

    // 查找员工所在部门的部门主管
    Employee findDeptManager(String empId);

    // 根据本部门deptid,查找上级部门的管理员信息
    Employee findParentDeptManager(String deptId);

    List<Employee> findEmpByDept(Map<String, String> params);
}
