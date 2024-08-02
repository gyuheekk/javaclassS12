<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 신용대출</title>
  
	  <!-- Favicon 링크 추가 -->
	  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
    <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
    <%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
    <style>
        body {
            margin: 0;
            padding: 0;
        }
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .step {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            line-height: 30px;
            text-align: center;
            background-color: lightgray;
            margin: 0 5px;
        }
        .step.active {
            background-color: #115C8B;
            color: white;
        }
        h3 {
		     	font-family: "Noto Sans KR", sans-serif;
			   	font-optical-sizing: auto;
			   	font-weight: <weight>;
			   	font-style: normal;
		    }
    </style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="step-indicator">
    <div class="step active">1</div>
    <div class="step active">2</div>
    <div class="step active">3</div>
</div>
<div class="container">
    <h3 class="text-center">GH Bank 신용대출 신청 완료</h3><br/>
    <p class="text-center">대출 신청이 완료되었습니다. 대출 승인까지는 일주일 정도 소요됩니다.</p>
    <p class="text-center">대출 신청 승인 여부는 마이페이지 메시지 확인 창에서 확인할 수 있습니다.</p>
    <p class="text-center">
        <input type="button" value="홈으로" onclick="location.href='${ctp}/';" class="btn btn-secondary mr-2"/>
    </p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
