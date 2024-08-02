<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 계좌이체</title>
  
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
  	#accountInputBtn {
	  	position: relative;
	  	left: 370px; /* 필요한 만큼 값을 조정하세요 */
		}
		h3 {
 			font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
  	}
	</style>
	<script>
		'use strict';
		
		$(function(){
			if('${param.accountFlag}'=='accountInput') $("#accountInputBtn").click();
			if('${accountNumberSearch}'=='OK') $("#accountNumberSearchBtn").click();			
		});
		
		function transferCheck() {
			let money = $("#money").val().trim();
			let content = $("#content").val().trim();
			let accountNumber = $("#accountNumber").val();
			if(accountNumber == "") {
				alert("이체할 계좌번호를 입력하세요");
				$("#accountNumber").focus();
			}
			else if(money == "") {
				alert("이체할 금액을 입력하세요");
				$("#money").focus();
			}
			else if(content == "") {
				alert("적요를 입력하세요");
				$("#content").focus();
			}
			else {
				let ans = confirm("입력하신 금액 "+money+"원을 이체하시겠습니까?");
				if(ans) myform.submit();
			}
		}
		
		$(document).ready(function() {
		    $('#accountRegisterBtn').click(function(e) {
		        e.preventDefault();
		        accountInputCheck();
		    });
		});

		function accountInputCheck() {
		    let youId = $("#youId").val().trim();
		    let faccountNumber = $("#faccountNumber").val().trim();
		    
		    if(youId == "") {
		        alert("등록할 아이디를 입력하세요.");
		        $("#youId").focus();
		    }
		    else if(faccountNumber == "") {
		        alert("등록할 계좌번호를 입력하세요.");
		        $("#faccountNumber").focus();
		    }
		    else {
		        // 모든 조건이 만족되면 모달을 수동으로 닫고 폼을 제출합니다.
		        $('#myModal2').modal('hide');
		        accountForm.submit();
		    }
		}
		
		// 즐겨찾기 등록한 계좌번호 삭제하기
		function accountDelete(idx) {
			let ans = confirm("선택하신 계좌번호를 삭제하시겠습니까?");
			if(ans) location.href = "accountDelete?idx="+idx;
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
          <h3>계좌이체</h3>
        </td>
      </tr>
      <tr>
        <th>거래자 성명</th>
        	<td class="currency-input">
        		<input type="text" name="name" id="name" value="${sName}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>현재잔액</th>
        	<td class="currency-input">
        		<input type="text" name="balance" id="balance" value="${balance}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>이체 할 계좌번호</th>
        	<td class="currency-input">
        	  <div class="input-group">
        			<input type="text" name="accountNumber2" id="accountNumber" value="${param.accountNumber}" class="form-control" autofocus required/>
        			<div class="input-group-append">
        			  <a href="#" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">즐겨찾기 계좌 조회</a>
        			</div>
        		</div>
      		</td>
      </tr>
      <tr>
        <th>이체할 금액</th>
        	<td class="currency-input">
        		<input type="number" name="money" id="money" class="form-control" /><span>원</span>
      		</td>
      </tr>
      <tr>
        <th>적요</th>
        	<td class="currency-input">
        		<input type="text" name="content" id="content" class="form-control" />
      		</td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="이전" onclick="location.href='${ctp}/';" class="btn btn-secondary mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
          <input type="button" value="다음" onclick="transferCheck()" class="btn btn-secondary mr-2"/>
          <input type="button" value="계좌등록" id="accountInputBtn" class="btn btn-secondary mr-2" data-toggle="modal" data-target="#myModal2"/>
          <input type="button" value="계좌조회" id="accountNumberSearchBtn" style="display:none;" data-toggle="modal" data-target="#myModal3"/>
        </td>
      </tr>
    </table>
    <br/>
    <input type="hidden" name="flagSw" value="E"/>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="myId" value="${sMid}"/>
  </form>
</div>
<p><br/></p>

  <!-- The Modal (즐겨찾기 계좌조회를 눌렀을 때 나오는 모달 폼) -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">즐겨찾기 계좌 목록</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <table class="table table-hover">
          	<tr class="text-center">
							<th>번호</th>
							<th>아이디</th>
							<th>계좌번호</th>
							<c:if test="${fn:length(vos) != 0}">
								<th>삭제</th>
							</c:if>
          	</tr>
          	
          	<c:if test="${fn:length(vos) != 0}">
	          	<c:forEach var="vo" items="${vos}" varStatus="st">
	          		<tr class="text-center">
	          			<td>${st.count}</td>
	          			<td>${vo.youId}</td>
	          			<td><a href="accountTransfer?youId=${vo.youId}&accountNumber=${vo.accountNumber}">${vo.accountNumber}</a></td>
	          			<c:if test="${fn:length(vos) != 0}">
	          				<td><a href="javascript:accountDelete(${vo.idx})"><i class="fa-solid fa-trash"></i></a></td>
	          			</c:if>
	          		</tr>
	          	</c:forEach>
          	</c:if>
          	
          	<c:if test="${fn:length(vos) == 0}">
          		<tr>
          			<td colspan="4" class="text-center">즐겨찾기 계좌가 없습니다.</td>
          		</tr>
          	</c:if>
          	
          	<tr><td colspan="4" class="m-0 p-0"></td></tr>
          </table>
        </div>
        
        <!-- Modal footer -->
        <!-- <div class="modal-footer"> -->
          <div class="row">
          	<div class="col text-left"><button type="button" class="btn btn-secondary m-3" data-dismiss="modal">Close</button></div>
            <div class="col text-right"><button type="button" onclick="location.href='accountTransfer?accountFlag=accountInput';" class="btn btn-secondary m-3" data-dismiss="modal">즐겨찾기계좌등록</button></div>
          </div>
        <!-- </div> -->
      </div>
    </div>
  </div>
  
  <!-- The Modal2 (계좌등록을 눌렀을 때 나오는 모달 폼 / 즐겨찾기 계좌조회 -> 즐겨찾기 계좌등록 눌렀을때도 같은 모달폼)-->
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <form name="accountForm" method="post" action="transferInput">
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">즐겨찾기 계좌 등록</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	          <table class="table table-hover">
	          	<tr>
								<th>아이디</th>
								<td><input type="text" name="youId" id="youId" class="form-control" placeholder="아이디 입력" required/></td>
							</tr>
							<tr>
								<th>계좌번호</th>
								<td><input type="text" name="accountNumber" id="faccountNumber" class="form-control" placeholder="계좌번호 입력" required/></td>
	          	</tr>
	          </table>
	        </div>
	        
	        <!-- Modal footer -->
	        <!-- <div class="modal-footer"> -->
	          <div class="row">
	          	<div class="col text-left"><button type="button" class="btn btn-secondary m-3" data-dismiss="modal">Close</button></div>
							<div class="col text-right"><button type="button" id="accountRegisterBtn" class="btn btn-secondary m-3">계좌등록</button></div>
	          </div>
	        <!-- </div> -->
	        <input type="hidden" name="myId" value="${sMid}"/>
	        <input type="hidden" name="flagSw" value="E"/>
	        <input type="hidden" name="accountFlag"/>
	        <input type="hidden" name="accountInput"/>
        </form>
      </div>
    </div>
  </div>
  
  <!-- The Modal3 (계좌이체에서 다음을 눌렀을때 나오는 모달 폼) -->
  <div class="modal fade" id="myModal3">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <form name="transferForm" method="post" action="AccountTransferOk.acc">
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title">계좌 이체정보 확인</h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	          <table class="table table-hover">
	          	<tr>
								<th>아이디</th>
								<td><input type="text" name="youId" value="${vo.mid}" class="form-control" readonly /></td>
							</tr>
							<tr>
								<th>계좌번호</th>
								<td><input type="text" name="accountNumber" value="${vo.accountNumber}" class="form-control" readonly /></td>
	          	</tr>
							<tr>
								<th>이체할 금액</th>
								<td><input type="text" name="money" value="${money}" class="form-control" readonly /></td>
	          	</tr>
							<tr>
								<th>적요</th>
								<td><input type="text" name="content" value="${content}" class="form-control" readonly /></td>
	          	</tr>
	          </table>
	        </div>
	        
	        <!-- Modal footer -->
	        <!-- <div class="modal-footer"> -->
	          <div class="row">
	            <div class="col text-left"><button type="button" onclick="accountTransferOk()" class="btn btn-secondary m-3" data-dismiss="modal">계좌이체</button></div>
	          	<div class="col text-right"><button type="button" class="btn btn-secondary m-3" data-dismiss="modal">Close</button></div>
	          </div>
	        <!-- </div> -->
	        <input type="hidden" name="myId" value="${sMid}"/>
	        <input type="hidden" name="youId" value="${vo.mid}"/>
	        <input type="hidden" name="youName" value="${vo.name}"/>
	        <input type="hidden" name="flagSw" value="E"/>
	        <input type="hidden" name="accountFlag"/>
	        <input type="hidden" name="accountInput"/>
        </form>
      </div>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>