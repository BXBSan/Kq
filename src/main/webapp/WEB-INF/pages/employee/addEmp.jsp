<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-新增员工</title>
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
    <%--<div class="admin-content">--%>
        <%--<div class="admin-content-body">--%>
            <%--<div class="am-cf am-padding">--%>
                <%--<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg"> 员工管理</strong> / <small>新增员工</small></div>--%>
            <%--</div>--%>

            <%--<form class="am-form-inline" action="addEmp" method="post" onsubmit="return checkData();">--%>
            <%--<fieldset>--%>
                <%--<legend><span style="color: red">${msg}</span></legend>--%>
                <%--<div class="am-form-group">--%>
                    <%--<label for="empname">姓　　名:</label>--%>
                    <%--<input type="text" class="" id="empname" name="empName" value="${newEmp.empName}" placeholder="输入姓名">--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--<div class="am-form-group">--%>
                    <%--<label for="empno">员工工号:</label>--%>
                    <%--<input type="text" class="" id="empno" name="empNo" value="${newEmp.empNo}" placeholder="输入员工号">--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--<div class="am-form-group">--%>
                    <%--<label for="roleid">选择角色:</label>--%>
                    <%--<select id="roleid" data-am-selected="{btnSize: 'sm'}" name="roleId">--%>
                        <%--<c:forEach items="${roleList}" var="role">--%>
                            <%--<option value="${role.uuid}">${role.roleName}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--<div class="am-form-group">--%>
                    <%--<label for="phoneno">手机号码:</label>--%>
                    <%--<input type="text" class="" id="phoneno" value="${newEmp.phoneNo}" name="phoneNo" placeholder="输入电话">--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--<div class="am-form-group">--%>
                    <%--<label>性　　别:</label>--%>
                    <%--<span  class="am-input-sm">--%>
                    <%--<input name="sex" type="radio" value="男" />男&nbsp;&nbsp;&nbsp;&nbsp;--%>
                    <%--<input name="sex" type="radio" value="女" />女--%>
                    <%--</span>--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="deptid">部门　ID:</label>--%>
                <%--<input type="text" class="" id="deptid" name="deptId" placeholder="输入部门号">--%>
                <%--</div>&ndash;%&gt;--%>
                <%--<div class="am-form-group">--%>
                    <%--<label for="deptid">选择部门:</label>--%>
                    <%--<select id="deptid" data-am-selected="{btnSize: 'sm'}" name="deptId">--%>
                      <%--<c:forEach items="${deptList}" var="dept">--%>
                          <%--<option value="${dept.uuid}" >${dept.deptName}</option>--%>
                      <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--<div class="am-form-group">--%>
                    <%--<label for="hiredate">入职日期:</label>--%>
                    <%--<input type="text" class="hiredate" id="hiredate" value="${newEmp.hireDate}" name="hireDate" placeholder="输入入职日期" readonly="true">--%>
                <%--</div>--%>
                <%--<br />--%>

                <%--&lt;%&ndash;<div class="am-form-group">--%>
                <%--<label for="createtime">创建日期:</label>--%>
                <%--<input type="text" class="" id="createtime" name="createTime"   placeholder="输入创建日期" readonly>--%>
                <%--</div>--%>
                <%--<br />--%>
                <%--<div class="am-form-group">--%>
                <%--<label for="updatetime">修改日期:</label>--%>
                <%--<input type="text" class="" id="updatetime" name="updateTime"   placeholder="输入修改日期" readonly>--%>
                <%--</div>--%>
                <%--<br />&ndash;%&gt;--%>

                <%--<div class="am-form-group">--%>
                    <%--<label for="password">密　　码:</label>--%>
                    <%--<input type="text" class="" id="password" name="passWord" value="${newEmp.passWord}" placeholder="设置个密码吧">--%>
                <%--</div>--%>
                <%--<br/>--%>

                <%--<p>--%>
                <%--<c:forEach items="${myRoleButtonList}" var="myBtn">--%>
                    <%--<c:if test="${myBtn.menuNo == '2'}">--%>
                        <%--<c:choose>--%>
                            <%--<c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">--%>
                                <%--<button type="submit" class="am-btn am-btn-default">提交</button>--%>
                            <%--</c:when>--%>
                            <%--<c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">--%>
                                <%--<button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-default">提交</button>--%>
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
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">新增员工</strong> / <small>AddEmployee</small></div>
            </div>

            <hr>

            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-4 am-u-md-push-8">
                    <div class="am-panel am-panel-default">
                        <div class="am-panel-bd">
                            <div class="am-g">
                                <div class="am-u-md-4">
                                    <img class="am-img-circle am-img-thumbnail" src="Amaze%20UI%20Admin%20user%20Examples_files/bw-2014-06-19.jpg" alt="">
                                </div>
                                <div class="am-u-md-8">
                                    <p>你可以使用<a href="#">gravatar.com</a>提供的头像或者使用本地上传头像。 </p>
                                    <form class="am-form"  method="post" action="upload"  enctype="multipart/form-data">
                                        <div class="am-form-group">
                                            <input id="user-pic" type="file" name="image">
                                            <p class="am-form-help">请选择要上传的文件...</p>
                                            <button type="submit" class="am-btn am-btn-primary am-btn-xs">保存</button>
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
                    <form class="am-form am-form-horizontal" action="addEmp" method="post" onsubmit="return checkData();">
                        <div class="am-form-group">
                            <label for="user-name" class="am-u-sm-3 am-form-label">姓名 / Name</label>
                            <div class="am-u-sm-9">
                                <input id="user-name" name="empName" value="${newEmp.empName}" placeholder="姓名 / Name" type="text">
                                <small>输入你的名字，让我们记住你。</small>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="user-email" class="am-u-sm-3 am-form-label">电子邮件 / Email</label>
                            <div class="am-u-sm-9">
                                <input id="user-email" name="email"  placeholder="输入你的电子邮件 / Email" type="email">
                                <small>邮箱你懂得...</small>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="user-phone" class="am-u-sm-3 am-form-label">电话 / Telephone</label>
                            <div class="am-u-sm-9">
                                <input id="user-phone" value="${newEmp.phoneNo}" name="phoneNo" placeholder="输入你的电话号码 / Telephone" type="tel">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="user-QQ" class="am-u-sm-3 am-form-label">员工号</label>
                            <div class="am-u-sm-9">
                                <input pattern="[0-9]*" id="user-QQ" name="empNo" value="${newEmp.empNo}" placeholder="输入员工号" type="number">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="user-weibo" class="am-u-sm-3 am-form-label">密码 / password</label>
                            <div class="am-u-sm-9">
                                <input id="user-weibo" name="passWord" value="${newEmp.passWord}" placeholder="输入你的密码" type="text">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="hiredate" class="am-u-sm-3 am-form-label">入职日期 / hiredate</label>
                            <div class="am-u-sm-9">
                                <input id="hiredate" value="${newEmp.hireDate}" name="hireDate" placeholder="输入入职日期" type="text">
                            </div>
                        </div>

                        <div class="am-form-group">
                        <label for="user-ww" class="am-u-sm-3 am-form-label">性　　别</label>&nbsp;&nbsp;
                        <span  class="am-input-sm">
                        <input id="user-ww" name="sex" type="radio" value="男" />男&nbsp;&nbsp;&nbsp;&nbsp;
                        <input name="sex" type="radio" value="女" />女
                        </span>
                        </div>

                        <div class="am-form-group">
                        <label for="deptid" class="am-u-sm-3 am-form-label">选择部门</label>&nbsp;&nbsp;
                        <select id="deptid" data-am-selected="{btnSize: 'sm'}" name="deptId">
                        <c:forEach items="${deptList}" var="dept">
                        <option value="${dept.uuid}" >${dept.deptName}</option>
                        </c:forEach>
                        </select>
                        </div>
                        <br />





                    <div class="am-form-group">
                        <div class="am-u-sm-9 am-u-sm-push-3">
                        <c:forEach items="${myRoleButtonList}" var="myBtn">
                        <c:if test="${myBtn.menuNo == '2'}">
                        <c:choose>
                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                        <button type="submit" class="am-btn am-btn-primary">提交</button>
                        </c:when>
                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                        <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary">提交</button>
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
    </div>

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

