<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 내 예금/적금 확인</title>
    
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
            font-weight: bold;
            font-style: normal;
        }
        p {
            font-family: "Noto Sans KR", sans-serif;
            font-optical-sizing: auto;
            font-weight: normal;
            font-style: normal;
        }
        .btn-secondary {
            background-color: #003366;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #004080;
        }
        .account-box {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            font-family: "Noto Sans KR", sans-serif;
            font-optical-sizing: auto;
            font-weight: bold;
            font-style: normal;
        }
        .account-box h4 {
            color: #003366;
            margin-bottom: 15px;
        }
        .user-info {
        	font-size: 1.15rem;  /* 원하는 크기로 조정 가능 */
        	margin-bottom: 15px;
        	color: #003366;  /* 강조를 위해 색상 추가 (선택사항) */
    		}
    </style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<div class="container">
    <h3>내 예금/적금 확인</h3>
    <p>고객님이 신청하신 예금/적금 정보를 확인하실 수 있습니다.</p><br/>
    
    <!-- 예금/적금 둘 다 가입정보가 없을때 -->
    <c:if test="${fn:length(vos) == 0}">
       <div class="text-center">정기예금/적금 가입 정보가 없습니다 <i class='fa-solid fa-face-sad-tear'></i></div>
    </c:if>
    
    <c:if test="${fn:length(vos) != 0}">
	    <div class="row">
	      <div class="col-md-6">
	        <div class="account-box">
	        	<c:set var="sw" value="NO"/>
	        	<c:forEach var="vo" items="${vos}">
	        	  <c:if test="${sw == 'NO'}">
		            <c:if test="${vo.savingSw == 'Y'}">
			     	    	<h4>정기예금</h4>
		  	          <hr/>
		            	<p class="user-info"><b>${sName}</b>님의 정기예금 가입 정보를 확인합니다.</p>
		              <p><b>계좌번호</b> : ${vo.savingAccount}</p>
		              <p><b>예치금액</b> : <fmt:formatNumber value="${vo.amount}" pattern="#,##0.##" />원</p>
		              <p><b>예금가입일</b> : ${vo.startDate}</p>
		             	<p><b>가입기간</b> : ${vo.paymentPeriod}개월</p>
		              <p><b>만기일</b> : ${vo.expiryDate}</p>
		              <p><b>연 이자율</b> : ${vo.interest}%</p>
		              <p><b>만기시 총 수령액</b> : <fmt:formatNumber value="${vo.totalAmount}" pattern="#,##0.##" />원</p>
		              <p><b>이자금액</b> : <fmt:formatNumber value="${vo.expectedInterest}" pattern="#,##0.##" />원</p>
		              <p><b>세금(15.4%)</b> : <fmt:formatNumber value="${vo.expectedTax}" pattern="#,##0.##" />원</p>
		              <p><b>세후 실 수령액</b> : <fmt:formatNumber value="${vo.expected_tax_amount}" pattern="#,##0.##" />원</p>
		            	<c:set var="sw" value="YES"/>
		            </c:if>
	            </c:if>
	          </c:forEach>
            <c:if test="${sw == 'NO'}">
            	<p>정기예금 가입 정보가 없습니다 <i class='fa-solid fa-face-sad-tear'></i></p>
            </c:if>
	        </div>
	      </div>
	        
	      <div class="col-md-6">
	        <div class="account-box">
	        	<c:set var="sw" value="NO"/>
		        <c:forEach var="vo" items="${vos}">
		       	  <c:if test="${sw == 'NO'}">
		        		<c:if test="${vo.savingSw == 'J'}">
			     	    	<h4>정기적금</h4>
		  	   	    	<hr/>
		              <p class="user-info"><b>${sName}</b>님의 정기적금 가입 정보를 확인합니다.</p>
		              <p><b>계좌번호</b> : ${vo.savingAccount}</p>
		              <p><b>한 달 납입금액</b> : <fmt:formatNumber value="${vo.amount}" pattern="#,##0.##" />원</p>
		              <p><b>총 납입금액</b> : <fmt:formatNumber value="${vo.total_deposit}" pattern="#,##0.##" />원</p>
		              <p><b>적금가입일</b> : ${vo.startDate}</p>
		              <p><b>가입기간</b> : ${vo.paymentPeriod}개월</p>
		              <p><b>만기일</b> : ${vo.expiryDate}</p>
		              <p><b>연 이자율</b> : ${vo.interest}%</p>
		              <p><b>만기시 총 수령액</b> : <fmt:formatNumber value="${vo.totalAmount}" pattern="#,##0.##" />원</p>
		              <p><b>이자금액</b> : <fmt:formatNumber value="${vo.expectedInterest}" pattern="#,##0.##" />원</p>
		              <p><b>세금(15.4%)</b> : <fmt:formatNumber value="${vo.expectedTax}" pattern="#,##0.##" />원</p>
		              <p><b>세후 실 수령액</b> : <fmt:formatNumber value="${vo.expected_tax_amount}" pattern="#,##0.##" />원</p>
		              <c:set var="sw" value="YES"/>
		            </c:if>
	            </c:if>
	          </c:forEach>
	        	<c:if test="${sw == 'NO'}">
        			<p>정기적금 가입 정보가 없습니다 <i class='fa-solid fa-face-sad-tear'></i></p>
        		</c:if>
	        </div>
	      </div>
	      
	    </div>
    </c:if>
    
    <button type="button" class="btn btn-secondary mt-4 mb-4" onclick="location.href='${ctp}/';">돌아가기</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>