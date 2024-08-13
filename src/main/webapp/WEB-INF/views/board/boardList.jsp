<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 게시판</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
      color: #333;
    }
    .container {
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 30px;
    }
    h1 {
		  color: #2c3e50;
		  margin-bottom: 30px;
		}
		h1 .part-title {
		  font-size: 0.7em;  /* 메인 제목의 70% 크기 */
		  color: #7f8c8d;  /* 조금 더 연한 색상 */
		  font-weight: normal;  /* 글씨 두께를 보통으로 */
		}
    .table {
      border: none;
    }
    .table-dark {
      background-color: #34495e;
    }
    .btn-secondary {
  background-color: #34495e;
  border-color: #34495e;
  color: #fff;
}

.btn-secondary:hover {
  background-color: #2c3e50;
  border-color: #2c3e50;
}

.pagination .page-link {
  color: #34495e;
}

.pagination .page-item.active .page-link {
  background-color: #34495e;
  border-color: #34495e;
  color: #fff;
}

.pagination .page-item:not(.active) .page-link:hover {
  background-color: #eaecee;
}
    select, input[type="text"] {
      border: 1px solid #ced4da;
      border-radius: 4px;
      padding: 5px 10px;
    }
  </style>
  <script>
    'use strict';
    
    function partCheck() {
      let part = $("#part").val();
      location.href = "boardList?pag=${pag}&pageSize=${pageSize}&part="+part;
    }
    
    function searchCheck() {
      searchForm.part.value = $("#part").val();
      searchForm.submit();
    }
    
  </script>
</head>
<body>
<div class="container">
  <h1 class="text-center">GH BANK <span class="part-title">[${part}]</span>
</h1>
  
  <div class="d-flex justify-content-between align-items-center mb-4">
    <form name="partForm">
      <select name="part" id="part" onchange="partCheck()" class="form-control">
        <option ${part=="전체게시판" ? "selected" : ""}>전체게시판</option>
        <option ${part=="공지사항" ? "selected" : ""}>공지사항</option>
        <option ${part=="FAQ" ? "selected" : ""}>FAQ</option>
      </select>
    </form>
    
    <c:if test="${!empty sMid}">
      <a href="boardInput" class="btn btn-secondary">글쓰기</a>
    </c:if>
    
  </div>
  
  <table class="table">
    <thead class="table-dark">
      <tr>
        <th>글번호</th>
        <th>글제목</th>
        <th>글쓴이</th>
        <th>글쓴날짜</th>
        <th>분류</th>
        <th>조회수</th>
      </tr>
    </thead>
    <tbody>
      <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
      <c:forEach var="vo" items="${vos}" varStatus="st">
        <c:if test="${vo.openSw == 'OK' || sLevel == 0 || sMid == vo.mid}">
          <tr>
            <td>${curScrStartNo}</td>
            <td>
              <a href="boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&part=${part}">${vo.title}</a>
              <c:if test="${vo.hour_diff <= 24}"><span class="badge badge-danger">New</span></c:if>  
            </td>
            <td>${vo.mid}</td>
            <td>
              ${vo.date_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,10)}
            </td>
            <td>${vo.part}</td>
            <td>${vo.readNum}</td>
          </tr>
        </c:if>
        <c:set var="curScrStartNo" value="${curScrStartNo-1}" />
      </c:forEach>
    </tbody>
  </table>
  
  <!-- 페이지네이션 -->
  <div class="d-flex justify-content-center mt-4">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="boardList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
    </ul>
  </div>
  
  <!-- 검색 폼 -->
  <div class="mt-4">
    <form name="searchForm" method="post" action="boardSearch" class="form-inline justify-content-center">
      <select name="search" id="search" class="form-control mr-2">
        <option value="title">글제목</option>
        <option value="mid">글쓴이</option>
        <option value="content">글내용</option>
      </select>
      <input type="text" name="searchString" id="searchString" required class="form-control mr-2" />
      
      <input type="button" value="검색" onclick="searchCheck()" class="btn btn-secondary"/>
      <input type="hidden" name="part"/>
      <input type="hidden" name="pag" value="${pageVO.pag}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>