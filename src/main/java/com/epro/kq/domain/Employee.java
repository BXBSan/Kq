package com.epro.kq.domain;

/**
 * Created by Administrator on 2016/6/24.
 */
public class Employee extends BaseDomain {
    private String empName;
    private String empNo;
    private String roleId;
    private String phoneNo;
    private String passWord;
    private String sex;
    private String deptId;
    private String hireDate;
    private String salt;
    private String email;
    private String image;

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getHireDate() {
        return hireDate;
    }

    public void setHireDate(String hireDate) {
        this.hireDate = hireDate;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empName='" + empName + '\'' +
                ", empNo='" + empNo + '\'' +
                ", roleId='" + roleId + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", passWord='" + passWord + '\'' +
                ", sex='" + sex + '\'' +
                ", deptId='" + deptId + '\'' +
                ", hireDate='" + hireDate + '\'' +
                ", salt='" + salt + '\'' +
                ", email='" + email + '\'' +
                ", image='" + image + '\'' +
                '}';
    }
}
