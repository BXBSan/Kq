package com.epro.kq.mappers;

import com.epro.kq.domain.TolReport;
import com.epro.kq.interaction.dept.DeptTree;
import com.epro.kq.interaction.report.CheckRoportRespose;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/7/11.
 */
@Repository
public interface ReportMapper {
    TolReport getTolReport(Map<String,String> params);
    int getCount();
    List<CheckRoportRespose> getLaterCounts(String date);
    List<CheckRoportRespose> getEarlyCounts(String date);
    List<DeptTree> getDeptTree(String uuid);
    List<CheckRoportRespose> getEmpCounts(Map<String, String> param);
    //查询各用户打卡两次的天数
    List<CheckRoportRespose> getPassCounts(String date);


}
