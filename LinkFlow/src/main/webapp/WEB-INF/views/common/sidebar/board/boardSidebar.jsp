<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.LinkFlowSidebar{
    width: 15%;
    min-width: 300px;
    min-height: 400px;
}
.sidebarName{
 font-size: 32px;
 font-weight: bold;
 color: #d0d4db;
}
.middleName{
 font-size: 20px;
 font-weight: bold;
}
.linkfoiwsideMenu{
 padding: 0px 20px 0px 20px;

 margin-top: 38px;

}
.LinkFlowInsertBtnArea{
  margin-bottom: 20%;
 
}
.sideSmall{
 padding-left: 20px;
}
</style>
</head>
<body>
 <div class="LinkFlowSidebar">
  <!-- Main Sidebar Container -->
  <aside class="sidebar-mini sidebar-dark-primary elevation-4 " style="height: 100%;">

  <!-- Sidebar -->
  <div class="sidebar">

  <!-- Sidebar Menu -->
  <nav class="linkfoiwsideMenu">

    <!--프로젝트 등록이나 휴가 신청등 버튼등 보여지는 요소 필요없음 지우거나~-->
    <div class="LinkFlowInsertBtnArea">
      <a href="#" class="btn btn-block bg-gradient-primary btn-lg" style="color:white">게시글 작성하기</a>
  
    </div>
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

      <li class="sidebarName">
        <span>게시판</span>
      </li><br>
  
      <li class="nav-item">
          <a href="#" class="nav-link middleName">
            <i class="nav-icon far-2xl fa-solid fa-check"></i>
            <p>사내공지</p>
          </a>
      </li>

      <li class="nav-item">
        <a href="#" class="nav-link middleName">
          <i class="nav-icon far fa-solid fa-user-group"></i>
          <p>
              부서게시판
              <i class="fas fa-angle-left right" ></i>
          </p>
        </a>

        <ul class="nav nav-treeview" style="padding-left: 20px;">
            <a href="#" class="nav-link">
              <i class="far fa-circle nav-icon"></i>
              <p>개발1팀 게시판</p>
            </a>
            <a href="#" class="nav-link">
              <i class="far fa-circle nav-icon"></i>
              <p>개발2팀 게시판</p>
            </a>
        </ul>

        <li class="nav-item">
          <a href="#" class="nav-link middleName">
            <i class="nav-icon far-2xl fa-solid fa-gear"></i>
            <p>
                게시판 관리
                <i class="fas fa-angle-left right" ></i>
            </p>
          </a>

          <ul class="nav nav-treeview" style="padding-left: 20px;">
              <a href="#" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p style="padding-left: 5px;">임시저장</p>
              </a>
              <a href="#" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p style="padding-left: 5px;">휴지통</p>
              </a>
              <a href="#" class="nav-link">
                <i class="far fa-circle nav-icon"></i>
                <p style="padding-left: 5px;">게시판 만들기</p>
              </a>
          </ul>
      </li>
    </li>  
  </nav>
  <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
	</aside>
	<!--사이드바 끝-->
</div>
</body>
</html>