<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 학자금대출</title>
  
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
    		let ans = confirm("학자금대출 신청을 취소하시겠습니까?");
				if(ans) location.href="${ctp}/";
    	}
    	
      	function loanCheck() {
      		let school = $("#school").val().trim();
	    		let major = $("#major").val();
	    		let grade = $("#grade").val().trim();
	    		let studentNumber = $("#studentNumber").val().trim();
	    		let tuition = $("#tuition").val();
	    		let loanAmount = $("#loanAmount").val();
	    		let loanPeriod = $("#loanPeriod").val();
      		
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		if(jobContent == "") {
	    			alert("직업을 선택하세요.");
	    			$("#jobContent").focus();
	    			return false;
	    		}
	    		
    			let ans = confirm("학자금대출 신청서를 제출하시겠습니까?");
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
                    <h3>GH Bank 학자금대출 신청서 <span class="sub-title">_대출 신청 정보 입력</span></h3>
                </td>
            </tr>
            <tr>
                <th>학교명</th>
                <td class="currency-input">
                    <input type="text" name="school" id="school" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>학과</th>
                <td class="currency-input">
                    <input type="text" name="major" id="major" class="form-control" />
                </td>
            </tr>
						<tr>
					    <th style="vertical-align: middle;">입학일</th>
					    <td class="currency-input">
				        <div class="input-group">
			            <input type="number" name="workingPeriodY" id="workingPeriodY" class="form-control"><span class="input-group-text">년</span>
			            <input type="number" name="workingPeriodM" id="workingPeriodM" class="form-control ml-3"><span class="input-group-text">월</span>
				        </div>
					    </td>
						</tr>
						<tr>
					    <th style="vertical-align: middle;">졸업예정일</th>
					    <td class="currency-input">
				        <div class="input-group">
			            <input type="number" name="workingPeriodY" id="workingPeriodY" class="form-control"><span class="input-group-text">년</span>
			            <input type="number" name="workingPeriodM" id="workingPeriodM" class="form-control ml-3"><span class="input-group-text">월</span>
				        </div>
					    </td>
						</tr>
            <tr>
              <th>학년</th>
              <td class="currency-input">
                <input type="number" name="grade" id="grade" class="form-control" max="4" min="1" />
              </td>
            </tr>
            <tr>
                <th>학번</th>
                <td class="currency-input">
                    <input type="text" name="studentNumber" id="studentNumber" class="form-control" />
                </td>
            </tr>
            <tr>
                <th>등록금 금액</th>
                <td class="currency-input">
                    <input type="text" name="tuition" id="tuition" class="form-control" />
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
                <td colspan="2" class="text-center">
                    <input type="button" value="취소" onclick="cancel()" class="btn btn-secondary mr-2"/>
                    <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
                    <input type="button" value="다음" onclick="loanCheck()" class="btn btn-secondary mr-2"/>
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