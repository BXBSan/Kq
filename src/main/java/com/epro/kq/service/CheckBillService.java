package com.epro.kq.service;

import com.epro.kq.common.SystemConstant;
import com.epro.kq.domain.CheckBill;
import com.epro.kq.domain.Employee;
import com.epro.kq.interaction.AjaxResponse;
import com.epro.kq.mappers.CheckBillMapper;
import com.epro.kq.mappers.EmpMapper;
import com.epro.kq.utils.MyDateUtils;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * Created by Administrator on 2016/6/28.
 */
@Service
public class CheckBillService {
    @Autowired
    private CheckBillMapper checkBillMapper;

    @Autowired
    private EmpMapper empMapper;

//    String preTime="09;00:00";
//    String sufTime="18:00:00";
    String sufTime = SystemConstant.CHECKOUT_TIME;
    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
    String nT=sdf.format(new Date());

    /**
     * 打卡信息插入功能实现
     * @param checkBill
     * @param nowDate
     * @param map1
     * @return
     */
    public boolean insertCheckBill(CheckBill checkBill,String nowDate,Map map1){
        try {
//            Date pt=sdf.parse(preTime);
//            Date st=sdf.parse(sufTime);
//            Date nowTime=sdf.parse(nT);
            Map params = new HashMap();
            params.put("empId", checkBill.getEmpId());
            params.put("checkDate", nowDate);
            int count=getCheckBillCount(params);
            if(count<2){
                checkBillMapper.insertCheckBill(checkBill);
            }if(count==2){
                updateCheckBill(map1);
            }

            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    };

    public int getCheckBillCount(Map params){
        int count = checkBillMapper.getCheckBillCount(params);
        return count;
    };

    public void updateCheckBill(Map map1){
        checkBillMapper.updateCheckBill(map1);
    }

    public AjaxResponse doUpload(MultipartFile excelFile){
        AjaxResponse ajaxResponse = new AjaxResponse();

        jxl.Workbook readwk = null;
        InputStream inputStream = null;
        try {
            readwk = Workbook.getWorkbook(excelFile.getInputStream());
            Sheet sheet = readwk.getSheet(0);
            int clumns = sheet.getColumns();
            int rows = sheet.getRows();
            //System.out.println("clumns:"+clumns+"rows:"+rows);

            if(clumns != 5){
                // 标准格式 5列
                ajaxResponse.setState(SystemConstant.AJAX_STATE_ERROR);
                ajaxResponse.setMsg("打卡文档格式不正确!{列数错误}");
                return ajaxResponse;
            }

            Map<String, String> errorPeople = new HashMap<String, String>();
            // 遍历每条信息
            for(int i = 0; i < rows; i++){
                if(i == 0){
                    // 判断标题行
                    if(!"员工号".equals(sheet.getCell(0, i).getContents())
                            || !"员工姓名".equals(sheet.getCell(1, i).getContents())
                            || !"登记手机号".equals(sheet.getCell(2, i).getContents())
                            || !"打卡日期".equals(sheet.getCell(3, i).getContents())
                            || !"打卡时间".equals(sheet.getCell(4, i).getContents())){
                        ajaxResponse.setState(SystemConstant.AJAX_STATE_ERROR);
                        ajaxResponse.setMsg("打卡文档格式不正确!{非标准文档,列标题不匹配}");
                        return ajaxResponse;
                    }
                    continue; // 跳过标题
                }

                // 查找员工
                Map<String, String> params = new HashMap<String, String>();
                params.put("empNo", sheet.getCell(0, i).getContents());
                params.put("empName", sheet.getCell(1, i).getContents());
                params.put("phoneNo", sheet.getCell(2, i).getContents());
                Employee findEmp = empMapper.findEmpByNoPhoneName(params);
                if(findEmp == null){
                    // 员工查找失败,打卡信息录入失败!
                    errorPeople.put("第" + (i + 1) + "条数据", "员工查找失败,打卡信息录入失败!");
                    continue;
                }

                String checkDate = sheet.getCell(3, i).getContents();
                String checkTime = sheet.getCell(4, i).getContents();
                String nowDateTime = DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss");
                // 校验时间格式 若不正确
                if(!MyDateUtils.checkStrYYYY_MM_DD(checkDate) || !MyDateUtils.checkStrHHmmss(checkTime)){
                    errorPeople.put("第" + (i + 1) + "条数据", "打卡日期或时间格式不正确!");
//                    boolean dateFlag = MyDateUtils.checkStrYYYY_MM_DD(checkDate);
//                    boolean timeFlag = MyDateUtils.checkStrHHmmss(checkTime);
                    continue;
                }

                // 构建插入对象
                CheckBill checkBill = new CheckBill();
                checkBill.setEmpId(findEmp.getUuid());
                checkBill.setCheckDate(checkDate);
                checkBill.setCheckTime(checkTime);
                checkBill.setUpdateTime(nowDateTime);
                checkBill.setCreateTime(nowDateTime);

                // 校验签卡,查找当天签卡
                Map paramsMap = new HashMap();
                paramsMap.put("empId", checkBill.getEmpId());
                paramsMap.put("chackDate", checkBill.getCheckDate());
                paramsMap.put("checktime", checkBill.getCheckTime()); // 更新用到的参数
                paramsMap.put("updatetime", nowDateTime);
                int count = getCheckBillCount(paramsMap);
                if(count < 2){
                    checkBillMapper.insertCheckBill(checkBill);
                }if(count >= 2){
                    checkBillMapper.updateCheckBill(paramsMap);
                }
            }

            // 如果有异常数据,未被插入的,提示!
            if(!errorPeople.isEmpty()){
                ajaxResponse.setMsg("数据有异常!");
                ajaxResponse.setData(errorPeople);
            }
        } catch (BiffException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if(inputStream != null){
                    inputStream.close();
                }
                if(readwk != null){
                    readwk.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // 插入操作成功!(包括有格式异常, 被跳过的数据)
        ajaxResponse.setState(SystemConstant.AJAX_STATE_SUCCESS);
        return ajaxResponse;
    }
}
