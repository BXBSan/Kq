<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-申请单管理</title>
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
        window.onload=function(){

            console.log(${table == "table2"});
            if(${table == "table2"}){
                $("#li1").removeClass();
                $("#li2").addClass("am-active");

                $("#tab1").removeClass("am-active");
                $("#tab1").removeClass("am-in");
                $("#tab2").addClass("am-active");
                $("#tab2").addClass("am-in");

            } else if(${table == "table1"}){
                $("#li2").removeClass();
                $("#li1").addClass("am-active");

                $("#tab2").removeClass("am-active");
                $("#tab2").removeClass("am-in");
                $("#tab1").addClass("am-active");
                $("#tab1").addClass("am-in");
            }
        }

        function doDelete(bid){
            if (confirm("确定要删除吗？")) {
                location.href="${pageContext.request.contextPath}/apply/show?startDate=${startDate}&applyType=${applyType}&id=" + bid.id;
            }

        }
        function selectData(){
            $('#datetimepicker').datetimepicker();
        }
        function caolilala(id){
            if(id == "li2"){
                $("#li1").removeClass();
                $("#li2").addClass("am-active");

                $("#tab1").removeClass("am-active");
                $("#tab1").removeClass("am-in");
                $("#tab2").addClass("am-active");
                $("#tab2").addClass("am-in");

            } else if(id == "li1"){
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
                    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">申请单</strong> / <small>ApplyBill</small></div>
                </div>

                <hr>
                <form class="am-form" action="${pageContext.request.contextPath}/apply/show" method="post">
                <div class="am-g">
                    <div class="am-u-sm-12 am-u-md-6">
                        <div class="am-btn-toolbar">
                            <div class="am-btn-group am-btn-group-xs">
                                <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                    <c:choose>
                                    <c:when test="${myBtn.menuNo == '4'}">
                                        <c:choose>
                                            <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                                <a href="${pageContext.request.contextPath}/apply/showWrite"><button type="button" class="am-btn am-btn-default" onclick="write();"><span class="am-icon-plus"></span> 新增</button></a>
                                            </c:when>
                                            <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                                <a disabled="disabled" title="您没有权限!" ><button type="button" class="am-btn am-btn-default"><span class="am-icon-plus"></span> 新增</button></a>
                                            </c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <div class="am-u-sm-12 am-u-md-3">
                        <div class="am-form-group">
                            <select data-am-selected="{btnSize: 'sm'}" name="applyType">
                                <option value="all" <c:if test="${applyType == 'all'}">selected="selected"</c:if>>所有类别</option>
                                <option value="1" <c:if test="${applyType == '1'}">selected="selected"</c:if>>请假单</option>
                                <option value="2" <c:if test="${applyType == '2'}">selected="selected"</c:if>>加班单</option>
                                <option value="3" <c:if test="${applyType == '3'}">selected="selected"</c:if>>调休单</option>
                            </select>
                        </div>
                    </div>
                    <div class="am-u-sm-12 am-u-md-3">
                        <div class="am-input-group date"  >
                                 <span  id="datetimepicker" class="am-input-group-label add-on"><i class="icon-th am-icon-calendar"></i></span>
                                <input size="16" type="text" name="startDate" value="${startDate}"  class="form-datetime am-form-field" data-date-format="yyyy-mm-dd"/>

                                <script>
                                        $(function() {
                                            var $dpInput = $('.form-datetime').datetimepicker({
                                                format: 'yyyy-mm-dd'
                                            });

                                            $('#datetimepicker').on('click', function() {
                                                $dpInput.datetimepicker('update', new Date());
                                            });
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
                                                format: 'yyyy-mm-dd'
                                            });

                                        }(jQuery));
                                </script>
                          <span class="am-input-group-btn">
                            <button class="am-btn am-btn-default" type="submit">搜索</button>
                          </span>
                        </div>
                    </div>
                    <script>
                        $(function() {
                            var $dpInput = $('.form-datetime').datetimepicker({
                                format: 'yyyy-mm-dd hh:ii'
                            });


                        });
                    </script>

                </div>
                </form>
                <div class="am-tabs am-margin" data-am-tabs  >
                    <ul class="am-tabs-nav am-nav am-nav-tabs">
                        <li class="am-active" id="li1"><a onclick="caolilala('li1')">待审批</a></li>
                        <li id="li2"><a  onclick="caolilala('li2')">已审批</a></li>
                    </ul>

                    <div class="am-tabs-bd"id="tables">
                        <div class="am-tab-panel am-fade am-in  am-active" id="tab1">
                            <div class="am-g">
                                <div class="am-u-sm-12">

                                        <table class="am-table am-table-striped am-table-hover table-main">
                                            <thead>
                                            <tr>
                                                <th class="table-check"><input type="checkbox" /></th><th class="table-id">ID</th><th class="table-title">类别</th><th class="table-type"><a href="${pageContext.request.contextPath}/apply/show?order=${order}&startDate=${startDate}&applyType=${applyType}">开始日期</a></th><th class="table-author am-hide-sm-only">结束日期</th><th class="table-date am-hide-sm-only">状态</th><th class="table-set">操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${applyList}" var="apply" varStatus="status">
                                                <tr>
                                                    <td><input type="checkbox" /></td>
                                                    <td>${status.index + 1}</td>
                                                    <td><a href="${pageContext.request.contextPath}/apply/details?id=${apply.uuid}&state=${apply.state}&flag=apply"><c:if test="${apply.applyType == '1'}">请假单</c:if><c:if test="${apply.applyType == '2'}">加班单</c:if><c:if test="${apply.applyType == '3'}">调休单</c:if></a></td>
                                                    <td>${apply.startDate}</td>
                                                    <td class="am-hide-sm-only">${apply.endDate}</td>
                                                    <td class="am-hide-sm-only"><c:if test="${apply.state == '0'}">待批</c:if><c:if test="${apply.state == '1'}">已审批</c:if><c:if test="${apply.state == '3'}">2级待批</c:if></td>

                                                    <td>
                                                        <div class="am-btn-toolbar">
                                                            <div class="am-btn-group am-btn-group-xs">
                                                                <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                                                    <c:if test="${myBtn.menuNo == '4'}">
                                                                        <c:choose>
                                                                            <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                                                                <button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" onclick="doDelete(this)" id="${apply.uuid}"><span class="am-icon-trash-o"></span> 删除</button>
                                                                            </c:when>
                                                                            <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                                                                <button disabled="disabled" title="您没有权限!" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button>
                                                                            </c:when>
                                                                            <c:otherwise></c:otherwise>
                                                                        </c:choose>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="am-cf">
                                            共 ${totalApply} 条记录
                                            <div class="am-fr">
                                                <ul class="am-pagination">
                                                    <%--<li class="am-disabled"><a href="#">«</a></li>
                                                    <li class="am-active"><a href="#">1</a></li>
                                                    <li><a href="#">2</a></li>
                                                    <li><a href="#">3</a></li>
                                                    <li><a href="#">4</a></li>
                                                    <li><a href="#">5</a></li>
                                                    <li><a href="#">»</a></li>--%>
                                                    <li ><a href="${pageContext.request.contextPath}/apply/show?applyPageNo=1&startDate=${startDate}&applyType=${applyType}&order=${thisOrder}">«</a></li>
                                                    <c:forEach begin="${applyPageMap.startPage}" end="${applyPageMap.endPage}" step="1" varStatus="status">
                                                        <li <c:if test="${applyPageNo == status.index}">class="am-active"</c:if>><a href="${pageContext.request.contextPath}/apply/show?applyPageNo=${status.index}&startDate=${startDate}&applyType=${applyType}&order=${thisOrder}">${status.index}</a></li>
                                                    </c:forEach>
                                                        <li><a href="${pageContext.request.contextPath}/apply/show?applyPageNo=${pageCount}&startDate=${startDate}&applyType=${applyType}&order=${thisOrder}">»</a></li>

                                                </ul>
                                            </div>
                                        </div>
                                        <span style="color: red;">${msg}</span>
                                        <hr />
                                        <%--<p>注：.....</p>--%>

                                </div>

                            </div>

                        </div>

                        <div class="am-tab-panel am-fade" id="tab2">
                            <div class="am-g">
                                <div class="am-u-sm-12">

                                        <table class="am-table am-table-striped am-table-hover table-main">
                                            <thead>
                                            <tr>
                                                <th class="table-check"><input type="checkbox" /></th><th class="table-id">ID</th><th class="table-title">类别</th><th class="table-type"><a href="${pageContext.request.contextPath}/apply/show?order=${order}&startDate=${startDate}&applyType=${applyType}&table=table2">开始日期</a></th><th class="table-author am-hide-sm-only">结束日期</th><th class="table-date am-hide-sm-only">状态</th><th class="table-date am-hide-sm-only">审批结果</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${appliedList}" var="apply" varStatus="status">
                                                <tr>
                                                    <td><input type="checkbox" /></td>
                                                    <td>${status.index + 1}</td>
                                                    <td><a href="${pageContext.request.contextPath}/apply/details?id=${apply.uuid}&state=${apply.state}&flag=apply"><c:if test="${apply.applyType == '1'}">请假单</c:if><c:if test="${apply.applyType == '2'}">加班单</c:if><c:if test="${apply.applyType == '3'}">调休单</c:if></a></td>
                                                    <td>${apply.startDate}</td>
                                                    <td class="am-hide-sm-only">${apply.endDate}</td>
                                                    <td class="am-hide-sm-only"><c:if test="${apply.state == '0'}">未审批</c:if><c:if test="${apply.state != '0'}">已审批</c:if></td>
                                                    <td class="am-hide-sm-only"><c:if test="${apply.state == '1'}"><span style="color: green;">审批通过</span></c:if><c:if test="${apply.state == '2'}"><span style="color: red;">审批不通过</span></c:if></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                        <div class="am-cf">
                                            共 ${totalApplied} 条记录
                                            <div class="am-fr">
                                                <ul class="am-pagination">
                                                    <li ><a href="${pageContext.request.contextPath}/apply/show?appliedPageNo=1&startDate=${startDate}&applyType=${applyType}&table=table2&order=${thisOrder}">«</a></li>
                                                    <c:forEach begin="${appliedPageMap.startPage}" end="${appliedPageMap.endPage}" step="1" varStatus="status">
                                                        <li <c:if test="${appliedPageNo == status.index}">class="am-active"</c:if>><a href="${pageContext.request.contextPath}/apply/show?appliedPageNo=${status.index}&startDate=${startDate}&applyType=${applyType}&table=table2&order=${thisOrder}">${status.index}</a></li>
                                                    </c:forEach>
                                                    <li><a href="${pageContext.request.contextPath}/apply/show?appliedPageNo=${appliedPageCount}&startDate=${startDate}&applyType=${applyType}&table=table2&order=${thisOrder}">»</a></li>

                                                </ul>
                                            </div>
                                        </div>

                                        <hr />
                                        <%--<p>注：</p>--%>

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
    </form>
    <!-- content end -->
    <!-- 修改.....内容部分 end -->

    <!-- 下面是地脚,不用改 -->
    <footer class="admin-content-footer">
        <hr>
        <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
    </footer>

</div>

<%--<!-- 下面不用改 -->--%>
<%--<!--[if lt IE 9]>--%>
<%--<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.datetimepicker.min.js"></script>--%>
<%--<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.ie8polyfill.min.js"></script>--%>
<![endif]-->

<!--[if (gte IE 9)|!(IE)]><!-->
<%--<script src="${pageContext.request.contextPath}/static/amazeui/js/jquery.min.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.datetimepicker.min.js"></script>--%>
<!--<![endif]-->

<%--<script src="${pageContext.request.contextPath}/static/amazeui/js/amazeui.min.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/amazeui/js/app.js"></script>--%>
</body>
</html>

