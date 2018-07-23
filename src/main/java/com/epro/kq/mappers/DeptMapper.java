package com.epro.kq.mappers;

import com.epro.kq.domain.Dept;
import com.epro.kq.interaction.dept.DeptInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2016/6/27.
 */
@Repository
public interface DeptMapper {
    List<Dept> findAll(@Param("showPage")int showPage, @Param("pageSize")int pageSize);

    void addDept(Dept dept);

    Dept findByNo(String deptNo);

    void updateDept(Dept dept);

    void deleteDept(String deptName);

    int getCount();

    Dept findDeptById(String deptId);

    int deleteDeptById(String deptId);

    List<DeptInfo> getDeptList(@Param("showPage")int startNo, @Param("pageSize")int pageSize);

    // 删除员工后,更新数据库管理员
    int updateDeptManager(@Param("currentEmpId")String currentEmpId, @Param("defaultEmpId")String defaultEmpId);

    Dept findParentDept(String subDeptId);
    String findRoleId(String deptId);

    Dept getRootDept();
}
