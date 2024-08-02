<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<script>
  function userDelCheck() {
	  if("${sMid}" != "") {
		  let ans = confirm("회원 탈퇴하시겠습니까?");
		  if(ans) {
			  ans = confirm("탈퇴하시면 1개월간 같은 아이디로 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
			  if(ans) {
				  $.ajax({
					  type : "post",
					  url  : "${ctp}/member/userDel",
					  success:function(res) {
						  if(res == "1") {
							  alert("회원에서 탈퇴 되셨습니다.");
							  location.href = '${ctp}/member/memberLogin';
						  }
						  else {
							  alert("회원 탈퇴신청 실패~~");
						  }
					  },
					  error : function() {
						  alert("전송오류!");
					  }
				  });
			  }
		  }
	  }
	  else {
		  alert("로그인이 필요한 서비스입니다");
		  location.href = "${ctp}/member/memberLogin";
	  }
  }
  
	// 근처 영업점 찾기 ()
 	function openKakaoMap(url) {
      window.open('${ctp}/kakao/kakaoMap', 'kakaoMapWindow', 'width=800,height=950');
  }
	
</script>
<style>
	#w3-function {
	  display: flex; /* Flexbox 사용 */
	  align-items: center; /* 수직 가운데 정렬 */
	  justify-content: center; /* 수평 가운데 정렬 */
	  margin: 0; /* 여백 제거 */
	  padding: 0; /* 패딩 제거 */
	  position: relative; /* 위치 조정 */
	  top: 7px; /* 헤더와 펑션 사이의 간격 조정, 필요에 따라 이 값을 조정하세요 */
	  z-index: 2; /* 스택 순서 조정 */
	  background-color: #f9f9f9; /* 배경 색상 추가 */
	  border-bottom: 1px solid #ddd; /* 하단 테두리 추가 */
}

/* Navbar 아이템 스타일 */
	#w3-function .w3-bar-item {
	  display: flex; /* Flexbox 사용 */
	  flex-direction: column; /* 아이콘을 위에, 텍스트를 아래에 배치 */
	  align-items: center; /* 수직 가운데 정렬 */
	  padding: 10px 20px; /* 각 아이템의 패딩 조정 */
	  text-decoration: none; /* 링크 텍스트 밑줄 제거 */
	  color: black; /* 텍스트 색상 */
	  margin: 0 10px; /* 앵커 태그들 사이의 간격 조정 */
}

	#w3-function .w3-bar-item i {
	  font-size: 2.2em; /* 아이콘 크기 조정 */
	  margin-bottom: 5px; /* 아이콘과 텍스트 간격 조정 */
	}

	#w3-function .w3-bar-item:hover {
	  background-color: #f0f0f0; /* 호버 시 배경색 변경 */
	  color: #333; /* 호버 시 텍스트 색상 변경 */
	}
	.w3-center {
		font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
   	font-size: 16px;
   	display: flex;
  	justify-content: center;
  	align-items: center;
	}
	.dropdown {
	  position: relative;
	  display: inline-block;
	}
	
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background-color: #f9f9f9;
	  min-width: 160px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	  z-index: 1;
	}
	
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropdown-content a:hover {
	  background-color: #f1f1f1;
	}
	
	.dropdown:hover .dropdown-content {
	  display: block;
	}
</style>
<!-- Navbar -->
<div class="w3-center" id="w3-function">

	<div class="dropdown">
    <a href="${ctp}/account/accountDeposit" class="w3-bar-item w3-button"><i class="fa-solid fa-circle-dollar-to-slot"></i>입금</a>
  </div>

	<div class="dropdown">
    <a href="#bank" class="w3-bar-item w3-button"><i class="fa-solid fa-comments-dollar icon-spacing"></i>출금</a>
	    <div class="dropdown-content">
	      <a href="${ctp}/account/accountWithdraw">출금</a>
	      <a href="${ctp}/account/accountTransfer">계좌이체</a>
	    </div>
  </div>
  <!-- 
	<div class="dropdown">
    <a href="#bank" class="w3-bar-item w3-button"><i class="fa-regular fa-calendar-check"></i>자동이체</a>
	    <div class="dropdown-content">
	      <a href="#">자동이체</a>
	      <a href="#">자동이체신청</a>
	    </div>
  </div>
 -->
  <div class="dropdown">
    <a href="${ctp}/account/accountview" class="w3-bar-item w3-button"><i class="fa-solid fa-magnifying-glass icon-spacing"></i>거래내역조회</a>
  </div>
  <div class="dropdown">
    <a href="#Loan" class="w3-bar-item w3-button"><i class="fa-solid fa-sack-dollar"></i>대출</a>
    <div class="dropdown-content">
      <a href="${ctp}/loan/loanProduct">대출 종류 소개</a>
      <a href="#sub10">내 대출 조회</a>
    </div>
  </div>
  <div class="dropdown">
    <a href="#card" class="w3-bar-item w3-button"><i class="fa-regular fa-credit-card icon-spacing"></i>카드발급</a>
    <div class="dropdown-content">
      <a href="${ctp}/card/cardProduct">카드 종류 소개</a>
      <a href="${ctp}/card/cardSignup">카드 신청</a>
      <a href="${ctp}/card/cardCheck">내 카드 확인</a>
    </div>
  </div>
  
  <div class="dropdown">
    <a href="#bank" class="w3-bar-item w3-button"><i class="fa-solid fa-chart-column"></i>예금/적금</a>
	    <div class="dropdown-content">
	      <a href="${ctp}/saving/savingProduct">예금/적금 상품</a>
	      <a href="${ctp}/saving/savingSignup?flagSw=Y">정기예금 신청</a>
	      <a href="${ctp}/saving/savingSignup?flagSw=J">정기적금 신청</a>
	      <a href="${ctp}/saving/savingCheck">내 예적금 조회</a>
	    </div>
  </div>
  
  <div class="dropdown">
	  <a class="w3-bar-item w3-button" onclick="openKakaoMap();">
	    <i class="fa-solid fa-map-location-dot"></i>영업점 찾기
		</a>
  </div>
  <div class="dropdown">
    <a href="#board" class="w3-bar-item w3-button"><i class="fa-regular fa-rectangle-list icon-spacing"></i>게시판</a>
    <div class="dropdown-content">
      <a href="${ctp}/board/boardList">전체게시판</a>
      <a href="${ctp}/board/boardList?part=공지사항">공지사항</a>
      <a href="${ctp}/board/boardList?part=문의사항">문의사항</a>
      <a href="${ctp}/board/boardList?part=FAQ">FAQ</a>
      <%-- <a href="${ctp}/board/boardList?part=이벤트">이벤트</a> --%>
    </div>
  </div>
  <div class="dropdown">
    <a href="#MyPage" class="w3-bar-item w3-button"><i class="fa-solid fa-user icon-spacing"></i>마이페이지</a>
    <div class="dropdown-content">
      <a href="#">메세지 확인</a>
      <a href="${ctp}/member/memberMyProfile">내 프로필 보기</a>
      <a href="${ctp}/member/memberPwdCheck/i">내 프로필 수정</a>
      <a href="${ctp}/member/memberPwdCheck/p">비밀번호 변경</a>
      <a href="javascript:userDelCheck()">회원탈퇴</a>
    </div>
  </div>
  </div>

