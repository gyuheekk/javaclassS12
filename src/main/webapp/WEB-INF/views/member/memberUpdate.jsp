<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';
    
    	function fCheck() {
    	// 유효성 검사(성명,이메일,전화번호)
    	
    	// 정규식을 이용한 유효성검사처리
      /*
      let regName = /^[가-힣a-zA-Z]+$/;																					// 이름은 한글/영문 가능
	    let regEmail = /^[a-zA-Z0-9_]{4,20}$/; 																	// 4~20의 영문 대/소문자와 숫자와 밑줄 가능 */
    	
    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
    	let name = myform.name.value;
    	
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let birth = myform.birth.value;
    	
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
    	let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    	
    	/* if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else if(!regPwd.test(pwd)) {
        alert("비밀번호는 8~16자리의 영문 대/소문자와 특수문자 하나를 꼭 포함해 주세요.");
        myform.pwd.focus();
        return false;
      }
    	else if(pwd.length < 4 && pwd.length > 20) {
        alert("비밀번호는 4~20 자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
			// 이메일 주소형식체크
			
			
			// 전화번호 형식 체크
			if(tel2 != "" && tel3 != "") {
				// 전화번호 정규화 체크
			}
			else {
				tel2 = " ";
				tel3 = " ";
				tel = tel1 + "-" + tel2 + "-" + tel3;
			} */
			
			// 전송전에 파일에 관련된 사항들을 체크해준다.
			let fName = document.getElementById("file").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 5;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					alert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 5MByte입니다.");
					return false;
				}
			}
				myform.email.value = email;
	   		myform.tel.value = tel;
	   		myform.address.value = address;
		    		
	   		myform.submit();
			}
			
			// 선택된 사진 미리보기
		 	function imgCheck(e) {
		 		$("#img").hide();
	    	if(e.files && e.files[0]) {
	    		let reader = new FileReader();
	    		reader.onload = function(e) {
	    			document.getElementById("photoDemo").src = e.target.result;
	    		}
	    		reader.readAsDataURL(e.files[0]);
	    	}
	    }
  </script>
<style>
  .form-group label {
    font-weight: bold;
    color: #333333;
  }
  .form-control, .custom-select, .btn {
    border-radius: 5px;
  }
  .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
  }
  .btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
  }
  .input-group-text {
    background-color: #e9ecef;
  }
  .form-check-input:checked {
    background-color: #007bff;
    border-color: #007bff;
  }
  .mb-1, .mb-3, .mb-4 {
    margin-bottom: 1rem !important;
  }
  .mb-3 {
    margin-bottom: 1.5rem !important;
  }
  .mb-4 {
    margin-bottom: 2rem !important;
  }
  #form-group {
    text-align: center; /* 내부 요소 가운데 정렬 */
  }
  #file {
  	text-align: center;
  	width: 50%;
  }
 .form-control-file {
   width: 20%; /* 폭을 35%로 설정 */
   display: block;
   margin: 10px auto; /* 가운데 정렬 */
 }
 .profile {
  	border-radius:50%;
  }
  h2 {
    color: #003366;
    border-bottom: 2px solid #003366;
    padding-bottom: 10px;
    margin-bottom: 20px;
    font-family: "Noto Sans KR", sans-serif;
	 	font-optical-sizing: auto;
	 	font-weight: <weight>;
	 	font-style: normal;
  }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav3.jsp" />
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<p><br/></p>
<div class="container">
	<h2>Profile Update</h2>
	<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
    <br/>
    <div class="form-group" id="form-group">
      <label for="address">프로필 사진</label><br/><img src="${ctp}/member/${vo.photo}" id="img" width="200px" class="profile"/>
   		<div><img id="photoDemo" width="200px"/></div>
      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border" />
    </div>
    <div class="form-group">
      <label for="name">아이디 </label>
      <input type="text" class="form-control" value="${sMid}" disabled/>
    </div>
    <div class="form-group">
      <label for="name">성명 </label>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="input-group mb-3">
          <c:set var="email" value="${fn:split(vo.email,'@')}"/>
          <input type="text" class="form-control" id="email1" name="email1" value="${email[0]}" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com"   ${email[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
              <option value="hanmail.net" ${email[1] == 'hanmail.net' ? 'selected' : ''}>hanmail.net</option>
              <option value="hotmail.com" ${email[1] == 'hotmail.com' ? 'selected' : ''}>hotmail.com</option>
              <option value="gmail.com"   ${email[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
              <option value="nate.com"    ${email[1] == 'nate.com' ? 'selected' : ''}>nate.com</option>
              <option value="yahoo.com"   ${email[1] == 'yahoo.com' ? 'selected' : ''}>yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 </span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender == '여자'}">checked</c:if>>여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birth">생년월일</label>
      <input type="date" name="birth" value="${fn:substring(vo.birth, 0, 10)}" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 </span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" ${tel1 == '010' ? 'selected' : ''}>010</option>
              <option value="02"  ${tel1 == '02'  ? 'selected' : ''}>서울</option>
              <option value="031" ${tel1 == '031' ? 'selected' : ''}>경기</option>
              <option value="032" ${tel1 == '032' ? 'selected' : ''}>인천</option>
              <option value="041" ${tel1 == '041' ? 'selected' : ''}>충남</option>
              <option value="042" ${tel1 == '042' ? 'selected' : ''}>대전</option>
              <option value="043" ${tel1 == '043' ? 'selected' : ''}>충북</option>
              <option value="051" ${tel1 == '051' ? 'selected' : ''}>부산</option>
              <option value="052" ${tel1 == '052' ? 'selected' : ''}>울산</option>
              <option value="061" ${tel1 == '061' ? 'selected' : ''}>전북</option>
              <option value="062" ${tel1 == '062' ? 'selected' : ''}>광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-
        <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <option ${vo.job == '학생'  ? 'selected' : ''}>학생</option>
        <option ${vo.job == '회사원' ? 'selected' : ''}>회사원</option>
        <option ${vo.job == '공무원' ? 'selected' : ''}>공무원</option>
        <option ${vo.job == '군인'  ? 'selected' : ''}>군인</option>
        <option ${vo.job == '의사'  ? 'selected' : ''}>의사</option>
        <option ${vo.job == '법조인' ? 'selected' : ''}>법조인</option>
        <option ${vo.job == '세무인' ? 'selected' : ''}>세무인</option>
        <option ${vo.job == '자영업' ? 'selected' : ''}>자영업</option>
        <option ${vo.job == '기타' ? 'selected' : ''}>기타</option>
      </select>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" value="${postcode}" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" value="${roadAddress}" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" value="${detailAddress}" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" value="${extraAddress}" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원 정보 수정</button> &nbsp;
    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
    
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="photo" value="${vo.photo}" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>