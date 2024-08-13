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
    <title>GH Bank - 내 대출정보 확인</title>
    
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
    <h3>내 대출 확인</h3>
    <p>고객님의 대출 정보를 확인하실 수 있습니다.</p><br/>
    
    <!-- 대출 가입정보가 없을때 -->
    <div class="row">
    	<div class="col-md-6">
		    <c:if test="${fn:length(vos1) == 0}">
        	<div class="account-box text-center">고객님의 신용대출 정보가 없습니다 <i class='fa-solid fa-face-sad-tear'></i></div>
		    </c:if>
    
		    <c:if test="${fn:length(vos1) != 0}">
	        <div class="account-box">
	        	<c:forEach var="vo" items="${vos1}">
	     	    	<h4>신용대출 정보</h4>
  	          <hr/>
            	<p class="user-info"><b>${sName}</b>님의 신용대출 정보를 확인합니다.</p>
              <p><b>직업</b> : ${vo.job}</p>
              <p><b>직장명</b> : ${vo.company}</p>
              <p><b>직위</b> : ${vo.position}</p>
              <p><b>근무기간</b> : ${vo.workingPeriod}</p>
              <p><b>월 소득</b> : <fmt:formatNumber value="${vo.monthlyIncome}" pattern="#,##0.##" />원</p>
              <p><b>대출 신청 금액</b> : <fmt:formatNumber value="${vo.loanAmount}" pattern="#,##0.##" />원</p>
              <p><b>대출기간</b> : ${vo.loanPeriod}년</p>
              <p><b>대출 신청 목적</b> : ${vo.loanContent}</p>
              <p><b>이자율</b> : ${vo.interesRate}%</p>
              <p><b>상환방식</b> : ${vo.repaymentMethod}</p>
              <p><b>대출 상태</b> : ${vo.status}</p>
	          </c:forEach>
	        </div>
		    </c:if>
		  </div>
    
      <div class="col-md-6">
      	<c:if test="${fn:length(vos2) == 0}">
		      <div class="account-box text-center">고객님의 학자금대출 정보가 없습니다 <i class='fa-solid fa-face-sad-tear'></i></div>
		    </c:if>
		    
		    <c:if test="${fn:length(vos2) != 0}">
	        <div class="account-box">
	        	<c:forEach var="vo" items="${vos2}">
	     	    	<h4>학자금대출 정보</h4>
	 	          <hr/>
	           	<p class="user-info"><b>${sName}</b>님의 학자금대출 정보를 확인합니다.</p>
             	<p><b>학교명</b> : ${vo.school}</p>
             	<p><b>학과</b> : ${vo.major}</p>
             	<p><b>입학일</b> : ${vo.admissionDate}</p>
             	<p><b>졸업예정일</b> : ${vo.graduationDate}</p>
             	<p><b>학년</b> : ${vo.grade}</p>
             	<p><b>학번</b> : ${vo.studentNumber}</p>
             	<p><b>등록금 금액</b> : <fmt:formatNumber value="${vo.tuition}" pattern="#,##0.##" />원</p>
             	<p><b>대출신청 금액</b> : <fmt:formatNumber value="${vo.loanAmount}" pattern="#,##0.##" />원</p>
             	<p><b>이자율</b> : ${vo.interesRate}%</p>
             	<p><b>상환방식</b> : ${vo.repaymentMethod}</p>
             	<p><b>대출 상태</b> : ${vo.status}</p>
	          </c:forEach>
	        </div>
		    </c:if>
      </div>
    </div>
    
    <button type="button" class="btn btn-secondary mt-4 mb-4" onclick="location.href='${ctp}/';">돌아가기</button>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>