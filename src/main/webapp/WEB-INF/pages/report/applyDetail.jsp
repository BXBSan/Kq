
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Tab页设计测试</title>
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
    <script>
        function doexcheckport(){
            alert("1");
            var form = $("<form>");   //定义一个form表单
            form.attr('style','display:none');   //在form表单中添加查询参数
            form.attr('target','');
            form.attr('method','post');
            form.attr('action',"${pageContext.request.contextPath}/report/exApplyReport?empId=${empId}&nowDate=${nowDate}");
            $('body').append(form);  //将表单放置在web中
            form.submit();   //表单提交
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
            <div class="am-cf am-padding">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">报表管理</strong>/
                    <small>申请详情</small>
                </div>
            </div>

            <hr>

            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active"><a href="#tab1">请假</a></li>
                    <li><a href="#tab2">加班</a></li>
                    <li><a href="#tab3">调休</a></li>
                    <li>
                        <button  type="button" class="am-btn am-btn-success am-btn-xs" style="margin-right:-90px;margin-left:30px;" onclick="doexcheckport()" ><span class="am-icon-save"></span>导出</button>
                    </li>
                </ul>
                <div class="am-tabs-bd">
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <table class="am-table am-table-striped am-table-hover table-main">
                            <thead>
                            <tr>
                                <th class="table-id">ID</th><th >员工号</th><th >申请人</th><th class="table-title">类别</th><th >开始日期</th><th class="table-author am-hide-sm-only">结束日期</th><th >审批人</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${leaveDetails}" varStatus="status" var="detail">
                                    <tr>
                                        <td>${status.index+1}</td>
                                        <td>${detail.empNo}</td>
                                        <td>${detail.applyName}</td>
                                        <td>请假</td>
                                        <td>${detail.startDate}</td>
                                        <td>${detail.endDate}</td>
                                        <td>${detail.approveName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <%--tab2 end--%>
                    <div class="am-tab-panel am-fade" id="tab2">
                        <table class="am-table am-table-striped am-table-hover table-main">
                            <thead>
                            <tr>
                                <th class="table-id">ID</th><th >员工号</th><th >申请人</th><th class="table-title">类别</th><th >开始日期</th><th class="table-author am-hide-sm-only">结束日期</th><th >审批人</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${overDetails}" varStatus="status" var="detail">
                                <tr>
                                    <td>${status.index+1}</td>
                                    <td>${detail.empNo}</td>
                                    <td>${detail.applyName}</td>
                                    <td>加班</td>
                                    <td>${detail.startDate}</td>
                                    <td>${detail.endDate}</td>
                                    <td>${detail.approveName}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="am-tab-panel am-fade" id="tab3">
                        <table class="am-table am-table-striped am-table-hover table-main">
                            <thead>
                            <tr>
                                <th class="table-id">ID</th><th >员工号</th><th >申请人</th><th class="table-title">类别</th><th >开始日期</th><th class="table-author am-hide-sm-only">结束日期</th><th >审批人</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${takeDetails}" varStatus="status" var="detail">
                                <tr>
                                    <td>${status.index+1}</td>
                                    <td>${detail.empNo}</td>
                                    <td>${detail.applyName}</td>
                                    <td>调休</td>
                                    <td>${detail.startDate}</td>
                                    <td>${detail.endDate}</td>
                                    <td>${detail.approveName}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <%--tab3 end--%>
                </div>
                <%--tabs end--%>
            </div>

            <%--<div class="am-margin">
                <button type="button" class="am-btn am-btn-primary am-btn-xs">提交保存</button>
                <button type="button" class="am-btn am-btn-primary am-btn-xs">放弃保存</button>
            </div>--%>
        </div>

        <footer class="admin-content-footer">
            <hr>
            <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
        </footer>
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