<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 카드신청</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
	<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
	<style>
	 	body {
    	margin: 0;
      padding: 0;
    }
    h3 {
	    font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
    } 
	</style>
	<script>
	
		function cardCheck() {
			let cardContent = $("#cardContent").val();
			let cardSw = $("#cardSw").val();
			if(cardContent == "") {
				alert("카드 발급 목적을 입력하세요");
				$("#cardContent").focus();
			}
			
			if(cardSw == "S") cardSw = "신용카드";
			else if(cardSw == "C") cardSw = "체크카드";
			else cardSw = "학생카드";
			
			let ans = confirm("선택하신 "+cardSw+"를 신청하시겠습니까?");
			if(!ans) return false;
			
			let nowDate = new Date();
			let startDate = new Date('${vo.startDate}');
			let Date_diff = (nowDate.getTime() - startDate.getTime()) / (1000*60*60*24);
			let birth_diff = nowDate.getFullYear() - '${vo.birth}'.substring(0,4);
			
			if(cardSw != "체크카드") {
				if(cardSw == "신용카드" && Date_diff < 90) {
						alert("가입일이 3개월 이상된 회원만 신용카드 발급이 가능합니다.");
						return false;
				}
		    else if(cardSw == "학생카드" && birth_diff > 19) {
						alert("19세 이하만 카드발급 가능합니다.");
						return false;
				}
			}
		  myform.submit();
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
          <h3>GH Bank
          	<c:if test="${flagSw == 'S'}">신용</c:if>
          	<c:if test="${flagSw == 'C'}">체크</c:if>
          	<c:if test="${flagSw == 'H'}">학생</c:if>
          	카드신청</h3>
        </td>
      </tr>
      <tr>
        <th>거래자 아이디</th>
        	<td class="currency-input">
        		<input type="text" name="mid" id="mid" value="${sMid}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>본인 계좌번호</th>
        	<td class="currency-input">
        		<input type="text" name="accountNumber" id="accountNumber" value="${vo.accountNumber}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>신청할 카드</th>
        	<td class="currency-input">
        		<select class="form-control" id="cardSw" name="cardSw">
	       			<option value="S" <c:if test="${flagSw == 'S'}">selected</c:if>>신용카드</option>
		        	<option value="C" <c:if test="${flagSw == 'C'}">selected</c:if>>체크카드</option>
		        	<option value="H" <c:if test="${flagSw == 'H'}">selected</c:if>>학생카드</option>
       			</select>
      		</td>
      </tr>
      <tr>
        <th>카드 발급 목적</th>
        	<td class="currency-input">
        		<input type="text" name="cardContent" id="cardContent" class="form-control" autofocus required/>
      		</td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="이전" onclick="location.href='${ctp}/card/cardProduct';" class="btn btn-secondary mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
          <input type="button" value="다음" onclick="cardCheck()" class="btn btn-secondary mr-2"/>
       
       		<input type="hidden" name="cardExpiryDate" />
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