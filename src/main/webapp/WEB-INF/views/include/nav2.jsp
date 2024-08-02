<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/include/bs4.jsp" %>

<style>
  .logo-image {
    max-height: 30px; /* 이미지의 최대 높이 설정 */
    max-width: auto; /* 이미지의 너비는 자동으로 조정 */
    margin: 20px;
    transition: transform 0.3s, filter 0.3s; /* 부드러운 변환을 위한 트랜지션 추가 */
  }
  .centered-image {
    transition: transform 0.3s;
  }
  .centered-image:hover {
    cursor: pointer;
  }
  .center-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 30vh; /* 뷰포트 높이의 30% */
    background-color: white; /* 배경색 설정 */
  }
</style>

<!-- Navbar -->
<div class="center-container">
	<a href="${ctp}/">
    <img src="${ctp}/images/Logo.png" class="centered-image">
  </a>
</div>
