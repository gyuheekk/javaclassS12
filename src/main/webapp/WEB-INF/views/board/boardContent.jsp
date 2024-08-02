<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
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
		  width: 100%;
		}
		
		h1 {
		  color: #2c3e50;
		  margin-bottom: 30px;
		}
		
		.table {
		  border: none;
		}
		
		.table th {
		  background-color: #f1f3f5;
		  color: #34495e;
		  width: 20%;
		  text-align: center;
		  vertical-align: middle;
		}
		
		.btn-secondary, .btn-warning {
		  background-color: #34495e;
		  border-color: #34495e;
		  color: #fff;
		}
		
		.btn-secondary:hover, .btn-warning:hover {
		  background-color: #2c3e50;
		  border-color: #2c3e50;
		}
		
		.icon {
		  margin-right: 10px;
		}
		
		.icon i {
		  font-size: 1.2em;
		  color: #34495e;
		}
		
		.table-borderless {
		  margin-top: 20px;
		}
		
		.table-borderless a {
		  color: #34495e;
		  text-decoration: none;
		}
		
		.table-borderless a:hover {
		  text-decoration: underline;
		}
		
		.icon-space {
		  margin-right: 5px;
		  color: #34495e;
		}
		
		/* 댓글 부분 스타일 */
		.table-hover th {
		  background-color: #34495e;
		  color: #fff;
		}
		
		.badge {
		  background-color: #34495e;
		  color: #fff;
		}
		
		textarea.form-control {
		  border: 1px solid #ced4da;
		  border-radius: 4px;
		}
  </style>
  <script>
    'use strict';
    
    function boardDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "boardDelete?idx=${vo.idx}";
    }
    
    
    // 원본글에 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		$("#content").focus();
    		return false;
    	}
    	let query = {
    			boardIdx 	: ${vo.idx},
    			mid				: '${sMid}',
    			content		: content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/boardReplyInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 댓글 삭제하기
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/board/boardReplyDelete",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
 		// 댓글 수정하기
    function replyEdit(modalIdx, content, boardIdx, pag, pagSize) {
      $("#myModal2 #modalIdx").val(modalIdx);
      $("#myModal2 #modalContent").val(content);
      $("#myModal2 #boardIdx").val(boardIdx);
      $("#myModal2 #pag").val(pag);
      $("#myModal2 #pagSize").val(pagSize);
  }
    
    // 처음에는 대댓글 '닫기'버튼은 보여주지 않는다.
    $(function(){
    	$(".replyCloseBtn").hide();
    });
    
    // 대댓글 입력버튼 클릭시 입력박스 보여주기
    function replyShow(idx) {
    	$("#replyShowBtn"+idx).hide();
    	$("#replyCloseBtn"+idx).show();
    	$("#replyDemo"+idx).slideDown(100);
    }
    
    // 대댓글 박스 감추기
    function replyClose(idx) {
    	$("#replyShowBtn"+idx).show();
    	$("#replyCloseBtn"+idx).hide();
    	$("#replyDemo"+idx).slideUp(300);
    }
    
    // 대댓글(부모댓글의 답변글)의 입력처리
    function replyCheckRe(idx, re_step, re_order) {
    	let content = $("#contentRe"+idx).val();
    	if(content.trim() == "") {
    		alert("답변글을 입력하세요");
    		$("#contentRe"+idx).focus();
    		return false;
    	}
    	
    	let query = {
    			boardIdx : ${vo.idx},
    			re_step : re_step,
    			re_order : re_order,
    			mid      : '${sMid}',
    			nickName : '${sNickName}',
    			hostIp   : '${pageContext.request.remoteAddr}',
    			content  : content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/boardReplyInputRe",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("답변글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("답변글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav3.jsp" />
<p><br/></p>
<div class="container">
  <h1 class="text-center mb-4">GH Bank Board</h1>
  <table class="table table-bordered">
    <tr>
      <th class="text-center">글쓴이</th>
      <td>${vo.mid}</td>
    </tr>
    <tr>
      <th class="text-center">분류</th>
      <td colspan="3">${vo.part}</td>
    </tr>
    <tr>
      <th class="text-center">글쓴날짜</th>
      <td colspan="3">${fn:substring(vo.WDate, 0, 10)}</td>
    </tr>
    <tr>
      <th class="text-center">글제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>
      <th class="text-center">글내용</th>
      <td colspan="3" style="height:200px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4">
        <div class="row">
	        <div class="col">
	        	<input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}&part=${part}';" class="btn btn-secondary" />
	        </div>
		        <div class="col text-right">
			        <c:if test="${(vo.part == '문의사항' && sMid == vo.mid) || (vo.part != '문의사항' && sLevel == 0)}">
						    <input type="button" value="수정" onclick="location.href='boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&part=${part}';" class="btn btn-secondary" />
							</c:if>
			        <c:if test="${sMid == vo.mid || sLevel == 0}">
					      <input type="button" value="삭제" onclick="boardDelete()" class="btn btn-secondary text-right" />
			        </c:if>
		        </div>
        </div>
      </td>
    </tr>
  </table>
  <!-- 이전글/ 다음글 출력하기 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${!empty nextVo.title}">
          <i class="fa-regular fa-square-caret-up icon-space"></i><a href="boardContent?idx=${nextVo.idx}">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${!empty preVo.title}">
        	<i class="fa-regular fa-square-caret-down icon-space"></i><a href="boardContent?idx=${preVo.idx}">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>
</div>
<p><br/></p>

<!-- 댓글 처리(리스트/입력) -->
<c:if test="${!empty sMid && vo.part == '문의사항'}">
	<div class="container">
		<!-- 댓글 리스트 보여주기 -->
		<table class="table table-hover text-center">
		  <tr>
		    <th>작성자</th>
		    <th>댓글내용</th>
		    <th>댓글일자</th>
		    <th>답글</th>
		    <c:if test="${sMid == 'admin' || sMid == vo.mid}">
		    	<th>댓글 수정/삭제</th>
		    </c:if>
		  </tr>
		  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
		    <tr>
		      <td class="text-left">
		        <c:if test="${replyVo.re_step >= 1}">
		          <c:forEach var="i" begin="1" end="${replyVo.re_step}"> &nbsp;&nbsp;</c:forEach> └▶
		        </c:if>
		        ${replyVo.mid}
		      </td>
		      <td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
		      <td>${fn:substring(replyVo.WDate, 0, 10)}</td>
		      <td>
		        <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge badge-success">답글</a>
		        <a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge badge-warning replyCloseBtn">닫기</a>
		      </td>
		      <c:if test="${sMid == 'admin' || vo.mid == sMid}">
		        <td>
		        	<a href="javascript:replyDelete(${replyVo.idx})" class="icon"><i class="fa-solid fa-trash"></i></a>
		      		<a href="#" onclick="replyEdit('${replyVo.idx}','${fn:replace(replyVo.content, newLine, '<br/>')}','${vo.idx}','${pag}','${pageSize}')" class="icon" data-toggle="modal" data-target="#myModal2"><i class="fa-solid fa-pen-to-square"></i></a>
		      	</td>
	      	</c:if>
		    </tr>
		    <tr>
		      <td colspan="5" class="m-0 p-0">
		        <div id="replyDemo${replyVo.idx}" style="display:none">
		          <table class="table table-center">
		            <tr>
		              <td style="85%" class="text-left">답글내용 :
		                <textarea rows="4" name="contentRe" id="contentRe${replyVo.idx}" class="form-control">@${replyVo.mid}</textarea>
		              </td>
		              <td style="15%">
		                <br/>
		                <p>작성자 : ${sMid}</p>
		                <input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-secondary btn-sm"/>
		              </td>
		            </tr>
		          </table>
		        </div>
		      </td>
		    </tr>
		  </c:forEach>
		  <tr><td colspan="4" class='m-0 p-0'></td></tr>
		</table>
		
		<!-- 댓글 입력창 -->
		<form name="replyForm">
		  <table class="table table-center">
		    <tr>
		      <td style="width:85%" class="text-left">
		        댓글달기
		        <textarea rows="4" name="content" id="content" class="form-control"></textarea>
		      </td>
		      <td style="width:15%">
		        <br/>
		        <p>작성자 : ${sMid}</p>
		        <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-secondary btn-sm"/></p>
		      </td>
		    </tr>
		  </table>
		</form>
		<br/>
	</div>
</c:if>
<!-- 댓글 처리 -->

<!-- 댓글 수정 폼 모달창 -->
  <div class="modal fade" id="myModal2">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">댓글 수정창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <form name="modalForm boardReplyEdit" method="post">
	          <textarea rows="4" name="modalContent" id="modalContent" class="form-control"></textarea>
		          <input type="hidden" name="modalIdx" id="modalIdx" /> 
		          <input type="hidden" name="boardIdx" id="boardIdx" /> 
		          <input type="hidden" name="pag" id="pag" /> 
		          <input type="hidden" name="pagSize" id="pagSize" /> 
		          <input type="submit" value="수정하기" class="btn btn-success mr-2 mt-2"/>
          </form> 
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>