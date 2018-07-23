
<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="no-js fixed-layout">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>EproKq-考勤报表</title>
  <meta name="description" content="这是一个 index 页面">
  <meta name="keywords" content="index">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/static/jedate/jedate.js"></script>
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/static/amazeui/i/favicon.png">
  <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/static/amazeui/i/app-icon72x72@2x.png">
  <meta name="apple-mobile-web-app-title" content="Amaze UI" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/amazeui/css/amazeui.min.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/amazeui/css/admin.css">
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
      <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">报表</strong> / <small>Report</small></div>
      </div>


      <div class="am-g">
        <div class="am-u-sm-12">
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>


            <c:if test="${!empty CheckList}">
              <tr>
                <th>ID</th><th>用户名</th><th>打卡日期</th><th>签到时间</th><th>签退时间</th><th>有效工时</th>
              </tr>
            </c:if>

            <c:if test="${empty CheckList}">
              <h2>你查询的数据不存在</h2>
            </c:if>



            </thead>
            <tbody>



            <c:forEach items="${CheckList}" var="CheckInfo" varStatus="status">
              <tr><td>${status.index+1}</td><td>${CheckInfo.empName}</td><td>${CheckInfo.checkDate}</td> <td>${CheckInfo.checkTime}</td>
                  <td>${CheckInfo.endTime}</td><td>${CheckInfo.workTime}</td>
              </tr>

            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>








</div>
    </div>
  </div>

  <!-- 修改.....内容部分 end -->

  <!-- 下面是地脚,不用改 -->
  <footer class="admin-content-footer">
    <hr>
    <p class="am-padding-left">© 2016.6 Epro.Kaoqing System.</p>
  </footer>

</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/static/jedate/seting.jsp"></script>

</body>
<script type="text/javascript">
  function checkIn(e){
    var check = document.getElementsByName("checkbox");
    var ch=document.getElementById("checkid");
    if(ch.checked == true){
      for(var i = 0;i<check.length;i++) {
        check[i].checked = true;
      }
    }
    if(ch.checked != true){
      for(var i = 0;i<check.length;i++) {
        check[i].checked = false;
      }
    }

  }
</script>
</html>

