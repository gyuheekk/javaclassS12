<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 은행 전체 잔고 조회</title>
  
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
  <h3 class="mb-4"><i class="fa-solid fa-coins icon-spacing mr-2"></i>은행 전체 잔고 조회</h3>
  <div class="card">
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
  <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/admin/adminContent';">관리자 메인화면</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>