<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
<html>
<head>
	<title>GH Bank</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
	body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
	
	body, html {
	  height: 100%;
	  line-height: 1.8;
	}
	
	.w3-bar .w3-button {
	  padding: 16px;
	}
	</style>
</head>
<body>
	<!-- Navbar -->
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	
	<!-- Header -->
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	<!-- function -->
	<jsp:include page="/WEB-INF/views/include/function.jsp" />
	
	<!-- body -->
	<jsp:include page="/WEB-INF/views/include/body.jsp" />
	
	<!-- footer -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>