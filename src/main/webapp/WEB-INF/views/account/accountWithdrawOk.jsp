<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 거래확인명세서</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
	<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
	<style>
		body {
        margin: 0;
        padding: 0;
    }
   	.container {
        position: relative; /* 자식의 absolute 위치 기준 */
        padding: 20px; /* div 안쪽에 여백 추가 */
    }
  	h3 {
	    border: 2px solid black; /* 테두리 스타일, 두께, 색상 설정 */
	    padding: 10px; /* 텍스트와 테두리 사이 여백 설정 */
	    display: inline-block; /* h3 요소가 블록 요소처럼 동작하도록 설정 */
	    text-align: center; /* 가운데 정렬 */
  	}
</style>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post">
   	<table class="table table-bordered text-center">
 			<tr>
 				<td colspan="2">
					<h3>출금 거래 확인 명세서</h3>
				</td>
 			</tr>
      <tr>
        <th>거래자 성명</th>
        	<td class="currency-input">
        		<input type="text" name="name" id="name" value="${sName}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>출금한 금액</th>
        	<td class="currency-input">
        		<input type="text" name="name" id="name" value="${vo.money}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>현재 잔액</th>
        	<td class="currency-input">
        		<input type="text" name="name" id="name" value="${vo.balance}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>적요</th>
        	<td class="currency-input">
        		<input type="text" name="name" id="name" value="${vo.content}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
 				<td colspan="2">
 					<button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">홈으로</button>
				</td>
 			</tr>
    </table>
  </form>
      
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>