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
		    .sub-title {
				  font-size: 0.7em;  /* 메인 제목의 70% 크기 */
				  color: #7f8c8d;  /* 조금 더 연한 색상 */
				  font-weight: normal;  /* 글씨 두께를 보통으로 */
				}
    </style>
    <script>
    	'use strict';
    	
    	function cancel() {
    		let ans = confirm("신용대출 신청을 취소하시겠습니까?");
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
    	
    	// 직업 기타 입력란
			function jobContentChange() {
			    var jobContentSelect = document.getElementById("job");
			    var otherjobContent = document.getElementById("otherjobContent");
			    if (jobContentSelect.value === "기타(직업)") {
			        otherjobContent.style.display = "block";
			        otherjobContent.focus();
			    } else {
			        otherjobContent.style.display = "none";
			    }
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
      		let job = $("#job").val().trim();
	    		let otherjobContent = $("#otherjobContent").val();
	    		let company = $("#company").val().trim();
	    		let position = $("#position").val().trim();
	    		let workingPeriodY = $("#workingPeriodY").val();
	    		let workingPeriodM = $("#workingPeriodM").val();
	    		let monthlyIncome = $("#monthlyIncome").val().replaceAll(",","");
	    		let loanAmount = $("#loanAmount").val().replaceAll(",","");
	    		let loanPeriod = $("#loanPeriod").val();
	    		let loanContent = $("#loanContent").val();
	    		let otherLoanContent = $("#otherLoanContent").val();
      		
	    		if(job == "") {
	    			alert("직업을 선택하세요.");
	    			$("#job").focus();
	    			return false;
	    		}
	    		else if(job == "기타(직업)") {
	    			if(otherjobContent == "") {
	    				alert("직업을 입력하세요.");
	    				$("#otherjobContent").focus();
	    				return false;
	    			}
	    		}
	    		
	    		if(company == "") {
	    			alert("직장명을 입력하세요.");
	    			$("#company").focus();
	    			return false;
	    		}
	    		else if(position == "") {
	    			alert("직위를 입력하세요.");
	    			$("#position").focus();
	    			return false;
	    		}
	    		else if(workingPeriodM == "") {
	    			alert("근무기간을 입력하세요.");
	    			$("#workingPeriodM").focus();
	    			return false;
	    		}
	    		else if(monthlyIncome == "") {
	    			alert("월소득을 입력하세요.");
	    			$("#monthlyIncome").focus();
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
      		
    			let ans = confirm("신용대출 신청서를 제출하시겠습니까?");
    			$("#monthlyIncome").val(monthlyIncome);
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
  <form name="myform" method="post" action="loanS">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2">
          <h3>GH Bank 신용대출 신청서 <span class="sub-title">_대출 신청 정보 입력</span></h3>
        </td>
      </tr>
      <tr>
        <th style="vertical-align: middle;">직업</th>
        <td class="currency-input">
        	<select class="form-control" id="job" name="job" onchange="jobContentChange()">
            <option value="">- 직업을 선택해주세요 -</option>
            <option value="회사원">회사원</option>
            <option value="공무원">공무원</option>
            <option value="군인">군인</option>
            <option value="의사">의사</option>
            <option value="법조인">법조인</option>
            <option value="세무인">세무인</option>
            <option value="자영업">자영업</option>
            <option value="기타(직업)">기타</option>
          </select>
          <input type="text" id="otherjobContent" name="otherjobContent" class="form-control mt-2" placeholder="직업을 입력하세요" style="display:none;">
        </td>
      </tr>
      <tr>
        <th style="vertical-align: middle;">직장명</th>
        <td class="currency-input">
          <input type="text" name="company" id="company" class="form-control" />
        </td>
      </tr>
      <tr>
        <th style="vertical-align: middle;">직위</th>
        <td class="currency-input">
          <input type="text" name="position" id="position" class="form-control" />
        </td>
      </tr>
			<tr>
		    <th style="vertical-align: middle;">근무 기간</th>
		    <td class="currency-input">
	        <div class="input-group">
            <input type="number" name="workingPeriodY" id="workingPeriodY" class="form-control" min="1"><span class="input-group-text">년</span>
            <input type="number" name="workingPeriodM" id="workingPeriodM" class="form-control ml-3" max="12" min="1"><span class="input-group-text">개월</span>
	        </div>
		    </td>
			</tr>
      <tr>
			  <th style="vertical-align: middle;">월 소득</th>
			  <td class="currency-input">
			    <div class="input-group">
			      <input type="text" name="monthlyIncome" id="monthlyIncome" class="form-control" oninput="formatCurrency(this)">
			      <span class="input-group-text">원</span>
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
          <input type="button" value="취소" onclick="cancel()" class="btn btn-secondary mr-2"/>
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