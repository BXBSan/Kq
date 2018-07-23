<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-新增角色</title>
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
                                <input size="16" type="text" name="startDate" id="roleName" onblur="checkRoleName()"/>
                            </div>
                            <div class="am-hide-sm-only am-u-md-6"></div>
                        </div>
                        <div class="am-g am-margin-top-sm">
                            <div class="am-u-sm-12 am-u-md-2 am-text-right admin-form-text">
                                权限：
                            </div>
                            <div class="am-tabs am-margin">
                                <script>
                                    function chkdis(che){
                                        var cheArray = document.getElementsByName(che.id);
                                        if(!che.checked){
                                            for(var i = 0;i<cheArray.length;i++){
                                                cheArray[i].disabled = "disabled";
                                                cheArray[i].checked = false;
                                            }
                                        }else{
                                            for(var i = 0;i<cheArray.length;i++){
                                                cheArray[i].disabled = "";
                                                cheArray[i].checked = true;
                                            }
                                        }
                                    }
                                </script>
                                    <table border="1px" class="am-table-striped am-table-hover table-main" style="width: 80%;">
                                        <tr>
                                            <th style="text-align:center; font-weight: bolder;">菜单</th>
                                            <th style="text-align:center; font-weight: bolder;">功能</th>
                                        </tr>
                                        <c:forEach items="${allMenuButtonList}" var="menuButton">
                                            <tr>
                                                <td style="height: 30px;"><input type="checkbox" name="menu" id="${menuButton.menuId}" onclick="chkdis(this)" value="${menuButton.menuId}"/>${menuButton.menuType}</td>
                                                <td>
                                                    <c:forEach items="${menuButton.buttonList}" var="button">
                                                        <input type="checkbox" disabled="disabled" name="${menuButton.menuId}" value="${button.buttonId}"/>${button.buttonType}&nbsp;&nbsp;
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
                                <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                    <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="addAjax()">提交</button>
                                </c:when>
                                <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                    <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-btn-xs" onclick="addAjax()">提交</button>
                                </c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:forEach>
                    <%--<button type="button" class="am-btn am-btn-primary am-btn-xs">放弃</button>--%>
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
<script type="text/javascript">
    function checkRoleName(){
        var roleName = document.getElementById("roleName").value;
        var result = true;
        if(roleName == "" || roleName == null){
            alert("角色名不能为空!");
            return;
        }
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/role/checkRoleName",
            data: {"roleName":roleName},
            dataType: "json",
            async: false,
            cache: false,
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            success:function(data){
                if(data.msg == "success"){
                    alert("角色名可用！");
                }else if(data.msg == "error"){
                    alert("已存在该角色！");
                    result = false;
                }
            },
            error:function(){
                result = false;
            }
        });
        return result;
    }
    function addAjax(){
        var flag = checkRoleName();
        if(!flag){
            return;
        }

        var roleName = document.getElementById("roleName").value;
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
            url: "${pageContext.request.contextPath}/role/addRole",
            data: {"dataJson":dataJson,"roleName":roleName},
            dataType: "json",
            async: false,
            cache: false,
            contentType: "application/x-www-form-urlencoded; charset=utf-8",

            success: function(data){
                alert("添加成功!");
                console.log("data:", data);
                location.href = "${pageContext.request.contextPath}/role/show";
            },
            error: function(){
                alert("系统错误");
            }
        });
    }

</script>


</html>

