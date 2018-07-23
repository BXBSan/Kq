<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.epro.kq.domain.Employee" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/24
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<!-- 头部导航start -->
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand">
        <strong>Epro-考勤</strong> <small>后台管理</small>
    </div>

    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <%--<li><a href="javascript:void(0);"/><button type="button" class="am-btn am-btn-danger" onclick="sendAjaxReq();">打卡</button>--%>
            <li>
            <c:forEach items="${myRoleButtonList}" var="myBtn" varStatus="status">
                <c:if test="${myBtn.menuNo == '1'}">
                    <c:choose>
                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                            <button type="button" class="am-btn am-btn-danger" onclick="check();"  value="subbtn">打卡</button>

                        </c:when>
                        <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                            <button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-danger">打卡</button>
                        </c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>
            </li>
            <li class="am-dropdown" data-am-dropdown>
                <%
                    String currentEmpName = "未登录";
                    Employee currentEmp = (Employee)request.getSession().getAttribute("emp");
                    if(currentEmp != null){
                        currentEmpName = currentEmp.getEmpName();
                    }
                %>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                    <span class="am-icon-users"></span> <%=currentEmpName%> <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/emp/load?empId=${emp.uuid}"><span class="am-icon-user"></span> 资料</a></li>
                    <%--<li><a href="#"><span class="am-icon-cog"></span> 设置</a></li>--%>
                    <li><a href="${pageContext.request.contextPath}/psd/password"><span class="am-icon-pencil-square"></span> 修改密码</a></li>
                    <li><a href="${pageContext.request.contextPath}/main/logout"><span class="am-icon-power-off"></span> 退出</a></li>
                </ul>
            </li>
            <li class="am-hide-sm-only"><a href="javascript:;" id="admin-fullscreen"><span class="am-icon-arrows-alt"></span> <span class="admin-fullText">开启全屏</span></a></li>
        </ul>
    </div>
</header>
<!-- 头部导航end -->
</body>
    <script type="text/javascript">
        function check(){
            $('#subbtn').text('加载中');
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/check/checkbill",
                data: "{}",
                dataType: "json",
                success: function(data){
                    //alert("1111");
                    //Data = eval("("+data+")");

                    alert(data.result);
                    //alert("3333")
                    //alert($('#subbtn').text(data));
                    //atconsole.log("data:",da);

                },
                error: function(data){
                    alert("打卡失败!请重试...");

                    console.log("error!");
                }

            });
        }
    </script>
</html>
