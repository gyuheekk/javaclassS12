<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 대출상품</title>
    <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
    <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
    <style>
        body {
            font-family: "Noto Sans KR", sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .product-box {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .product-title {
            color: #0066b3;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .product-subtitle {
            font-size: 16px;
            color: #5f6368;
            margin-bottom: 10px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        .product-icon {
            font-size: 30px;
            color: #0066b3;
            margin-bottom: 15px;
        }
        .apply-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #0066b3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .apply-button:hover {
            background-color: #004c8c;
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
        .product-info {
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
<h2 class="mt-5">GH Bank 대출상품</h2>
<h6 class="mb-5">아래는 GH Bank 대출 상품입니다. 원하시는 대출 종류를 클릭하면, 신청페이지로 이동합니다.</h6><br/>
    <div class="product-box">
        <div class="product-icon"><i class="fa-solid fa-chart-line"></i></div>
        <div class="product-title">신용 대출</div>
        <div class="product-subtitle">담보없이 개인의 신용을 바탕으로 제공되는 대출</div>
        <div class="product-subtitle mb-3">대출 한도와 금리는 개인의 신용도에 따라 결정됩니다. 용도가 자유롭고, 주로 생활비나 긴급자금으로 사용됩니다.</div>
        <br/>
        <div class="product-info mb-4">
          <div class="info-item mb-1">대출금액 | 최소 5,000,000 ~ 최대 70,000,000원</div>
          <div class="info-item mb-1">대출기간 | 최소 1년 ~ 최대 5년 (1년단위)</div>
          <div class="info-item mb-1">연이자율 | 연 8%</div>
          <div class="info-item mb-1">상환방법 | 원금균등상환</div>
          <div class="info-item">월 소득기준 | 월 대출 상환액의 30% 이내</div>
        </div>
        <a href="${ctp}/loan/loanSignup?loanSw=S" class="apply-button" onclick="return confirm('신용 대출 신청페이지로 이동하시겠습니까?')">신청하기</a>
    </div>
    
    <div class="product-box">
        <div class="product-icon"><i class="fa-solid fa-school"></i></div>
        <div class="product-title">학자금 대출</div>
        <div class="product-subtitle">학비와 관련된 비용을 지원하는 대출</div>
        <div class="product-subtitle mb-3">학비, 교재비, 생활비 등을 위해 사용되며, 상환은 졸업 후 일정 기간 뒤에 시작됩니다.</div>
        <br/>
        <div class="product-info mb-4">
          <div class="info-item mb-1">대출금액 | 등록금 금액의 최대 70%</div>
          <div class="info-item mb-1">대출기간 | 재학 기간</div>
          <div class="info-item mb-1">연이자율 | 연 5%</div>
          <div class="info-item">상환방법 | 원금균등상환 (졸업 후 상환 가능)</div>
        </div>
        <a href="${ctp}/loan/loanSignup?loanSw=H" class="apply-button" onclick="return confirm('학자금 대출 신청페이지로 이동하시겠습니까?')">신청하기</a>
    </div>
    
    <%-- <div class="product-box">
        <div class="product-icon"><i class="fa-solid fa-car"></i></div>
        <div class="product-title">자동차 대출</div>
        <div class="product-subtitle">자동차 구매를 위한 대출</div>
        <p>구매하려는 자동차를 담보로 제공하며, 대출 상환 기간 동안 자동차는 금융기관의 소유로 간주될 수 있습니다.</p>
        <a href="${ctp}/loan/loanSignup?loanSw=J" class="apply-button" onclick="alert('자동차 대출 신청페이지로 이동하시겠습니까?')">신청하기</a>
    </div> --%>
    
    <%-- <div class="product-box">
        <div class="product-icon"><i class="fa-solid fa-coins"></i></div>
        <div class="product-title">예/적금 담보대출</div>
        <div class="product-subtitle">정기예금이나 정기적금을 담보로 대출</div>
        <div class="product-subtitle mb-3">만기가 얼마 안남았을때는 해지시 손해가 크기 때문에 담보대출이 유리하다.</div>
        <br/>
        <div class="product-info mb-4">
          <div class="info-item mb-1">신청조건 | 담보상품의 만기일이 1년 이상 남아있어야 신청 가능</div>
          <div class="info-item mb-1">대출금액 | 예/적금 납입금액의 90%이내</div>
          <div class="info-item mb-1">대출기간 | 담보상품의 만기일 이내</div>
          <div class="info-item mb-1">연이자율 | 연 3%</div>
          <div class="info-item">상환방법 | 만기일시상환</div>
        </div> 
        <a href="${ctp}/loan/loanSignup?loanSw=M" class="apply-button" onclick="alert('예/적금 담보대출 신청페이지로 이동하시겠습니까?')">신청하기</a>
    </div> --%>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>