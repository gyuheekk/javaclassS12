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
	<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
	<style>
		body {
        margin: 0;
        padding: 0;
    }
  	h3 {
    	text-align: center; /* 가운데 정렬 */
	    font-family: "Noto Sans KR", sans-serif;
	   	font-optical-sizing: auto;
	   	font-weight: <weight>;
	   	font-style: normal;
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
					<h3>계좌이체 거래 확인 명세서</h3>
				</td>
 			</tr>
      <tr>
        <th>거래자 성명</th>
        	<td class="currency-input">
        		<input type="text" name="name" id="name" value="${sName}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>이체 받는 사람 성명</th>
        	<td class="currency-input">
        		<input type="text" name="youName" id="youName" value="${vo.youName}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>이체한 금액</th>
        	<td class="currency-input">
        		<input type="text" name="money" id="money" value="${vo.money}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>현재 잔액</th>
        	<td class="currency-input">
        		<input type="text" name="sum" id="sum" value="${vo.balance}" class="form-control" readonly />
      		</td>
      </tr>
      <tr>
        <th>적요</th>
        	<td class="currency-input">
        		<input type="text" name="content" id="content" value="${vo.content}" class="form-control" readonly />
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