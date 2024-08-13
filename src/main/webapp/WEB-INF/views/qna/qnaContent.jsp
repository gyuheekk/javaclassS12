<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Q&A 상세보기</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Noto Sans KR', sans-serif;
    }
    .container {
      background-color: #ffffff;
      border-radius: 15px;
      padding: 30px;
      margin-top: 50px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    h2 {
      color: #343a40;
      margin-bottom: 30px;
    }
    .table {
      border: none;
    }
    .table th {
      background-color: #e9ecef;
      color: #495057;
      font-weight: bold;
    }
    .btn-custom {
      margin: 5px;
    }
    .content-area {
      background-color: #f8f9fa;
      padding: 15px;
      border-radius: 5px;
      min-height: 200px;
    }
  </style>
  <script>
    'use strict';
    
    // 답변글 달기 폼...
    function answerCheck() {
    	let tempStr = '<br/>';
    	tempStr += '<h3 class="text-center">답 변 글 달 기</h3>';
    	tempStr += '<table class="table">';
    	tempStr += '<tr>';
  		tempStr += '  <th class="text-center">글쓴이</th>';
			tempStr += '  <td><input type="text" name="nickName" value="${sName}" readonly class="form-control"/></td>';
			tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '  <th class="text-center">답변글제목</th>';
    	/* tempStr += '  <td><input type="text" name="title" value="(Re) ${vo.title}" size="60" required class="form-control"/></td>'; */
    	tempStr += '  <td class="text-left">(Re) ${vo.title}</td>';
    	tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '<th class="text-center">이메일</th>';
    	tempStr += '  <td><input type="text" name="email" value="${email}" size="60" class="form-control" required/></td>';
    	tempStr += '  </tr>';
    	tempStr += '<tr>';
    	tempStr += '  <th class="text-center">글내용</th>';
    	tempStr += '  <td><textarea rows="6" name="content" required class="form-control"></textarea></td>';
    	tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '<th class="text-center">비밀번호</th>';
    	tempStr += '  <td class="text-left">';
    	tempStr += '    <input type="checkbox" name="pwdCheck" id="pwdCheck" <c:if test="${!empty vo.pwd}">checked</c:if>/>';
    	tempStr += '		<label for="pwdCheck">비밀글로 등록</label> <font size="1"></font>';
  		tempStr += '    <input type="hidden" name="pwd" id="pwd" value="1234"/>';  // 이곳에서는 사용하지 않았음. 별 의미기 없기에...
  		tempStr += '  </td>';
  		tempStr += '</tr>';
    	tempStr += '<tr>';
    	tempStr += '  <td colspan="2" style="text-align:center">';
    	tempStr += '    <input type="button" value="답글올리기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;';
    	tempStr += '    <input type="button" value="취소" onclick="location.reload();" class="btn btn-secondary"/> &nbsp;';
    	tempStr += '  </td>';
    	tempStr += '</tr>';
    	tempStr += '</table>';
    	tempStr += '<input type="hidden" name="qnaSw" value="a"/>';
    	tempStr += '<input type="hidden" name="qnaIdx" value="${vo.qnaIdx}"/>';
    	tempStr += '<input type="hidden" name="title" value="(Re) ${vo.title}"/>';
			$("#reply").html(tempStr);
    }
    
    function fCheck() {
    	var nickName = myform.nickName.value;
    	var title = myform.title.value;
    	var pwdCheck = document.getElementById("pwdCheck");
    	var pwd = myform.pwd.value;
    	var content = myform.content.value;
    	
    	if(nickName=="") {
    		alert("글올린이 닉네임을 입력하세요");
    		myform.nickName.focus();
    		return false;
    	}
    	else if(title=="") {
    		alert("글제목을 입력하세요");
    		myform.title.focus();
    		return false;
    	}
    	else if(content=="") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    		return false;
    	}
    	else {
    		if($("#pwdCheck").is(":checked")) myform.pwd.value = '1234';
    		else myform.pwd.value = "";
    		myform.submit();
    	}
    }
    
    function delCheck() {
    	let ans = "현재 글을 삭제하시겠습니까?";
    	if(!ans) return false;
    	
    	location.href = "${ctp}/qna/qnaDelete?idx=${vo.idx}";
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav3.jsp"/>
<div class="container">
  <h2 class="text-center">Q&A 상세보기</h2>
  <div class="row">
    <div class="col-md-6">
      <p><strong>글쓴이:</strong> ${vo.nickName}</p>
      <p><strong>이메일:</strong> ${vo.email}</p>
    </div>
    <div class="col-md-6 text-right">
      <p><strong>작성일:</strong> ${fn:substring(vo.WDate,0,fn:length(vo.WDate)-3)}</p>
    </div>
  </div>
  <hr>
  <h4>${vo.title}</h4>
  <div class="content-area">
    ${fn:replace(vo.content,newLine,"<br/>")}
  </div>
  <hr>
  <div class="text-center">
    <c:if test="${sLevel == '0' || !fn:contains(vo.title,'현재 삭제된 글입니다.')}">
      <c:if test="${vo.qnaSw == 'q'}">
        <button onclick="answerCheck()" class="btn btn-outline-primary btn-custom">답변</button>
      </c:if>
      <c:if test="${sNickName eq vo.nickName || sLevel == '0'}">
        <c:if test="${sLevel != '0' && vo.qnaSw == 'q'}">
          <button onclick="location.href='${ctp}/qna/qnaUpdate?idx=${vo.idx}';" class="btn btn-primary btn-custom">수정</button>
        </c:if>
        <button onclick="delCheck()" class="btn btn-danger btn-custom">삭제</button>
      </c:if>
    </c:if>
    <button onclick="location.href='qnaList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary btn-custom">목록으로</button>
  </div>
  <form name="myform" method="post" action="qnaInput">
    <div id="reply"></div>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <input type="hidden" name="mid" value="${vo.mid}"/>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>