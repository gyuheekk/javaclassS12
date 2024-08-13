<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - Q&A 작성</title>
  
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
    }
    .container {
      max-width: 800px;
      margin-top: 50px;
      padding: 30px;
      background-color: #ffffff;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h2 {
      color: #343a40;
      margin-bottom: 30px;
    }
    .form-group {
      margin-bottom: 25px;
    }
    label {
      font-weight: bold;
      color: #495057;
    }
    .form-control {
      border-radius: 5px;
    }
    .btn-primary {
      background-color: #007bff;
      border: none;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
    #content {
      min-height: 150px;
      resize: vertical;
    }
  </style>
  <script>
  
  
    function fCheck() {
	  	CKupdate();
	  	
    	var nickName = myform.nickName.value;
    	var title = myform.title.value;
    	var pwdCheck = document.getElementById("pwdCheck");
    	var pwd = myform.pwd.value;
    	var content = myform.content.value;
    	
    	if(nickName=="") {
    		alert("글올린이 닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(title=="") {
    		alert("글제목을 입력하세요");
    		myform.title.focus();
    	}
    	else if(content=="") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    	}
    	else {
	    	if($("#pwdCheck").is(":checked") && pwd == "") {
	    		alert("비밀번호를 입력하세요");
	    		myform.pwd.focus();
	    	 	return false;
	    	}
    		myform.submit();
    	}
    }

    // ckeditor null값체크하도록 처리하기 함수
    function CKupdate(){
        for (var instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
    }
    
    $(document).ready(function() {
	    $("#pwdCheck").click(function() {
	    	if($("#pwdCheck").is(":checked")) {
		    	$("#pwd").removeAttr("readonly");
		    	$("#pwd").focus();
	    	}
	    	else {
	    		$("#pwd").attr("readonly",true);
	    	}
	    });
    });
  </script>
</head>
<body>
<div class="container">
  <h2 class="text-center mb-4">QnA 글쓰기</h2>
  <form name="myform" method="post">
    <div class="form-group">
      <label for="nickName">글쓴이</label>
      <input type="text" class="form-control" id="nickName" name="nickName" value="${sName}" readonly>
    </div>
    <div class="form-group">
      <label for="title">글제목</label>
      <input type="text" class="form-control" id="title" name="title" placeholder="글제목을 입력하세요" required>
    </div>
    <div class="form-group">
      <label for="email">이메일</label>
      <input type="email" class="form-control" id="email" name="email" value="${email}" required>
    </div>
    <div class="form-group">
      <label for="content">글내용</label>
      <input type="text" class="form-control" id="content" name="content" required>
    </div>
    <div class="form-group">
      <div class="custom-control custom-checkbox">
        <input type="checkbox" class="custom-control-input" id="pwdCheck" name="pwdCheck">
        <label class="custom-control-label" for="pwdCheck">비밀글</label>
      </div>
      <small class="form-text text-muted">비밀글로 등록시는 '비밀글'체크후, 아래 비밀번호를 입력해주세요.</small>
      <input type="password" class="form-control mt-2" id="pwd" name="pwd" readonly>
    </div>
    <div class="text-center">
      <button type="button" class="btn btn-primary" onclick="fCheck()">글올리기</button>
      <button type="reset" class="btn btn-secondary">다시쓰기</button>
      <button type="button" class="btn btn-info" onclick="location.href='qnaList';">돌아가기</button>
    </div>
    <c:if test="${qnaFlag == 'q'}"><input type="hidden" name="qnaSw" value="q"/></c:if>
    <c:if test="${qnaFlag != 'q'}">
      <input type="hidden" name="qnaSw" value="a"/>
      <input type="hidden" name="qnaIdx" value="${vo.idx}"/>
    </c:if>
    <input type="hidden" name="mid" value="${sMid}"/>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>