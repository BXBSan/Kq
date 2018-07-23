<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<!-- sidebar start -->
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul class="am-list admin-sidebar-list">
        <c:forEach items="${myRoleMenuList}" var="myRoleMenu" varStatus="status">
            <%--<c:if test="${myRoleMenu.menuType == '首页'}">--%>
            <c:if test="${myRoleMenu.menuNo == '1'}">
                <li><a href="${pageContext.request.contextPath}/main/index"><span class="am-icon-home"></span> 首页</a></li>
            </c:if>
            <%--<c:if test="${myRoleMenu.menuType == '员工管理'}">--%>
            <c:if test="${myRoleMenu.menuNo == '2'}">
                <li><a href="${pageContext.request.contextPath}/emp/getAll"><span class="am-icon-header"></span> 员工管理</a></li>
            </c:if>
            <%--<c:if test="${myRoleMenu.menuType == '部门管理'}">--%>
            <c:if test="${myRoleMenu.menuNo == '3'}">
                <li><a href="${pageContext.request.contextPath}/dept/getAll"><span class="am-icon-desktop"></span> 部门管理</a></li>
            </c:if>
            <%--<c:if test="${myRoleMenu.menuType == '申请单'}">--%>
            <c:if test="${myRoleMenu.menuNo == '4'}">
                <li><a href="${pageContext.request.contextPath}/apply/show"><span class="am-icon-pencil-square-o"></span> 申请单</a></li>
            </c:if>
            <%--<c:if test="${myRoleMenu.menuType == '审批管理'}">--%>
            <c:if test="${myRoleMenu.menuNo == '5'}">
                <li><a href="${pageContext.request.contextPath}/approve/show"><span class="am-icon-pencil-square"></span> 审批管理</a></li>
            </c:if>
            <%--<c:if test="${myRoleMenu.menuType == '报表管理'}">--%>
            <c:if test="${myRoleMenu.menuNo == '6'}">
                <li><a href="${pageContext.request.contextPath}/reportform/showReportForm"><span class="am-icon-pencil-square-o"></span> 报表管理(zzp)</a></li>
                <li><a href="${pageContext.request.contextPath}/report/toReport"><span class="am-icon-recycle"></span> 报表管理</a></li>
            </c:if>
            <c:if test="${myRoleMenu.menuNo == '7'}">
                <li><a href="${pageContext.request.contextPath}/check/goupload" class="am-cf"><span class="am-icon-check"></span> 上传签卡记录<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
            </c:if>
            <c:if test="${myRoleMenu.menuNo == '8'}">
                <li><a href="${pageContext.request.contextPath}/role/show"><span class="am-icon-calendar-o"></span> 权限管理</a></li>
            </c:if>
        </c:forEach>
            <%--<li><a href="${pageContext.request.contextPath}/role/show"><span class="am-icon-calendar-o"></span> 权限管理</a></li>--%>
            <li><a href="${pageContext.request.contextPath}/main/logout"><span class="am-icon-sign-out"></span> 注销</a></li>
        </ul>

        <div class="am-panel am-panel-default admin-sidebar-panel">
            <div class="am-panel-bd">
                <p><span class="am-icon-bookmark"></span> 共勉</p>
                <p style="text-align: center">时光静好，与君语；<br/>细水流年，与君同。<br/>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;—— Epro</p>
            </div>
        </div>
    </div>
</div>

<!-- sidebar end -->
</body>
</html>
