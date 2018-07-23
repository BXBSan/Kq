<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-角色管理</title>
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
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">权限控制</strong> / <small>角色管理 </small></div>
            </div>
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-6">
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <script>
                                $(function(){
                                    $("#add").bind("click",function(){
                                        location.href = "${pageContext.request.contextPath}/role/add";
                                    });
                                });
                            </script>
                            <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                <c:if test="${myBtn.menuNo == '8'}">
                                    <c:choose>
                                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                            <button type="button" class="am-btn am-btn-default" id="add"><span class="am-icon-plus"></span> 新增</button>
                                        </c:when>
                                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                            <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-default" id="add"><span class="am-icon-plus"></span> 新增</button>
                                        </c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                            <%--<a disabled="disabled" title="您没有权限!" ><button type="button" class="am-btn am-btn-default" id="add"><span class="am-icon-plus"></span> 新增</button></a>--%>
                        </div>
                    </div>
                </div>


                <div class="am-u-sm-12 am-u-md-3">
                    <form action="${pageContext.request.contextPath}/role/show" method="get">
                        <div class="am-input-group date">
                            <input size="16" type="text" name="keyWord" value="${keyWord}" class="form-datetime am-form-field"/>
                            <span class="am-input-group-btn">
                            <button class="am-btn am-btn-default" type="submit">搜索</button>
                            </span>
                        </div>
                    </form>
                </div>
            </div>
            <div class="am-tab-panel am-fade am-in  am-active" id="tab1">
                <div class="am-g">
                    <div class="am-u-sm-12">

                        <table class="am-table am-table-striped am-table-hover table-main" style="text-align: center;">
                            <thead>
                                <tr>
                                    <th class="table-check"><input type="checkbox" /></th>
                                    <th class="table-id" style="text-align: center;">编号</th>
                                    <th class="table-title" style="text-align: center;">角色</th>
                                    <th class="table-type" style="text-align: center;">修改时间</th>
                                    <th class="table-set" style="text-align: center;">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${roleList}" var="role" varStatus="status">
                                <tr>
                                    <td><input type="checkbox" /><input type="hidden" value="${role.uuid}" /></td>
                                    <td>${status.index + 1}</td>
                                    <td><a href="${pageContext.request.contextPath}/role/edit?roleId=${role.uuid}">${role.roleName}</a></td>
                                    <td>${role.updateTime}</td>
                                    <td style="text-align: center;">
                                        <span>
                                            <%--普通员工和超级管理员不可删除--%>
                                            <%--<c:if test="${role.uuid != 'ccfdb51d-8cf0-1034-a809-c1a90b3d119b' && role.uuid != 'd16249e8-8cf0-1034-a809-c1a90b3d119b'}">
                                                <button onclick="deleteRole('${role.uuid}');" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                                            </c:if>--%>
                                            <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                                <c:if test="${myBtn.menuNo == '8'}">
                                                    <c:choose>
                                                        <c:when test="${myBtn.buttonNo == '3' && myBtn.avaliable == '1' && role.uuid != 'ccfdb51d-8cf0-1034-a809-c1a90b3d119b' && role.uuid != 'd16249e8-8cf0-1034-a809-c1a90b3d119b'}">
                                                            <button onclick="deleteRole('${role.uuid}');" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                                                        </c:when>
                                                        <c:when test="${myBtn.buttonNo == '3' && myBtn.avaliable == '0'}">
                                                            <button disabled="disabled" title="您没有权限!" onclick="deleteRole('${role.uuid}');" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                                                        </c:when>
                                                        <c:otherwise></c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </c:forEach>
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="am-cf">
                            共 ${roleCount} 条记录
                        </div>
                        <span style="color: red;">${msg}</span>
                        <hr />
                       <%--<p>注：.....</p>--%>

                    </div>

                </div>

            </div>

        </div>
    </div>

    <!-- 修改.....内容部分 end -->

    <!-- 下面是地脚,不用改 -->
    <footer class="admin-content-footer">
        <hr>
        <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
    </footer>

</div>
</body>

<script type="text/javascript">

    function deleteRole(roleId){
        console.log("roleId:",roleId);
        if (confirm("确定要删除吗？")) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/role/delete",
                data: {"roleId" : roleId},
                dataType: "json",
                async: false,
                cache: false,
//              contentType: false,
//              processData: false,
                success: function (data) {
                    alert("删除成功!");
                    location.href = "${pageContext.request.contextPath}/role/show";
                    console.log("data:", data);
                },
                error: function (data) {
                    alert("网络原因,删除失败!");
                    //alert("error："+data);
                    console.log("error-data:", data);
                }
            });
        }

    }
</script>

</html>