package com.epro.kq.mappers;

import com.epro.kq.domain.Apply;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.apply.ApplyDetail;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/24.
 */
@Repository
public interface ApplyMapper {
    void add(Apply apply);

    int getPage(Map<String, Object> param);

    List<Apply> getApplyList(Map<String, Object> param);

    void delete(String id);

    List<Employee> getEmpList();

    List<ApplyDetail> getApplyDetail(Map<String, String> param);
}
