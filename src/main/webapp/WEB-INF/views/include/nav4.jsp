<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/include/bs4.jsp" %>

<style>
.nav-custom {
            background-color: #0066b3;
            padding: 0;
            margin-bottom: 30px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
         .nav-custom .container {
            display: flex;
            justify-content: flex-start;
        }
        .nav-item {
            position: relative;
        }
        .nav-custom a {
          color: white;
			    text-decoration: none;
			    font-weight: bold;
			    padding: 15px 20px;
			    display: block;
        }
        .nav-custom a:hover {
          background-color: white;
			    color: #0066b3;
			    text-decoration: none;
        }
         .dropdown-menu {
          display: none;
    			position: absolute;
			    background-color: white;
			    min-width: 160px;
			    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
			    z-index: 1;
        }
        .dropdown-menu a {
          color: #0066b3;
			    padding: 12px 16px;
			    text-decoration: none;
			    display: block;
        }
        .dropdown-menu a:hover {
          background-color: #0066b3;
  				color: white;
        }
        .nav-item:hover .dropdown-menu {
            display: block;
        }
</style>

<!-- Navbar -->
<nav class="nav-custom">
    <div class="container">
        <div class="nav-item">
            <a href="${ctp}/account/accountview">거래 관리</a>
            <div class="dropdown-menu">
                <a href="${ctp}/account/accountDeposit">입금</a>
                <a href="${ctp}/account/accountWithdraw">출금</a>
                <a href="${ctp}/account/accountTransfer">계좌이체</a>
                <a href="${ctp}/account/accountview">거래내역조회</a>
            </div>
        </div>
        <div class="nav-item">
            <a href="${ctp}/saving/savingProduct">예금/적금</a>
            <div class="dropdown-menu">
                <a href="${ctp}/saving/savingProduct">예금/적금 상품</a>
                <a href="${ctp}/saving/savingSignup?flagSw=Y">정기예금 신청</a>
                <a href="${ctp}/saving/savingSignup?flagSw=J">정기적금 신청</a>
            </div>
        </div>
        <div class="nav-item">
            <a href="${ctp}/loan/loanProduct">대출</a>
            <div class="dropdown-menu">
                <a href="${ctp}/loan/loanSignup?loanSw=S">신용대출</a>
                <a href="${ctp}/loan/loanSignup?loanSw=H">학자금대출</a>
                <%-- <a href="${ctp}/loan/loanSignup?loanSw=J">자동차대출</a>
                <a href="${ctp}/loan/loanSignup?loanSw=M">예/적금 담보대출</a> --%>
            </div>
        </div>
        <div class="nav-item">
            <a href="${ctp}/card/cardProduct">카드</a>
            <div class="dropdown-menu">
                <a href="${ctp}/card/cardSignup?flagSw=S">신용카드</a>
                <a href="${ctp}/card/cardSignup?flagSw=C">체크카드</a>
                <a href="${ctp}/card/cardSignup?flagSw=H">학생카드</a>
            </div>
        </div>
        <div class="nav-item">
            <a href="${ctp}/board/boardList">게시판</a>
            <div class="dropdown-menu">
                <a href="${ctp}/board/boardList?part=공지사항">공지사항</a>
                <a href="${ctp}/board/boardList?part=문의사항">문의사항</a>
                <a href="${ctp}/board/boardList?part=FAQ">FAQ</a>
            </div>
        </div>
    </div>
</nav>
