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
  <title>GH Bank - 관리자 거래 확인</title>
  
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
    .table {
      margin-bottom: 0;
    }
    .table thead th {
      border-top: none;
      background-color: #ecf0f1;
    }
    .btn-primary, .btn-secondary {
      background-color: #34495e;
      border-color: #34495e;
    }
    .btn-primary:hover, .btn-secondary:hover {
      background-color: #2c3e50;
      border-color: #2c3e50;
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
    .stats-card p {
      font-size: 16px;
    }
    .pagination .page-link {
      color: #34495e;
    }
    .pagination .page-item.active .page-link {
      background-color: #34495e;
      border-color: #34495e;
    }
    .custom-btn {
      background-color: #34495e;
      border-color: #34495e;
      color: white;
      text-decoration: none;
    }
    .custom-btn:hover,
    .custom-btn:focus,
    .custom-btn:active,
    .custom-btn.active {
      background-color: #2c3e50 !important;
      border-color: #2c3e50 !important;
      color: white !important;
      text-decoration: none !important;
      box-shadow: none !important;
    }
    h4 {
      color: #FFFFFF;
      margin-bottom: 30px;
    }
    h4 .part-title {
      font-size: 0.7em;
      color: #FFFFFF;
      font-weight: normal;
    }
  </style>
  <script>
    'use strict';
    
    function flagSwCheck() {
      let flagSw = $("#flagSw").val();
      location.href = "dailyAccount?pag=${pag}&pageSize=${pageSize}&flagSw="+flagSw;
    }
  </script>
</head>
<body>
<%
  Date date = new Date();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String strDate = sdf.format(date);
%>
<div class="container-fluid">
<h3 class="mb-5"><i class="fa-solid fa-user-gear icon-spacing mr-2"></i>은행 거래량 관리</h3>
  <div class="card mb-4">
    <div class="card-header">
      <div class="d-flex justify-content-between align-items-center">
        <h4 class="mb-0">일일 거래량 확인 <span class="part-title">[<%=strDate%>]</span> </h4>
          <form name="partForm">
            <select name="flagSw" id="flagSw" onchange="flagSwCheck()" class="form-control">
              <option value="" ${flagSw=="" ? "selected" : ""}>전체보기</option>
              <option value="I" ${flagSw=="I" ? "selected" : ""}>입금</option>
              <option value="C" ${flagSw=="C" ? "selected" : ""}>출금</option>
              <option value="E" ${flagSw=="E" ? "selected" : ""}>계좌이체</option>
            </select>
          </form>
      </div>
    </div>
    <div class="card-body">
      <table class="table table-hover">
        <thead>
          <tr class="text-center">
            <th>번호</th>
            <th>거래자아이디</th>
            <th>거래분류</th>
            <th>금액</th>
            <th>적요</th>
            <th>거래날짜</th>
          </tr>
        </thead>
        <tbody>
        
  				<c:if test="${fn:length(vos) == 0}">
  					<td colspan="6" class="text-center">
  						일일 거래 내역이 없습니다.
  					</td>
  				</c:if>    
  				    
          <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
          <c:forEach var="vo" items="${vos}" varStatus="st">
         	<c:if test="${fn:length(vos) != 0}">
            <tr class="text-center">
              <td>${curScrStartNo}</td>
              <td>${vo.mid}</td>
	              <c:if test="${vo.flagSw == 'I'}">
		            	<td>입금</td>
		            </c:if>
		            <c:if test="${vo.flagSw == 'C'}">
		            	<td>출금</td>
		            </c:if>
		            <c:if test="${vo.flagSw == 'E'}">
		            	<td>계좌이체</td>
		            </c:if>
		            <c:if test="${vo.flagSw == 'G'}">
		            	<td>계좌입금</td>
		            </c:if>
              <td><fmt:formatNumber value="${vo.money}" pattern="#,##0.##" />원</td>
              <td>${vo.content}</td>
              <td>${fn:substring(vo.accDate,0,10)}</td>
            </tr>
            <c:set var="curScrStartNo" value="${curScrStartNo-1}" />
            </c:if>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <!-- 페이지네이션 -->
  <div class="d-flex justify-content-center mt-4 mb-4">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="dailyAccount?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="dailyAccount?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="dailyAccount?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="dailyAccount?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="dailyAccount?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="dailyAccount?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-8">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">오늘의 거래 통계</h5>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-md-6">
              <p><b>입금 건수 :</b> ${accountDailyI}건</p>
              <p><b>출금 건수 :</b> ${accountDailyC}건</p>
              <hr/>
              <p><b>총 거래 건수 :</b> ${accountDaily}건</p>
            </div>
            <div class="col-md-6">
              <p><b>계좌이체 건수 :</b> ${accountDailyE}건</p>
              <p><b>계좌입금 건수 :</b> ${accountDailyG}건</p>
              <hr/>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <div class="col-md-4">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">일일 거래 요약</h5>
        </div>
        <div class="card-body">
          <p><b>총 입금액:</b> <fmt:formatNumber value="${DtotalDeposit}" pattern="#,##0.##" />원</p>
          <p><b>총 출금액:</b> <fmt:formatNumber value="${DtotalWithdraw}" pattern="#,##0.##" />원</p>
        </div>
      </div>
    </div>
  </div>

  <div class="card mt-4">
    <div class="card-header">
      <h5 class="mb-0">은행 잔고 현황</h5>
    </div>
    <div class="card-body">
      <div class="row">
        <div class="col-md-4 mb-3">
          <p><b>현 은행 전체 잔고:</b></p>
          <p class="h4"><fmt:formatNumber value="${totalBalance}" pattern="#,##0" />원</p>
        </div>
        <div class="col-md-4 mb-3">
          <p><b>현 은행 전체 입금액:</b></p>
          <p class="h4"><fmt:formatNumber value="${totalDeposit}" pattern="#,##0" />원</p>
        </div>
        <div class="col-md-4 mb-3">
          <p><b>현 은행 전체 출금액:</b></p>
          <p class="h4"><fmt:formatNumber value="${totalWithdraw}" pattern="#,##0" />원</p>
        </div>
      </div>
    </div>
  </div>

  <button type="button" class="btn btn-secondary mt-3" onclick="location.href='${ctp}/admin/adminContent';">관리자 메인화면</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>