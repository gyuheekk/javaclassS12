<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 입금</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
	<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
	<style>
		body {
      margin: 0;
      padding: 0;
    }
   	.form-control {
      display: inline-block;
  	}
  	.currency-input {
      display: flex;
      align-items: center;
  	}
  	.currency-input span {
    	margin-left: 10px; /* 텍스트 박스와 "원" 사이의 간격 */
  	}
  	h3 {
 			font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
	   	color: #003366;
  	}
  	
	</style>
	<script>
		'use strict';
		
		function depositCheck() {
			let money = $("#money").val().trim();
			let content = $("#content").val().trim();
			if(money == "") {
				alert("입금할 금액을 입력하세요");
				$("#money").focus();
			}
			else if(content == "") {
				alert("적요를 입력하세요");
				$("#content").focus();
			}
			else {
				let ans = confirm("입력하신 금액 "+money+"원을 입금하시겠습니까?");
				if(ans) myform.submit();
			}
		}
		
	</script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="container">
	<div class="a">
	  <form name="myform" method="post">
	    <table class="table table-bordered text-center">
	      <tr>
	        <td colspan="2">
	          <h3>입금</h3>
	        </td>
	      </tr>
	      <tr>
	        <th>거래자 성명</th>
	        	<td class="currency-input">
	        		<input type="text" name="name" id="name" value="${sName}" class="form-control" readonly />
	      		</td>
	      </tr>
	      <tr>
	        <th>입금할 금액</th>
	        	<td class="currency-input">
	        		<input type="number" name="money" id="money" class="form-control" autofocus required/><span>원</span>
	      		</td>
	      </tr>
	      <tr>
	        <th>적요</th>
	        	<td class="currency-input">
	        		<input type="text" name="content" id="content" class="form-control" autofocus required/>
	      		</td>
	      </tr>
	      <tr>
	        <td colspan="2" class="text-center">
	          <input type="button" value="이전" onclick="location.href='${ctp}/';" class="btn btn-secondary mr-2"/>
	          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
	          <input type="button" value="다음" onclick="depositCheck()" class="btn btn-secondary mr-2"/>
	        </td>
	      </tr>
	    </table>
	    <br/>
	    <input type="hidden" name="mid" value="${sMid}"/>
	    <input type="hidden" name="flagSw" value="I"/>
	  </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>