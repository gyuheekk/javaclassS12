<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 관리자메뉴</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f7f9;
    }
    .sidebar {
      background-color: #ffffff;
      height: 100vh;
      padding-top: 20px;
      box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    }
    .nav-link {
      color: #333;
      transition: all 0.3s ease;
    }
    .nav-link:hover {
      background-color: #f8f9fa;
      color: #007bff;
    }
    .active {
      background-color: #e9ecef;
      color: #007bff;
      font-weight: bold;
    }
    .sidebar {
  /* 기존 속성들 유지 */
  resize: none;
  user-select: none;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
}
  </style>
</head>
<body>
<div class="sidebar">
  <div class="text-center mb-4">
    <h4>관리자 메뉴</h4>
  </div>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/" target="_top"><i class="fas fa-home mr-2"></i>홈으로</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/dailyAccount" target="adminContent"><i class="fa-solid fa-circle-dollar-to-slot mr-2"></i>일일 거래 관리</a>
    </li>
    <!-- <li class="nav-item">
      <a class="nav-link" href="#" target="adminContent"><i class="fa-solid fa-sack-dollar mr-2"></i>대출관리</a>
    </li> -->
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/qna/qnaList" target="adminContent"><i class="fas fa-question-circle mr-2"></i>문의사항 관리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/admin/member/memberList" target="adminContent"><i class="fas fa-users mr-2"></i>회원 리스트</a>
    </li>
  </ul>
</div>
</body>
</html>