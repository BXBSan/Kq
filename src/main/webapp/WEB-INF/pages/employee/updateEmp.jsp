<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-编辑员工信息</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jedate/jedate.js"></script>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/static/amazeui/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/static/amazeui/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/amazeui/css/amazeui.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/amazeui/css/admin.css">
    <script src="${pageContext.request.contextPath}/static/js/updateEmp.js" />
    <script type="text/javascript">
        window.onload = function(){
            console.log(${tabNum == "tab2"});
            if(${tabNum == "tab2"}){
                $("#li1").removeClass();
                $("#li2").addClass("am-active");

                $("#tab1").removeClass("am-active");
                $("#tab1").removeClass("am-in");
                $("#tab2").addClass("am-active");
                $("#tab2").addClass("am-in");
            } else if(${tabNum == "tab1"}){
                $("#li2").removeClass();
                $("#li1").addClass("am-active");

                $("#tab2").removeClass("am-active");
                $("#tab2").removeClass("am-in");
                $("#tab1").addClass("am-active");
                $("#tab1").addClass("am-in");
            }
        }

        // 测试tab的切换
        function test(){
            if($("#li1").hasClass("am-active")){
                $("#li1").removeClass();
                $("#li2").addClass("am-active");

                $("#tab1").removeClass("am-active");
                $("#tab1").removeClass("am-in");
                $("#tab2").addClass("am-active");
                $("#tab2").addClass("am-in");

            } else if($("#li2").hasClass("am-active")){
                $("#li2").removeClass();
                $("#li1").addClass("am-active");

                $("#tab2").removeClass("am-active");
                $("#tab2").removeClass("am-in");
                $("#tab1").addClass("am-active");
                $("#tab1").addClass("am-in");
            }

        }
    </script>
</head>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
  以获得更好的体验！</p>
<![endif]-->

<!-- 引入头部 -->
<jsp:include page="/WEB-INF/pages/base/header.jsp" />

