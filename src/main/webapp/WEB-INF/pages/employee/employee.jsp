<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="no-js fixed-layout">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>EproKq-员工管理</title>
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
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">员工信息</strong> / <small>EmpInfo</small></div>
          <%--<button type="button" class="am-btn am-btn-secondary am-round am-active am-btn-sm">新增员工</button>--%>
      </div>

      <hr>

      <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
          <div class="am-btn-toolbar">
              <c:forEach items="${myRoleButtonList}" var="myBtn">
                  <c:if test="${myBtn.menuNo == '2'}">
                      <c:choose>
                          <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '1'}">
                              <a href="${pageContext.request.contextPath}/emp/toAdd"><button type="button" class="am-btn am-btn-primary am-round  am-btn-sm">新增员工</button></a>
                              <a href="${pageContext.request.contextPath}/emp/export"><button type="button" class="am-btn am-btn-primary am-round  am-btn-sm">导出员工</button></a>
                          </c:when>
                          <c:when test="${myBtn.buttonNo == '1' && myBtn.avaliable == '0'}">
                              <div title="您没有权限!">
                              <a disabled="disabled" title="您没有权限" href="${pageContext.request.contextPath}/emp/toAdd"><button disabled="disabled" title="您没有权限!" type="button" class="am-btn am-btn-primary am-round  am-btn-sm">新增员工</button></a>
                              </div>
                          </c:when>
                          <c:otherwise></c:otherwise>
                      </c:choose>
                  </c:if>
              </c:forEach>
          </div>
        </div>
        <div class="am-u-sm-12 am-u-md-3">

        </div>
        <div class="am-u-sm-12 am-u-md-3">
          <form action="findByNo" method="post">
            <div class="am-input-group am-input-group-sm">
              <input class="am-form-field" type="text" name="empNo">
          <span class="am-input-group-btn">
            <button class="am-btn am-btn-default" type="submit">搜索</button>
          </span>
            </div>
          </form>
        </div>
      </div>

      <div class="am-g">
        <div class="am-u-sm-12">
          <form class="am-form">
            <table class="am-table am-table-striped am-table-hover table-main" id="table1">
              <thead>
              <tr>
                <th class="table-check"><input type="checkbox"></th>
                  <th class="table-type">员工号</th>
                  <th class="table-type">姓名</th>
                  <th class="table-type">性别</th>
                  <th class="table-author am-hide-sm-only">电话号</th>
                  <th class="table-date am-hide-sm-only">入职日期</th>
                  <th class="table-set">操作</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${emps}" var="c">
                <tr>
                  <td><input type="checkbox"></td>
                  <td>${c.empNo}</td>
                  <td><a href="${pageContext.request.contextPath}/emp/load?empId=${c.uuid}">${c.empName}</a></td>
                  <td>${c.sex}</td>
                  <td class="am-hide-sm-only">${c.phoneNo}</td>
                  <td class="am-hide-sm-only">${c.hireDate}</td>
                  <td>
                    <div class="am-btn-toolbar">
                      <div class="am-btn-group am-btn-group-xs">
                          <c:forEach items="${myRoleButtonList}" var="myBtn">
                              <c:if test="${myBtn.menuNo == '2'}">
                                  <c:choose>
                                      <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '1'}">
                                          <a class="am-btn am-btn-default am-btn-xs am-text-secondary"
                                             href="${pageContext.request.contextPath}/emp/load?empId=${c.uuid}"><span class="am-icon-pencil-square-o"></span> 编辑</a>
                                      </c:when>
                                      <c:when test="${myBtn.buttonNo == '2' && myBtn.avaliable == '0'}">
                                          <a disabled="disabled" title="您没有权限!" class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-pencil-square-o"></span> 编辑</a>
                                      </c:when>
                                      <c:when test="${myBtn.buttonNo == '3' && myBtn.avaliable == '1'
                                            && c.uuid != '49da318f-8cf7-1034-a809-c1a90b3d119b'}">
                                          <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"
                                             href="${pageContext.request.contextPath}/emp/delete?empId=${c.uuid}"><span class="am-icon-trash-o"></span> 删除</a>
                                      </c:when>
                                      <c:when test="${myBtn.buttonNo == '3' && myBtn.avaliable == '0'}">
                                          <a disabled="disabled" title="您没有权限!" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</a>
                                      </c:when>
                                      <c:otherwise></c:otherwise>
                                  </c:choose>
                              </c:if>
                          </c:forEach>
                      </div>
                    </div>
                  </td>
                  </tr>
              </c:forEach>
              </tbody>
            </table>
            <div class="am-cf">
              第${showPage}页（共${pageCount}页）
              <br>
              <a href="${pageContext.request.contextPath}/emp/getAll?showPage=1">首页</a>
              <a href="${pageContext.request.contextPath}/emp/getAll?showPage=${showPage-1}">上一页</a>
              <%
                Integer pageCount=(Integer)request.getAttribute("pageCount");
                if(pageCount==null){pageCount=1;}


              %>
              <% //根据pageCount的值显示每一页的数字并附加上相应的超链接
                for(int i=1;i<=pageCount;i++){
              %>
              <a href="${pageContext.request.contextPath}/emp/getAll?showPage=<%=i%>"><%=i%></a>
              <% }
              %>

              <a href="${pageContext.request.contextPath}/emp/getAll?showPage=${showPage+1}">下一页</a>
              <a href="${pageContext.request.contextPath}/emp/getAll?showPage=${pageCount}">末页</a>
              <!-- 通过表单提交用户想要显示的页数 -->
              <form action="getAll"  method="get">
                跳转到第<input style="width: 50px;height: 30px;display:inline-block;" type="text" name="showPage" size="4">页
                <input type="submit" name="submit" value="跳转">
              </form>



            </div>

            <hr>
            <%--<p>注：.....</p>--%>
          </form>
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
</html>

