<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>GH Bank | 환율 계산기</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
    }
    .container {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 20px;
      margin-top: 30px;
    }
    h2 {
      color: #115C8B;
      border-bottom: 2px solid #115C8B;
      padding-bottom: 10px;
    }
    .table {
      margin-top: 20px;
    }
    th {
      background-color: #115C8B;
      color: white;
      text-align: center;
    }
    .btn-primary {
      background-color: #115C8B;
      border-color: #115C8B;
    }
    .btn-primary:hover {
      background-color: #0e4d75;
      border-color: #0e4d75;
    }
    #receiveResult {
      margin-top: 20px;
    }
    .alert-success {
  background-color: #e6f3f8;
  border-color: #b3d7e6;
  color: #115C8B;
}

.alert-danger {
  background-color: #f8d7da;
  border-color: #f5c6cb;
  color: #721c24;
}

.result-amount {
  font-size: 1.2em;
  font-weight: bold;
  color: #115C8B;
}

.decimal-point {
  color: #4a90e2;
}

#receiveResult {
  margin-top: 20px;
  padding: 15px;
  border-radius: 5px;
}

#receiveResult p {
  margin-bottom: 0;
}
  </style>
  <script>
  'use strict';

  $(function(){
	    if('${searchdate}' != '') $("#searchdate").val('${searchdate}');
  });
  // 날짜 새롭게 반영(적용)하기
	  function searchdateCheck() {
		  let searchdate = $("#searchdate").val();
		  location.href = "exchangeRate?searchdate="+searchdate;
	  }
  		
  // 송금액 입력후 엔터키누르면 환율계산으로 바로가기
  $(function(){
	    $('#send_amount').keypress(function (e) {
	      if (e.which === 13) {
	        getSendAmount();
	      }
	    });
  });
  
  // 수취 국가 변경할때마다 새로운 환율 구해오기
  function getExchangeRates(){
  	let searchdate = $("#searchdate").val();
    let receiveCountry = $('#receiveCountry').val();
    let receiveCountryText = $("#receiveCountry option:checked").text();
    if(receiveCountry == ""){
      $('#exchangeRate').text("");
      return;
    }
    $.ajax({
      url : "${ctp}/exchangeRate/exchangeRate?receiveCountry=" + receiveCountry + "&searchdate=" + searchdate,
      type : "post",
      success : function(res){
      	console.log(res);
      	let resArr = res.split("@");
      	let jsObj = JSON.parse(resArr[0]);
      	console.log(jsObj);
      	
      	if(res != "") {
	        	let str = '<option value="">선택</option>';
	        	for(let i=0; i<jsObj.length; i++) {
		        	str += '<option value='+jsObj[i].cur_unit+'>'+jsObj[i].cur_nm+'('+jsObj[i].cur_unit+')</option>';
		        }
	        	str += '<option value='+receiveCountry+' selected>'+receiveCountryText+'</option>';
	        	//let temp = receiveCountry.indexOf("(100)") == -1 ? "1" : "100";
	        	$('#receiveCountry').html(str);
	          //$('#exchangeRate').text(resArr[1] + " KRW(원) / " + temp + " " + receiveCountry);
	          $('#exchangeRate').text(resArr[1] + " KRW(원) / " + receiveCountry);
	          $('#searchdate').val(searchdate);
	        }
      },
      error : function(err){
        if(err.status === 400){
            alert("잘못 입력된 값 입니다.")
        }else if(err.status === 500){
            alert("서버에 문제가 발생했습니다.")
        }
      }
    })
  }
  
  // 전체 체크함수(송금액이 0미만이거나 5000000원 초과는 송금할수 없다. 물론 공백 금지이다.)
  function validCheck() {
    let amount = $('#send_amount').val();
    let receivingCountry = $('#receiveCountry').val();
    return (amount.length <= 0 || amount < 0 || amount > 5000000 || receivingCountry == "");
  }

	//최신 환율에 따른 송금액 구하기
  function getSendAmount() {
    let searchdate = $("#searchdate").val();
    let receivingCountry = $('#receiveCountry').val();
    let sendAmount = $('#send_amount').val();
    if (validCheck()) {
      $('#receiveResult').html("<div class=\"alert alert-danger\"><p>수취국가를 선택하고 송금액을 입력해주세요.<br/>송금액은 0 ~ 5,000,000 사이의 수를 입력하세요</p></div>");
      return;
    }
    let query = {
      "searchdate": searchdate,
      "receiveCountry": receivingCountry,
      "sendAmount": sendAmount
    }
    
    $.ajax({
      url: "${ctp}/exchangeRate/exchangeRateCompute",
      type: "POST",
      data: query,
      success: function(res) {
        let temps = res.split(".");
        let temp = "<span class='result-amount'>" + numberWithCommas(temps[0]) + "<span class='decimal-point'>.</span>" + temps[1].substring(0,4) + "</span>";
        let str = '<div class="alert alert-success"><p>수취금액은 ' + temp + ' ' + receivingCountry + ' 입니다.</p></div>';
        $('#receiveResult').html(str);
      },
      error: function(err) {
        if (err.status === 400) {
          showError("잘못 입력된 값입니다.");
        } else if (err.status === 500) {
          showError("서버에 문제가 발생했습니다.");
        }
      }
    });
  }

  function showError(message) {
    $('#receiveResult').html("<div class=\"alert alert-danger\"><p>" + message + "</p></div>");
  }
  
	  // 천단위마다 쉼표처리
  function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }
  </script>
