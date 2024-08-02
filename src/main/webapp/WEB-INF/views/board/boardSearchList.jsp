<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
  <style>
  	h2 {
 		font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
   	font-size: 17px;
  	}
  </style>
  <script>
    'use strict';
    
    function partCheck() {
    	let part = $("#part").val();
    	location.href = "boardList?pag=${pag}&pageSize=${pageSize}&part="+part;
    }
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav3.jsp" />
<p><br/></p>
<div class="container">
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td colspan="2" class="text-center">
        <h2 class="text-center">게시판 조건별 검색 리스트</h2>
        (<font color="blue">${searchTitle}</font>(으)로 <font color="blue">${searchString}</font>(을)를 검색한 결과 <font color="red"><b>${searchCount}</b></font> 건의 게시글이 검색되었습니다.)
      </td>
    </tr>
    <tr>
      <td>
        <form name="partForm">
          <select name="part" id="part" onchange="partCheck()">
            <option ${part=="전체게시판" ? "selected" : ""}>전체게시판</option>
            <option ${part=="공지사항" ? "selected" : ""}>공지사항</option>
            <option ${part=="문의사항" ? "selected" : ""}>문의사항</option>
            <option ${part=="FAQ" ? "selected" : ""}>FAQ</option>
            <option ${part=="이벤트" ? "selected" : ""}>이벤트</option>
          </select>
        </form>
      </td>
    </tr>
  </table>
  
  <table class="table table-hover m-0 p-0 text-center">
    <tr class="table-dark text-dark">
      <th>글번호</th>
      <th>글제목</th>
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>분류</th>
      <th>조회수</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
    <c:forEach var="vo" items="${vos}" varStatus="st">
    <c:if test="${vo.openSw == 'OK' || sLevel == 0 || sMid == vo.mid}">
	    <tr>
	      <td>${curScrStartNo}</td>
	      <td class="text-left">
	        <a href="boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&part=${part}">${vo.title}</a>
	        <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>  
	      </td>
	      <td>${vo.mid}</td>
	      <td>
	        <!-- 1일(24시간) 이내는 시간만 표시(10:43), 이후는 날짜와 시간을 표시 : 2024-05-14 10:43 -->
	        ${vo.date_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,10)}
	      </td>
	      <td>${vo.part}</td>
	      <td>${vo.readNum}</td>
	    </tr>
    </c:if>
			    
    	<c:set var="curScrStartNo" value="${curScrStartNo-1}" />
	  </c:forEach>
	  <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <br/>
  
	<!-- 블록페이지 시작 -->
	<%-- <div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="boardList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<br/> --%>
	<!-- 블록페이지 끝 -->
	
	<input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}';" class="btn btn-secondary"/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>