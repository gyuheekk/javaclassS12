<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 관리자메뉴</title>
  
	  <!-- Favicon 링크 추가 -->
	  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
        }
        h3 {
            color: #115C8B;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #115C8B;
            border-color: #115C8B;
        }
        .btn-primary:hover {
            background-color: #0e4d73;
            border-color: #0e4d73;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f8ff;
        }
        .pagination .page-link {
            color: #115C8B;
        }
        .pagination .page-item.active .page-link {
            background-color: #115C8B;
            border-color: #115C8B;
        }
        .form-control:focus {
            border-color: #115C8B;
            box-shadow: 0 0 0 0.2rem rgba(17, 92, 139, 0.25);
        }
        .top-controls {
            margin-bottom: 20px;
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
				 .pagination .page-item .page-link {
            color: #115C8B;
        }
        .pagination .page-item.active .page-link {
            background-color: #115C8B;
            border-color: #115C8B;
            color: #fff;
        }
        .pagination .page-item .page-link:hover {
            background-color: #115C8B;
            border-color: #115C8B;
            color: #fff;
        }
    </style>
    <script>
    'use strict';
    
    $(function(){
    	$("#userDispaly").hide();
    	
    	$("#userInfor").on("click", function(){
    		if($("#userInfor").is(':checked')) {
    			$("#totalList").hide();
    			$("#userDispaly").show();
    		}
    		else {
    			$("#totalList").show();
    			$("#userDispaly").hide();
    		}
    	});
    });
    
    // 30일 경과회원 삭제처리
    function memberDeleteOk(idx) {
    	let ans = confirm("선택하신 회원을 영구 삭제 하시겠습니까?");
    	if(ans) {
    		$.ajax({
    			url  : "${ctp}/admin/member/memberDeleteOk",
    			type : "post",
    			data : {idx : idx},
    			success:function(res) {
    				if(res != "0") {
    					alert("영구 삭제 되었습니다.");
    					location.reload();
    				}
    				else alert("삭제 실패~~");
    			}
    		});
    	}
    }
    /*
    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
    }

    
    // 선택항목 등급변경처리
    function levelSelectCheck() {
    	let select = document.getElementById("levelSelect");
    	let levelSelectText = select.options[select.selectedIndex].text;
    	let levelSelect = select.options[select.selectedIndex].value;
    	let idxSelectArray = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
      }
    	if(idxSelectArray == '') {
    		alert("등급을 변경할 항목을 1개 이상 선택하세요");
    		return false;
    	}
    	
      idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
      let query = {
    		  idxSelectArray : idxSelectArray,
    		  levelSelect : levelSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/admin/member/memberLevelSelectCheck",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택한 항목들이 "+levelSelectText+"(으)로 변경되었습니다.");
    		  else alert("등급변경 실패~");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    }
    */
  </script>
</head>
<body>
    <div class="container">
        <h3 class="text-center mb-5">전체 회원 리스트</h3>
        
        <%-- <div class="row top-controls">
            <div class="col-md-4">
                <select name="levelItem" id="levelItem" class="form-control" onchange="levelItemCheck()">
                    <option value="999" ${level > 5  ? "selected" : ""}>전체보기</option>
                    <option value="1"   ${level == 1 ? "selected" : ""}>VVIP</option>
                    <option value="2"   ${level == 2 ? "selected" : ""}>VIP</option>
                    <option value="3"   ${level == 3 ? "selected" : ""}>우수회원</option>
                    <option value="4"   ${level == 4 ? "selected" : ""}>일반회원</option>
                    <option value="99"  ${level == 99 ? "selected" : ""}>탈퇴신청회원</option>
                    <option value="0"   ${level == 0 ? "selected" : ""}>관리자</option>
                </select>
            </div>
            <div class="col-md-8 text-right">
                <button class="btn btn-secondary mr-2" onclick="allCheck()">전체선택</button>
                <button class="btn btn-secondary mr-2" onclick="allReset()">전체취소</button>
                <div class="input-group d-inline-flex" style="width: auto;">
                    <select name="levelSelect" id="levelSelect" class="form-control">
                        <option value="1">VVIP</option>
                        <option value="2">VIP</option>
                        <option value="3">우수회원</option>
                        <option value="4">일반회원</option>
                    </select>
                    <div class="input-group-append">
                        <button class="btn btn-primary" onclick="levelSelectCheck()">선택항목 등급변경</button>
                    </div>
                </div>
            </div>
        </div> --%>

        <form name="myform">
            <table class="table table-hover">
                <thead class="thead-light">
                    <tr>
                        <!-- <th><input type="checkbox" id="allCheck" onclick="allCheck()"/> 번호</th> -->
                        <th>번호</th>
                        <th>아이디</th>
                        <th>성명</th>
                        <th>생일</th>
                        <th>성별</th>
                        <th>최종방문일</th>
                        <th>활동여부</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="vo" items="${vos}" varStatus="st">
                        <tr>
                            <td>
                                <%-- <c:if test="${vo.level != 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
                                <c:if test="${vo.level != 0}"></c:if> --%>
                                ${vo.idx}
                            </td>
                            <td><a href="${ctp}/member/memberSearch?mid=${vo.mid}">${vo.mid}</a></td>
                            <td>${vo.name}</td>
                            <td>${fn:substring(vo.birth,0,10)}</td>
                            <td>${vo.gender}</td>
                            <td>${fn:substring(vo.lastDate,0,10)}</td>
                            <td>
                                <c:if test="${vo.userDel == 'OK'}"><span class="text-danger"><b>탈퇴신청</b></span></c:if>
                                <c:if test="${vo.userDel != 'OK'}">활동중</c:if>
                                <c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
                                    <a href="javascript:memberDeleteOk(${vo.idx})" class="text-primary">(30일경과)</a>
                                </c:if>
                            </td>
                            <%-- <td>
                                <c:if test="${vo.level != 0}">
                                    <select name="level" id="level" class="form-control" onchange="levelChange(this)">
                                        <option value="1/${vo.idx}"  ${vo.level == 1  ? "selected" : ""}>VVIP</option>
                                        <option value="2/${vo.idx}"  ${vo.level == 2  ? "selected" : ""}>VIP</option>
                                        <option value="3/${vo.idx}"  ${vo.level == 3  ? "selected" : ""}>우수회원</option>
                                        <option value="4/${vo.idx}"  ${vo.level == 4  ? "selected" : ""}>일반회원</option>
                                        <option value="0/${vo.idx}"  ${vo.level == 0  ? "selected" : ""}>관리자</option>
                                        <option value="99/${vo.idx}" ${vo.level == 99 ? "selected" : ""}>탈퇴신청회원</option>
                                    </select>
                                </c:if>
                                <c:if test="${vo.level == 0}">관리자</c:if>
                            </td> --%>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
        
				<!-- 페이징처리 -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:if test="${pageVO.pag > 1}">
                    <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li>
                </c:if>
                <c:if test="${pageVO.curBlock > 0}">
                    <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전페이지</a></li>
                </c:if>
                <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
                    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
                        <li class="page-item active"><span class="page-link">${i}</span></li>
                    </c:if>
                    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
                        <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li>
                    </c:if>
                </c:forEach>
                <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
                    <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음페이지</a></li>
                </c:if>
                <c:if test="${pageVO.pag < pageVO.totPage}">
                    <li class="page-item"><a class="page-link" href="${ctp}/admin/member/memberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li>
                </c:if>
            </ul>
        </nav>
        <!-- 페이징처리 끝 -->
        <button type="button" class="btn btn-secondary align-center" onclick="location.href='${ctp}/admin/adminContent';">돌아가기</button>
    </div>
</body>
</html>