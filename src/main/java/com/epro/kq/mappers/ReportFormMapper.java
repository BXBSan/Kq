package com.epro.kq.mappers;

import com.epro.kq.domain.CheckBill;
import com.epro.kq.interaction.approve.ReportFormsResponse;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/28.
 */
@Repository
public interface ReportFormMapper {

    int getEveryEmpApplyBillCount(Map<String, String> param);

    int getEveryApplyTypeBillCount(Map<String, String> param);

    List<ReportFormsResponse> getApplyList(Map<String, String> params);

    int getApplyCount(Map<String, String> params);
}
