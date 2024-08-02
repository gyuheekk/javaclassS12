<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 카드상품</title>
    <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
    <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
            background-color: #f8f9fa;
        }
        .card-box {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            border: 1px solid #e0e0e0;
        }
        .card-icon {
            font-size: 50px;
            color: #1F50B5;
            margin-right: 30px;
        }
        .card-content {
            flex: 1;
        }
        .card-title {
            color: #0E1241;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .card-subtitle {
            font-size: 18px;
            color: #5f6368;
            margin-bottom: 15px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        .card-description {
            font-size: 16px;
            color: #333;
            margin-bottom: 13px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        .apply-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #1F50B5;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .apply-button:hover {
            background-color: #163c8c;
            color: white;
            text-decoration: none;		
        }
        h2 {
            color: #003366;
            border-bottom: 2px solid #003366;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        h6 {
        	font-family: "Noto Sans KR", sans-serif;
			   	font-optical-sizing: auto;
			   	font-weight: <weight>;
			   	font-style: normal;
        }
    </style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>


<div class="container">
<h2 class="mt-5">GH Bank 카드상품</h2>
<h6 class="mb-5">아래는 GH Bank 카드 상품입니다. 카드 종류를 클릭하면, 신청페이지로 이동합니다.</h6>
    <div class="card-box">
        <div class="card-icon"><i class="fa-solid fa-money-check-dollar"></i></div>
        <div class="card-content">
            <div class="card-title">GH Credit Card</div>
            <div class="card-subtitle">신용카드</div>
            <div class="card-description">사용자의 신용을 기반으로 발급되는 카드로, 일정 한도 내에서 금액을 결제하고 추후 결제액을 갚는 형태로 운영되는 카드입니다.</div>
            <a href="${ctp}/card/cardSignup?flagSw=S" class="apply-button" onclick="return confirm('신용카드 신청페이지로 이동하시겠습니까?')">신청하기</a>
        </div>
    </div>
    
    <div class="card-box">
        <div class="card-icon"><i class="fa-solid fa-money-check"></i></div>
        <div class="card-content">
            <div class="card-title">GH Check Card</div>
            <div class="card-subtitle">체크카드</div>
            <div class="card-description">사용 시 해당 금액이 즉시 연결된 계좌에서 출금되는 카드입니다. 사용 즉시 결제되어 과소비를 방지할 수 있습니다.</div>
            <a href="${ctp}/card/cardSignup?flagSw=C" class="apply-button" onclick="return confirm('체크카드 신청페이지로 이동하시겠습니까?')">신청하기</a>
        </div>
    </div>
    
    <div class="card-box">
        <div class="card-icon"><i class="fa-regular fa-credit-card"></i></div>
        <div class="card-content">
            <div class="card-title">GH Student Card</div>
            <div class="card-subtitle">학생카드</div>
            <div class="card-description">학생들을 대상으로 발급되는 카드로, 낮은 한도와 특화된 혜택을 제공합니다. 학업에 필요한 다양한 할인 혜택을 누려보세요.</div>
            <a href="${ctp}/card/cardSignup?flagSw=H" class="apply-button" onclick="return confirm('학생카드 신청페이지로 이동하시겠습니까?')">신청하기</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>