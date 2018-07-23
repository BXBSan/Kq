package com.epro.kq.mappers;

import com.epro.kq.domain.Apply;
import com.epro.kq.domain.CheckBill;
import com.epro.kq.interaction.report.CheckBillDetail;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/29.
 */
@Repository
public interface CheckBillInfoMapper {
    public List<CheckBill> getCheckBillInfo(Map map);
    List<Apply> getApplyInfo(Map<String, String> param);
    List<CheckBillDetail> getCheckBill(Map map);
}
