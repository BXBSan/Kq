<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-申请单详情</title>
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
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf">
                    <strong class="am-text-primary am-text-lg">申请单详情</strong> /
                    <small>ApplyBillDetailInfo</small>
                </div>
            </div>
            <hr>
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active">
                        <a href="#tab1">
                            <c:if test="${approveDetails.applyType == '1'}">请假单</c:if>
                            <c:if test="${approveDetails.applyType == '2'}">加班单</c:if>
                            <c:if test="${approveDetails.applyType == '3'}">调休单</c:if>
                            <c:if test="${approveDetails.state == '0'}">(1级待批)</c:if>
                            <c:if test="${approveDetails.state == '2'}">(通过)</c:if>
                            <c:if test="${approveDetails.state == '2'}">(不通过)</c:if>
                            <c:if test="${approveDetails.state == '3'}">(2级待批)</c:if>
                        </a>
                    </li>
                    <li><a href="#tab2">审批流程</a></li>
                </ul>

                <div class="am-tabs-bd">
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <form id="form1" class="am-form" method="get">
                            <input type="hidden" id="flag" value="1" name="flag" />
                            <input type="hidden" name="applyId" value="${approveDetails.applyId}" />

                            <div class="am-g am-margin-top">
                                <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                    申请人
                                </div>
                                <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                    <input value="${approveDetails.empName}" type="text" readonly>
                                    <%--${approveDetails.empName}--%>
                                </div>
                            </div>
                            <div class="am-g am-margin-top">
                                <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                    开始时间
                                </div>
                                <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                    <input value="${approveDetails.startDate} ${approveDetails.startTime}" type="text" readonly>
                                    <%--${approveDetails.startDate} ${approveDetails.startTime}--%>
                                </div>
                            </div>

                            <div class="am-g am-margin-top">
                                <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                    结束时间
                                </div>
                                <div class="am-u-sm-8 am-u-md-4">
                                    <input value="${approveDetails.endDate} ${approveDetails.endTime}" type="text" readonly>
                                    <%--${approveDetails.endDate} ${approveDetails.endTime}--%>
                                </div>
                                <div class="am-hide-sm-only am-u-md-6"></div>
                            </div>

                            <div class="am-g am-margin-top-sm">
                                <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
                                    请假原因
                                </div>
                                <div class="am-u-sm-12 am-u-md-10">
                                    <textarea readonly rows="4" style="width: 306px;">${approveDetails.reason}</textarea>
                                </div>
                            </div>

                            <c:if test="${approveDetails.state == '1' || approveDetails.state == '2'}">
                            <div class="am-g am-margin-top">
                                <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                    审批人
                                </div>
                                <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                    ${approveDetails.approverName}
                                </div>
                            </div>
                            <div class="am-g am-margin-top">
                                <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                    审批时间
                                </div>
                                <div class="am-u-sm-8 am-u-md-4 am-u-end col-end">
                                    ${approveDetails.approveTime}
                                </div>
                            </div>
                            </c:if>
                            <c:if test="${(approveDetails.state == '0' || approveDetails.state == '3') && flag!='apply'}">
                                <div class="am-g am-margin-top-sm">
                                    <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
                                        审批备注
                                    </div>
                                    <div class="am-u-sm-12 am-u-md-10">
                                        <textarea rows="4" style="width: 306px;"name="approveRemark" id="approveRemark" >${approveDetails.approveRemark}</textarea>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${approveDetails.state != '0' && approveDetails.state != '3'}">
                                <div class="am-g am-margin-top-sm">
                                    <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
                                        审批备注
                                    </div>
                                    <div class="am-u-sm-12 am-u-md-10">
                                        <textarea rows="4" style="width: 306px;" readonly>${approveDetails.approveRemark}</textarea>
                                    </div>
                                </div>
                            </c:if>
                            <span style="color: red;">${msg}</span>
                        </form>
                    </div>
                    <%--tab1 end--%>

                    <%--审批流程页 tab2--%>
                    <div class="am-tab-panel am-fade" id="tab2">
                        <c:if test="${approveDetails.state != '0'}">
                            <div class="am-form-group">
                                <label>本部主管:</label>
                                <input value="${processInfo.approverName1}" type="text" class="" readonly>
                            </div>
                            <div class="am-form-group">
                                <label>审批日期:</label>
                                <input value="${processInfo.approveTime1}" type="text" class="" readonly>
                            </div>
                            <div class="am-form-group">
                                <label>审批结果:</label>
                                <input value="1级<c:if test="${processInfo.result1 == '0'}">待批</c:if><c:if test="${processInfo.result1 == '1' || processInfo.result1 == '3'}">审批通过</c:if><c:if test="${processInfo.result1 == '2'}">审批不通过</c:if> " type="text" class="" readonly>
                            </div>
                            <div class="am-form-group">
                                <label>审批备注:</label>
                                <input value="${processInfo.approveRemark1}" type="text" class="" readonly>
                            </div>
                            <hr>
                        </c:if>

                        <c:if test="${approveDetails.state != '0' && processInfo.approverName2 != null}">
                            <div class="am-form-group">
                                <label>上级主管:</label>
                                <input value="${processInfo.approverName2}" type="text" class="" readonly>
                            </div>
                            <div class="am-form-group">
                                <label>审批日期:</label>
                                <input value="${processInfo.approveTime2}" type="text" class="" readonly>
                            </div>
                            <div class="am-form-group">
                                <label>审批结果:</label>
                                <input value="2级<c:if test="${processInfo.result2 == '1'}">审批通过</c:if><c:if test="${processInfo.result2 == '2'}">审批不通过</c:if> " type="text" class="" readonly>
                            </div>
                            <div class="am-form-group">
                                <label>审批备注:</label>
                                <input value="${processInfo.approveRemark2}" type="text" class="" readonly>
                            </div>
                            <hr>
                        </c:if>
                        <c:if test="${approveDetails.state == '0'}">
                            <br/>
                            <p style="color: red">等待1级申批...</p>
                            <br/>
                            <br/>
                            <hr>
                        </c:if>
                    </div>
                    <%--tab2 end--%>

                    <div class="am-margin">
                        <c:if test="${(approveDetails.state == '0' || approveDetails.state == '3') && flag!='apply'}">
                            <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                <c:if test="${myBtn.menuNo == '5'}">
                                    <c:choose>
                                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                            <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="approve('1');">同意</button>
                                        </c:when>
                                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                            <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-btn-xs">同意</button>
                                        </c:when>
                                        <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                            <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="approve('2');">不同意</button>
                                        </c:when>
                                        <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                            <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-btn-xs">不同意</button>
                                        </c:when>
                                        <c:otherwise></c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <a class="am-btn am-btn-primary am-btn-xs" href="javascript:history.go(-1)">返回</a>
                    </div>
                    <%--button end--%>
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

<script type="text/javascript">
    function checkNull(){
        var approveRemark = document.getElementById("approveRemark").value;
        if(approveRemark == ""){
            document.getElementById("approveRemark").value = "No Remark.";
        }
    }

    function approve(flag){ // 同意
        checkNull();

        if(flag == '1'){
            document.getElementById("flag").value = "1";
        } else if(flag == '2'){
            document.getElementById("flag").value = "2";
        }

        console.log("同意了...");
        document.getElementById("form1").action = "${pageContext.request.contextPath}/approve/doapprove";
        alert(document.getElementById("form1").action);
        document.getElementById("form1").submit();
    }

</script>

</html>

