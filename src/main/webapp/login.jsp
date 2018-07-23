<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.epro.kq.domain.Employee" %>
<%@ page import="com.epro.kq.utils.DesUtils" %>
<%@ page import="com.epro.kq.common.SystemConstant" %>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>EproKq-系统登录</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="alternate icon" type="image/png" href="${pageContext.request.contextPath}/static/amazeui/i/favicon.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/amazeui/css/amazeui.min.css"/>
    <style>
        .header {
            text-align: center;
        }

        .header h1 {
            font-size: 200%;
            color: #333;
            margin-top: 30px;
        }

        .header p {
            font-size: 14px;
        }
    </style>
</head>


<body>
<h3>${error}</h3>
<%session.removeAttribute("error");%>
<div class="header">
    <div class="am-g">
        <h1>考勤系统</h1>
    </div>
    <hr/>
</div>
<div class="am-g">
    <div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
        <h3>登录</h3>
        <%-- <hr>
         <div class="am-btn-group">
             <a href="#" class="am-btn am-btn-secondary am-btn-sm"><i class="am-icon-github am-icon-sm"></i> Github</a>
             <a href="#" class="am-btn am-btn-success am-btn-sm"><i class="am-icon-google-plus-square am-icon-sm"></i> Google+</a>
             <a href="#" class="am-btn am-btn-primary am-btn-sm"><i class="am-icon-stack-overflow am-icon-sm"></i> stackOverflow</a>
         </div>
         <br>
         <br>--%>

        <%
            String name = "";
            String password = "";
            String salt="";
            try {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (int i = 0; i < cookies.length; i++) {
                        if(cookies[i].getName().equals("salt")) {
                            salt=cookies[i].getValue();
                        }
                        if (cookies[i].getName().equals("username")) {
                            name = cookies[i].getValue();
                        }
                        if (cookies[i].getName().equals("password")) {
                            password = DesUtils.decodeValue(SystemConstant.DES_PASSWORD,cookies[i].getValue(),salt);

                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <form class="am-form">
            <label for="usernameid">账号:</label>
            <input type="text" name="username" value="18312345678" id="usernameid" value="<%=name%>">
            <br>
            <label for="passwordid">密码:</label>
            <input type="password" name="password" value="123456" id="passwordid" value="<%=password%>">
            <br>
            <label for="flag">
                <%
                    if(StringUtils.isEmpty(password)){
                %>
                    <input id="flag" type="checkbox" name="flag" value="0" onclick="mind();"/>
                <%
                    }else{
                %>
                    <input id="flag" type="checkbox" name="flag" value="1" onclick="mind();" checked/>
                <%
                    }
                %>
                记住密码
            </label>
            <br/>

            <div class="am-cf">
                <input type="button" name="" value=" 登 录 " onclick="checkUser();"
                       class="am-btn am-btn-primary am-btn-lg am-fl">
                <input type="button" onclick="show();" name="" value="忘记密码 ^_^? "
                       class="am-btn am-btn-warning am-btn-default am-btn-sm am-fr">
            </div>
        </form>
        <hr>
        <p>© 2016.6 Epro.Kaoqing System., Inc. Licensed under MIT license.</p>
    </div>
</div>
</body>
<script type="text/javascript">
    function mind() {
        var checkid = document.getElementById("flag");

        if (checkid.checked == true) {
            checkid.value = "1";
        } else {
            checkid.value = "0";
        }
    }

    function show() {
        window.location.href = "<%=request.getContextPath()%>/psd/show";
    }

    //表单校验
    function checkuser(username, password) {
        if (username == null || username == "") {
            alert("账号不能为空");
            return false;
        }
        if (password == null || password == "") {
            alert("密码不能为空");
            return false;
        }
        return true;
    }

    function checkUser() {
        var username = document.getElementById("usernameid").value;
        var password = document.getElementById("passwordid").value;
        var flag = document.getElementById("flag").value;


        if (!checkuser(username, password)) {
            return;
        }

        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/login/log",
            data: {"username": username, "password": password, "flag": flag},
            dataType: "json",
            success: function (data) {
                console.log("data:", data);
                if (data.result == '登录成功') {
                    alert("success!" + data.result);
                    window.location.href = "<%=request.getContextPath()%>/main/index";
                } else {
                    // 后台验证失败！
                    alert("error1:：" + data.result);
                }
            },
            error: function (data) {
                alert("error2：" + "账号不存在");
            }
        });
    }

</script>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>

<script src="${pageContext.request.contextPath}/static/amazeui/js/jquery.min.js"></script>
</html>