<%--<script type="text/javascript">--%>
    <%--// 非空检查--%>
    <%--function checkData(){--%>
        <%--if($("#user-name").val() == ""){--%>
            <%--alert("请输入姓名!");--%>
            <%--return false;--%>
        <%--}--%>
        <%--if($("#user-QQ").val() == ""){--%>
            <%--alert("请输入员工工号!");--%>
            <%--return false;--%>
        <%--}--%>

        <%--if($("#user-phone").val() == ""){--%>
            <%--alert("请输入手机号码!");--%>
            <%--return false;--%>
        <%--}else{--%>
            <%--var phoneReg = /^1[358]\d{9}$/;--%>
            <%--if(phoneReg.test($("#user-phone").val()) == false) {--%>
                <%--alert("手机号码格式不正确!");--%>
                <%--return false;--%>
            <%--}--%>
        <%--}--%>
        <%--var sex = $("input[name='sex']:checked").val();--%>
        <%--if(sex == null){--%>
            <%--alert("请选择性别!");--%>
            <%--return false;--%>
        <%--}--%>
        <%--if($("#deptid").val() == ""){--%>
            <%--alert("请选择部门!");--%>
            <%--return false;--%>
        <%--}--%>
        <%--if($("#hiredate").val() == ""){--%>
            <%--alert("请选择入职日期!");--%>
            <%--return false;--%>
        <%--}--%>
        <%--if($("#user-weibo").val() == ""){--%>
            <%--alert("请输入密码!");--%>
            <%--return false;--%>
        <%--}--%>
    <%--}--%>

<%--</script>--%>

</html>

