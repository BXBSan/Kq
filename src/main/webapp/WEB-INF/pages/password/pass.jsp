<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>EproKq-修改密码</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
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
        <h1>密码修改</h1>
    </div>
    <hr />
</div>
<div class="am-g">
    <div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
        <h3>修改密码</h3>
        <%-- <hr>
         <div class="am-btn-group">
             <a href="#" class="am-btn am-btn-secondary am-btn-sm"><i class="am-icon-github am-icon-sm"></i> Github</a>
             <a href="#" class="am-btn am-btn-success am-btn-sm"><i class="am-icon-google-plus-square am-icon-sm"></i> Google+</a>
             <a href="#" class="am-btn am-btn-primary am-btn-sm"><i class="am-icon-stack-overflow am-icon-sm"></i> stackOverflow</a>
         </div>
         <br>
         <br>--%>
        <form class="am-form">
            <label for="psdid">原密码:</label>
            <input type="password" name="psd"  id="psdid">
            <br>
            <label for="newpsdid">新密码:</label>
            <input type="password" name="newpsd" id="newpsdid" value="">
            <br>
            <label for="repsdid">重复新密码:</label>
            <input type="password" name="repsd" id="repsdid" value="">
            <br />
            <div class="am-cf">
                <input type="button" name="" value="确认" onclick="checkUser();" oclass="am-btn am-btn-primary am-btn-sm am-fl">
                <a href="javascript: history.go(-1)"><input type="button" name="" value="返回" class="am-btn am-btn-default am-btn-sm am-fr"></a>
            </div>
        </form>
        <hr>
        <footer class="admin-content-footer">
            <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
        </footer>
    </div>
</div>
</body>
<script type="text/javascript">
    //表单校验
    function checkuser(psd,newpsd,repsd){
        //alert(username);
        if(psd==null || psd==""){
            alert("原密码不能为空");
            return false;
        }if(newpsd==null || newpsd==""){
            alert("新密码不能为空");
            return false;
        }if(repsd==null || repsd==""){
            alert("二次新密码不能为空");
            return false;
        }
        if(newpsd!=repsd){
            alert("两次密码输入不相同");
            return false;
        }
        return true;
    }
    function checkUser() {
        var psd = document.getElementById("psdid").value;
        var newpsd = document.getElementById("newpsdid").value;
        var repsd = document.getElementById("repsdid").value;
        if(!checkuser(psd,newpsd,repsd)){
            return;
        }
        //alert(username);
        $.ajax({
            type: "POST",
            url: "<%=request.getContextPath()%>/psd/modify",
            data: {"psd": psd, "newpsd": newpsd,"repsd":repsd},
            dataType: "json",
            success: function (data) {
                console.log("data:",data);
                alert("111111");
                if(data.result == '密码修改成功'){
                    alert("222222");
                    alert("success!"+data.result);
                    window.location.href = "<%=request.getContextPath()%>/main/index";
                }else if(data.result=='原密码不正确，请重新输入！'){
                    // 后台验证失败！
                    alert("error1:："+data.result);
                    window.location.href = "<%=request.getContextPath()%>/psd/password";
                }

            },
            error: function (data) {
                alert("error2："+"系统错误");
            }

        });
    }

</script>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>

<script src="${pageContext.request.contextPath}/static/amazeui/js/jquery.min.js"></script>
</html>