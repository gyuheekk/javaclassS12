<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - QnA</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f4f7;
      color: #333;
    }
    .container {
      background-color: #fff;
      border-radius: 15px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      padding: 40px;
      margin-top: 40px;
    }
    h1 {
      color: #115C8B;
      margin-bottom: 30px;
      font-weight: bold;
    }
    h1 .part-title {
      font-size: 0.6em;
      color: #95a5a6;
      font-weight: normal;
      display: block;
      margin-top: 5px;
    }
    .table {
      border: none;
    }
    .table-header {
      background-color: #115C8B;
      color: white;
    }
    .btn-qna {
      background-color: #115C8B;
      border-color: #115C8B;
      color: #fff;
    }
    .btn-qna:hover {
      background-color: #115C8B;
      border-color: #115C8B;
      color: #white;
    }
    .pagination .page-link {
      color: #115C8B;
    }
    .pagination .page-item.active .page-link {
      background-color: #115C8B;
      border-color: #115C8B;
      color: #fff;
    }
    .pagination .page-item:not(.active) .page-link:hover {
      background-color: #e8f4ff;
    }
    select, input[type="text"] {
      border: 2px solid #bdc3c7;
      border-radius: 4px;
      padding: 8px 12px;
      transition: all 0.3s ease;
    }
    select:focus, input[type="text"]:focus {
      border-color: #3498db;
      box-shadow: 0 0 0 2px rgba(52,152,219,0.2);
    }
    .badge-waiting {
      background-color: #e74c3c;
    }
    .badge-completed {
      background-color: #2ecc71;
    }
  </style>
  <script>
    'use strict';
    
    /* function sChange() {
      searchForm.searchString.focus();
    }
    
    function sCheck() {
      var searchString = searchForm.searchString.value;
      if(searchString == "") {
        alert("검색어를 입력하세요");
        searchForm.searchString.focus();
      }
      else {
        searchForm.submit();
      }
    } */
  </script>
</head>
<body>
<div class="container">
  <h1 class="text-center">GH BANK <span class="part-title">궁금한 점을 물어보세요</span></h1>
  
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div></div>
    <c:if test="${!empty sMid}">
      <a href="qnaInput?qnaFlag=q" class="btn btn-qna">질문하기</a>
    </c:if>
  </div>
  
  <table class="table table-hover">
    <thead class="table-header">
      <tr>
        <th>번호</th>
        <th>상태</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
      </tr>
    </thead>
    <tbody>
      <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
      <c:forEach var="vo" items="${vos}">
        <tr>
          <td>${curScrStartNo}</td>
          <td>
            <c:if test="${vo.qnaAnswer == '답변완료'}"><span class="badge badge-completed" style="color: #fff;">${vo.qnaAnswer}</span></c:if>
            <c:if test="${vo.qnaAnswer == '답변대기'}">
              <span class="badge badge-waiting" style="color: #fff;">
                <c:if test="${sLevel == 0}"><a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}" style="color: #fff;">${vo.qnaAnswer}</a></c:if>
                <c:if test="${sLevel != 0}" >${vo.qnaAnswer}</c:if>
              </span>
            </c:if>
          </td>
          <td style="text-align:left;">
            <c:if test="${vo.qnaSw == 'a'}"> &nbsp;&nbsp; └</c:if>
            <c:if test="${!empty vo.pwd}"><i class="fas fa-lock"></i></c:if>
            <c:if test="${vo.pwd == ''}"><a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a></c:if>
            <c:if test="${vo.pwd != '' && (sLevel == 0 || sNickName == vo.nickName)}">
              <c:if test="${sLevel == 0 || sNickName == vo.nickName}">
                <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
              </c:if>
            </c:if>
            <c:if test="${vo.pwd != '' && sNickName != vo.nickName && sLevel != 0}">
              ${vo.title}
            </c:if>
            <c:if test="${vo.diffTime <= 24}"><span class="badge badge-danger">New</span></c:if>
          </td>
          <td>${vo.nickName}</td>
          <td>
            <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
            <c:if test="${vo.diffTime > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
          </td>
        </tr>
        <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
      </c:forEach>
    </tbody>
  </table>
  
  <!-- 페이지네이션 -->
  <div class="d-flex justify-content-center mt-4">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="qnaList?pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="qnaList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="qnaList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="qnaList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="qnaList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="qnaList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
    </ul>
  </div>
  
  <!-- 검색기 처리 -->
  <%-- <div class="mt-5">
    <form name="searchForm" method="get" action="qnaSearch" class="form-inline justify-content-center">
      <select name="search" onchange="sChange()" class="form-control mr-2">
        <option value="title" selected>제목</option>
        <option value="nickName">작성자</option>
        <option value="content">내용</option>
      </select>
      <input type="text" name="searchString" class="form-control mr-2"/>
      <input type="button" value="검색" onclick="sCheck()" class="btn btn-qna"/>
      <input type="hidden" name="pag" value="${pageVO.pag}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div> --%>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>