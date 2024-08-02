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
  	
  	function loanCheck() {
		let mid = $("#mid").val().trim();
		let name = $("#name").val().trim();
		let birth = $("#birth").val().trim();
		let tel = $("#tel").val();
		let email = $("#email").val();
		
		if(mid == "") {
			alert("아이디를 입력하세요.");
			$("#mid").focus();
			return false;
		}
		else if(name == "") {
			alert("이름을 입력하세요.");
			$("#name").focus();
			return false;
		}
		else if(birth == "") {
			alert("생년월일을 입력하세요.");
			$("#birth").focus();
			return false;
		}
		else if(tel == "") {
			alert("연락처를 입력하세요.");
			$("#tel").focus();
			return false;
		}
		else if(email == "") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return false;
		}
		
		$.ajax({
			url  : "${ctp}/loan/loanSignup",
			type : "post",
			data : {
				mid   : mid,
				name  : name,
				birth : birth,
				tel   : tel,
				email : email
			},
  		success:function(res) {
  			let loanSw = "";
  			if(res != "0") {
	  				if("${loanSw}" == "S") loanSw = "신용";
	  				else if("${loanSw}" == "H") loanSw = "학자금";
	  				else if("${loanSw}" == "J") loanSw = "자동차";
	  				else loanSw = "예/적금 담보";
  				alert("입력하신 정보 확인이 완료되었습니다.\n"+loanSw+"대출 신청 2단계로 넘어갑니다.");
  				if("${loanSw}" == "S") location.href="${ctp}/loan/loanSignCheck?loanSw=S";
  				else if("${loanSw}" == "H") location.href="${ctp}/loan/loanSignCheck?loanSw=H";
  				else if("${loanSw}" == "J") location.href="${ctp}/loan/loanSignCheck?loanSw=J";
  				else location.href="${ctp}/loan/loanSignCheck?loanSw=M";
  			}
  			else {
  				alert("입력하신 정보가 가입시 등록했던 정보와 일치하지 않습니다.\n개인정보 확인 후 다시 신청해주세요.");
	  			location.reload();
  			}
  		},
  		error : function() {
  			alert("전송오류!!")
  		}
  	});
	}
  	
  	function cancel() {
  		let ans = confirm("신청하시던 대출상품을 취소하시겠습니까?");
  		if(ans) location.href='${ctp}/';
  	}
  </script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="step-indicator">
    <div class="step active">1</div>
    <div class="step">2</div>
    <div class="step">3</div>
</div>
<div class="container">
  <form name="myform" method="post">
	  <table class="table table-bordered text-center">
      <tr>
        <td colspan="2">
          <h3>GH Bank
          	<c:if test="${loanSw == 'S'}">신용</c:if>
          	<c:if test="${loanSw == 'H'}">학자금</c:if>
          	<c:if test="${loanSw == 'J'}">자동차</c:if>
          	<c:if test="${loanSw == 'M'}">예/적금 담보</c:if>
          	대출 신청서
          	<span class="sub-title">_개인정보 입력</span>
         	</h3>
        </td>
      </tr>
      <tr>
        <th>본인 아이디</th>
          <td class="currency-input">
            <input type="text" name="mid" id="mid" class="form-control" />
	        </td>
	    </tr>
	    <tr>
        <th>이름</th>
	        <td class="currency-input">
            <input type="text" name="name" id="name" class="form-control" />
	        </td>
	    </tr>
	    <tr>
        <th>생년월일</th>
	        <td class="currency-input">
            <input type="date" name="birth" id="birth" value="<%=java.time.LocalDate.now() %>" class="form-control" />
	        </td>
	    </tr>
	    <tr>
        <th>연락처</th>
	        <td class="currency-input">
	          <input type="text" name="tel" id="tel" class="form-control"/>
	        </td>
	    </tr>
	    <tr>
        <th>이메일</th>
	        <td class="currency-input">
            <input type="text" name="email" id="email" class="form-control"/>
	        </td>
	    </tr>
	    <tr>
        <td colspan="2" class="text-center">
        	<input type="button" value="취소" onclick="cancel()" class="btn btn-secondary mr-2 button-left"/>
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
