package com.epro.kq.common;

/**
 * Created by Administrator on 2016/6/24.
 */
public class SystemConstant {
    public static Integer pageSize = 10; // 每页数据数

    // 审批相关
    public static String APPLY_STATE_WAIT = "0";     // 待批
    public static String APPLY_STATE_THROUGH = "1";  // 审批通过
    public static String APPLY_STATE_REFUSE = "2";   // 审批不通过
    public static String APPLY_STATE_SECOND_LEVEL = "3";   // 1级审批通过,进入2级审批

    // ajax返回对象(AjaxResponse)属性:status
    public static String AJAX_STATE_ERROR = "0";
    public static String AJAX_STATE_SUCCESS = "1";

    // 系统考勤标准时间(上班打卡时间)
    public static String CHECKIN_TIME = "09:00:00";
    public static String CHECKOUT_TIME = "18:00:00";

    // 权限控制
    public static String ROLE_AVALIABLE_ABLE = "1";
    public static String ROLE_AVALIABLE_DISABLE = "0";
    //加密相关
    public static String DES_PASSWORD="12345678";

    // 默认权限
    public static final String DEFAULT_ROLE_NAME = "普通员工";
    public static final String DEFAULT_ROLE_NO = "1";

    // 默认员工empId和默认部门
    public static final String DEFAULT_EMPID_ADMIN = "49da318f-8cf7-1034-a809-c1a90b3d119b";
    public static final String DEFAULT_DEPTID_COMPANY = "cb53bad6-99f5-1034-a238-a6796bac1f96";

}
