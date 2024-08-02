<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GH Bank - 관리자메뉴</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
	<frameset cols="180px, *">
		<frame src="${ctp}/admin/adminLeft" name="adminLeft" frameborder="0" />
		<frame src="${ctp}/admin/adminContent" name="adminContent" frameborder="0" />
	</frameset>
</head>
<body>
</body>
</html>