<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>GH Bank - MyProfile</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <jsp:include page="/WEB-INF/views/include/nav3.jsp" />
<style>
  body {
    font-family: Arial, sans-serif;
  }
  .form-group label {
    font-weight: bold;
    color: #333333;
  }
  .form-control, .custom-select, .btn {
    border-radius: 5px;
  }
  .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
  }
  .btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
  }
  .input-group-text {
    background-color: #e9ecef;
  }
  .form-check-input:checked {
    background-color: #007bff;
    border-color: #007bff;
  }
  .mb-1, .mb-3, .mb-4 {
    margin-bottom: 1rem !important;
  }
  .mb-3 {
    margin-bottom: 1.5rem !important;
  }
  .mb-4 {
    margin-bottom: 2rem !important;
  }
  h1 {
    color: #003366;
    border-bottom: 2px solid #003366;
    padding-bottom: 10px;
    margin-bottom: 30px;
    font-family: "Noto Sans KR", sans-serif;
	 	font-optical-sizing: auto;
	 	font-weight: <weight>;
	 	font-style: normal;
  }
  p {
   	font-family: "Noto Sans KR", sans-serif;
  	font-optical-sizing: auto;
  	font-weight: <weight>;
  	font-style: normal;
   }
  .col {
  	margin: 10px auto; /* 가운데 정렬 */
  	text-align: center;
  }
 	.profile-header {
  	width: 100%;
  }
  .profile {
  	border-radius:50%;
  }
</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="container">
	<div class="profile-header">
	  <h1>My Profile</h1>
	</div>
  <form name="myform">
    <br/>
    <div class="form-group">
	    <div class="col">
	      <label for="name">프로필 사진</label>
	      <p><img src="${ctp}/member/${vo.photo}" width="200px" class="profile" /></p>
	  	</div>
    </div>
    
    <div class="form-group">
      <label for="name">아이디 </label>
      <input type="text" class="form-control" value="${vo.mid}" disabled />
    </div>
    <div class="form-group">
      <label for="name">성명 </label>
      <input type="text" class="form-control" value="${vo.name}" disabled />
    </div>
    <div class="form-group">
      <label for="name">계좌번호 </label>
      <input type="text" class="form-control" value="${vo.accountNumber}" disabled />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="form-row">
        	<div class="col">
	          <input type="text" class="form-control" value="${vo.email}" disabled />
        	</div>
        </div>
    </div>
    <div class="form-group">
      <label for="name">성별 </label>
      <input type="text" class="form-control" value="${vo.gender}" disabled />
    </div>
    <div class="form-group">
      <label for="birth">생년월일</label>
      <input type="date" value="${fn:substring(vo.birth, 0, 10)}" class="form-control" disabled/>
    </div>
     <div class="form-group">
      <label for="name">전화번호 </label>
      <input type="text" class="form-control" value="${vo.tel}" disabled />
    </div>
     <div class="form-group">
      <label for="name">직업 </label>
      <input type="text" class="form-control" value="${vo.job}" disabled />
    </div>
     <div class="form-group">
      <label for="name">주소 </label>
      <input type="text" class="form-control" value="${vo.address}" disabled />
    </div>
    
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/member/memberPwdCheck/i';">프로필 수정</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
    
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>