<div class="am-cf admin-main">
  <!-- 引入侧边栏 -->
  <jsp:include page="/WEB-INF/pages/base/sidebar.jsp"/>

  <!-- 修改.....内容部分 start -->
  <!-- content start -->
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">修改员工信息</strong> / <small>Modify</small></div>
            </div>
            <hr>
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active" id="li1"><a href="#tab1" id="t1">基本信息</a></li>
                    <li id="li2"><a href="#tab2" id="t2">考勤详情</a></li>
                </ul>

                <div class="am-tabs-bd">
                    <!-- 基本信息Tab -->
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <div class="am-g">
                            <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                                <div class="am-panel am-panel-default">
                                    <div class="am-panel-bd">
                                        <div class="am-g">
                                            <%--<div class="am-u-md-4">
                                                <img class="am-img-circle am-img-thumbnail" width="300" height="280" src="${pageContext.request.contextPath}/static/images/empPhotos/dafultPhoto.jpg" alt="">
                                            </div>--%>
                                            <div class="am-u-md-8">
                                                <img class="am-img-circle am-img-thumbnail" width="500" height="350" src="${pageContext.request.contextPath}/static/images/empPhotos/dafultPhoto.jpg" alt="">
                                                <%--<p>你可以使用<a href="#">gravatar.com</a>提供的头像或者使用本地上传头像。 </p>--%>
                                                <form action="${pageContext.request.contextPath}/emp/photo_upload" class="am-form" id="photoUploadForm">
                                                    <div class="am-form-group">
                                                        <input id="empPhoto" name="empPhoto" type="file"><%-- accept="image/*"--%>
                                                        <p class="am-form-help">请选择要上传的文件...</p>
                                                        <button type="button" onclick="uploadPhoto();" class="am-btn am-btn-primary am-btn-xs">保存</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="am-panel am-panel-default">
                                    <div class="am-panel-bd">
                                        <div class="user-info">
                                            <p>等级信息</p>
                                            <div class="am-progress am-progress-sm">
                                                <div class="am-progress-bar" style="width: 60%"></div>
                                            </div>
                                            <p class="user-info-order">当前等级：<strong>LV8</strong> 活跃天数：<strong>587</strong> 距离下一级别：<strong>160</strong></p>
                                        </div>
                                        <div class="user-info">
                                            <p>信用信息</p>
                                            <div class="am-progress am-progress-sm">
                                                <div class="am-progress-bar am-progress-bar-success" style="width: 80%"></div>
                                            </div>
                                            <p class="user-info-order">信用等级：正常当前 信用积分：<strong>80</strong></p>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="am-u-sm-12 am-u-md-8 am-u-md-pull-4">
                                    <form class="am-form am-form-horizontal" action="update" method="post" onsubmit="return checkData();">
                                        <div class="am-form-group">
                                            <label for="deptid" class="am-u-sm-3 am-form-label" >部门</label>&nbsp;&nbsp;
                                            <select  id="deptid" data-am-selected="{btnSize: 'sm'}" name="deptId">
                                                <c:forEach items="${deptList}" var="dept">
                                                    <option value="${dept.uuid}"
                                                            <c:if test="${updatedEmp.deptId == dept.uuid}">
                                                                selected="selected"
                                                            </c:if>>${dept.deptName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="am-form-group">
                                            <label for="user-ww" class="am-u-sm-3 am-form-label">性　　别</label>&nbsp;&nbsp;
                                            <span  class="am-input-sm">
                                            <input id="user-ww" name="sex" <c:if test="${updatedEmp.sex == '男'}" >checked="checked"</c:if> type="radio" value="男" />男&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input name="sex" <c:if test="${updatedEmp.sex == '女'}" >checked="checked"</c:if> type="radio" value="女" />女
                                            </span>
                                        </div>
                                        <div class="am-form-group">
                                            <label for="user-name" class="am-u-sm-3 am-form-label">姓名 / Name</label>
                                            <div class="am-u-sm-9">
                                                <input id="user-name" name="empName" value="${updatedEmp.empName}" placeholder="姓名 / Name" type="text">
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="user-QQ" class="am-u-sm-3 am-form-label">员工号</label>
                                            <div class="am-u-sm-9">
                                                <input pattern="[0-9]*" id="user-QQ" name="empNo" value="${updatedEmp.empNo}" placeholder="输入员工号" type="number">
                                            </div>
                                        </div>


                                        <div class="am-form-group">
                                            <label for="user-email" class="am-u-sm-3 am-form-label">电子邮件 / Email</label>
                                            <div class="am-u-sm-9">
                                                <input id="user-email" name="email" value="${updatedEmp.email}" placeholder="输入你的电子邮件 / Email" type="email">
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="user-phone" class="am-u-sm-3 am-form-label">电话 / Telephone</label>
                                            <div class="am-u-sm-9">
                                                <input id="user-phone" value="${updatedEmp.phoneNo}" name="phoneNo" placeholder="输入你的电话号码 / Telephone" type="tel">
                                            </div>
                                        </div>

                                        <div class="am-form-group">
                                            <label for="hiredate" class="am-u-sm-3 am-form-label">入职日期 / hiredate</label>
                                            <div class="am-u-sm-9">
                                                <input id="hiredate" value="${updatedEmp.hireDate}" name="hireDate" placeholder="输入入职日期" type="text">
                                            </div>
                                        </div>
                                        <%--<div class="am-form-group">
                                            <label for="user-weibo" class="am-u-sm-3 am-form-label">密码 / password</label>
                                            <div class="am-u-sm-9">
                                                <input id="user-weibo" name="passWord" value="${updatedEmp.passWord}" placeholder="输入你的密码" type="text">
                                            </div>
                                        </div>--%>






                                        <input type="hidden" class="" id="uuid" name="uuid" value="${updatedEmp.uuid}" >

                                        <div class="am-form-group">
                                        <div class="am-u-sm-9 am-u-sm-push-3">
                                        <c:forEach items="${myRoleButtonList}" var="myBtn">
                                        <c:if test="${myBtn.menuNo == '2'}">
                                        <c:choose>
                                        <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                        <button type="submit" class="am-btn am-btn-primary">修改</button>
                                        </c:when>
                                        <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                        <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-default">修改</button>
                                        </c:when>
                                        <c:otherwise></c:otherwise>
                                        </c:choose>
                                        </c:if>
                                        </c:forEach>
                                        <a class="am-btn am-btn-default" href="javascript:history.go(-1)">返回</a>
                                        </div>
                                        </div>
                                    </form>
                                    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jedate/seting.jsp"></script>
                            </div>

                        </div>
                    </div>






                    <!-- 考情详情Tab -->
                    <div class="am-tab-panel am-fade" id="tab2">
                        <div class="am-g">
                            <div class="am-u-sm-12">
                                <div class="am-g">
                                    <div class="am-u-sm-12">
                                        <table class="am-table am-table-bd am-table-striped admin-content-table">
                                            <thead>
                                            <tr>
                                                <th class="table-check" onclick="checkIn(this);"><input type="checkbox" id="checkid"/></th><th>员工号</th><th>员工姓名</th><th>打卡次数</th><th>请假次数</th><th>加班次数</th><th>调休次数</th>
                                            </tr>
                                            </thead>
                                            <tbody>


                                                <tr>
                                                    <td><input type="checkbox" name="checkbox" /></td>
                                                    <td>${tolRepot.empNo}</td>
                                                    <td><a style="color: green;" href="${pageContext.request.contextPath}/report/getApplyDetail?empId=${aa.uuid}">${tolRepot.empName}</a></td>
                                                    <td>${tolRepot.clockNum}</td>
                                                    <td class="am-hide-sm-only">${tolRepot.leaveNum}</td>
                                                    <td>${tolRepot.overTime}</td>
                                                    <td>${tolRepot.offNum}</td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- Tab 1 2 end. -->
                </div>
            </div>

        </div>
    </div>






    <%--<div class="admin-content">--%>
        <%--<div class="admin-content-body">--%>
            <%--<div class="am-cf am-padding">--%>
                <%--<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"> 员工管理</strong> / <small>修改员工信息</small></div>--%>
            <%--</div>--%>
            <%--<form class="am-form-inline" action="update" method="post" onsubmit="return checkData();">--%>
            <%--<fieldset>--%>
              <%--<legend><span style="color: red">${msg}</span></legend>--%>
              <%--<div class="am-form-group">--%>
                <%--<label for="empname">姓　　名:</label>--%>
                <%--<input type="text" class="" id="empname" name="empName" value="${updatedEmp.empName}" >--%>
              <%--</div>--%>
              <%--<br />--%>
              <%--<div class="am-form-group">--%>
                <%--<label for="empno">工　　号:</label>--%>
                <%--<input type="text" class="" id="empno" name="empNo"  value="${updatedEmp.empNo}" >--%>
              <%--</div>--%>
              <%--<br />--%>

              <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="roleid">角　　色:</label>--%>
                <%--<input type="text" class="" id="roleid" name="roleId" value="${updatedEmp.roleId}"  >--%>
              <%--</div>--%>
              <%--<br />&ndash;%&gt;--%>
                <%--<div class="am-form-group">--%>
                    <%--<label for="roleid">角　　色:</label>--%>
                    <%--<c:choose>--%>
                        <%--<c:when test="${updatedEmp.uuid == '49da318f-8cf7-1034-a809-c1a90b3d119b'}">--%>
                            <%--<input type="text" value="${updatedEmp.roleName}" readonly="true" title="超级管理员,不可改!">--%>
                            <%--<input type="hidden" id="roleid" name="roleId" value="${updatedEmp.roleId}">--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                            <%--<select id="roleid" data-am-selected="{btnSize: 'sm'}" name="roleId">--%>
                                <%--<c:forEach items="${roleList}" var="role">--%>
                                    <%--<option value="${role.uuid}"--%>
                                            <%--<c:if test="${updatedEmp.roleId == role.uuid}">--%>
                                                <%--selected="selected"--%>
                                            <%--</c:if> >${role.roleName}</option>--%>
                                <%--</c:forEach>--%>
                            <%--</select>--%>
                        <%--</c:otherwise>--%>
                    <%--</c:choose>--%>
                <%--</div>--%>
                <%--<br />--%>

              <%--<div class="am-form-group">--%>
                <%--<label for="phoneno">电　　话:</label>--%>
                <%--<input type="text" class="" id="phoneno" name="phoneNo" value="${updatedEmp.phoneNo}"  >--%>
              <%--</div>--%>
              <%--<br />--%>
              <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="sex">性　　别:</label>--%>
                <%--<input type="text" class="" id="sex" name="sex" value="${updatedEmp.sex}"  >--%>
              <%--</div>&ndash;%&gt;--%>
                <%--<div class="am-form-group">--%>
                    <%--<label>性　　别:</label>--%>
                    <%--<span  class="am-input-sm">--%>
                    <%--<input name="sex" <c:if test="${updatedEmp.sex == '男'}" >checked="checked"</c:if> type="radio" value="男" />男&nbsp;&nbsp;&nbsp;&nbsp;--%>
                    <%--<input name="sex" <c:if test="${updatedEmp.sex == '女'}" >checked="checked"</c:if> type="radio" value="女" />女--%>
                    <%--</span>--%>
                <%--</div>--%>
              <%--<br />--%>

              <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="deptid">部　　门:</label>--%>
                <%--<input type="text" class="" id="deptid" name="deptId" value="${updatedEmp.deptId}"  >--%>
              <%--</div>&ndash;%&gt;--%>
                <%--<div class="am-form-group">--%>
                    <%--<label for="deptid">选择部门:</label>--%>
                    <%--<select id="deptid" data-am-selected="{btnSize: 'sm'}" name="deptId">--%>
                        <%--<c:forEach items="${deptList}" var="dept">--%>
                            <%--<option value="${dept.uuid}"--%>
                                    <%--<c:if test="${updatedEmp.deptId == dept.uuid}">--%>
                                        <%--selected="selected"--%>
                                    <%--</c:if>>${dept.deptName}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</div>--%>
              <%--<br />--%>

              <%--<div class="am-form-group">--%>
                <%--<label for="hiredate">入职日期:</label>--%>
                <%--<input type="text" class="" id="hiredate" name="hireDate" value="${updatedEmp.hireDate}" readonly >--%>
              <%--</div>--%>
              <%--<br />--%>

              <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="createtime">创建日期:</label>--%>
                <%--<input type="text" class="" id="createtime" name="createTime" value="${updatedEmp.createTime}" readonly>--%>
              <%--</div>--%>
              <%--<br />&ndash;%&gt;--%>

              <%--<div class="am-form-group">--%>
                <%--<label for="updatetime">修改日期:</label>--%>
                <%--<input type="text" class="" id="updatetime" name="updateTime" value="${updatedEmp.updateTime}" readonly >--%>
              <%--</div>--%>
              <%--<br />--%>

              <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="password">密　　码:</label>--%>
                <%--<input type="password" class="" id="password22" name="passWord22" value="${updatedEmp.passWord}" readonly >--%>
              <%--</div>--%>

              <%--<div class="am-form-group">--%>
                <%--<label for="password"></label>--%>
                <%--<input type="hidden" class="" id="password" name="passWord" value="${updatedEmp.passWord}"  >--%>
              <%--</div>&ndash;%&gt;--%>

              <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="uuid"></label>--%>
                <%--<input type="hidden" class="" id="uuid" name="uuid" value="${updatedEmp.uuid}" >--%>
              <%--</div>&ndash;%&gt;--%>
              <%--<input type="hidden" class="" id="uuid" name="uuid" value="${updatedEmp.uuid}" >--%>

              <%--<p>--%>
                  <%--<c:forEach items="${myRoleButtonList}" var="myBtn">--%>
                      <%--<c:if test="${myBtn.menuNo == '2'}">--%>
                          <%--<c:choose>--%>
                              <%--<c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">--%>
                                  <%--<button type="submit" class="am-btn am-btn-default">修改</button>--%>
                              <%--</c:when>--%>
                              <%--<c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">--%>
                                  <%--<button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-default">修改</button>--%>
                              <%--</c:when>--%>
                              <%--<c:otherwise></c:otherwise>--%>
                          <%--</c:choose>--%>
                      <%--</c:if>--%>
                  <%--</c:forEach>--%>
                  <%--<a class="am-btn am-btn-default" href="javascript:history.go(-1)">返回</a>--%>
              <%--</p>--%>
            <%--</fieldset>--%>
            <%--</form>--%>
            <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/jedate/seting.jsp"></script>--%>
        <%--</div>--%>
    <%--</div>--%>

  <!-- content end -->
  <!-- 修改.....内容部分 end -->

  <!-- 下面是地脚,不用改 -->
  <footer class="admin-content-footer">
    <hr>
    <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
  </footer>

</div>

<!-- 下面不用改 -->
<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/static/amazeui/js/jquery.min.js"></script>
<!--<![endif]-->
<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/amazeui/js/app.js"></script>
</body>
<script type="text/javascript">
    // 非空检查
    function checkData(){
        if($("#empname").val() == ""){
            alert("请输入姓名!");
            return false;
        }
        if($("#empno").val() == ""){
            alert("请输入员工工号!");
            return false;
        }
        if($("#roleid").val() == ""){
            alert("请选择角色!");
            return false;
        }
        if($("#phoneno").val() == ""){
            alert("请输入手机号码!");
            return false;
        }else{
            var phoneReg = /^1[358]\d{9}$/;
            if(phoneReg.test($("#phoneno").val()) == false) {
                alert("手机号码格式不正确!");
                return false;
            }
        }
        var sex = $("input[name='sex']:checked").val()
        if(sex == null){
            alert("请选择性别!");
            return false;
        }
        if($("#deptid").val() == ""){
            alert("请选择部门!");
            return false;
        }
        if($("#hiredate").val() == ""){
            alert("请选择入职日期!");
            return false;
        }
        if($("#password").val() == ""){
            alert("请输入密码!");
            return false;
        }
    }

</script>

</html>

