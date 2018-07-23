<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Epro-编辑部门信息</title>
    <meta name="description" content="这是一个 index 页面">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
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
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg"> 部门管理</strong>/
                    <small>UpdateDept</small>
                </div>
            </div>

            <hr>

            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active"><a href="#tab1">部门信息</a></li>
                    <li><a href="#tab2">部门员工列表</a></li>
                    <%--<li><a href="#tab3">SEO 选项</a></li>--%>
                </ul>

                <div class="am-tabs-bd">
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <form class="am-form-inline" action="update" method="post" onsubmit="return checkData();">
                            <fieldset>
                                <div class="am-g am-margin-top">
                                    <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                        <label for="empname">部门名称</label>
                                    </div>
                                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                        <input type="text" class="" id="empname" name="deptName" value="${dept.deptName}" style="width:200px;">
                                    </div>
                                </div>

                                <div class="am-g am-margin-top">
                                    <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                        <label for="empno">部门编号</label>
                                    </div>
                                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                        <input type="text" class="" id="empno" name="deptNo" value="${dept.deptNo}" style="width:200px;">
                                    </div>
                                </div>

                                <div class="am-g am-margin-top">
                                    <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                        <label for="parentid">上级部门</label>
                                    </div>
                                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                        <select id="parentid" data-am-selected="{btnSize: 'sm'}" name="parentId">
                                            <option value=""></option>
                                            <c:forEach items="${deptList}" var="parent">
                                                <option value="${parent.uuid}"
                                                        <c:if test="${parent.uuid == dept.parentId}">
                                                            selected="selected"
                                                        </c:if>>${parent.deptName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <%--<div class="am-form-group">
                                    <label for="parentid">上级部门:</label>
                                    <select id="parentid" data-am-selected="{btnSize: 'sm'}" name="parentId">
                                        <option value=""></option>
                                        <c:forEach items="${deptList}" var="parent">
                                            <option value="${parent.uuid}"
                                                    <c:if test="${parent.uuid == dept.parentId}">
                                                        selected="selected"
                                                    </c:if>>${parent.deptName}</option>
                                        </c:forEach>
                                    </select>
                                </div>--%>

                                <div class="am-g am-margin-top">
                                    <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                        <label for="employeeId">部门主管</label>
                                    </div>
                                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                        <select id="employeeId" data-am-selected="{btnSize: 'sm'}" name="employeeId">
                                            <%--<option value=""></option>--%>
                                            <c:forEach items="${leaderList}" var="leader">
                                                <option value="${leader.uuid}"
                                                        <c:if test="${leader.uuid == dept.employeeId}">
                                                            selected="selected"
                                                        </c:if>>${leader.empName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <%--<div class="am-form-group">
                                    <label for="employeeId">部门主管:</label>
                                    <select id="employeeId" data-am-selected="{btnSize: 'sm'}" name="employeeId">
                                        &lt;%&ndash;<option value=""></option>&ndash;%&gt;
                                        <c:forEach items="${leaderList}" var="leader">
                                            <option value="${leader.uuid}"
                                                    <c:if test="${leader.uuid == dept.employeeId}">
                                                        selected="selected"
                                                    </c:if>>${leader.empName}</option>
                                        </c:forEach>
                                    </select>
                                </div>--%>

                                <div class="am-g am-margin-top">
                                    <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                        <label for="roleid">部门权限</label>
                                    </div>
                                    <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                        <select id="roleid" name="roleId" data-am-selected="{btnSize: 'sm'}" style="width:100px;">
                                            <option value=""></option>
                                            <c:forEach items="${roleList}" var="role">
                                                <option value="${role.uuid}"
                                                        <c:if test="${role.uuid == dept.roleId}">
                                                            selected="selected"
                                                        </c:if>>${role.roleName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <%--<div class="am-form-group">
                                    <label for="roleid">部门权限:</label>
                                    <select id="roleid" name="roleId" data-am-selected="{btnSize: 'sm'}" style="width:100px;">
                                        <option value=""></option>
                                        <c:forEach items="${roleList}" var="role">
                                            <option value="${role.uuid}"
                                                    <c:if test="${role.uuid == dept.roleId}">
                                                        selected="selected"
                                                    </c:if>>${role.roleName}</option>
                                        </c:forEach>
                                    </select>
                                </div>--%>

                                <div class="am-form-group">
                                    <label for="uuid"></label>
                                    <input type="hidden" class="" id="uuid" name="uuid" value="${dept.uuid}" >
                                </div>

                                <div class="am-g am-margin-top">
                                    <div class="am-u-sm-4 am-u-md-3 am-text-right">
                                    <c:forEach items="${myRoleButtonList}" var="myBtn">
                                        <c:if test="${myBtn.menuNo == '3'}">
                                            <c:choose>
                                                <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                                    <button type="submit" class="am-btn am-btn-default">修改</button>
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
                            </fieldset>
                        </form>
                    </div>
                    <%--tab1 end--%>

                    <div class="am-tab-panel am-fade" id="tab2">
                        <form class="am-form">
                            <table class="am-table am-table-striped am-table-hover table-main" id="table1">
                                <thead>
                                <tr>
                                    <th class="table-check"><input type="checkbox"></th>
                                    <th class="table-type">员工号</th>
                                    <th class="table-type">姓名</th>
                                    <th class="table-type">性别</th>
                                    <th class="table-author am-hide-sm-only">电话号</th>
                                    <%--<th class="table-date am-hide-sm-only">入职日期</th>
                                    <th class="table-set">操作</th>--%>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${deptEmps}" var="emp">
                                    <tr>
                                        <td><input type="checkbox"></td>
                                        <td>${emp.empNo}</td>
                                        <td><%--<a href="${pageContext.request.contextPath}/emp/load?empId=${emp.uuid}"></a>--%>${emp.empName}</td>
                                        <td>${emp.sex}</td>
                                        <td class="am-hide-sm-only">${emp.phoneNo}</td>
                                        <%--<td class="am-hide-sm-only">${emp.hireDate}</td>--%>
                                        <%--<td>
                                            <div class="am-btn-toolbar">
                                                <div class="am-btn-group am-btn-group-xs">
                                                </div>
                                            </div>
                                        </td>--%>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <a class="am-btn am-btn-default" href="javascript:history.go(-1)">返回</a>
                        </form>
                    </div>
                    <%--tab2 end--%>
                </div>
                <%--tabs end--%>
            </div>
        </div>

        <%--<footer class="admin-content-footer">
            <hr>
            <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
        </footer>--%>
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
</html>