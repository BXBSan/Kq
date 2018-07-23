package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/6/24.
 */
public class Button extends BaseDomain {
    private String buttonNo;
    private String buttonType;

    public String getButtonNo() {
        return buttonNo;
    }

    public void setButtonNo(String buttonNo) {
        this.buttonNo = buttonNo;
    }

    public String getButtonType() {
        return buttonType;
    }

    public void setButtonType(String buttonType) {
        this.buttonType = buttonType;
    }
}
