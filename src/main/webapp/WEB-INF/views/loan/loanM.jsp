<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 예/적금 담보대출</title>
  
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
    		let ans = confirm("예/적금 담보대출 신청을 취소하시겠습니까?");
				if(ans) location.href="${ctp}/";
    	}
    	
    	// 금액 입력과 동시에 3자리마다 콤마찍기
    	function formatCurrency(input) {
			  // 숫자와 쉼표를 제외한 모든 문자 제거
			  let value = input.value.replace(/[^\d,]/g, '');
			  
			  // 쉼표 제거
			  value = value.replace(/,/g, '');
			  
			  // 3자리마다 쉼표 추가
			  value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			  
			  // 입력 필드에 포맷된 값 설정
			  input.value = value;
			}
    	
    	// 대출신청목적 기타 입력란
    	function loanContentChange() {
        var loanContentSelect = document.getElementById("loanContent");
        var otherLoanContent = document.getElementById("otherLoanContent");
        if (loanContentSelect.value === "기타(목적)") {
        		otherLoanContent.style.display = "block";
        		otherLoanContent.focus();
            $("#otherLoanContent").focus();
        } else {
            otherLoanContent.style.display = "none";
        }
      }
    	
    	function loanCheck() {
      		let savingName = $("#savingName").val().trim();
	    		let savingAccount = $("#savingAccount").val();
	    		let StartDateY = $("#StartDateY").val().trim();
	    		let StartDateM = $("#StartDateM").val().trim();
	    		let StartDateD = $("#StartDateD").val().trim();
	    		let savingPeriod = $("#savingPeriod").val().trim();
	    		let expiryDateY = $("#expiryDateY").val();
	    		let expiryDateM = $("#expiryDateM").val();
	    		let expiryDateD = $("#expiryDateD").val();
	    		let loanAmount = $("#loanAmount").val().replaceAll(",","");
	    		let loanPeriod = $("#loanPeriod").val();
	    		let loanContent = $("#loanContent").val();
	    		let otherLoanContent = $("#otherLoanContent").val();
      		
	    		if(savingName == "") {
	    			alert("가입한 예/적금 상품을 선택하세요.");
	    			$("#savingName").focus();
	    			return false;
	    		}
	    		else if(savingAccount == "") {
	    			alert("예/적금 계좌번호를 입력하세요.");
	    			$("#savingAccount").focus();
	    			return false;
	    		}
	    		else if(StartDateY == "") {
	    			alert("예/적금 가입일을 입력하세요.");
	    			$("#StartDateY").focus();
	    			return false;
	    		}
	    		else if(StartDateM == "") {
	    			alert("예/적금 가입일을 입력하세요.");
	    			$("#StartDateM").focus();
	    			return false;
	    		}
	    		else if(StartDateD == "") {
	    			alert("예/적금 가입일을 입력하세요.");
	    			$("#StartDateD").focus();
	    			return false;
	    		}
	    		else if(savingPeriod == "") {
	    			alert("예/적금 가입기간을 입력하세요.");
	    			$("#savingPeriod").focus();
	    			return false;
	    		}
	    		else if(expiryDateY == "") {
	    			alert("예/적금 만기일을 입력하세요.");
	    			$("#expiryDateY").focus();
	    			return false;
	    		}
	    		else if(expiryDateM == "") {
	    			alert("예/적금 만기일을 입력하세요.");
	    			$("#expiryDateM").focus();
	    			return false;
	    		}
	    		else if(expiryDateD == "") {
	    			alert("예/적금 만기일을 입력하세요.");
	    			$("#expiryDateD").focus();
	    			return false;
	    		}
	    		else if(loanAmount == "") {
	    			alert("대출신청금액을 입력하세요.");
	    			$("#loanAmount").focus();
	    			return false;
	    		}
	    		else if(loanPeriod == "") {
	    			alert("대출기간 입력하세요.");
	    			$("#loanPeriod").focus();
	    			return false;
	    		}
	    		else if(loanContent == "") {
	    			alert("대출신청목적을 입력하세요.");
	    			$("#loanContent").focus();
	    			return false;
	    		}
	    		else if(loanContent == "기타(목적)") {
	    			if(otherLoanContent == "") {
	    				alert("대출신청목적을 입력하세요.");
	    				$("#otherLoanContent").focus();
	    				return false;
	    			}
	    		}
      		
    			let ans = confirm("예/적금 담보대출 신청서를 제출하시겠습니까?");
    			$("#loanAmount").val(loanAmount);
    			
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
	<form name="myform" method="post" action="loanM">
	  <table class="table table-bordered text-center">
	    <tr>
       <td colspan="2">
          <h3>GH Bank 예/적금 담보대출 신청서 <span class="sub-title">_대출 신청 정보 입력</span></h3>
       </td>
	    </tr>
      <tr>
        <th style="vertical-align: middle;">예금/적금 상품명</th>
        <td class="currency-input">
          <select class="form-control" id="savingName" name="savingName" onchange="toggleOtherField()">
            <option value="">- 예금/적금 상품명을 선택해주세요 -</option>
            <option value="Smart 정기예금">Smart 정기예금</option>
            <option value="Hello GH, 반가워 적금">Hello GH, 반가워 적금</option>
          </select>
        </td>
      </tr>
      <tr>
	      <th style="vertical-align: middle;">예금/적금 계좌번호<br/>('-' 넣어서 작성)</th>
	      <td class="currency-input">
          <input type="text" name="savingAccount" id="savingAccount" class="form-control" />
	      </td>
      </tr>
      <tr>
	      <th style="vertical-align: middle;">예금/적금 가입일</th>
	      <td class="currency-input">
	      	<div class="input-group">
        		<input type="number" name="StartDateY" id="StartDateY" class="form-control" min="1"><span class="input-group-text">년</span>
          	<input type="number" name="StartDateM" id="StartDateM" class="form-control ml-3" max="12" min="1"><span class="input-group-text">월</span>
          	<input type="number" name="StartDateD" id="StartDateD" class="form-control ml-3" max="31" min="1"><span class="input-group-text">일</span>
        	</div>
        </td>
      </tr>
      <tr>
	      <th style="vertical-align: middle;">가입기간</th>
	      <td class="currency-input">
          <input type="text" name="savingPeriod" id="savingPeriod" class="form-control" />
	      </td>
      </tr>
      <tr>
        <th style="vertical-align: middle;">예금/적금 만기일</th>
        <td class="currency-input">
        	<div class="input-group">
        		<input type="number" name="expiryDateY" id="expiryDateY" class="form-control" min="1"><span class="input-group-text">년</span>
          	<input type="number" name="expiryDateM" id="expiryDateM" class="form-control ml-3" max="12" min="1"><span class="input-group-text">월</span>
          	<input type="number" name="expiryDateD" id="expiryDateD" class="form-control ml-3" max="31" min="1"><span class="input-group-text">일</span>
        	</div>
        </td>
      </tr>
      <tr>
	      <th style="vertical-align: middle;">대출 신청 금액<br/>(100만원 단위로 신청)</th>
	      <td class="currency-input">
	        <input type="text" name="loanAmount" id="loanAmount" class="form-control" oninput="formatCurrency(this)" />
	      </td>
	    </tr>
			<tr>
	      <th style="vertical-align: middle;">대출 기간(1년단위)</th>
	      <td class="currency-input">
	     		<div class="input-group">
	          <input type="number" name="loanPeriod" id="loanPeriod" class="form-control"><span class="input-group-text">년</span>
	      	</div>
	      </td>
	    </tr>
      <tr>
     		<th style="vertical-align: middle;">대출신청 목적</th>
	      	<td class="currency-input">
		        <select class="form-control" id="loanContent" name="loanContent" onchange="loanContentChange()">
		          <option value="">- 대출신청 목적을 선택해주세요 -</option>
		          <option value="개인 대출">개인 대출</option>
		          <option value="주택 자금">주택 자금</option>
		          <option value="교육 자금">교육 자금</option>
		          <option value="사업 자금">사업 자금</option>
		          <option value="차량 구입">차량 구입</option>
		          <option value="기타(목적)">기타</option>
		        </select>
	        	<input type="text" id="otherLoanContent" name="otherLoanContent" class="form-control mt-2" placeholder="기타 대출 목적을 입력하세요" style="display:none;">
	     		</td>
   		</tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="취소" onclick="cancel()" class="btn btn-secondary mr-2 text-left"/>
          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
          <input type="button" value="다음" onclick="loanCheck()" class="btn btn-secondary mr-2"/>
      
      		<input type="hidden" name="mid" value="${sMid}"/>
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