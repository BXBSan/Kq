package com.epro.kq.mappers;

import com.epro.kq.domain.CheckBill;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * Created by Administrator on 2016/6/28.
 */
@Repository
public interface CheckBillMapper {
    public void insertCheckBill(CheckBill checkBill);

    public int getCheckBillCount(Map params);

    public void updateCheckBill(Map map1);

    int getCount(Map param);

    int getEveryEmpApplyBillCount(Map<String, String> param);

    int getEveryApplyTypeBillCount(Map<String, String> param);
}
