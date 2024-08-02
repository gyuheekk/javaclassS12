<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 자동차대출</title>
  
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
		    .sub-title {
				  font-size: 0.7em;  /* 메인 제목의 70% 크기 */
				  color: #7f8c8d;  /* 조금 더 연한 색상 */
				  font-weight: normal;  /* 글씨 두께를 보통으로 */
				}
    </style>
    <script>
    	'use strict';
    	
    	function cancel() {
    		let ans = confirm("자동차대출 신청을 취소하시겠습니까?");
				if(ans) location.href="${ctp}/";
    	}
    	
    	function toggleOtherField() {
            var loanContent = document.getElementById("loanContent");
            var otherLoanContent = document.getElementById("otherLoanContent");
            if (loanContent.value === "O") {
                otherLoanContent.style.display = "block";
                $("#otherLoanContent").focus();
            } else {
                otherLoanContent.style.display = "none";
            }
        }
    	
      	function loanS2() {
    			let ans = confirm("자동차대출 신청서를 제출하시겠습니까?");
    			if(ans) myform.submit();
    		}
    </script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="step-indicator">
    <div class="step active">1</div>
    <div class="step active">2</div>
    <div class="step">3</div>
</div>
<div class="container">
    <form name="myform" method="post" action="loanS3">
        <table class="table table-bordered text-center">
            <tr>
                <td colspan="2">
                    <h3>GH Bank 자동차대출 신청서 <span class="sub-title">_대출 신청 정보 입력</span></h3>
                </td>
            </tr>
            <tr>
                <th>자동차 종류</th>
                <td class="currency-input">
                    <input type="text" name="carKind" id="carKind" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>자동차 제조사</th>
                <td class="currency-input">
                    <input type="text" name="carManufacturer" id=""carManufacturer"" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>자동차 모델명</th>
                <td class="currency-input">
                    <input type="text" name="carModel" id="carModel" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>차량 등록 번호</th>
                <td class="currency-input">
                    <input type="text" name="carNumber" id="carNumber" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>월 소득</th>
                <td class="currency-input">
                    <input type="text" name="monthlyIncome" id="monthlyIncome" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>대출 신청 금액</th>
                <td class="currency-input">
                    <input type="text" name="loanAmount" id="loanAmount" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>대출 기간</th>
                <td class="currency-input">
                    <input type="text" name="loanPeriod" id="loanPeriod" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>대출신청 목적</th>
                <td class="currency-input">
                    <select class="form-control" id="loanContent" name="loanContent" onchange="toggleOtherField()">
                        <option value="">- 대출신청 목적을 선택해주세요 -</option>
                        <option value="P">개인 대출</option>
                        <option value="H">주택 자금</option>
                        <option value="E">교육 자금</option>
                        <option value="B">사업 자금</option>
                        <option value="M">차량 구입</option>
                        <option value="O">기타</option>
                    </select>
                    <input type="text" id="otherLoanContent" name="otherLoanContent" class="form-control mt-2" placeholder="기타 대출 목적을 입력하세요" style="display:none;">
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-center">
                    <input type="button" value="취소" onclick="cancel()" class="btn btn-secondary mr-2"/>
                    <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
                    <input type="button" value="다음" onclick="loanS2()" class="btn btn-secondary mr-2"/>
                </td>
            </tr>
        </table>
        <br/>
    </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>