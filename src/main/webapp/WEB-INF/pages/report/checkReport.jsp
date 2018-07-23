
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
  <script type="text/javascript">
    var dept = "";
    var obj = null;
    function doexport(){
      location.href="${pageContext.request.contextPath}/report/export";
    }
    function doexcheckport(){
      var form = $("<form>");   //定义一个form表单
      form.attr('style','display:none');   //在form表单中添加查询参数
      form.attr('target','');
      form.attr('method','post');
      form.attr('action',"${pageContext.request.contextPath}/report/exCheckReport");
      $('body').append(form);  //将表单放置在web中
      form.submit();   //表单提交
    }
    $(function(){
      obj = eval('( ${deptTree})');
      dept += "<li><input type=\"checkbox\" value=\"" + obj.uuid +"\" alt=\"" + obj.deptName + "\" onclick=\"getDeptName();\" id=\""+ obj.uuid +"\" name = \"dept\" /><a  data-am-collapse=\"{target: '#collapse-nav'}\">" + obj.deptName + "<span class=\"am-icon-angle-right am-fr am-margin-right\"></span></a></li>";
      traverse(obj.sdept,'collapse-nav');
      dept += "</li>";
      document.getElementById("dept").innerHTML = dept;
    });
    $(function(){
      obj = eval('( ${dept})');
      for(var i = 0;i<obj.length;i++){
        document.getElementById(obj[i]).checked = true;
      }
      getDeptName();
    });
    function traverse(node,id){
      dept += "<ul  id=\""+ id +"\" style=\"background-color: white;\">";
      for(var i = 0;i<node.length;i++){
        if(node[i].sdept.length >0 && node[i].sdept !=null){
          dept += "<li><input type=\"checkbox\" id=\""+ node[i].uuid +"\" onclick=\"getDeptName();\" alt=\"" + node[i].deptName + "\" name = \"dept\" value=\"" + node[i].uuid +"\"/><a data-am-collapse=\"{target: '#"+ id + i +"'}\">" + node[i].deptName + "<span class=\"am-icon-angle-right am-fr am-margin-right\"></span></a></li>";
          traverse(node[i].sdept,id + i);
        }else{
          dept += "<li><a href=\"#\"><input type=\"checkbox\" id=\""+ node[i].uuid +"\" onclick=\"getDeptName();\" alt=\"" + node[i].deptName + "\" name = \"dept\" value=\"" + node[i].uuid +"\"/>" + node[i].deptName + "</a></li>";
        }
      }
      dept += "</ul>";
    }
    function getDeptName(){

      var deptBox = document.getElementsByName("dept");
      document.getElementById("deptName").value = "";
      for(var i = 0;i<deptBox.length;i++) {
        if(deptBox[i].checked) {
          document.getElementById("deptName").value += deptBox[i].alt+" ";
        }
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
      <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">报表</strong> / <small>Report</small></div>
      </div>

      <ul class="am-avg-sm-1 am-avg-md-4 am-margin am-padding am-text-center admin-content-list ">
        <li><a href="${pageContext.request.contextPath}/report/getAll" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>总报表</a><button  type="button" class="am-btn am-btn-success am-btn-xs" style="margin-right:-90px;margin-left:30px;" onclick="doexport()" ><span class="am-icon-save"></span>导出</button></li>
        <li><a href="${pageContext.request.contextPath}/report/getCheckReport" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>考勤报表</a><button  type="button" class="am-btn am-btn-success am-btn-xs" style="margin-right:-90px;margin-left:30px;" onclick="doexcheckport()" ><span class="am-icon-save"></span>导出</button></li>
        <li><a href="${pageContext.request.contextPath}/report/" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>业绩报表</a><button  type="button" class="am-btn am-btn-success am-btn-xs" style="margin-right:-90px;margin-left:30px;" onclick="doexport()" ><span class="am-icon-save"></span>导出</button></li>
      </ul>

      <form action="${pageContext.request.contextPath}/report/getCheckReport">
        <input type="hidden" name="sort" value="${sort}"/>
        <input type="hidden" name="tabNum" value="${tabNum}" />
        <div class="am-u-sm-12 am-u-md-3">
          <div class="am-form-group">
            <script>
              function showDept(){
                $("#dept").toggle();
              }
            </script>
            <input type="text" id="deptName" style="width: 200px;" onclick="showDept();" readonly/>
            <div id="dept" style="position: absolute;color: red;z-index: 999;width: 200px;display: none;">

            </div>
          </div>
        </div>
        <div class="am-u-sm-12 am-u-md-3">
          <div class="am-input-group am-input-group-sm">
            <input name="hiredate" id="hiredate" type="text" value="${month}" class="am-form-field" placeholder="查询时间" readonly="true">
            <%--<input type="text" class="hiredate" id="hiredate" value="" name="" placeholder="输入入职日期" readonly="true">--%>
                <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" type="submit">搜索</button>
                </span>
          </div>
        </div>
      </form>


      <div class="am-g">
        <div class="am-u-sm-12">
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
              <tr>
                <th class="table-check" onclick="checkIn(this);"><input type="checkbox" id="checkid"/><th>员工号</th><th>员工姓名</th><th>迟到次数</th><th>早退次数</th><th>旷工次数</th>
              </tr>
            </thead>
            <tbody>

            <c:forEach items="${allCounts}" var="counts" >
              <tr>
                <td><input type="checkbox" name="checkbox"/></td>
                <td>${counts.empNo}</td>
                <td><a href="${pageContext.request.contextPath}/report/getCheckBill?empId=${counts.uuid}&nowDate=${month}">${counts.empName}</a></td>
                <td>${counts.laterCount}</td>
                <td class="am-hide-sm-only">${counts.earlyCount}</td>
                <td>${counts.nullCounts}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
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

