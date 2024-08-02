<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 로그인</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <%@ include file = "/WEB-INF/views/include/nav2.jsp" %>
  <style>
  .spinner-container {
	  position: fixed;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  display: none;
	  z-index: 9999; /* 다른 요소들보다 위에 표시되도록 합니다 */
	}
	.container {
		font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
   	font-size: 17px;
   	text-align: center;
    margin-top: 50px;
	}
	body{
  	margin: 0 auto;
    font-family: Arial, sans-serif;
  }
  .move-right {
    position: relative;
    right: -170px;
   /* -a(-값이 커질수록 오른쪽으로 이동) */
  }
  .warning {
  	font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-weight: <weight>;
	  font-style: normal;
  }
 .tabs {
      display: flex;
      justify-content: center;
      margin-bottom: 20px;
      border-bottom: 1px solid #ccc;
  }
  .tab {
    padding: 10px 20px;
    cursor: pointer;
    border: 1px solid #ccc;
    border-bottom: none;
    background-color: #f8f9fa;
    color: black;
}
  .tab.active {
    background-color: #007bff; /* 배경색 : 파랑 */
    color: white;
    border-bottom: 1px solid white;
}
  .form-container {
    display: none;
}
  .form-container.active {
    display: block;
}
  .form-group {
      margin-bottom: 15px;
  }
  .form-group input {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
  }
  button {
      padding: 10px 20px;
      cursor: pointer;
  }
  </style>
  <script>
    'use strict';
 		// 처음 로딩시는 아이디찾기/비밀번호 찾기(가려진상태)
    $(function(){
    	$("#searchMid").hide();
    	$("#searchPassword").hide();
    });
    
    // 비밀번호 찾기버튼 누르면(보이기)
    function pwdSearch() {
    	$("#searchPassword").show();
    	$("#searchMid").hide();
    	$("#warning").hide();
    }
    
    //아이디 찾기버튼 누르면(보이기)
    function midSearch() {
    	$("#searchMid").show();
    	$("#searchPassword").hide();
    	$("#warning").hide();
    }
    
    $(function(){
        // 초기 설정
        $("#idLoginForm").show();
        $("#qrLoginForm").hide();
        $("#idLogin").addClass("active");
        $("#qrLogin").removeClass("active");

        $(".tab").click(function(){
            $(".tab").removeClass("active");
            $(this).addClass("active");
            
            if ($(this).attr("id") === "qrLogin") {
                $("#qrLoginForm").show();
                $("#idLoginForm").hide();
            } else {
                $("#idLoginForm").show();
                $("#qrLoginForm").hide();
            }
        });
    });
    
 	// 임시비밀번호 등록시켜주기
  function newPassword() {
  	let mid = $("#midSearch").val().trim();
  	let email = $("#emailSearch2").val().trim();
  	if(mid == "" || email == "") {
  		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
  		$("#midSearch").focus();
  		return false;
  	}
  	
  	$.ajax({
  		url  : "${ctp}/member/memberNewPassword",
  		type : "post",
  		data : {
  			mid   : mid,
  			email : email
  		},
  		beforeSend: function() {
  			// AJAX 요청이 시작되기 전에 스핀 태그 표시
  			$("#spinner-password").css("display", "inline-block");
  		},
  		success:function(res) {
  			// AJAX 요청이 성공하면 스핀 태그 숨김
  			$("#spinner-password").css("display", "none");
  			
  			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
  			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
				location.reload();
  		},
  		error : function() {
  			// AJAX 요청이 실패해도 스핀 태그를 숨김
  			$("#spinner-password").css("display", "none");
  			alert("전송오류!!")
  		}
  	});
  }
 	
	//이메일로 아이디 보내주기
  function findMid() {
  	let name = $("#nameSearch").val().trim();
  	let email = $("#emailSearch1").val().trim();
  	if(name == "" || email == "") {
  		alert("가입시 등록한 이름과 메일주소를 입력하세요");
  		$("#nameSearch").focus();
  		return false;
  	}
  	
  	$.ajax({
  		url  : "${ctp}/member/memberFindMid",
  		type : "post",
  		data : {
  			name  : name,
  			email : email
  		},
  		beforeSend: function() {
  			$("#spinner-mid").css("display", "inline-block");
  		},
  		success:function(res) {
  			$("#spinner-mid").css("display", "none");
  			
  			if(res != "0") alert("회원님의 아이디를 메일로 발송 했습니다.\n메일주소를 확인하세요.");
  			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
  			location.reload();
  		},
  		error : function() {
  			$("#spinner-mid").css("display", "none");
  			alert("전송오류!!")
  		}
  	});
  }
	
	//QR 로그인
  function qrLogin() {
  	let mid = qrform.mid.value;
  	if(mid == "") {
  		alert("회원 아이디를 입력하세요\n아이디가 없으시면, QR로그인을 이용하실 수 없습니다.");
  		return false;
  	}
  	let url = "${ctp}/member/qrLogin?mid="+mid;
    let windowName = "childWindow";
    let windowWidth = 300;
    let windowHeight = 400;
    let x = (window.screen.width / 2) - (windowWidth / 2);
    let y = (window.screen.height / 2) - (windowHeight / 2);
    let opt = "width="+windowWidth+"px, height="+windowHeight+"px, left="+x+", top="+y;

    newWin = window.open(url, windowName, opt);
  }
	
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="tabs">
	  <div class="tab active" id="qrLogin" onclick="QrLogin">QR코드 로그인</div>
	  <div class="tab" id="idLogin" onclick="idpwdLogin">ID/비밀번호</div>
  </div>
  <form name="myform" id="idpwdLogin" method="post">
	  <div id="idLoginForm">
	  	<div class="text-center">
		    <table class="table table-bordered" style="width:600px; margin:0 auto">
		      <tr>
			      <td>
				      <input type="text" name="mid" value="admin" placeholder="아이디 입력" autofocus required class="form-control mt-3 mb-3"/>
				      <input type="password" name="pwd" value="1234" placeholder="비밀번호 입력" required class="form-control mb-3"/>
			    	</td>
			    	<td rowspan="2">
				      <button type="submit" class="btn btn-primary mt-2" style="width: 100%; height: 100px;">로그인</button>
			    	</td>
		    	</tr>
		    </table>
	    </div>
    </div>
   </form>
  <form name="qrform" id="qrCodeLogin" method="post">
	  <div id="qrLoginForm">
	    <div class="text-center">
        <table class="table table-bordered" style="width:600px; margin:0 auto">
            <tr>
                <td>
                    <input type="text" name="mid" id="mid" placeholder="아이디 입력" autofocus required class="form-control mt-3 mb-3"/>
                    <input type="button" value="QR로그인" onclick="qrLogin()" class="btn btn-primary mt-2" style="width: 100%; height: 45px;"/>
                </td>
            </tr>
        </table>
	    </div>
    </div>
   </form>
    <div class="text-center mt-3">
			<a href="javascript:midSearch()">아이디찾기</a> |
			<a href="javascript:pwdSearch()">비밀번호 찾기</a>
		</div>
		<div class="text-center mt-4 move-right">
		  아직 회원이 아니신가요?<a href="${ctp}/member/memberJoin"> 회원가입</a>
		</div>
		<hr/>
		<pre class="warning text-left" id="warning">
			<i class="fa-solid fa-bullhorn icon-spacing"></i><b>가짜 은행사이트에 속지 마세요!</b>
			
			GH Bank는 어떠한 이유로도 OTP카드와 보안카드 '전체(35개)' 또는 '일부(2개 초과)'를 요구하지 않습니다.
			
			최근 금융기관 콜센터번호를 도용하여 개인정보 유출 등 사유로 가짜 사이트 접속을 유도하는 SMS가 발견되고 있습니다.
			PC에 악성코드가 설치될 경우 즐겨찾기 또는 정상 은행 사이트를 입력하셔도 가짜 은행 사이트에 연결될 수 있습니다.
		</pre>
  <div id="searchPassword">
    <hr/>
  	<table class="table table-bordered p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>비밀번호 찾기</b></font>
  	      (가입시 입력한 아이디와 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>아이디</th>
  	    <td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="새비밀번호발급" onclick="newPassword()" class="form-control btn btn-outline-secondary" placeholder="메일주소를 입력하세요"/>
  	   		<div id="spinner-password" class="spinner-container">
					  <div id="spinner" class="spinner-border text-muted"></div>
					</div>
  	    </td>
  	  </tr>
  	</table>
  </div>
  <div id="searchMid">
    <hr/>
  	<table class="table table-bordered p-0 text-center">
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <font size="4"><b>아이디 찾기</b></font>
  	      (가입시 입력한 이름과 메일주소를 입력하세요)
  	    </td>
  	  </tr>
  	  <tr>
  	    <th>이름</th>
  	    <td><input type="text" name="nameSearch" id="nameSearch" class="form-control" placeholder="이름을 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <th>메일주소</th>
  	    <td><input type="text" name="emailSearch1" id="emailSearch1" class="form-control" placeholder="메일주소를 입력하세요"/></td>
  	  </tr>
  	  <tr>
  	    <td colspan="2" class="text-center">
  	      <input type="button" value="아이디 찾기" onclick="findMid()" class="form-control btn btn-outline-secondary" placeholder="메일주소를 입력하세요"/>
  	    	<div id="spinner-mid" class="spinner-container">
					  <div id="spinner" class="spinner-border text-muted"></div>
					</div>
  	    </td>
  	  </tr>
  	</table>
  </div>
</div>
<p><br/></p>
</body>
</html>