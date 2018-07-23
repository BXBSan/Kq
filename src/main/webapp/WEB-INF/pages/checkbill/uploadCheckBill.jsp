<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js fixed-layout">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>EproKq-上传签卡记录</title>
    <meta name="description" content="这是一个上传签卡记录页">
    <meta name="keywords" content="upload">
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
    <jsp:include page="../base/sidebar.jsp"/>

    <!-- 修改.....内容部分 start -->
    <div class="admin-content">
        <div class="admin-content-body">
            <div class="am-cf am-padding">
                <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">签卡记录</strong> / <small>上传签卡记录</small></div>
            </div>

            <!-- 这里开始,file标签... -->
            <div class="am-panel am-panel-default">
                <div class="am-panel-bd">
                    <div class="am-g">
                        <div class="am-u-md-4">
                            <img class="am-img-circle am-img-thumbnail am-circle" src="${pageContext.request.contextPath}/static/images/excel_icon.jpg" alt="支持Excel文件"/>
                        </div>
                        <div class="am-u-md-8">
                            <p>请选择要上传签卡记录的Excel文件(.xsl)...</p> <%--<p class="am-form-help">请选择要上传签卡记录的Excel文件(.xsl)...</p>--%>
                            <form action="<%=request.getContextPath()%>/check/doupload" method="post" id="uploadForm" class="am-form" enctype="multipart/form-data">
                                <div class="am-form-group">
                                    <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                                        <c:if test="${myBtn.menuNo == '7'}">
                                            <c:choose>
                                                <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                                                    <input type="file" id="excelFile" name="excelFile" accept="application/vnd.ms-excel">
                                                    <button type="button" class="am-btn am-btn-primary am-btn-xs" onclick="uploadFile();">确认上传</button>
                                                </c:when>
                                                <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                                                    <div title="您没有权限!">
                                                    <input disabled="disabled" title="您没有权限!" type="file" name="excelFile" accept="application/vnd.ms-excel">
                                                    <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-btn-xs" onclick="uploadFile();">确认上传</button>
                                                    </div>
                                                </c:when>
                                                <c:otherwise></c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- file标签end -->

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
    function uploadFile(){
//        var excelFile = document.getElementById("excelFile").files[0]; // 获取文件
//        console.log("文件:", excelFile);

        var fileName = $("#excelFile").val();
        if("" == fileName){
            alert("请先选择文件!");
            return;
        }

        //form提交方式(success)
        //$("#uploadForm").submit();

        var formUrl = document.getElementById("uploadForm").action;
        var formData = new FormData($( "#uploadForm" )[0]); // 将上传文件封装!!!!!
        //console.log("formData:", formData);

        // 请求Ajax
        $.ajax({
            type: "POST",
            url: formUrl,
            //data: $("#uploadForm").serialize(),// 你的formid,只能提交普通form数据,无法提交文件上传
            data: formData,
            dataType: "json",
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if(data.state == "0"){
                    alert("上传文档失败!" + data.msg);
                }else if(data.state == "1" && data.data == null){
                    alert("上传文档成功,数据无误,录入完毕!");
                }else if(data.state == "1" && data.data != null){
                    alert("上传文档成功!" + data.msg + ":" + data.data);
                }

                //alert("success!"+data);
                console.log("data:", data);
            },
            error: function (data) {
                alert("网络原因,上传文档失败!");
                //alert("error："+data);
                console.log("error-data:", data);
            }
        });
    }
</script>

</html>

