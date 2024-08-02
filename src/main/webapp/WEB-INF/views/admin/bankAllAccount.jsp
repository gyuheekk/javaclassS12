<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 전체 거래량 관리</title>
  
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f7f9;
      color: #333;
    }
    .container-fluid {
      padding: 30px;
    }
    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    .card-header {
      background-color: #34495e;
      color: white;
      font-weight: bold;
      border-radius: 10px 10px 0 0;
    }
    .stats-card {
      background-color: #fff;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .stats-card h5 {
      color: #34495e;
      margin-bottom: 15px;
    }
    .btn-secondary {
      background-color: #34495e;
      border-color: #34495e;
    }
    .btn-secondary:hover {
      background-color: #2c3e50;
      border-color: #2c3e50;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <h3 class="mb-4"><i class="fa-solid fa-chart-line mr-2"></i>전체 거래량 관리</h3>
  
  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">전체 거래 통계</h5>
        </div>
        <div class="card-body">
          <p><b>총 거래 건수:</b> ${totalTransactions}</p>
          <p><b>총 거래 금액:</b> <fmt:formatNumber value="${totalAmount}" pattern="#,##0.##" />원</p>
          <p><b>평균 일일 거래량:</b> ${averageDailyTransactions}</p>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">거래 유형별 분포</h5>
        </div>
        <div class="card-body">
          <!-- 여기에 차트 삽입 -->
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">월별 거래 통계</h5>
        </div>
        <div class="card-body">
          <!-- 여기에 월별 통계 테이블 삽입 -->
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">최다 거래 고객 Top 10</h5>
        </div>
        <div class="card-body">
          <!-- 여기에 고객 리스트 삽입 -->
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">거래량 피크 시간대</h5>
        </div>
        <div class="card-body">
          <!-- 여기에 시간대별 차트 삽입 -->
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">거래 추이 그래프</h5>
        </div>
        <div class="card-body">
          <!-- 여기에 시계열 그래프 삽입 -->
        </div>
      </div>
    </div>
  </div>

  <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/admin/adminContent';">관리자 메인화면</button>
</div>
</body>
</html>