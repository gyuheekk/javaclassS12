<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>GH Bank - 회원가입</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';
    
    let idCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사(아이디,비밀번호(재확인),성명,이메일)
    	
    	// 정규식을 이용한 유효성검사처리
    	/* let regMid = /^[a-zA-Z0-9_]{4,20}$/;																		// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
      let regPwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;    // 비밀번호 8~16의 영문 대/소문자와 특수문자 숫자와 밑줄 가능
      let regName = /^[가-힣a-zA-Z]+$/;																					// 이름은 한글/영문 가능
	    let regEmail = /^[a-zA-Z0-9_]{4,20}$/; 																	// 4~20의 영문 대/소문자와 숫자와 밑줄 가능 */
    	
    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
    	let mid = myform.mid.value.trim();
    	let pwd = myform.pwd.value.trim();
    	let name = myform.name.value;
    	
    	if(name.trim() == "") {
				alert("이름을 입력하세요");
				myform.name.focus();
				return false;
			}
    	
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let birth = myform.birth.value;
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
			if(tel1.trim() == "") {
				alert("전화번호를 입력하세요");
				myform.tel1.focus();
				return false;
			}
			else if(tel2.trim() == "") {
				alert("전화번호를 입력하세요");
				myform.tel2.focus();
				return false;
			}
			else if(tel3.trim() == "") {
				alert("전화번호를 입력하세요");
				myform.tel3.focus();
				return false;
			}
    	
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
			
    	// 아이디 중복체크
    	if(idCheckSw == 0) {
    		alert("아이디 중복체크버튼을 눌러주세요");
    		document.getElementById("midBtn").focus();
    	}
    	else {
    		myform.email.value = email;
    		myform.tel.value = tel;
    		myform.address.value = address;
    		
    		myform.submit();
    	}
    }
    
    // 아이디 중복체크
    function idCheck() {
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요!");
    		myform.mid.focus();
    	}
    	else {
    		idCheckSw = 1;
    		
    		$.ajax({
    			url  : "${ctp}/member/memberIdCheck",
    			type : "get",
    			data : {mid : mid},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
    					myform.mid.focus();
    				}
    				else {
    					alert("사용 가능한 아이디 입니다.");
    					myform.pwd.focus();
    				}
    			},
    			error : function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    }
    
    $(function(){
    	$("#mid").on("blur", () => {
    		idCheckSw = 0;
    	});
    });	
    
    // 비밀번호 재확인
    function pwdCheck(){
    	if($('#pwd').val() == $('#pwd2').val()){
    		$('#pwdConfirm').text('비밀번호 일치').css('color','green')
    	}
    	else {
    		$('#pwdConfirm').text('비밀번호 불일치').css('color','red')
    	}
    }
    
 	 	// 선택된 사진 미리보기
	 	function imgCheck(e) {
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
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<p><br/></p>
<div class="container">
	<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
    <br/>
    <div class="form-group">
      <label for="mid">아이디  &nbsp; &nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 </label>
      <input type="password" class="form-control" name="pwd" id="pwd" oninput="pwdCheck()" placeholder="비밀번호를 입력하세요." required />
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 재확인 </label>
      <input type="password" class="form-control" name="pwd2" id="pwd2" oninput="pwdCheck()" placeholder="위와 동일한 비밀번호를 한번 더 입력하세요." required />
   		<span id="pwdConfirm"></span>
    </div>
    <div class="form-group">
      <label for="name">성명 </label>
      <input type="text" class="form-control" name="name" id="name" placeholder="성명을 입력하세요." required />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
        <div class="form-row">
        	<div class="col">
	          <input type="text" class="form-control" id="email1" name="email1" required />
        	</div>
        	<div class="col-auto">@</div>
        	<div class="col">
            <select name="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="nate.com">nate.com</option>
              <option value="yahoo.com">yahoo.com</option>
            </select>
	         </div>
          </div>
        </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 </span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birth">생년월일</label>
      <input type="date" name="birth" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 </span> &nbsp;&nbsp;
            <select name="tel1" id="tel1" class="custom-select" required>
              <option value="010" selected>010</option>
              <option value="02">서울</option>
              <option value="031">경기</option>
              <option value="032">인천</option>
              <option value="041">충남</option>
              <option value="042">대전</option>
              <option value="043">충북</option>
              <option value="051">부산</option>
              <option value="052">울산</option>
              <option value="061">전북</option>
              <option value="062">광주</option>
            </select>-
        </div>
        <input type="text" name="tel2" id="tel2" size=4 maxlength=4 class="form-control" required/>-
        <input type="text" name="tel3" id="tel3" size=4 maxlength=4 class="form-control" required/>
      </div>
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <!-- <option value="">직업선택</option> -->
        <option>학생</option>
        <option>회사원</option>
        <option>공무원</option>
        <option>군인</option>
        <option>의사</option>
        <option>법조인</option>
        <option>세무인</option>
        <option>자영업</option>
        <option selected>기타</option>
      </select>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) :
      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
   		<div><img id="photoDemo" width="100px"/></div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
    
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>