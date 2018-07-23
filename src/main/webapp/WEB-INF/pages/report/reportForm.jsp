<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.epro.kq.common.BasePage" %>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-报表管理</title>
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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">报表统计</strong></div>
            </div>
            <hr>
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active" id="li1"><a href="#tab1" id="t1">报表统计</a></li>
                </ul>

                <div class="am-tabs-bd">
                    <!-- 未审批Tab -->
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <div class="am-g">
                            <div class="am-u-sm-12">
                                <form class="am-form">
                                    <table class="am-table am-table-striped am-table-hover table-main">
                                        <thead>
                                        <tr style="text-align: center">
                                            <th class="table-check"><input type="checkbox" /></th>
                                            <th class="table-id">编号</th>
                                            <th class="table-author">申请人</th>
                                            <%--<th class="table-date">申请日期</th>--%>
                                            <th class="table-type">本月请假</th>
                                            <th class="table-date am-hide-sm-only">本月调休</th>
                                            <th class="table-date am-hide-sm-only">本月加班</th>
                                            <th id='export' class="table-date am-hide-sm-only"><a href="/kqproject/reportform/download">导出</a></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${applyListPage.dataList}" var="data" varStatus="status">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" />
                                                        <%--<input type="text" id="applyId1" value="${data.applyId}"/>--%>
                                                </td>
                                                <td>${status.index+1}</td>
                                                <td><a onclick="showEmpInfo();">${data.empName}</a></td>

                                                <td class="am-hide-sm-only">${data.leaveBillCount}</td>
                                                <td class="am-hide-sm-only">${data.workOverTimeBillCount}</td>
                                                <td class="am-hide-sm-only">${data.daysOffBillCount}</td>

                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>

                                    <div class="am-cf">
                                        共 ${applyListPage.totalCount} 条记录
                                        <div class="am-fr">
                                            <ul class="am-pagination">
                                                <%--<li class="am-disabled"><a href="#">«</a></li>
                                                <li class="am-active"><a href="#">1</a></li><li><a href="#">2</a></li><li><a href="#">3</a></li>
                                                <li><a href="#">4</a></li><li><a href="#">5</a></li><li><a href="#">»</a></li>--%>
                                                <li><a href="${pageContext.request.contextPath}/reportform/showReportForm?pageNo1=1&applyType=${applyType}&keyWord=${keyWord}">«</a></li>
                                                <c:forEach begin="${pageBeginNum1}" end="${pageEndNum1}" step="1" varStatus="status" >
                                                    <li <c:if test="${applyListPage.pageNo == (status.index)}">class="am-active"</c:if>>
                                                        <a href="${pageContext.request.contextPath}/approve/show?pageNo1=${status.index}&applyType=${applyType}&keyWord=${keyWord}">${status.index}</a>
                                                    </li>
                                                </c:forEach>
                                                <li><a href="${pageContext.request.contextPath}/reportform/showReportForm?pageNo1=${applyListPage.pageCount}&applyType=${applyType}&keyWord=${keyWord}">»</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr />
                                </form>
                            </div>

                        </div>

                    </div>
                </div>
            </div>

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

<script type="text/javascript">
    // 暂时不用ajax提交了...
    function approve(applyId, flag){
        console.log("开始审批! flag:", flag,",applyId:",applyId);
        // 审批批注
        var approveRemark = '无';
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/approve/doapprove",
            data: {
                applyId:applyId,
                flag:flag,
                approveRemark:approveRemark
            },
            dataType: "json",
            success: function(data){
                alert("success!");
                console.log("data:",data);

            },
            error: function(data){
                console.log("error!");
            }
        });
    }

    function showDetails(applyId){
        alert("显示详情页...");
    }

    function showEmpInfo(){
        alert("员工详情?");
    }
</script>

</html>

