<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 게시판</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
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
		h2 {
		  color: #2c3e50;
		  margin-bottom: 30px;
		  font-family: "Noto Sans KR", sans-serif;
		  font-optical-sizing: auto;
		  font-weight: <weight>;
		  font-style: normal;
		}
		.table {
		  border: none;
		}
		.table th {
		  background-color: #f1f3f5;
		  color: #34495e;
		}
		.btn-success, .btn-warning, .btn-info {
		  background-color: #34495e;
		  border-color: #34495e;
		  color: #fff;
		}
		.btn-success:hover, .btn-warning:hover, .btn-info:hover {
		  background-color: #2c3e50;
		  border-color: #2c3e50;
		}
		select, input[type="text"], textarea {
		  border: 1px solid #ced4da;
		  border-radius: 4px;
		}
		.table td, .table th {
		  vertical-align: middle;
		}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav3.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">게 시 판 글 쓰 기</h2>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th class="text-center">글쓴이</th>
        <td><input type="text" name="mid" id="mid" value="${sMid}" readonly class="form-control" /></td>
      </tr>
      <tr>
        <th class="text-center">글제목</th>
        <td><input type="text" name="title" id="title" placeholder="글제목을 입력하세요" autofocus required class="form-control" /></td>
      </tr>
      <tr>
				<th class="text-center">분류</th>
					<td>
						<select name="part" id="part" class="form-control">
						<c:if test="${sMid == 'admin'}">
            	<option ${part=="공지사항" ? "selected" : ""}>공지사항</option>
            	<option ${part=="FAQ" ? "selected" : ""}>FAQ</option>
            	<option ${part=="이벤트" ? "selected" : ""}>이벤트</option>
            </c:if>
						<c:if test="${sMid != 'admin'}">
            	<option ${part=="문의사항" ? "selected" : ""}>문의사항</option>
            </c:if>
         		</select>
	      	</td>
			</tr>
      <tr>
        <th class="text-center">글내용</th>
        <td><textarea name="content" id="CKEDITOR" rows="6" class="form-control" required></textarea></td>
        <script>
          CKEDITOR.replace("content",{
        	  height:400,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
        	  uploadUrl : "${ctp}/imageUpload"						/* uploadUrl : 여러개의 그림파일을 드래그&드롭해서 올릴수 있다. */
          });
        </script>
      </tr>
      <c:if test="${sMid != 'admin'}">
	      <tr>
	        <th class="text-center">공개여부</th>
	        <td>
	          <input type="radio" name="openSw" id="openSw1" value="OK" checked /> 공개 &nbsp;
	          <input type="radio" name="openSw" id="openSw2" value="NO" /> 비공개
	        </td>
	      </tr>
      </c:if>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="글올리기" class="btn btn-secondary mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-secondary mr-2"/>
          <input type="button" value="돌아가기" onclick="location.href='boardList';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>