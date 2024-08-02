<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>

<style>
  .logo-image {
    max-height: 30px; /* 이미지의 최대 높이 설정 */
    max-width: auto; /* 이미지의 너비는 자동으로 조정 */
  }
  .w3-top {
 	  font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
   	font-size: 17px;
	}
  .w3-top .w3-bar-item {
  	text-decoration: none; /* 링크 텍스트 밑줄 제거 */
  }
	
</style>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-card" id="myNavbar">
    <a href="${ctp}/" class="w3-bar-item w3-button w3-wide">
    	<img src="${ctp}/images/Logo.png" class="logo-image">
   	</a>
    <!-- Right-sided navbar links -->
    <div class="w3-right w3-hide-small">
    
    <c:if test="${empty sLevel}">
	    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button">로그인</a>
	    <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button">회원가입</a>
    </c:if>
    <c:if test="${!empty sLevel}">
	    	<c:if test="${sLevel == 0}">
			    <a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button"><i class="fa-solid fa-user-gear icon-spacing"></i>관리자메뉴</a>
	    	</c:if>
	    <a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button"><i class="fa-solid fa-right-to-bracket"></i>로그아웃</a>
    </c:if>
    
      <!-- 
	      <a href="#team" class="w3-bar-item w3-button"><i class="fa fa-user"></i> TEAM</a>
	      <a href="#work" class="w3-bar-item w3-button"><i class="fa fa-th"></i> WORK</a>
	      <a href="#pricing" class="w3-bar-item w3-button"><i class="fa fa-usd"></i> PRICING</a>
	      <a href="#contact" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i> CONTACT</a>
       -->
    </div>
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>

<!-- Sidebar on small screens when clicking the menu icon -->
<nav class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large" style="display:none" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">Close ×</a>
  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">ABOUT</a>
  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">TEAM</a>
  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">WORK</a>
  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">PRICING</a>
  <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button">CONTACT</a>
</nav>