<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 예/적금신청</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
	<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
	<style>
	 	body {
    	margin: 0;
      padding: 0;
    }
    .currency-input {
      display: flex;
      align-items: center;
  	}
    .currency-input span {
    	margin-left: 10px; /* 텍스트 박스와 "원" 사이의 간격 */
  	}
  	h3, p {
 			font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
  	}
	</style>
	<script>
	function fCheck() {
		  const productSelect = document.getElementById('savingSw');
		  const depositAmount = document.getElementById('amount');
		  const periodSelect = document.getElementById('paymentPeriod');
		  
		  if(productSelect.value === "") {
		    alert("상품을 선택해주세요.");
		    productSelect.focus();
		    return false;
		  }
		  else if(depositAmount.value.trim() === "") {
		    alert("예치금액을 입력해주세요.");
		    depositAmount.focus();
		    return false;
		  }
		  else if(periodSelect.value === "") {
		    alert("가입기간을 선택해주세요.");
		    periodSelect.focus();
		    return false;
		  }
		  
		  // 폼 제출 직전에 disabled속성을 제거한다.
		  productSelect.disabled = false;

		  // 모든 검증을 통과하면 폼 제출
		  document.myform.submit();
		}

		// 기존의 updatePeriodOptions 함수 수정
		function updatePeriodOptions() {
		  const productSelect = document.getElementById('savingSw');
		  const periodSelect = document.getElementById('paymentPeriod');
		  
		  // 기존 옵션 제거
		  periodSelect.innerHTML = '<option value="">- 가입기간을 선택해주세요. -</option>';
		  
		  if (productSelect.value === 'Y') {
		    const options = [
		      {value: '6', text: '6개월'},
		      {value: '12', text: '12개월'},
		      {value: '24', text: '24개월'}
		    ];
		    options.forEach(option => {
		      const newOption = new Option(option.text, option.value);
		      periodSelect.add(newOption);
		    });
		    periodSelect.disabled = false;
		  } else if (productSelect.value === 'J') {
		    const options = [
		      {value: '12', text: '12개월'},
		      {value: '24', text: '24개월'},
		      {value: '36', text: '36개월'}
		    ];
		    options.forEach(option => {
		      const newOption = new Option(option.text, option.value);
		      periodSelect.add(newOption);
		    });
		    periodSelect.disabled = false;
		  } else {
		    // 상품이 선택되지 않았을 때
		    periodSelect.disabled = true;
		  }
		}

		// 페이지 로드 시 초기화 (이전과 동일)
		window.onload = function() {
		  const productSelect = document.getElementById('savingSw');
		  const periodSelect = document.getElementById('paymentPeriod');
		  
		  //periodSelect.disabled = true;
		  savingSw.disabled = true;
		  productSelect.focus();
		};

		// 상품 선택 변경 시 이벤트 (이전과 동일)
		document.getElementById('savingSw').addEventListener('change', function() {
		  updatePeriodOptions();
		});
		
		function balanceCheck() {
			let balance = $("#balance").val(); 
			let amount = $("#amount").val();
			if(Number(amount) > Number(balance)) {
				alert("현재 잔고가 부족합니다.");
				$("#balance").focus();
				return false;
			}
		}
	</script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="container">
	<form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2">
          <h3><c:if test="${flagSw == 'Y'}">정기예금</c:if> <c:if test="${flagSw == 'J'}">정기적금</c:if> 신청</h3>
          <p class="text-center">
						<i class="fa-solid fa-magnifying-glass icon-spacing mr-1"></i>가입할 상품을 선택하시면 가입 기간 확인이 가능합니다.
					</p>
        </td>
      </tr>
      <tr>
			  <th>신청하는 상품</th>
			  <td class="currency-input">
			    <select class="form-control" id="savingSw" name="savingSw" onchange="updatePeriodOptions()">
			      <option value="">- 신청하는 상품을 선택해주세요. -</option>
			      <option value="Y" <c:if test="${flagSw == 'Y'}">selected</c:if>>smart 정기예금</option>
			      <option value="J" <c:if test="${flagSw == 'J'}">selected</c:if>>GH 반가워적금</option>
			    </select>
			  </td>
			</tr>
      
      <!-- 예/적금신청 동일폼 -->
      <tr>
        <th>신청자 아이디</th>
        	<td class="currency-input">
        		<input type="text" name="mid" id="mid" value="${sMid}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>본인 계좌번호</th>
        	<td class="currency-input">
        		<input type="text" name="accountNumber" id="accountNumber" value="${vo.accountNumber}"  class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>현재 잔액</th>
        	<td class="currency-input">
        		<input type="text" name="balance" id="balance" value="${balance}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
			  <th>예치 금액<br/>
			  (적금의 경우, 한달 납입 금액 기재)</th>
			  <td class="currency-input">
			    <input type="number" name="amount" id="amount" class="form-control" onblur="balanceCheck()" /><span>원</span>
			  </td>
			</tr>
      
      <!-- 예/적금 다르게 처리 -->
      <tr>
			  <th>가입기간</th>
				  <td class="currency-input">
				    <select class="form-control" id="paymentPeriod" name="paymentPeriod">
				      <option value="">- 가입기간을 선택해주세요. -</option>
				      <c:forEach var="v" items="${productSelect}">
				        <option value="${v}">${v}개월</option>
				      </c:forEach>
				    </select>
				  </td>
			</tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="이전" onclick="location.href='${ctp}/';" class="btn btn-secondary mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
          <input type="button" value="신청" onclick="fCheck()" class="btn btn-secondary mr-2"/>
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