</head>
<body>
<div class="container">
  <div class="col-md-8 mx-auto">
    <h2>환율 계산기</h2>
    <div><b>0 ~ 5,000,000 원</b> 까지 송금가능합니다.</div>
    <hr/>
    <table class="table table-bordered">
      <tr>
        <th class="text-center">환율적용날짜</th>
        <td>
          <input type="date" name="searchdate" id="searchdate" class="form-control d-inline-block w-auto" value="<%=java.time.LocalDate.now() %>" />
          <input type="button" value="적용" onclick="searchdateCheck()" class="btn btn-secondary btn-sm" />
          <a href="https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=5wwuTWVo28tdVcpsD2HidBhEH5PS6b1f&searchdate=2024-07-22&data=AP01" target="_blank" class="btn btn-sm btn-darklight" title="임시체크하기">¤</a>
        </td>
      </tr>
      <tr>
        <th><label>송금 국가</label></th>
        <td><span>대한민국(KRW)</span></td>
      </tr>
      <tr>
        <th><label>수취 국가</label></th>
        <td>
          <select name="receiveCountry" class="form-control w-auto" id="receiveCountry" onchange="getExchangeRates()">
            <option selected value="">국가 선택</option>
            <c:forEach var="vo" items="${unitVos}" varStatus="st">
              <option value="${vo.cur_unit}">${vo.cur_nm}(${vo.cur_unit})</option>
            </c:forEach>
          </select>
        </td>
      </tr>
      <tr>
        <th><label>환율</label></th>
        <td><span id="exchangeRate"></span></td>
      </tr>
      <tr>
        <th><label>송금액</label></th>
        <td><input type="number" id="send_amount" value="100000" class="form-control w-auto d-inline-block"> KRW(원)</td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <button type="button" class="btn btn-primary" onclick="getSendAmount()">환율 계산</button>
        </td>
      </tr>
    </table>
    <div id="receiveResult" class="col"></div>
    <c:if test="${empty unitVos}">
      <div id="receiveResult" class="col alert alert-warning">
        <b>오늘날짜(지정날짜)의 환율이 반영되지 않았습니다.<br/>잠시후에 다시 조회해 주세요.</b>
      </div>
    </c:if>
  </div>
</div>
</body>
</html>