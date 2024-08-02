<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	h1 {
		font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
	  margin-top: 100px;
	}
  .button-container {
  display: flex;
  justify-content: center;
  gap: 3px;
  margin-bottom: 20px;
  margin-top: 0px;
  max-width: 25%;
  margin: 0 auto;
}

.button-container .btn {
  padding: 15px 30px;
  font-size: 16px;
  min-width: 150px;
  border: 1px solid;
  transition: all 0.3s;
}

.button-container .btn-outline-warning {
  color: #ffc107;
  border-color: #ffc107;
}

.button-container .btn-outline-danger {
  color: #dc3545;
  border-color: #dc3545;
}

.button-container .btn-outline-primary {
  color: #007bff;
  border-color: #007bff;
}

.button-container .btn-outline-warning.active {
  background-color: #ffc107;
  color: white;
}

.button-container .btn-outline-danger.active {
  background-color: #dc3545;
  color: white;
}

.button-container .btn-outline-primary.active {
  background-color: #007bff;
  color: white;
}

.box-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
  margin-bottom: 40px;
}

.box {
  width: 300px;
  height: 400px;
  overflow: hidden;
  border-radius: 8px;
  transition: transform 0.3s;
  display: block; /* 기본적으로 모든 박스 표시 */
}

.box img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.box:hover {
  transform: translateY(-5px);
}
</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
	  const buttons = document.querySelectorAll('.button-container .btn');
	  const boxes = document.querySelectorAll('.box-container .box');
	  
	  buttons.forEach(button => {
	    button.addEventListener('click', function() {
	      const category = this.getAttribute('data-category');
	      
	      // 버튼 활성화 상태 변경
	      buttons.forEach(btn => btn.classList.remove('active'));
	      this.classList.add('active');
	      
	      // 박스 필터링
	      boxes.forEach(box => {
	        if (category === 'all' || box.getAttribute('data-category') === category) {
	          box.style.display = 'block';
	        } else {
	          box.style.display = 'none';
	        }
	      });
	    });
	  });
	});
</script>
<!-- Team Section -->
<h1 class="text-center">GH Bank News</h1>
<div class="w3-container" style="padding-top: 40px; padding-bottom: 16px;" id="team">
  <div class="w3-row-padding w3-grayscale">
    <div class="button-container">
      <input type="button" name="button" value="ALL NEWS" class="btn btn-outline-warning active" data-category="all" />
      <input type="button" name="button" value="SERVICE" class="btn btn-outline-danger" data-category="service" />
      <input type="button" name="button" value="PRODUCT" class="btn btn-outline-primary" data-category="product" />
    </div>
    <!-- 나머지 내용 -->
  </div>
</div>

<div class="box-container">
  <a href="${ctp}/card/cardProduct" class="box" data-category="product">
    <img src="${ctp}/images/Card1.png" class="centered-image">
  </a>
  <a href="${ctp}/saving/savingProduct" class="box" data-category="product">
    <img src="${ctp}/images/Card2.png" class="centered-image">
  </a>
  <a href="#" onclick="openCalculator();" class="box" data-category="service">
    <img src="${ctp}/images/Card3.png" class="centered-image">
  </a>
</div>

<div class="box-container">
	<a href="${ctp}/loan/loanProduct" class="box" data-category="product">
    <img src="${ctp}/images/Card4.png" class="centered-image">
  </a>
  <a href="${ctp}/loan/loanProduct" class="box" data-category="product">
    <img src="${ctp}/images/Card5.png" class="centered-image">
  </a>
  <a href="${ctp}/loan/loanProduct" class="box" data-category="product">
    <img src="${ctp}/images/Card6.png" class="centered-image">
  </a>
  <a href="#" onclick="openKakaoMap();" class="box" data-category="service">
    <img src="${ctp}/images/Card7.png" class="centered-image">
  </a>
</div>
