<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 거래내역조회</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
	<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<style>
		h3 {
    	border: 2px solid black; /* 테두리 스타일, 두께, 색상 설정 */
    	padding: 10px; /* 텍스트와 테두리 사이 여백 설정 */
    	display: inline-block; /* h2 요소가 블록 요소처럼 동작하도록 설정 */
    	font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
  	}
	 	.currency-input {
	    gap: 20px;
	    align-items: center;
	 	}
	 	.form-check-label {
	    margin-right: 10px;
	 	}
 		.currency-input label {
    	margin-right: 40px; /* 라벨 간의 간격 조정 */
 		}
	  .table-title {
      margin-bottom: 20px;
      text-align: center;
    }
</style>
<script>
	'use strict';
	
	function hisShow() {
		let flagSw = $("#flagSw").val();
		
		function formatNumber(number) {
		    return new Intl.NumberFormat('ko-KR', { 
		        minimumFractionDigits: 0, 
		        maximumFractionDigits: 2 
		    }).format(number);
		}
		
		$.ajax({
			url  : "${ctp}/account/accountView",
			type : "post",
			data : {mid : '${sMid}',
							flagSw : flagSw},
			success:function(res) {
				let strFlagSw = res.strFlagSw;
				let vos = res.vos2;
				
				let str = "<table class='table table-bordered table-hover text-center'>";
			 	str += "<h4 class='table-title mb-3'>" + strFlagSw + "내역서</h4>";
			 	
			 	if(vos && vos.length > 0) {
		  		str += "<tr style='background-color: lightgray;'>";
		  		str += "<th>번호</th><th>거래날짜</th><th>거래액</th><th>적요</th>";
		  		str += "</tr>";
			 		
		  		vos.forEach(function(item, index) {
		        str += "<tr>";
		        str += "<td>" + (index + 1) + "</td>";
		        
		        let accDateSubstring = item.accDate.substring(0, 10);
	          str += "<td>" + accDateSubstring + "</td>";
		        
	          str += "<td>" + formatNumber(item.money) + "원</td>";
		        str += "<td>" + item.content + "</td>";
		        str += "</tr>";
	        });
			 	}
			 	else {
			 		str += "<h6 class='text-center'>조회하신 거래내역이 없습니다 <i class='fa-solid fa-face-sad-tear'></i></h6>";
			 	}
	  		str += "</table>";
				$("#historyDemo").html(str);
			},
			error : function() {
				alert("전송실패");
			}
		});
	}
	
</script>
<style>
  #historyDemo {
    width: 1110px;
    height: 600px;
    overflow:auto;
  }
  p {
  	font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
  }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav3.jsp" />
<%@ include file="/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="container">
	<form name="searchForm" method="post" action="AccountHistoryShow.acc">
	  <h3>거래내역조회</h3>
		<table class="table table-bordered text-center">
			<tr>
	      <th>거래자 성명</th>
	       	<td class="currency-input">
	       		<input type="text" name="name" id="name" value="${vo.name}" class="form-control" readonly />
	     		</td>
	    </tr>
			<tr>
	      <th>조회 계좌번호</th>
	       	<td class="currency-input">
	       		<input type="text" name="accountNumber" id="accountNumber" value="${vo.accountNumber}" class="form-control" readonly />
	     		</td>
	    </tr>
			<tr>
	      <th>조회 내역</th>
	       	<td class="currency-input">
	       		<div class="input-group">
	       			<select class="form-control" id="flagSw" name="flagSw">
			        	<option value="" selected>전체</option>
		       			<option value="I">입금</option>
			        	<option value="C">출금</option>
			        	<option value="E">계좌이체</option>
	       			</select>
	       			<div class="input-group-append">
	          		<input type="button" onclick="hisShow()" value="조회" class="btn btn-secondary">
	        		</div>
	        	</div>
	     		</td>
	    	</tr>
		</table>
		<p class="text-right">
			<i class="fa-solid fa-magnifying-glass icon-spacing mr-1"></i>조회할 내역을 선택하신 후, 조회 버튼을 눌러주세요.
		</p>
	</form>
	<section id="historyDemo"></section>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>