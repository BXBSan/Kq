<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.epro.kq.common.BasePage" %>
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-审批单管理</title>
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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">审批单</strong> / <small>ApproveBill</small></div>
            </div>
            <hr>
            <div class="am-g">
                <div class="am-u-sm-12 am-u-md-6">
                    <div class="am-btn-toolbar">
                        <div class="am-btn-group am-btn-group-xs">
                            <%--<input type="button" id="testBtn" onclick="test();" value="测试锚点"/>--%>
                            <%--<a href="${pageContext.request.contextPath}/apply/write"><button type="button" class="am-btn am-btn-default" onclick="write();"><span class="am-icon-plus"></span> 新增</button></a>--%>
                        </div>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/approve/show">
                    <input type="hidden" name="sort" value="${sort}"/>
                    <input type="hidden" name="tabNum" value="${tabNum}" />
                    <div class="am-u-sm-12 am-u-md-3">
                        <div class="am-form-group">
                            <select data-am-selected="{btnSize: 'sm'}" name="applyType">
                                <option value="All" <c:if test="${applyType=='All'}">selected="selected"</c:if>>所有类别</option>
                                <option value="1" <c:if test="${applyType=='1'}">selected="selected"</c:if>>请假单</option>
                                <option value="2" <c:if test="${applyType=='2'}">selected="selected"</c:if>>加班单</option>
                                <option value="3" <c:if test="${applyType=='3'}">selected="selected"</c:if>>调休单</option>
                            </select>
                        </div>
                    </div>
                    <div class="am-u-sm-12 am-u-md-3">
                        <div class="am-input-group am-input-group-sm">
                            <input name="keyWord" value="${keyWord}" type="text" class="am-form-field" placeholder="员工姓名、申请时间">
                            <span class="am-input-group-btn">
                                <button class="am-btn am-btn-default" type="submit">搜索</button>
                            </span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <%--<li <c:if test="${tabName == 'tab1'}">class="am-active"</c:if>>
                        <a href="#tab1">待审批</a>
                    </li>
                    <li <c:if test="${tabName == 'tab2'}">class="am-active"</c:if>>
                        <a href="#tab2">已审批</a>
                    </li>--%>
                    <li class="am-active" id="li1"><a href="#tab1" id="t1">待审批</a></li>
                    <li id="li2"><a href="#tab2" id="t2">已审批</a></li>
                </ul>

                <div class="am-tabs-bd">
                    <!-- 未审批Tab -->
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                        <div class="am-g">
                            <div class="am-u-sm-12">
                                <form class="am-form">
                                    <table style="text-align: center;" class="am-table am-table-striped am-table-hover table-main">
                                        <thead>
                                        <tr style="text-align: center">
                                            <th class="table-check"><input type="checkbox" /></th>
                                            <th class="table-id" style="text-align: center">编号</th>
                                            <th class="table-author" style="text-align: center">申请人</th>
                                            <%--<th class="table-date">申请日期</th>--%>
                                            <th class="table-type" style="text-align: center">类别</th>
                                            <th class="table-date am-hide-sm-only am-icon-sort" style="text-align: center">
                                                <a href="${pageContext.request.contextPath}/approve/show?sort=${newSort}&applyType=${applyType}&keyWord=${keyWord}">开始时间</a>
                                            </th>
                                            <th class="table-date am-hide-sm-only" style="text-align: center">结束时间</th>
                                            <th class="table-title am-hide-sm-only" style="text-align: center">申请原因</th>
                                            <th class="table-id" style="text-align: center">状态</th>
                                            <th class="table-set" style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${unapprovedListPage.dataList}" var="data" varStatus="status">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" />
                                                    <%--<input type="text" id="applyId1" value="${data.applyId}"/>--%>
                                                </td>
                                                <td>${status.index+1}</td>
                                                <td><a onclick="showEmpInfo();">${data.empName}</a></td>
                                                <td class="am-hide-sm-only">
                                                    <a href="${pageContext.request.contextPath}/approve/details?applyId=${data.applyId}&state=0">
                                                        <c:if test="${data.applyType == '1'}">请假单</c:if>
                                                        <c:if test="${data.applyType == '2'}">加班单</c:if>
                                                        <c:if test="${data.applyType == '3'}">调休单</c:if>
                                                    </a>
                                                </td>
                                                <td class="am-hide-sm-only">${data.startDate}</td>
                                                <td class="am-hide-sm-only">${data.endDate}</td>
                                                <td class="am-hide-sm-only">${data.reason}</td>
                                                <td class="am-hide-sm-only"><c:if test="${data.state == '0'}">待批</c:if><c:if test="${data.state == '3'}">2级待批</c:if></td>
                                                <td style="text-align: center">
                                                    <span>
                                                    <div class="am-btn-toolbar">
                                                        <div class="am-btn-group am-btn-group-xs" style="text-align: center">
                                                            <span>
                                                            <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                                                <c:if test="${myBtn.menuNo == '5'}">
                                                                    <c:choose>
                                                                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                                                            <span><a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/approve/doapprove?applyId=${data.applyId}&flag=1"><span class="am-icon-pencil-square-o"></span> 同意</a></span>
                                                                        </c:when>
                                                                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                                                            <span><a disabled="disabled" title="您没有权限!" class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-pencil-square-o"></span> 同意</a></span>
                                                                        </c:when>
                                                                        <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                                                            <span><a align="center" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/approve/doapprove?applyId=${data.applyId}&flag=2"><span class="am-icon-trash-o"></span> 不同意</a></span>
                                                                        </c:when>
                                                                        <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                                                            <span><a disabled="disabled" title="您没有权限!" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 不同意</a></span>
                                                                        </c:when>
                                                                        <c:otherwise></c:otherwise>
                                                                    </c:choose>
                                                                </c:if>
                                                            </c:forEach>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>

                                    <div class="am-cf">
                                        共 ${unapprovedListPage.totalCount} 条记录
                                        <div class="am-fr">
                                            <ul class="am-pagination">
                                                <%--<li class="am-disabled"><a href="#">«</a></li>
                                                <li class="am-active"><a href="#">1</a></li><li><a href="#">2</a></li><li><a href="#">3</a></li>
                                                <li><a href="#">4</a></li><li><a href="#">5</a></li><li><a href="#">»</a></li>--%>
                                                    <li><a href="${pageContext.request.contextPath}/approve/show?sort=${sort}&pageNo1=1&applyType=${applyType}&keyWord=${keyWord}">«</a></li>
                                                    <c:forEach begin="${pageBeginNum1}" end="${pageEndNum1}" step="1" varStatus="status" >
                                                        <li <c:if test="${unapprovedListPage.pageNo == (status.index)}">class="am-active"</c:if>>
                                                            <a href="${pageContext.request.contextPath}/approve/show?sort=${sort}&pageNo1=${status.index}&applyType=${applyType}&keyWord=${keyWord}">${status.index}</a>
                                                        </li>
                                                    </c:forEach>
                                                    <li><a href="${pageContext.request.contextPath}/approve/show?sort=${sort}&pageNo1=${unapprovedListPage.pageCount}&applyType=${applyType}&keyWord=${keyWord}">»</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr />
                                    <%--<p>注：未审批列表</p>--%>
                                </form>
                            </div>

                        </div>

                    </div>

                    <!-- 已审批Tab -->
                    <div class="am-tab-panel am-fade" id="tab2">
                        <div class="am-g">
                            <div class="am-u-sm-12">
                                <form class="am-form">
                                    <table class="am-table am-table-striped am-table-hover table-main">
                                        <thead>
                                        <tr style="text-align: center">
                                            <th class="table-check"><input type="checkbox" /></th>
                                            <th class="table-id">编号</th>
                                            <th class="table-author">申请人</th>
                                            <%--<th class="table-date am-hide-sm-only">申请日期</th>--%>
                                            <th class="table-type">类别</th>
                                            <th class="table-date am-hide-sm-only am-icon-sort">
                                                <a href="${pageContext.request.contextPath}/approve/show?sort=${newSort}&applyType=${applyType}&keyWord=${keyWord}&tabNum=tab2">开始时间</a>
                                            </th>
                                            <th class="table-date am-hide-sm-only">结束时间</th>
                                            <th class="table-title am-hide-sm-only">申请原因</th>
                                            <th class="table-author">审批人</th>
                                            <th class="table-date am-hide-sm-only">审批时间</th>
                                            <%--<th class="table-set">操作</th>--%>
                                            <th class="table-set">审批结果</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${approvedListPage.dataList}" var="data" varStatus="status">
                                            <tr>
                                                <td>
                                                    <input type="checkbox" />
                                                    <input type="hidden" id="applyId2" value="${data.applyId}"/>
                                                </td>
                                                <td>${status.index+1}</td>
                                                <td><a href="#">${data.empName}</a></td>
                                                <%--<td>${data.createTime}</td>--%>
                                                <td class="am-hide-sm-only">
                                                    <a href="${pageContext.request.contextPath}/approve/details?applyId=${data.applyId}&state=${data.state}">
                                                        <c:if test="${data.applyType == '1'}">请假单</c:if>
                                                        <c:if test="${data.applyType == '2'}">加班单</c:if>
                                                        <c:if test="${data.applyType == '3'}">调休单</c:if>
                                                    </a>
                                                </td>
                                                <td class="am-hide-sm-only">${data.startDate}</td>
                                                <td class="am-hide-sm-only">${data.endDate}</td>
                                                <td class="am-hide-sm-only">${data.reason}</td>
                                                <td class="am-hide-sm-only">${data.approverName}</td>
                                                <td class="am-hide-sm-only">${data.approveTime}</td>
                                                <td>
                                                    <div class="am-btn-toolbar">
                                                        <div class="am-btn-group am-btn-group-xs">
                                                            <c:if test="${data.state == '1'}"><span style="color: green;">审批通过</span></c:if><c:if test="${data.state == '2'}"><span style="color: red;">审批未通过</span></c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="am-cf">
                                        共 ${approvedListPage.totalCount} 条记录
                                        <div class="am-fr">
                                            <ul class="am-pagination">
                                                <%--<li class="am-disabled"><a href="#">«</a></li>
                                                <li class="am-active"><a href="#">1</a></li>
                                                <li><a href="#">2</a></li><li><a href="#">3</a></li>
                                                <li><a href="#">4</a></li><li><a href="#">5</a></li>
                                                <li><a href="#">»</a></li>--%>
                                                <li><a href="${pageContext.request.contextPath}/approve/show?sort=${sort}&pageNo2=1&applyType=${applyType}&keyWord=${keyWord}&tabNum=tab2">«</a></li>
                                            <c:forEach begin="${pageBeginNum2}" end="${pageEndNum2}" step="1" varStatus="status" >
                                                <li <c:if test="${approvedListPage.pageNo == (status.index)}">class="am-active"</c:if>>
                                                    <a href="${pageContext.request.contextPath}/approve/show?sort=${sort}&pageNo2=${status.index}&applyType=${applyType}&keyWord=${keyWord}&tabNum=tab2">${status.index}</a>
                                                </li>
                                            </c:forEach>
                                                <li><a href="${pageContext.request.contextPath}/approve/show?sort=${sort}&pageNo2=${approvedListPage.pageCount}&applyType=${applyType}&keyWord=${keyWord}&tabNum=tab2">»</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <hr />
                                    <%--<p>注：已审批列表</p>--%>
                                </form>
                            </div>

                        </div>
                    </div>
                    <!-- Tab 1 2 end. -->
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

