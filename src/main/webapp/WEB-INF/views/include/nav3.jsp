<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/include/bs4.jsp" %>

<style>
  .top-left-image {
        position: absolute;
        top: 10px;  /* 상단에서 10px 내려오도록 설정 */
        left: 10px;  /* 왼쪽에서 10px 떨어지도록 설정 */
        width: 200px;  /* 이미지 너비를 50px로 설정 */
        height: auto;  /* 이미지 비율을 유지하도록 설정 */
        margin-bottom: 30px;  /* 이미지 아래에 20px 여백 추가 */
    }
    .top-left-image:hover {
	    cursor: pointer; /* 호버 시 커서를 포인터로 변경 */
		}
    .move-right {
    	position: relative;
  	}
</style>

<!-- Navbar -->
<div class="center-container">
	<a href="${ctp}/">
    <img id="img" src="${ctp}/images/Logo.png" class="top-left-image move-right">
  </a>
</div>
