<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 내 카드 확인</title>
    
    <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
    <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
    <%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
            background-color: #f8f9fa;
        }
        h3 {
            color: #003366;
            border-bottom: 2px solid #003366;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        p {
        	font-family: "Noto Sans KR", sans-serif;
			   	font-optical-sizing: auto;
			   	font-weight: <weight>;
			   	font-style: normal;
        }
        .select-wrapper {
            margin-bottom: 30px;
        }
        select {
            width: 200px;
            padding: 10px;
            border: 1px solid #003366;
            border-radius: 5px;
            background-color: white;
            color: #003366;
        }
        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }
        .card-item {
            border-radius: 15px;
            padding: 20px;
            transition: all 0.3s ease;
            border: 1px solid #e0e0e0;
        }
        .card-item h4 {
            color: #003366;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .form-group label {
            color: #666;
            font-size: 0.9em;
        }
        .form-control {
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
        }
        .card-icon {
            font-size: 2.5em;
            color: #003366;
            margin-bottom: 15px;
        }
        .btn-secondary {
            background-color: #003366;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #004080;
        }
    </style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<div class="container">
    <h3>내 카드 확인</h3>
    <p>고객님이 발급하신 모든 카드 정보를 확인하실 수 있습니다.</p><br/>
    
    <div class="select-wrapper">
      <select onchange="filterCards(this.value)">
        <option value="all">전체 카드 보기</option>
        <option value="S">신용카드</option>
        <option value="C">체크카드</option>
        <option value="H">학생카드</option>
      </select>
    </div>

    <div class="card-container">
      <c:forEach var="vo" items="${vos}">
        <div class="card-item" data-card-type="${vo.cardSw}">
          <c:if test="${vo.cardSw == 'S'}">
            <i class="fas fa-credit-card card-icon"></i>
              <h4>신용카드</h4>
         	</c:if>
          <c:if test="${vo.cardSw == 'C'}">
            <i class="fas fa-wallet card-icon"></i>
            <h4>체크카드</h4>
         	</c:if>
         	<c:if test="${vo.cardSw == 'H'}">
            <i class="fas fa-graduation-cap card-icon"></i>
            <h4>학생카드</h4>
          </c:if>
          <div class="form-group">
          	<p class="mb-1 mt-4"><b>카드번호</b></p>
          	<p>${vo.cardNumber}</p>
          </div>
          <div class="form-group">
          	<p class="mb-1"><b>발급 목적</b></p>
          	<p>${vo.cardContent}</p>
          </div>
          <div class="form-group">
          	<p class="mb-1"><b>발급일</b></p>
          	<p>${fn:substring(vo.cardIssuedDate, 0, 10)}</p>
          </div>
          <div class="form-group">
         		<p class="mb-1"><b>만료일</b></p>
          	<p class="mb-1">${fn:substring(vo.cardExpiryDate, 0, 10)}</p>
          </div>
        </div>
      </c:forEach>
    </div>

    <c:if test="${fn:length(vos) == 0}">
        <p>발급받은 카드 내역이 없습니다 <i class='fa-solid fa-face-sad-tear'></i></p>
    </c:if>
    
    <button type="button" class="btn btn-secondary mt-4 mb-4" onclick="location.href='${ctp}/';">돌아가기</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
function filterCards(type) {
    const cards = document.querySelectorAll('.card-item');
    cards.forEach(card => {
        if (type === 'all' || card.getAttribute('data-card-type') === type) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}
</script>
</body>
</html>