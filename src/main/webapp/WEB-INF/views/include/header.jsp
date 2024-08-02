<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<style>
body {
  margin: 0;
  padding: 0;
}
.page-container {
  display: flex;
  width: 100%;
  background-color: #F0F8FF;
}
.main-content {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  padding-left: 0%
}
header {
  margin-bottom: 0;
  padding-bottom: 0;
  margin-top: 20px;
  width: 100%;
}
.slideshow-container {
  max-width: 60%; /* 이 값을 줄여서 전체 슬라이드쇼 컨테이너의 크기를 줄입니다 */
  position: relative;
  margin: auto;
  height: 65vh; /* 이 값도 줄여서 세로 크기를 조정합니다 */
  display: flex;
  align-items: center;
  justify-content: center;
}

.mySlides img {
  max-width: 100%; /* 이미지의 최대 너비를 조정합니다 */
  max-height: 85%; /* 이미지의 최대 높이를 조정합니다 */
  object-fit: contain;
  display: block;
  margin-top:50px;
}
.mySlides {
  display: none;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: #888;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}
.prev {
  left: 0%;
  border-radius: 3px 0 0 3px;
}
.next {
  right: 0%;
  border-radius: 3px 0 0 3px;
}
.prev:hover {
  background-color: rgba(0,0,0,0.8);
  color: white;
  text-decoration: none;
}
.next:hover {
  background-color: rgba(0,0,0,0.8);
  color: white;
  text-decoration: none;
}
.vertical-navbar {
  width: 165px;
  background-color: white;
  padding: 20px;
  height: 400px;
  position: fixed;
  top: 0;
  right:0;
  margin-top: 140px;
  margin-right:45px;
  overflow-y: auto;
  border: 1px solid #a9a9a9;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  z-index: 1000;
}
.vertical-navbar ul {
  list-style-type: none;
  padding: 0;
  margin:0;
}
.vertical-navbar li {
  margin-bottom: 7px;
}
.vertical-navbar a {
  text-decoration: none;
  color: #333;
  display: block;
  padding: 10px;
  transition: background-color 0.3s;
  font-weight:bold;
  text-align: center; /* 글자를 가운데 정렬 */
}
.vertical-navbar a:hover {
  background-color: #EEEEEE;
  text-decoration: none;
}
</style>
</head>
<body>
<div class="page-container">
  <div class="main-content">
    <header>
      <div class="slideshow-container">
        <div class="mySlides">
          <img src="${ctp}/images/Main1.png">
        </div>
        <div class="mySlides">
          <img src="${ctp}/images/Main2.png">
        </div>
        <div class="mySlides">
          <img src="${ctp}/images/Main3.png">
        </div>
        <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
        <a class="next" onclick="plusSlides(1)">&#10095;</a>
      </div>
    </header>
  </div>
  
  <div class="vertical-navbar">
    <ul>
    	<li style="font-size:18px" class="text-center"><b>QUICK MENU</b></li>
    	<hr/>
      <li><a href="#" onclick="openKakaoMap();">영업점찾기</a></li>
      <li><a href="${ctp}/board/boardList?part=FAQ">FAQ</a></li>
      <li><a href="${ctp}/board/boardList?part=문의사항">문의사항</a></li>
      <li><a href="${ctp}/board/boardList?part=공지사항">공지사항</a></li>
      <li><a href="#" onclick="openCalculator();">환율 계산기</a></li>
      <li><a href="${ctp}/member/memberMyProfile">My Profile</a></li>
    </ul>
  </div>
</div>
<script>
function openCalculator() {
    const width = 600;
    const height = 800;
    
    // 실제 사용 가능한 화면 크기 계산
    const screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    const screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    
    // 창 위치 계산 (약간의 여백 고려)
    const left = Math.max(0, (screenWidth - width) / 2);
    const top = Math.max(0, (screenHeight - height) / 2);
    
    const features = [
        `width=${width}`,
        `height=${height}`,
        `left=${left}`,
        `top=${top}`,
        'resizable=yes',
        'scrollbars=yes',
        'status=no',
        'location=no',
        'menubar=no',
        'toolbar=no'
    ].join(',');
    
    const popup = window.open('${ctp}/exchangeRate/exchangeRate', 'calculatorWindow', features);
    
    // 팝업 창이 차단되었는지 확인
    if (!popup || popup.closed || typeof popup.closed == 'undefined') {
        alert('팝업 차단을 해제해주세요.');
    } else {
        // 팝업 창의 크기와 위치를 다시 한번 설정
        popup.resizeTo(width, height);
        popup.moveTo(left, top);
    }
}
</script>
<script>
// JavaScript 코드는 그대로 유지
let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  slides[slideIndex-1].style.display = "flex";  
}

// 자동 슬라이드
setInterval(function() {
  plusSlides(1);
}, 3500); // 자동 슬라이드 간격을 3.5초로 설정
</script>
</body>
</html>