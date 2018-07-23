<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-修改角色</title>
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
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">权限管理</strong> / <small>添加角色</small></div>
            </div>

            <hr>
            <div class="am-tabs am-margin" data-am-tabs>
                <ul class="am-tabs-nav am-nav am-nav-tabs">
                    <li class="am-active"><a href="#tab1">角色</a></li>
                </ul>
            </div>
            <form class="am-form" action="add" method="post">
                <div class="am-tabs-bd">
                    <div class="am-tab-panel am-fade am-in am-active" id="tab1">

                        <div class="am-g am-margin-top">
                            <div class="am-u-sm-4 am-u-md-2 am-text-right">
                                角色名：
                            </div>
                            <div class="am-u-sm-8 am-u-md-4">
                                <input size="16" type="text" name="startDate" id="roleName" value="${role.roleName}"/>
                                <input type="hidden" value="${role.uuid}" name="roleId" id="roleId"/>
                            </div>
                            <div class="am-hide-sm-only am-u-md-6"></div>
                        </div>
                        <div class="am-g am-margin-top-sm">
                            <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
                                权限：
                            </div>
                            <div  class="am-tabs am-margin">
                                <table border="1px" class="am-table-striped am-table-hover table-main" style="width: 80%;">
                                    <tr>
                                        <th style="text-align:center; font-weight: bolder;">菜单</th>
                                        <th style="text-align:center; font-weight: bolder;">功能</th>
                                    </tr>
                                    <c:forEach items="${allMenuButtonList}" var="menuButton">
                                        <tr>
                                            <td style="height: 30px;"><input type="checkbox" name="menu"
                                                                             <c:forEach items="${myRoleMenus}" var="menu">
                                                                                 <c:if test="${menu.menuId == menuButton.menuId}">
                                                                                     checked="checked"
                                                                                 </c:if>
                                                                             </c:forEach>
                                                                             id="${menuButton.menuId}" onclick="chkdis(this)" value="${menuButton.menuId}"/>${menuButton.menuType}</td>
                                            <td>
                                                <c:forEach items="${menuButton.buttonList}" var="button">
                                                    <input type="checkbox"  id="${button.buttonId}"
                                                            <c:forEach items="${myRoleButtons}" var="buttons">
                                                                <c:if test="${buttons.buttonId == button.buttonId && buttons.avaliable == '1'}">
                                                                    checked="checked"
                                                                </c:if>
                                                            </c:forEach> name="${menuButton.menuId}" value="${button.buttonId}"/>${button.buttonType}&nbsp;&nbsp;
                                                </c:forEach>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                        <span style="color: red;">${msg}</span>
                    </div>

                </div>
                <div class="am-margin">
                    <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                        <c:if test="${myBtn.menuNo == '8'}">
                            <c:choose>
                                <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                    <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="editAjax()">提交</button>
                                </c:when>
                                <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                    <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-btn-xs" onclick="editAjax()">提交</button>
                                </c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                    <a class="am-btn am-btn-primary am-btn-xs" href="javascript:history.go(-1)">返回</a>
                    <%--<button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="" id="test">放弃</button>--%>
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
<script type="text/javascript">
    function editAjax(){
        var roleName = document.getElementById("roleName").value;

        if(roleName == "" || roleName == null){
            alert("角色名不能为空");
            return;
        }

        var roleId = document.getElementById("roleId").value;
        var dataList = [];

        var menu = document.getElementsByName("menu");
        for(var i = 0;i < menu.length;i ++) {
            if (menu[i].checked) {
                var menu_button = {menu: "", buttonList: ""};
                var button = document.getElementsByName(menu[i].id);
                var buttonList = [];
                menu_button.menu = menu[i].value;
                for (var j = 0; j < button.length; j++) {
                    if(button[j].checked){
                        buttonList[buttonList.length] = button[j].value;
                    }
                }
                menu_button.buttonList = buttonList;
                dataList[dataList.length] = menu_button;
            }
        }

        var dataJson = JSON.stringify(dataList);

        console.log("dataList:", JSON.stringify(dataList));

       $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/role/doEdit",
            data: {"dataJson":dataJson,"roleName":roleName,"roleId":roleId},
            dataType: "json",
            async: false,
            cache: false,
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success: function(data){
                alert(data.msg);
                location.href = "${pageContext.request.contextPath}/role/show";
            },
            error: function(){
                alert("系统错误");
            }
        });
    }

</script>
</html>

