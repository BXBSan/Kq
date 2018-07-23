
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-首页</title>
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
    <%--<script type="text/javascript">
        function checkIn(){

            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/main/checkbill",
                data: "{}",
                dataType: "json",
                success: function(data){
                    alert("1111");
                    //Data = eval("("+data+")");

                    alert(data.result);
                    alert("3333")
                    //alert($('#subbtn').text(data));
                    atconsole.log("data:",da);

                },
                error: function(data){
                    alert("2222");

                    console.log("error!");
                },

            });
        }
    </script>--%>
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
    <jsp:include page="base/sidebar.jsp"/>

    <!-- 修改.....内容部分 start -->
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>个人月统计</small></div>
            </div>

            <ul class="am-avg-sm-1 am-avg-md-4 am-margin am-padding am-text-center admin-content-list ">
                <c:forEach var="myBtn" items="${myRoleButtonList}">
                    <c:if test="${myBtn.menuNo == '1'}">
                        <c:choose>
                            <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                <li><a href="${pageContext.request.contextPath}/main/checkinfo" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>本月打卡<br/>${countMap.checkCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                <li><a title="您没有权限!" aria-disabled="true" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>本月打卡<br/>${countMap.checkCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '3' && myBtn.avaliable == '1'}">
                                <li><a href="${pageContext.request.contextPath}/main/getApplyInfo?applyType=2" class="am-text-warning"><span class="am-icon-btn am-icon-briefcase"></span><br/>本月加班<br/>${countMap.overtimeCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '3' && myBtn.avaliable == '0'}">
                                <li><a title="您没有权限!" aria-disabled="true" class="am-text-warning"><span class="am-icon-btn am-icon-briefcase"></span><br/>本月加班<br/>${countMap.overtimeCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '4' && myBtn.avaliable == '1'}">
                                <li><a href="${pageContext.request.contextPath}/main/getApplyInfo?applyType=1" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>本月请假<br/>${countMap.leaveCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '4' && myBtn.avaliable == '0'}">
                                <li><a title="您没有权限!" aria-disabled="true" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>本月请假<br/>${countMap.leaveCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '5' && myBtn.avaliable == '1'}">
                                <li><a href="${pageContext.request.contextPath}/main/getApplyInfo?applyType=3" class="am-text-secondary"><span class="am-icon-btn am-icon-user-md"></span><br/>本月调休<br/>${countMap.restCount}</a></li>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '5' && myBtn.avaliable == '0'}">
                                <li><a title="您没有权限!" aria-disabled="true" class="am-text-secondary"><span class="am-icon-btn am-icon-user-md"></span><br/>本月调休<br/>${countMap.restCount}</a></li>
                            </c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <%--<li><a href="${pageContext.request.contextPath}/main/checkinfo" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>本月打卡<br/>${countMap.checkCount}</a></li>
                   <li><a href="${pageContext.request.contextPath}/main/getApplyInfo?applyType=2" class="am-text-warning"><span class="am-icon-btn am-icon-briefcase"></span><br/>本月加班<br/>${countMap.overtimeCount}</a></li>
                   <li><a href="${pageContext.request.contextPath}/main/getApplyInfo?applyType=1" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>本月请假<br/>${countMap.leaveCount}</a></li>
                   <li><a href="${pageContext.request.contextPath}/main/getApplyInfo?applyType=3" class="am-text-secondary"><span class="am-icon-btn am-icon-user-md"></span><br/>本月调休<br/>${countMap.restCount}</a></li>--%>
            </ul>
            <div class="am-g">
                <div class="am-u-sm-12">
                    <table class="am-table am-table-bd am-table-striped admin-content-table">
                        <thead>
                            <c:if test="${!empty applyInfo}">
                                <tr>
                                    <th>ID</th><th>申请类型</th><th>开始时间</th><th>结束时间</th><th>原因</th>
                                </tr>
                            </c:if>


                        <c:if test="${!empty CheckList}">
                            <tr>
                                <th>ID</th><th>用户名</th><th>打卡日期</th><th>打卡时间</th>
                            </tr>
                        </c:if>


                        </thead>
                        <tbody>

                        <c:forEach items="${applyInfo}" var="apply" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td><a style="color: green;" href="${pageContext.request.contextPath}/apply/details?id=${apply.uuid}&state=${apply.state}&flag=apply"><c:if test="${apply.applyType == '1'}">请假单</c:if><c:if test="${apply.applyType == '2'}">加班单</c:if><c:if test="${apply.applyType == '3'}">调休单</c:if></a></td>
                                <td>${apply.startDate}</td>
                                <td class="am-hide-sm-only">${apply.endDate}</td>
                                <td>${apply.reason}</td>
                            </tr>
                        </c:forEach>
                        
                        <c:forEach items="${CheckList}" var="CheckInfo" varStatus="status">
                        <tr><td>${status.index+1}</td><td>${emp.empName}</td><td>${CheckInfo.checkDate}</td> <td>${CheckInfo.checkTime}</td>
                            <%--<td>管理</td>--%>
                        </tr>
                       
                        </c:forEach>
                        </tbody>
                    </table>
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

