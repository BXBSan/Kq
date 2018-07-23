<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-新增申请单</title>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/amazeui/css/amazeui.datetimepicker.css"/>
    <script src="${pageContext.request.contextPath}/static/amazeui/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.datetimepicker.min.js"></script>
    <script type="text/javascript">
        function checkNull(){

            var applyType = document.getElementById("applyType").value;

            var startDate = document.getElementById("startDate").value;

            var endDate = document.getElementById("endDate").value;

            var reason = document.getElementById("reason").value;

            if(applyType == "0"){
                alert("请选择申请单类型！");
                return false;
            }else if(startDate == ""){
                alert("请填写开始日期！");
                return false;
            }else if(endDate == ""){
                alert("请填写开始时间！");
                return false;
            }else if( reason == ""){
                alert("请填写原因！");
                return false;
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
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding am-padding-bottom-0">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">申请单填写</strong> / <small>ApplyBill</small></div>
            </div>

            <hr>
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active"><a href="#tab1">申请单</a></li>
                </ul>
            </div>
            <form class="am-form" action="add" method="post">
            <div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab1">

                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                申请单
                            </div>
                            <div class="am-u-sm-8 am-u-md-4">
                                <select data-am-selected="{btnSize: 'sm'}" name="applyType" id="applyType">
                                    <option value="0">申请单类型</option>
                                    <option value="1">请假单</option>
                                    <option value="2">加班单</option>
                                    <option value="3">调休单</option>
                                </select>
                            </div>
                            <div class="am-hide-sm-only am-u-md-6"></div>
                        </div>
                    <div class="am-g am-margin-top">
                        <div class="am-u-sm-4 am-u-md-2 am-text-right">
                            申请人
                        </div>
                        <div class="am-u-sm-8 am-u-md-4">
                            <select data-am-selected="{btnSize: 'sm'}" name="empId" id="empId">
                               <c:if test="${empty empList}">
                                   <option value="${emp.uuid}">${emp.empName}</option>
                               </c:if>
                                <c:if test="${!empty empList}">
                                    <option value="0">申请人</option>
                                    <c:forEach items="${empList}" var="getemp">
                                        <option value="${getemp.uuid}">${getemp.empName}</option>
                                    </c:forEach>
                                </c:if>
                            </select>
                        </div>
                        <div class="am-hide-sm-only am-u-md-6"></div>
                    </div>
                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-2 am-text-right" >
                                开始时间
                            </div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end am-input-group date">
                                <span  id="datetimepicker2" class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
                                <input size="16" type="text" name="startDate" id="startDate" readonly class="form-datetime am-form-field" data-date-format="yyyy-mm-dd hh:ii"/>
                                <script>
                                    $(function() {
                                        var $dpInput = $('#startDate').datetimepicker({
                                            format: 'yyyy-mm-dd hh:ii'
                                        });

                                        $('#datetimepicker2').on('click', function() {
                                            $dpInput.datetimepicker('update', new Date());
                                        });
                                        $dpInput.datetimepicker('setStartDate', new Date());
                                    });
                                </script>
                            </div>
                        </div>


                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                结束时间
                            </div>
                            <div class="am-u-sm-8 am-u-md-4 am-u-end col-end am-input-group date">
                                <span  id="datetimepicker" class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
                                <input size="16" type="text" name="endDate" id="endDate"  readonly class="form-datetime am-form-field" data-date-format="yyyy-mm-dd hh:ii"/>
                                <script>
                                    $(function() {
                                        var $dpInput = $('#endDate').datetimepicker({
                                            format: 'yyyy-mm-dd hh:ii'
                                        });

                                        $('#datetimepicker').on('click', function() {
                                            $dpInput.datetimepicker('update', new Date());
                                        });
                                        $dpInput.datetimepicker('setStartDate', new Date());
                                    });
                                    (function($){
                                        // 只需要添加一次
                                        $.fn.datetimepicker.dates['zh-CN'] = {
                                            days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
                                            daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
                                            daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
                                            months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                                            monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                                            today: "今日",
                                            suffix: [],
                                            meridiem: ["上午", "下午"]
                                        };

                                        $('.form-datetime').datetimepicker({
                                            language:  'zh-CN',
                                            format: '日期,yyyy-mm-dd,时间,hh:ii'
                                        });
                                    }(jQuery));
                                </script>
                            </div>
                            <div class="am-hide-sm-only am-u-md-6"></div>
                        </div>



                        <div class="am-g am-margin-top-sm">
                            <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
                                原因
                            </div>
                            <div class="am-u-sm-12 am-u-md-10">
                                <textarea rows="9" name="reason" id="reason"></textarea>
                            </div>
                        </div>
                    <span style="color: red;">${msg}</span>

                </div>

            </div>
            <div class="am-margin">
                <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                    <c:if test="${myBtn.menuNo == '4'}">
                        <c:choose>
                            <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                <button type="submit" class="am-btn am-btn-primary am-btn-xs" onclick="return checkNull();">提交</button>
                            </c:when>
                            <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-btn-xs">提交</button>
                            </c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <a class="am-btn am-btn-primary am-btn-xs" href="javascript:history.go(-1)">返回</a>
            </div>
            </form>
        </div>
    </div>
    <!-- 修改.....内容部分 end -->

    <!-- 下面是地脚,不用改 -->
    <footer class="admin-content-footer">
        <hr>
        <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
    </footer>

</div>

<%--<!-- 下面不用改 -->
<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/static/amazeui/js/jquery.min.js"></script>
<!--<![endif]-->
<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/static/amazeui/js/app.js"></script>--%>
</body>
</html>

