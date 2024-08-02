<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>1:1 상담 채팅</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
    }
    .chat-container {
      max-width: 800px;
      margin: 30px auto;
      background-color: #ffffff;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }
    .chat-header {
      border-bottom: 1px solid #e9ecef;
      padding-bottom: 15px;
      margin-bottom: 20px;
    }
    #list {
      height: 400px;
      overflow-y: auto;
      border: 1px solid #e9ecef;
      border-radius: 5px;
      padding: 15px;
      background-color: #f8f9fa;
    }
    .message {
      margin-bottom: 10px;
      padding: 8px 12px;
      border-radius: 18px;
      max-width: 70%;
    }
    .message-received {
      background-color: #e9ecef;
      align-self: flex-start;
    }
    .message-sent {
      background-color: #007bff;
      color: white;
      align-self: flex-end;
      margin-left: auto;
    }
    .chat-input {
      margin-top: 20px;
    }
    .btn-custom {
      background-color: #007bff;
      border-color: #007bff;
      color: white;
    }
    .btn-custom:hover {
      background-color: #0056b3;
      border-color: #0056b3;
    }
  </style>
  <script>
  $(document).ready(function(){
    // ... (기존 코드 유지)

    // 로그인 사용자가 메세지 전송시 처리(유저명, 메세지)
    function print(user, txt) {
      let temp = '';
      let isCurrentUser = '${sMid}' == user;
      
      temp += `<div class="message ${isCurrentUser ? 'message-sent' : 'message-received'}">`;
      temp += `<small class="text-muted">${user}</small><br>`;
      temp += `<span>${txt}</span><br>`;
      temp += `<small class="text-muted">${new Date().toLocaleTimeString()}</small>`;
      temp += '</div>';
      
      temp = temp.replace(/\n/gi,"<br/>");	
      
      $('#list').append(temp);	
    }
    
    // 다른 클라이언트 사용자가 처음 접속할때 처리		
    function print2(user) {
      let temp = `
        <div class="text-center my-2">
          <span class="badge badge-info">
            '${user}'님이 접속했습니다. (${new Date().toLocaleTimeString()})
          </span>
        </div>
      `;
      
      $('#list').append(temp);
    }
  
    // 클라이언트가 접속 종료시 처리
    function print3(user) {
      let temp = `
        <div class="text-center my-2">
          <span class="badge badge-secondary">
            '${user}'님이 종료했습니다. (${new Date().toLocaleTimeString()})
          </span>
        </div>
      `;
      
      $('#list').append(temp);
    }

    $('#user').keydown(function() {
	  	if (event.keyCode == 13) {
	  		$('#btnConnect').click();
	  	}
	  });
	  
	  
	  $('#msg').keydown(function() {
	  	if (event.keyCode == 13) {
	  		if(!event.shiftKey) {
		  		if($('#msg').val().trim() == '') return false;
		  		let chatColor = $("#chatColor").val();
		  		
		  		ws.send('2#' + $('#user').val() + '#' + $(this).val() + '@' + chatColor);
		  		print($('#user').val(), '<font color="'+chatColor+'">'+$(this).val()+'</font>');
		  		
		  		event.preventDefault();	
		      $('#msg').val('');  		
		  		$('#msg').focus();
		  		$('#list').scrollTop($('#list').prop('scrollHeight'));	
	  		}
	  	}
	  });

    $('#btnDisconnect').click(function() {
      ws.send('3#' + $('#user').val() + '#');
      ws.close();
      
      $('#user').attr('readonly', false);
      
      $('#user').val('${sMid}');
      $('#user').attr('disabled', true);
      $('#chatStatus').html('${sMid}님 <span class="text-danger">접속대기</span> 상태');
      $('#list').append('<div class="text-center my-2"><span class="badge badge-danger">${sMid}님 접속종료</span></div>');
      
      $('#btnConnect').attr('disabled', false);
      $('#btnDisconnect').attr('disabled', true);
      
      $('#msg').val('');
      $('#msg').attr('disabled', true);
    });
    
  });
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<div class="container chat-container">
  <div class="chat-header">
    <h2 class="text-center">1:1 상담원 채팅 문의</h2>
    <p class="text-center" id="chatStatus">${sMid}님 <span class="text-danger">접속대기</span> 상태</p>
  </div>
  
  <div class="row mb-3">
    <div class="col-md-8">
      <input type="text" name="user" value="${sMid}" id="user" class="form-control" readonly />
    </div>
    <div class="col-md-4">
      <button id="btnConnect" class="btn btn-custom btn-sm">연결</button>
      <button id="btnDisconnect" class="btn btn-outline-secondary btn-sm" disabled>종료</button>
      <input type="color" name="chatColor" id="chatColor" title="글자색 변경" style="width:30px;" class="ml-2">
    </div>
  </div>

  <div id="list"></div>

  <div class="chat-input">
    <textarea name="msg" id="msg" rows="3" placeholder="메시지를 입력하세요." class="form-control mb-2" disabled></textarea>
    <div class="text-right">
      <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">돌아가기</button>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>